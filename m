Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262371AbTELRmb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 13:42:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262413AbTELRmb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 13:42:31 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:64149 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S262371AbTELRmX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 13:42:23 -0400
X-Envelope-From: kraxel@bytesex.org
Date: Mon, 12 May 2003 19:16:39 +0200
From: Gerd Knorr <kraxel@bytesex.org>
To: Linus Torvalds <torvalds@transmeta.com>,
       Kernel List <linux-kernel@vger.kernel.org>
Subject: [patch] v4l: #4 - bttv docmentation update
Message-ID: <20030512171639.GA24272@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

This patch updates the bttv documentation.

Please apply,

  Gerd

diff -u linux-2.5.69/Documentation/video4linux/bttv/CARDLIST linux/Documentation/video4linux/bttv/CARDLIST
--- linux-2.5.69/Documentation/video4linux/bttv/CARDLIST	2003-05-08 13:29:56.000000000 +0200
+++ linux/Documentation/video4linux/bttv/CARDLIST	2003-05-08 13:55:11.000000000 +0200
@@ -22,7 +22,7 @@
   card=20 - CEI Raffles Card
   card=21 - Lifeview FlyVideo 98/ Lucky Star Image World ConferenceTV LR50
   card=22 - Askey CPH050/ Phoebe Tv Master + FM
-  card=23 - Modular Technology MM205 PCTV, bt878
+  card=23 - Modular Technology MM201/MM202/MM205/MM210/MM215 PCTV, bt878
   card=24 - Askey CPH05X/06X (bt878) [many vendors]
   card=25 - Terratec TerraTV+ Version 1.0 (Bt848)/ Terra TValue Version 1.0/ Vobis TV-Boostar
   card=26 - Hauppauge WinCam newer (bt878)
@@ -39,7 +39,7 @@
   card=37 - Prolink PixelView PlayTV pro
   card=38 - Askey CPH06X TView99
   card=39 - Pinnacle PCTV Studio/Rave
-  card=40 - STB TV PCI FM, Gateway P/N 6000704 (bt878)
+  card=40 - STB TV PCI FM, Gateway P/N 6000704 (bt878), 3Dfx VoodooTV 100
   card=41 - AVerMedia TVPhone 98
   card=42 - ProVideo PV951
   card=43 - Little OnAir TV
@@ -81,11 +81,27 @@
   card=79 - DSP Design TCVIDEO
   card=80 - Hauppauge WinTV PVR
   card=81 - GV-BCTV5/PCI
+  card=82 - Osprey 100/150 (878)
+  card=83 - Osprey 100/150 (848)
+  card=84 - Osprey 101 (848)
+  card=85 - Osprey 101/151
+  card=86 - Osprey 101/151 w/ svid
+  card=87 - Osprey 200/201/250/251
+  card=88 - Osprey 200/250
+  card=89 - Osprey 210/220
+  card=90 - Osprey 500
+  card=91 - Osprey 540
+  card=92 - Osprey 2000
+  card=93 - IDS Eagle
+  card=94 - Pinnacle PCTV Sat
+  card=95 - Formac ProTV II
+  card=96 - MachTV
+  card=97 - Euresys Picolo
 
 tuner.o
   type=0 - Temic PAL (4002 FH5)
   type=1 - Philips PAL_I (FI1246 and compatibles)
-  type=2 - Philips NTSC (FI1236 and compatibles)
+  type=2 - Philips NTSC (FI1236,FM1236 and compatibles)
   type=3 - Philips (SECAM+PAL_BG) (FI1216MF, FM1216MF, FR1216MF)
   type=4 - NoTuner
   type=5 - Philips PAL_BG (FI1216 and compatibles)
diff -u linux-2.5.69/Documentation/video4linux/bttv/Cards linux/Documentation/video4linux/bttv/Cards
--- linux-2.5.69/Documentation/video4linux/bttv/Cards	2003-05-08 13:30:15.000000000 +0200
+++ linux/Documentation/video4linux/bttv/Cards	2003-05-08 13:55:11.000000000 +0200
@@ -179,7 +179,8 @@
   has not yet been seen (perhaps it was the german name for LR90 [stereo]).
   These cards are sold by many OEMs too.
 
-  FlyVideo A2 = LR90 Rev.F (w/Remote, w/o FM, stereo TV by tda9821) {Germany}
+  FlyVideo A2 (Elta 8680)= LR90 Rev.F (w/Remote, w/o FM, stereo TV by tda9821) {Germany}
+  Lifeview 3000 (Elta 8681) as sold by Plus(April 2002), Germany = LR138 w/ saa7134
 
 
 Typhoon TV card series:
@@ -397,6 +398,8 @@
    AVerTV98 mit Fernbedienung (BT-878 chip)
    AVerTV/FM98 (BT-878 chip)
 
+   VDOmate (www.averm.com.cn) = M168U ?
+
 Aimslab
 -------
    Video Highway or "Video Highway TR200" (ISA)
@@ -413,7 +416,8 @@
    LT9306/MD9306 = CPH061
    LT9415/MD9415 = LR90 Rev.F or Rev.G
           MD9592 = Avermedia TVphone98 (PCI_ID=1461:0003), PCB-Rev=M168II-B (w/TDA9873H)
-          MD9717 = KNC One (Rev D4, saa7134)
+          MD9717 = KNC One (Rev D4, saa7134, FM1216 MK2 tuner)
+          MD5044 = KNC One (Rev D4, saa7134, FM1216ME MK3 tuner)
 
 Modular Technologies (www.modulartech.com) UK
 ---------------------------------------------
@@ -481,7 +485,8 @@
    Studio PCTV Pro  (Bt878 stereo w/ FM)
    Pinnacle PCTV    (Bt878, MT2032)
    Pinnacle PCTV Pro (Bt878, MT2032)
-   Pinncale PCTV Sat (bt878a, HM1821/1221)
+   Pinncale PCTV Sat (bt878a, HM1821/1221) ["Conexant CX24110 with CX24108 tuner, aka HM1221/HM1811"]
+   Pinnacle PCTV Sat XE
 
    M(J)PEG capture and playback:
    DC1+ (ISA)
@@ -654,9 +659,9 @@
    WinTV PVR 450
 
   US models
-  990 WinTV-PVR-350 (249USD)
-  980 WinTV-PVR-250 (149USD)
-  880 WinTV-PVR-PCI (199USD)
+  990 WinTV-PVR-350 (249USD) (iTVC15 chipset + radio)
+  980 WinTV-PVR-250 (149USD) (iTVC15 chipset)
+  880 WinTV-PVR-PCI (199USD) (KFIR chipset + bt878)
   881 WinTV-PVR-USB
   190 WinTV-GO
   191 WinTV-GO-FM
@@ -697,11 +702,40 @@
   566 WinTV USB (UK)
   573 WinTV USB FM
   429 Impact VCB (bt848)
-  600 USB Libe (Video-In 1x Comp, 1xSVHS)
+  600 USB Live (Video-In 1x Comp, 1xSVHS)
   542 WinTV Nova
   717 WinTV DVB-S
   909 Nova-t PCI
   893 Nova-t USB   (Duplicate entry)
+  802 MyTV
+  804 MyView
+  809 MyVideo
+  872 MyTV2Go FM
+
+ 
+  546 WinTV Nova-S CI
+  543 WinTV Nova
+  907 Nova-S USB
+  908 Nova-T USB
+  717 WinTV Nexus-S
+  157 DEC3000-s Standalone + USB
+
+  Spain
+  685 WinTV-Go
+  690 WinTV-PrimioFM
+  416 WinTV-PCI Nicam Estereo
+  677 WinTV-PCI-FM
+  699 WinTV-Theater
+  683 WinTV-USB
+  678 WinTV-USB-FM
+  983 WinTV-PVR-250
+  883 WinTV-PVR-PCI
+  993 WinTV-PVR-350
+  893 WinTV-PVR-USB
+  728 WinTV-DVB-C PCI
+  832 MyTV2Go
+  869 MyTV2Go-FM
+  805 MyVideo (USB)
   
 
 Matrix-Vision
@@ -713,6 +747,7 @@
 Conceptronic (.net)
 ------------
    TVCON FM,  TV card w/ FM = CPH05x
+   TVCON = CPH06x
 
 BestData
 --------
@@ -747,11 +782,22 @@
 
 Kworld (www.kworld.com.tw)
 --------------------------
-   KWORLD KW-TV878RF-Pro TV Capture with FM Radio
-   KWORLD KW-TV878R-Pro TV
-   KWORLD KW-TVL878RF  (low profile)
-   KWORLD KW-TV878R TV Capture (No FM Radio)
-   KWORLD KW-TV878RF TV
+  PC TV Station
+   KWORLD KW-TV878R  TV (no radio)
+   KWORLD KW-TV878RF TV (w/ radio)
+
+   KWORLD KW-TVL878RF (low profile)
+
+   KWORLD KW-TV713XRF (saa7134)
+
+
+  MPEG TV Station (same cards as above plus WinDVR Software MPEG en/decoder)
+   KWORLD KW-TV878R -Pro   TV (no Radio)
+   KWORLD KW-TV878RF-Pro   TV (w/ Radio)
+   KWORLD KW-TV878R -Ultra TV (no Radio)
+   KWORLD KW-TV878RF-Ultra TV (w/ Radio)
+
+
 
 JTT/ Justy Corp.http://www.justy.co.jp/ (www.jtt.com.jp website down)
 ---------------------------------------------------------------------
@@ -793,7 +839,7 @@
    TV-FM =KNC1 saa7134
    Standard PCI (DVB-S) = Technotrend Budget
    Standard PCI (DVB-S) w/ CI
-   Satelco Hoghend PCI (DVB-S) = Technotrend Premium
+   Satelco Highend PCI (DVB-S) = Technotrend Premium
 
 
 Sensoray www.sensoray.com
@@ -879,3 +925,37 @@
 Mercury www.kobian.com (UK and FR)
     LR50
     LR138RBG-Rx  == LR138
+
+TEC sound (package and manuals don't have any other manufacturer info) TecSound
+    Though educated googling found: www.techmakers.com
+    TV-Mate = Zoltrix VP-8482
+
+Lorenzen www.lorenzen.de
+--------
+     SL DVB-S PCI = Technotrend Budget PCI (su1278 or bsru version)
+
+Origo (.uk) www.origo2000.com
+     PC TV Card = LR50
+
+I/O Magic www.iomagic.com
+---------
+    PC PVR - Desktop TV Personal Video Recorder DR-PCTV100 = Pinnacle ROB2D-51009464 4.0 + Cyberlink PowerVCR II
+
+Arowana
+-------
+    TV-Karte / Poso Power TV (?) = Zoltrix VP-8482 (?)
+
+iTVC15 boards:
+-------------
+kuroutoshikou.com ITVC15
+yuan.com MPG160 PCI TV (Internal PCI MPEG2 encoder card plus TV-tuner)
+
+Asus www.asuscom.com
+   Asus TV Tuner Card 880 NTSC (low profile, cx23880)
+   Asus TV (saa7134)
+
+Hoontech
+--------
+http://www.hoontech.com/korean/download/down_driver_list03.html
+   HART Vision 848 (H-ART Vision 848)
+   HART Vision 878 (H-Art Vision 878)
diff -u linux-2.5.69/Documentation/video4linux/bttv/Sound-FAQ linux/Documentation/video4linux/bttv/Sound-FAQ
--- linux-2.5.69/Documentation/video4linux/bttv/Sound-FAQ	2003-05-08 13:32:18.000000000 +0200
+++ linux/Documentation/video4linux/bttv/Sound-FAQ	2003-05-08 13:55:11.000000000 +0200
@@ -79,10 +79,11 @@
 What you have to do is figure out the correct values for gpiomask and
 the audiomux array.  If you have Windows and the drivers four your
 card installed, you might to check out if you can read these registers
-values used by the windows driver.  A tool to do this is available from
-ftp://telepresence.dmem.strath.ac.uk/pub/bt848/winutil, but it does'nt
-work with bt878 boards according to some reports I received.  Another
-one is available from http://www.kki.net.pl/~borgx/bTV.html.
+values used by the windows driver.  A tool to do this is available
+from ftp://telepresence.dmem.strath.ac.uk/pub/bt848/winutil, but it
+does'nt work with bt878 boards according to some reports I received.
+Another one with bt878 suport is available from
+http://btwincap.sourceforge.net/Files/btspy2.00.zip
 
 You might also dig around in the *.ini files of the Windows applications.
 You can have a look at the board to see which of the gpio pins are

-- 
sigfault
