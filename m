Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262597AbSJaP1z>; Thu, 31 Oct 2002 10:27:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262536AbSJaP1K>; Thu, 31 Oct 2002 10:27:10 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:39588 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP
	id <S262597AbSJaPYV>; Thu, 31 Oct 2002 10:24:21 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Thu, 31 Oct 2002 17:24:43 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: Linus Torvalds <torvalds@transmeta.com>,
       Kernel List <linux-kernel@vger.kernel.org>,
       video4linux list <video4linux-list@redhat.com>
Subject: [patch] bttv documentation update
Message-ID: <20021031162443.GA17465@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi Linus,

$subject says all: This patch updates the bttv documentation.

  Gerd

--- linux-2.5.45/Documentation/video4linux/bttv/CARDLIST	2002-10-31 14:02:41.000000000 +0100
+++ linux/Documentation/video4linux/bttv/CARDLIST	2002-10-31 14:20:28.000000000 +0100
@@ -2,13 +2,13 @@
   card=0 -  *** UNKNOWN/GENERIC *** 
   card=1 - MIRO PCTV
   card=2 - Hauppauge (bt848)
-  card=3 - STB
+  card=3 - STB, Gateway P/N 6000699 (bt848)
   card=4 - Intel Create and Share PCI/ Smart Video Recorder III
   card=5 - Diamond DTV2000
   card=6 - AVerMedia TVPhone
   card=7 - MATRIX-Vision MV-Delta
   card=8 - Lifeview FlyVideo II (Bt848) LR26
-  card=9 - IXMicro TurboTV
+  card=9 - IMS/IXmicro TurboTV
   card=10 - Hauppauge (bt878)
   card=11 - MIRO PCTV pro
   card=12 - ADS Technologies Channel Surfer TV (bt848)
@@ -24,22 +24,22 @@
   card=22 - Askey CPH050/ Phoebe Tv Master + FM
   card=23 - Modular Technology MM205 PCTV, bt878
   card=24 - Askey CPH05X/06X (bt878) [many vendors]
-  card=25 - Terratec Terra TV+ Version 1.0 (Bt848)/Vobis TV-Boostar
+  card=25 - Terratec TerraTV+ Version 1.0 (Bt848)/ Terra TValue Version 1.0/ Vobis TV-Boostar
   card=26 - Hauppauge WinCam newer (bt878)
   card=27 - Lifeview FlyVideo 98/ MAXI TV Video PCI2 LR50
-  card=28 - Terratec TerraTV+
+  card=28 - Terratec TerraTV+ Version 1.1 (bt878)
   card=29 - Imagenation PXC200
   card=30 - Lifeview FlyVideo 98 LR50
   card=31 - Formac iProTV
   card=32 - Intel Create and Share PCI/ Smart Video Recorder III
-  card=33 - Terratec TerraTValue
-  card=34 - Leadtek WinFast 2000
+  card=33 - Terratec TerraTValue Version Bt878
+  card=34 - Leadtek WinFast 2000/ WinFast 2000 XP
   card=35 - Lifeview FlyVideo 98 LR50 / Chronos Video Shuttle II
   card=36 - Lifeview FlyVideo 98FM LR50 / Typhoon TView TV/FM Tuner
   card=37 - Prolink PixelView PlayTV pro
   card=38 - Askey CPH06X TView99
   card=39 - Pinnacle PCTV Studio/Rave
-  card=40 - STB2
+  card=40 - STB TV PCI FM, Gateway P/N 6000704 (bt878)
   card=41 - AVerMedia TVPhone 98
   card=42 - ProVideo PV951
   card=43 - Little OnAir TV
@@ -78,14 +78,17 @@
   card=76 - Canopus WinDVR PCI (COMPAQ Presario 3524JP, 5112JP)
   card=77 - GrandTec Multi Capture Card (Bt878)
   card=78 - Jetway TV/Capture JW-TV878-FBK, Kworld KW-TV878RF
+  card=79 - DSP Design TCVIDEO
+  card=80 - Hauppauge WinTV PVR
+  card=81 - GV-BCTV5/PCI
 
 tuner.o
   type=0 - Temic PAL (4002 FH5)
-  type=1 - Philips PAL_I
-  type=2 - Philips NTSC
-  type=3 - Philips SECAM
+  type=1 - Philips PAL_I (FI1246 and compatibles)
+  type=2 - Philips NTSC (FI1236 and compatibles)
+  type=3 - Philips (SECAM+PAL_BG) (FI1216MF, FM1216MF, FR1216MF)
   type=4 - NoTuner
-  type=5 - Philips PAL
+  type=5 - Philips PAL_BG (FI1216 and compatibles)
   type=6 - Temic NTSC (4032 FY5)
   type=7 - Temic PAL_I (4062 FY5)
   type=8 - Temic NTSC (4036 FY5)
@@ -103,7 +106,7 @@
   type=20 - Temic PAL_BG (4009 FR5) or PAL_I (4069 FR5)
   type=21 - Temic NTSC (4039 FR5)
   type=22 - Temic PAL/SECAM multi (4046 FM5)
-  type=23 - Philips PAL_DK
+  type=23 - Philips PAL_DK (FI1256 and compatibles)
   type=24 - Philips PAL/SECAM multi (FQ1216ME)
   type=25 - LG PAL_I+FM (TAPC-I001D)
   type=26 - LG PAL_I (TAPC-I701D)
@@ -118,3 +121,5 @@
   type=35 - Temic PAL_DK/SECAM_L (4012 FY5)
   type=36 - Temic NTSC (4136 FY5)
   type=37 - LG PAL (newer TAPC series)
+  type=38 - Philips PAL/SECAM multi (FM1216ME MK3)
+  type=39 - LG NTSC (newer TAPC series)
--- linux-2.5.45/Documentation/video4linux/bttv/Cards	2002-10-31 14:03:10.000000000 +0100
+++ linux/Documentation/video4linux/bttv/Cards	2002-10-31 14:20:28.000000000 +0100
@@ -157,6 +157,7 @@
 		   Flyvideo 2000S (Bt878) w/Stereo TV (Package incl. LR91 daughterboard)
       LR91       = Stereo daughter card for LR90
       LR97       = Flyvideo DVBS
+      LR99 Rev.E = Low profile card for OEM integration (only internal audio!) bt878
       LR136	 = Flyvideo 2100/3100 (Low profile, SAA7130/SAA7134)
       LR137      = Flyvideo DV2000/DV3000 (SAA7130/SAA7134 + IEEE1394)
       LR138 Rev.C= Flyvideo 2000 (SAA7130)
@@ -236,6 +237,7 @@
    Further Cards:
    PV-BT878P+rev.9B (Play TV Pro, opt. w/FM w/NICAM)
    PV-BT878P+rev.2F
+   PV-BT878P Rev.1D (bt878, capture only)
    
    Video Conferencing:
    PixelView Meeting PAK - (Model: PV-BT878P)
@@ -273,6 +275,7 @@
    WinView 601 (Bt848)
    WinView 610 (Zoran)
    WinFast2000
+   WinFast2000 XP
 
 KNC One
 -------
@@ -282,15 +285,19 @@
    TV-Station FM (+Radio)
    TV-Station RDS (+RDS)
 
-Provideo PV951 
---------------
-  These are sold as:
+   newer Cards have saa7134, but model name stayed the same?
+
+Provideo 
+--------
+  PV951 or PV-951 (also are sold as:
    Boeder TV-FM Video Capture Card
    Titanmedia Supervision TV-2400
    Provideo PV951 TF
    3DeMon PV951
    MediaForte TV-Vision PV951
    Yoko PV951
+  )
+  PV-148 (capture only)
 
 Highscreen
 ----------
@@ -320,15 +327,47 @@
 
    PCB      PCI-ID      Model-Name      Eeprom  Tuner  Sound    Country
    --------------------------------------------------------------------
-   M1A8-A      --       AVer TV-Phone           FM1216  --
+   M101.C   ISA !
+   M108-B      Bt848                     --     FR1236		 US   (2),(3)
+   M1A8-A      Bt848    AVer TV-Phone           FM1216  --
    M168-T   1461:0003   AVerTV Studio   48:17   FM1216 TDA9840T  D    (1) w/FM w/Remote
    M168-U   1461:0004   TVCapture98     40:11   FI1216   --      D    w/Remote
    M168II-B 1461:0003   Medion MD9592   48:16   FM1216 TDA9873H  D    w/FM
 
    (1) Daughterboard MB68-A with TDA9820T and TDA9840T
+   (2) Sony NE41S soldered (stereo sound?)
+   (3) Daughterboard M118-A w/ pic 16c54 and 4 MHz quartz
+ 
+   US site has different drivers for (as of 09/2002):
+   EZ Capture/InterCam PCI (BT-848 chip)
+   EZ Capture/InterCam PCI (BT-878 chip)
+   TV-Phone (BT-848 chip)
+   TV98 (BT-848 chip)
+   TV98 With Remote (BT-848 chip)
+   TV98 (BT-878 chip)
+   TV98 With Remote (BT-878)
+   TV/FM98 (BT-878 chip)
+   AVerTV
+   AverTV Stereo
+   AVerTV Studio
+
+   DE hat diverse Treiber fuer diese Modelle (Stand 09/2002):
+   TVPhone (848) mit Philips tuner FR12X6 (w/ FM radio)
+   TVPhone (848) mit Philips tuner FM12X6 (w/ FM radio)
+   TVCapture (848) w/Philips tuner FI12X6
+   TVCapture (848) non-Philips tuner
+   TVCapture98 (Bt878)
+   TVPhone98 (Bt878)
+   AVerTV und TVCapture98 w/VCR (Bt 878)
+   AVerTVStudio und TVPhone98 w/VCR (Bt878)
+   AVerTV GO Serie (Kein SVideo Input)
+   AVerTV98 (BT-878 chip)
+   AVerTV98 mit Fernbedienung (BT-878 chip)
+   AVerTV/FM98 (BT-878 chip)
 
 Aimslab
 -------
+   Video Highway or "Video Highway TR200" (ISA)
    Video Highway Xtreme (aka "VHX") (Bt848, FM w/ TEA5757)
 
 IXMicro (former: IMS=Integrated Micro Solutions)
@@ -364,6 +403,9 @@
 
    LR74 is a newer PCB revision of ceb105 (both incl. connector for Active Radio Upgrade)
 
+   Cinergy 400 (saa7134), "E877 11(S)", "PM820092D" printed on PCB
+   Cinergy 600 (saa7134)
+
 Technisat
 ---------
    Discos ADR PC-Karte ISA (no TV!)
@@ -373,7 +415,7 @@
    Mediafocus I (zr36120/zr36125, drp3510, Sat. analog + ADR Radio)
    Mediafocus II (saa7146, Sat. analog)
          SatADR Rev 2.1 (saa7146a, saa7113h, stv0056a, msp3400c, drp3510a, BSKE3-307A)
-   SkyStar 1 DVB  (AV7110)
+   SkyStar 1 DVB  (AV7110) = Technotrend Premium
    SkyStar 2 DVB  (B2C2) (=Sky2PC)
 
 Siemens
@@ -387,6 +429,9 @@
 Powercolor
 ----------
    MTV878
+       Package comes with different contents:
+       a) pcb "MTV878" (CARD=75)
+       b) Pixelview Rev. 4_
    MTV878R w/Remote Control
    MTV878F w/Remote Control w/FM radio
 
@@ -394,10 +439,14 @@
 --------
    Mirovideo PCTV (Bt848)
    Mirovideo PCTV SE (Bt848)
-   Mirovideo PCTV Pro (Bt848 + Daughterboard)
+   Mirovideo PCTV Pro (Bt848 + Daughterboard for TV Stereo and FM)
+   Studio PCTV Rave (Bt848 Version = Mirovideo PCTV)
    Studio PCTV Rave (Bt878 package w/o infrared)
    Studio PCTV      (Bt878)
    Studio PCTV Pro  (Bt878 stereo w/ FM)
+   Pinnacle PCTV    (Bt878, MT2032)
+   Pinnacle PCTV Pro (Bt878, MT2032)
+   Pinncale PCTV Sat
 
    M(J)PEG capture and playback:
    DC1+ (ISA)
@@ -495,8 +544,10 @@
 
 STB
 ---
-   TV PCI (Temic4032FY5, tda9850??)
-   other variants?
+   STB bt878 == Gateway 6000704 
+   STB Gateway 6000699 (bt848)
+   STB Gateway 6000402 (bt848)
+   STB TV130 PCI
 
 Videologic
 ----------
@@ -507,6 +558,16 @@
 ------------
    TT-SAT PCI (PCB "Sat-PCI Rev.:1.3.1"; zr36125, vpx3225d, stc0056a, Tuner:BSKE6-155A
    TT-DVB-Sat
+    This card is sold as OEM from:
+	Siemens DVB-s Card
+	Hauppauge WinTV DVB-S
+	Technisat SkyStar 1 DVB
+	Galaxis DVB Sat
+    Now this card is called TT-PCline Premium Family
+   TT-Budget
+    This card is sold as OEM from:
+	Hauppauge WinTV Nova
+	Satelco Standard PCI (DVB-S)
    TT-DVB-C PCI
 
 Teles
@@ -546,10 +607,13 @@
 Hauppauge
 ---------
    many many WinTV models ...
-   WinTV DVBs
-   WinTV NOVA
+   WinTV DVBs = Tehcnotrend Premium
+   WinTV NOVA = Technotrend Budget
    WinTV NOVA-CI
    WinTV-Nexus-s
+   WinTV PVR
+   WinTV PVR 250
+   WinTV PVR 450
 
 Matrix-Vision
 -------------
@@ -615,7 +679,7 @@
 
 NoBrand
 -------
-   TV Excel = Australian Name for "PV-BT878P+ 8E" or so
+   TV Excel = Australian Name for "PV-BT878P+ 8E" or "878TV Rev.3_"
 
 Mach www.machspeed.com
 ----
@@ -638,9 +702,51 @@
 Satelco
 -------
    TV-FM =KNC1 saa7134
+   Standard PCI (DVB-S) = Technotrend Budget
+   Standard PCI (DVB-S) w/ CI
+   Satelco Hoghend PCI (DVB-S) = Technotrend Premium
+
 
 Sensoray www.sensoray.com
 --------
    Sensoray 311 (PC/104 bus)
    Sensoray 611 (PCI)
 
+CEI (Chartered Electronics Industries Pte Ltd [CEI] [FCC ID HBY])
+---
+  TV Tuner  -  HBY-33A-RAFFLES  Brooktree Bt848KPF + Philips
+  TV Tuner MG9910  -  HBY33A-TVO  CEI + Philips SAA7110 + OKI M548262 + ST STV8438CV
+  Primetime TV (ISA)
+   acquired by Singapore Technologies
+   now operating as Chartered Semiconductor Manufacturing
+   Manufacturer of video cards is listed as:
+   Cogent Electronics Industries [CEI]
+
+AITech
+------
+   AITech WaveWatcher TV-PCI = LR26
+   WaveWatcher TVR-202 TV/FM Radio Card (ISA)
+
+MAXRON
+------
+   Maxron MaxTV/FM Radio (KW-TV878-FNT) = Kworld or JW-TV878-FBK
+
+www.ids-imaging.de
+------------------
+   Falcon Series (capture only)
+ In USA: http://www.theimagingsource.com/
+   DFG/LC1	
+
+www.sknet-web.co.jp
+-------------------
+   SKnet Monster TV (saa7134)
+
+A-Max www.amaxhk.com (Colormax, Amax, Napa)
+-------------------
+   APAC Viewcomp 878
+
+Cybertainment
+-------------
+   CyberMail AV Video Email Kit w/ PCI Capture Card (capture only)
+   CyberMail Xtreme
+  These are Flyvideo
--- linux-2.5.45/Documentation/video4linux/bttv/README	2002-10-31 14:02:37.000000000 +0100
+++ linux/Documentation/video4linux/bttv/README	2002-10-31 14:20:28.000000000 +0100
@@ -76,6 +76,12 @@
 video but no sound you've very likely specified the wrong (or no)
 card type.  A list of supported cards is in CARDLIST.
 
+For the WinTV/PVR you need one firmware file from the driver CD:
+hcwamc.rbf.  The file is in the pvr45xxx.exe archive (self-extracting
+zip file, unzip can unpack it).  Put it into the /etc/pvr directory or
+use the firm_altera=<path> insmod option to point the driver to the
+location of the file.
+
 If your card isn't listed in CARDLIST or if you have trouble making
 audio work, you should read the Sound-FAQ.
 
--- linux-2.5.45/Documentation/video4linux/bttv/README.freeze	2002-10-31 14:02:30.000000000 +0100
+++ linux/Documentation/video4linux/bttv/README.freeze	2002-10-31 14:20:28.000000000 +0100
@@ -61,6 +61,9 @@
 other
 -----
 
+If you use some binary-only yunk (like nvidia module) try to reproduce
+the problem without.
+
 IRQ sharing is known to cause problems in some cases.  It works just
 fine in theory and many configurations.  Neverless it might be worth a
 try to shuffle around the PCI cards to give bttv another IRQ or make
--- linux-2.5.45/Documentation/video4linux/bttv/Tuners	2002-10-31 14:02:22.000000000 +0100
+++ linux/Documentation/video4linux/bttv/Tuners	2002-10-31 14:20:28.000000000 +0100
@@ -1,3 +1,16 @@
+1) Tuner Programming
+====================
+There are some flavors of Tuner programming APIs.
+These differ mainly by the bandswitch byte.
+
+    L= LG_API       (VHF_LO=0x01, VHF_HI=0x02, UHF=0x08, radio=0x04)
+    P= PHILIPS_API  (VHF_LO=0xA0, VHF_HI=0x90, UHF=0x30, radio=0x04)
+    T= TEMIC_API    (VHF_LO=0x02, VHF_HI=0x04, UHF=0x01)
+    A= ALPS_API     (VHF_LO=0x14, VHF_HI=0x12, UHF=0x11)
+    M= PHILIPS_MK3  (VHF_LO=0x01, VHF_HI=0x02, UHF=0x04, radio=0x19)
+
+2) Tuner Manufacturers
+======================
 
 SAMSUNG Tuner identification: (e.g. TCPM9091PD27)
   TCP [ABCJLMNQ] 90[89][125] [DP] [ACD] 27 [ABCD]
@@ -24,6 +37,8 @@
  [ABCD]:
    3-wire/I2C tuning, 2-band/3-band
 
+ These Tuners are PHILIPS_API compatible.
+
 Philips Tuner identification: (e.g. FM1216MF)
   F[IRMQ]12[1345]6{MF|ME|MP}
   F[IRMQ]:
@@ -39,15 +54,17 @@
    1246: PAL I
    1256: Pal DK
   {MF|ME|MP}
-   MF: w/ Secam
+   MF: BG LL w/ Secam (Multi France)
    ME: BG DK I LL   (Multi Europe)
    MP: BG DK I      (Multi PAL)
    MR: BG DK M (?)
    MG: BG DKI M (?)
+  MK2 series PHILIPS_API, most tuners are compatible to this one !
+  MK3 series introduced in 2002 w/ PHILIPS_MK3_API
 
 Temic Tuner identification: (.e.g 4006FH5)
    4[01][0136][269]F[HYNR]5
-    40x2: Tuner (5V/33V), different I2C programming from Philips !
+    40x2: Tuner (5V/33V), TEMIC_API.
     40x6: Tuner 5V
     41xx: Tuner compact
     40x9: Tuner+FM compact
@@ -62,6 +79,7 @@
     FN5: multistandard
     FR5: w/ FM radio
    3X xxxx: order number with specific connector
+  Note: Only 40x2 series has TEMIC_API, all newer tuners have PHILIPS_API.
 
 LG Innotek Tuner:
   TPI8NSR11 : NTSC J/M    (TPI8NSR01 w/FM)  (P,210/497)
@@ -78,12 +96,6 @@
   TADC-H002F: NTSC (L,175/410?; 2-B, C-W+11, W+12-69)
   TADC-M201D: PAL D/K+B/G+I (L,143/425)  (sound control at I2C address 0xc8)
   TADC-T003F: NTSC Taiwan  (L,175/410?; 2-B, C-W+11, W+12-69)
-
-  (API,Lo-Hi-takeover/Hi-UHF-takeover)
-   I2C APIs:
-    L= LG programming (VHF_LO=0x01, VHF_HI=0x02, UHF=0x08, radio=0x04)
-    P= Philips progr. (VHF_LO=0xA0, VHF_HI=0x90, UHF=0x30, radio=0x04)
-    T= Temic progr.   (VHF_LO=0x02, VHF_HI=0x04, UHF=0x01)
   Suffix: 
     P= Standard phono female socket
     D= IEC female socket
@@ -93,3 +105,11 @@
 TCL2002MB-1 : PAL BG + DK       =TUNER_LG_PAL_NEW_TAPC
 TCL2002MB-1F: PAL BG + DK w/FM  =PHILIPS_PAL
 TCL2002MI-2 : PAL I		= ??
+
+ALPS Tuners:
+   Most are LG_API compatible
+   TSCH6 has ALPS_API (TSCH5 ?)
+   TSBE1 has extra API 05,02,08 Control_byte=0xCB Source:(1)
+
+Lit.
+(1) conexant100029b-PCI-Decoder-ApplicationNote.pdf

-- 
You can't please everybody.  And usually if you _try_ to please
everybody, the end result is one big mess.
				-- Linus Torvalds, 2002-04-20
