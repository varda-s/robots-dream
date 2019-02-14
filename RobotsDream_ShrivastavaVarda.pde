int cols, rows;
int scale = 25;
int w = 1600;
int h = 1600;
float movement = 0;
float phones = 0;
float[][] wave;

void setup(){
  size(800, 800, P3D);
  cols = w/scale;
  rows = w/scale;
  wave = new float[cols][rows];
  frameRate(16);
}

void draw(){
  background(#170058);
  movement -= 0.08;
  phones += 0.1;
  if (phones > 20) phones = 0;
  
  // draw phones
  stroke(0);
  strokeWeight(2);
  fill(255);
  for (int ph = 0; ph < phones; ph++) {
    rect(random(width/4, 3*width/4 - 20), random(height/4-20,3*height/4+30), 10, 18);
  }
  
  // draw center screen
  noStroke();
  fill(#450055);
  rect(random(width/4, width/2), random(height/4-20,height/4+20), 15, 450);
  rect(random(width/2, 3*width/4 - 20), random(height/4-20,height/4+20), 15, 450);
  for (int wi = width/4 + 50; wi < 3*width/4 - 50; wi += 10) {
    fill(random(255),random(255),random(255));
    rect(wi, height/4, 8, 400);
  }
  fill(#170058);
  rect(200, random(height/4, height/2), 200, 5);
  rect(400, random(height/2, 3*height/4), 200, 5);
  rect(200, random(height/4, 3*height/4), 400, 3);
  rect(200, random(height/4, 3*height/4), 400, 3);
  
  // set the perlin noise
  float yoffset = movement;
  for (int y = 0; y < rows; y++) {
    float xoffset = 0;
    for (int x = 0; x < cols; x++) {
      wave[x][y] = map(noise(xoffset, yoffset), 0, 1, -50, 50);
      xoffset += 0.2;
    }
    yoffset += 0.2;
  }

  noFill();
  strokeWeight(1);
  
  // I followed a tutorial by Daniel Shiffman (The Coding Train) 
  // to learn the basics of creating a fluid mesh
  
  // turqoise mesh
  translate(width/2, height/2 + 200);
  rotateX(PI/3);
  translate(-w/2, -h/2);
  stroke(#05F5FF);
  for (int y = 0; y < rows-1; y++) {
    beginShape();
    for (int x = 0; x < cols; x++) {
      vertex(x*scale, y*scale, wave[x][y]);
      vertex(x*scale, (y+1)*scale, wave[x][y+1]);
    }
    endShape();
  }
  
  // pink mesh
  rotateX(PI/4);
  stroke(#FE2CFF);
  for (int y = 0; y < rows-1; y++) {
    beginShape();
    for (int x = 0; x < cols; x++) {
      vertex(x*scale, y*scale, wave[x][y]);
      vertex(x*scale, (y+1)*scale, wave[x][y+1]);
    }
    endShape();
  }
  
}
