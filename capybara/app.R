#library(igraph) 
#library(network) 
#library(sna)
library(visNetwork)
#library(threejs)
#library(networkD3)
#library(ndtv)
library(shiny)
library(ggplot2)
library(shinydashboard)

library(readr)
edges <- read_csv("www/edges.csv")
nodes <- read_csv("www/nodes.csv")


# nodes2 <- read.csv("Dataset2-Media-User-Example-NODES.csv", header=T, as.is=T)
# links2 <- read.csv("Dataset2-Media-User-Example-EDGES.csv", header=T, row.names=1)
# nodes <- read.csv("Dataset1-Media-Example-NODES.csv", header=T, as.is=T)
# links <- read.csv("Dataset1-Media-Example-EDGES.csv", header=T, as.is=T)

# nodes <- data.frame(id = 1:4, 
#                     shape = c("image", "circularImage"),
#                     image = paste0( 1:4, ".png"),
#                     label = "I'm an image")
# 
 #edges <- data.frame(from = c(2,4,3,3), to = c(1,2,4,2))




# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("Capybara Awesomeness Index"),
   
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
      sidebarPanel(
         sliderInput("baras",
                     "Number of Happybaras:",
                     min = 1,
                     max = nrow(nodes),
                     step = 1,
                     value = 1)
      ),
      
      # Show a plot of the generated distribution
      mainPanel(
       visNetworkOutput("capyPlot")
      )
   )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
   
   output$capyPlot <- renderVisNetwork({
     
     
     visNetwork(nodes[1:input$baras,], edges, width = "100%") %>% 
       visNodes(shapeProperties = list(useBorderWithImage = TRUE)) %>%
       visLayout(randomSeed = 2)
   })
}

# Run the application 
shinyApp(ui = ui, server = server)

