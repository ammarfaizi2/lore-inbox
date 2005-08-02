Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261479AbVHBKug@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261479AbVHBKug (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 06:50:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261480AbVHBKuf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 06:50:35 -0400
Received: from mail.guam.net ([202.128.0.37]:55515 "EHLO asa.kuentos.guam.net")
	by vger.kernel.org with ESMTP id S261479AbVHBKte (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 06:49:34 -0400
From: "Michael D. Setzer II" <mikes@kuentos.guam.net>
To: linux-kernel@vger.kernel.org
Date: Tue, 02 Aug 2005 20:49:39 +1000
MIME-Version: 1.0
Subject: kernel options for cd project with processor family
Message-ID: <42EFDC63.31465.58ED66@mikes.kuentos.guam.net>
X-mailer: Pegasus Mail for Windows (4.30 public beta 1)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm working on the ghost for linux project, which uses various 
kernels. The older version 0.14 version had two kernels that support 
some configurations. I've added a number of additional builds 
adding extra features, but left earlier version in case the later 
additions didn't work with hardware. The bzImage6 is the latest and 
it works with most hardware, but I found it didn't work on a K6, since 
it was build with the Pentium Pro Family. I was able to build one with 
the K6 family, and it worked. I had used one of the original kernels 
with a K6 before, but this one had a network card that wasn't 
supported by it. 

I've built a test set of kernels with the same configuration as the 
bzImage6, but changed the Processor family. Below is a list of the 
build. I'm interested in which ones would make a difference. I would 
think that the 386 version would probable work on all hardware, but 
at what cost in performance for creating and restoring the disk 
images. G4L uses basically dd, gzip, lzop, bzop, ncftpget, and 
ncftpput. With all these images, the g4l iso image is 50MB. 


3877213 Aug  2 11:46 bzImage.386
3961494 Aug  2 11:46 bzImage.486
3971857 Aug  2 11:46 bzImage.586
4100360 Aug  2 11:46 bzImage6
4038178 Aug  2 11:46 bzImage.Athlon
4033738 Aug  2 11:46 bzImage.Athlon64
3915459 Aug  2 11:46 bzImage.K6
3927064 Aug  2 11:46 bzImage.P4
3973329 Aug  2 11:46 bzImage.PClasic
4083542 Aug  2 11:46 bzImage.PIII
4083891 Aug  2 11:46 bzImage.PPro

+----------------------------------------------------------+
  Michael D. Setzer II -  Computer Science Instructor      
  Guam Community College  Computer Center                  
  mailto:mikes@kuentos.guam.net                            
  mailto:msetzerii@gmail.com
  http://www.guam.net/home/mikes
  Guam - Where America's Day Begins                        
+----------------------------------------------------------+

http://setiathome.berkeley.edu
Number of Seti Units Returned:  17,188
Processing time:  31 years, 176 days,  2 hours, 20 minutes
(Total Hours: 275,786)


