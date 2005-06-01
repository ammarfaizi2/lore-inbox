Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261192AbVFADZO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261192AbVFADZO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 23:25:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261214AbVFADZO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 23:25:14 -0400
Received: from wproxy.gmail.com ([64.233.184.196]:27727 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261192AbVFADYs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 23:24:48 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:x-enigmail-version:content-type;
        b=LbjmTDq7UfaIEGWTYFhEEmfqtnAz53F/wC9xx7k+3JcrPpQ1Ln93ZxAXeNwAQoVx43yxgHTzdyJXLZnHAdhH+UTYumHbBt88kDq8sqSoaJzAbwsgeyCuN8C+m+HAmxGMnV2kdzsXWYPAz8LAGLLQnJc8b9wTdZU1ZtrHtgCULl0=
Message-ID: <429D2A7C.1080002@gmail.com>
Date: Wed, 01 Jun 2005 00:24:44 -0300
From: Mauro Carvalho Chehab <maurochehab@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.2-3mdk (X11/20050322)
X-Accept-Language: pt-br, pt, es, en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Linux and Kernel Video <video4linux-list@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: [PATCH] Video for Linux Docummentation
X-Enigmail-Version: 0.91.0.0
Content-Type: multipart/mixed;
 boundary="------------050901050006080403080704"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050901050006080403080704
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

This patch synchronizes documentation from V4L CVS with current kernel
release.


--------------050901050006080403080704
Content-Type: text/x-patch;
 name="doc.diff"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
 filename="doc.diff"

diff -urN /usr/src/linux-2.6.12-rc5-mm/Documentation/video4linux/CARDLIST.bttv kernel//Documentation/video4linux/CARDLIST.bttv
--- /usr/src/linux-2.6.12-rc5-mm/Documentation/video4linux/CARDLIST.bttv	2005-05-31 23:17:31.000000000 -0300
+++ kernel//Documentation/video4linux/CARDLIST.bttv	2005-05-30 12:30:09.000000000 -0300
@@ -119,3 +119,17 @@
 card=118 - LMLBT4
 card=119 - Tekram M205 PRO
 card=120 - Conceptronic CONTVFMi
+card=121 - Euresys Picolo Tetra
+card=122 - Spirit TV Tuner
+card=123 - AVerMedia AVerTV DVB-T 771
+card=124 - AverMedia AverTV DVB-T 761
+card=125 - MATRIX Vision Sigma-SQ
+card=126 - MATRIX Vision Sigma-SLC
+card=127 - APAC Viewcomp 878(AMAX)
+card=128 - DVICO FusionHDTV DVB-T Lite
+card=129 - V-Gear MyVCD
+card=130 - Super TV Tuner
+card=131 - Tibet Systems 'Progress DVR' CS16
+card=132 - Kodicom 4400R (master)
+card=133 - Kodicom 4400R (slave)
+card=134 - Adlink RTV24
diff -urN /usr/src/linux-2.6.12-rc5-mm/Documentation/video4linux/CARDLIST.cx88 kernel//Documentation/video4linux/CARDLIST.cx88
--- /usr/src/linux-2.6.12-rc5-mm/Documentation/video4linux/CARDLIST.cx88	1969-12-31 21:00:00.000000000 -0300
+++ kernel//Documentation/video4linux/CARDLIST.cx88	2005-05-30 12:30:09.000000000 -0300
@@ -0,0 +1,29 @@
+card=0 - UNKNOWN/GENERIC
+card=1 - Hauppauge WinTV 34xxx models
+card=2 - GDI Black Gold
+card=3 - PixelView
+card=4 - ATI TV Wonder Pro
+card=5 - Leadtek Winfast 2000XP Expert
+card=6 - AverTV Studio 303 (M126)
+card=7 - MSI TV-@nywhere Master
+card=8 - Leadtek Winfast DV2000
+card=9 - Leadtek PVR 2000
+card=10 - IODATA GV-VCP3/PCI
+card=11 - Prolink PlayTV PVR
+card=12 - ASUS PVR-416
+card=13 - MSI TV-@nywhere
+card=14 - KWorld/VStream XPert DVB-T
+card=15 - DVICO FusionHDTV DVB-T1
+card=16 - KWorld LTV883RF
+card=17 - DViCO - FusionHDTV 3 Gold
+card=18 - Hauppauge Nova-T DVB-T
+card=19 - Conexant DVB-T reference design
+card=20 - Provideo PV259
+card=21 - DVICO FusionHDTV DVB-T Plus
+card=22 - digitalnow DNTV Live! DVB-T
+card=23 - pcHDTV HD3000 HDTV
+card=24 - Hauppauge WinTV 28xxx (Roslyn) models
+card=25 - Digital-Logic MICROSPACE Entertainment Center (MEC)
+card=26 - IODATA GV/BCTV7E
+card=27 - PixelView PlayTV Ultra Pro (Stereo)
+card=28 - DViCO - FusionHDTV 3 Gold-Q
diff -urN /usr/src/linux-2.6.12-rc5-mm/Documentation/video4linux/CARDLIST.saa7134 kernel//Documentation/video4linux/CARDLIST.saa7134
--- /usr/src/linux-2.6.12-rc5-mm/Documentation/video4linux/CARDLIST.saa7134	2005-05-31 23:17:31.000000000 -0300
+++ kernel//Documentation/video4linux/CARDLIST.saa7134	2005-05-30 12:30:09.000000000 -0300
@@ -7,29 +7,50 @@
   6 -> Tevion MD 9717                          
   7 -> KNC One TV-Station RDS / Typhoon TV Tuner RDS [1131:fe01,1894:fe01]
   8 -> Terratec Cinergy 400 TV                  [153B:1142]
-  9 -> Medion 5044
- 10 -> Kworld/KuroutoShikou SAA7130-TVPCI
+  9 -> Medion 5044                             
+ 10 -> Kworld/KuroutoShikou SAA7130-TVPCI      
  11 -> Terratec Cinergy 600 TV                  [153B:1143]
  12 -> Medion 7134                              [16be:0003]
- 13 -> Typhoon TV+Radio 90031
+ 13 -> Typhoon TV+Radio 90031                  
  14 -> ELSA EX-VISION 300TV                     [1048:226b]
  15 -> ELSA EX-VISION 500TV                     [1048:226b]
  16 -> ASUS TV-FM 7134                          [1043:4842,1043:4830,1043:4840]
  17 -> AOPEN VA1000 POWER                       [1131:7133]
- 18 -> BMK MPEX No Tuner
+ 18 -> BMK MPEX No Tuner                       
  19 -> Compro VideoMate TV                      [185b:c100]
  20 -> Matrox CronosPlus                        [102B:48d0]
  21 -> 10MOONS PCI TV CAPTURE CARD              [1131:2001]
- 22 -> Medion 2819/ AverMedia M156              [1461:a70b,1461:2115]
- 23 -> BMK MPEX Tuner
+ 22 -> AverMedia M156 / Medion 2819             [1461:a70b]
+ 23 -> BMK MPEX Tuner                          
  24 -> KNC One TV-Station DVR                   [1894:a006]
  25 -> ASUS TV-FM 7133                          [1043:4843]
  26 -> Pinnacle PCTV Stereo (saa7134)           [11bd:002b]
- 27 -> Manli MuchTV M-TV002
- 28 -> Manli MuchTV M-TV001
+ 27 -> Manli MuchTV M-TV002/Behold TV 403 FM   
+ 28 -> Manli MuchTV M-TV001/Behold TV 401      
  29 -> Nagase Sangyo TransGear 3000TV           [1461:050c]
  30 -> Elitegroup ECS TVP3XP FM1216 Tuner Card(PAL-BG,FM)  [1019:4cb4]
  31 -> Elitegroup ECS TVP3XP FM1236 Tuner Card (NTSC,FM) [1019:4cb5]
- 32 -> AVACS SmartTV
+ 32 -> AVACS SmartTV                           
  33 -> AVerMedia DVD EZMaker                    [1461:10ff]
- 34 -> LifeView FlyTV Platinum33 mini           [5168:0212]
+ 34 -> Noval Prime TV 7133                     
+ 35 -> AverMedia AverTV Studio 305              [1461:2115]
+ 37 -> Items MuchTV Plus / IT-005              
+ 38 -> Terratec Cinergy 200 TV                  [153B:1152]
+ 39 -> LifeView FlyTV Platinum Mini             [5168:0212]
+ 40 -> Compro VideoMate TV PVR/FM               [185b:c100]
+ 41 -> Compro VideoMate TV Gold+                [185b:c100]
+ 42 -> Sabrent SBT-TVFM (saa7130)              
+ 43 -> :Zolid Xpert TV7134                     
+ 44 -> Empire PCI TV-Radio LE                  
+ 45 -> Avermedia AVerTV Studio 307              [1461:9715]
+ 46 -> AVerMedia Cardbus TV/Radio               [1461:d6ee]
+ 47 -> Terratec Cinergy 400 mobile              [153b:1162]
+ 48 -> Terratec Cinergy 600 TV MK3              [153B:1158]
+ 49 -> Compro VideoMate Gold+ Pal               [185b:c200]
+ 50 -> Pinnacle PCTV 300i DVB-T + PAL           [11bd:002d]
+ 51 -> ProVideo PV952                           [1540:9524]
+ 52 -> AverMedia AverTV/305                     [1461:2108]
+ 54 -> LifeView FlyTV Platinum FM               [5168:0214,1489:0214]
+ 55 -> LifeView FlyDVB-T DUO                    [5168:0306]
+ 56 -> Avermedia AVerTV 307                     [1461:a70a]
+ 57 -> Avermedia AVerTV GO 007 FM               [1461:f31f]
diff -urN /usr/src/linux-2.6.12-rc5-mm/Documentation/video4linux/CARDLIST.tuner kernel//Documentation/video4linux/CARDLIST.tuner
--- /usr/src/linux-2.6.12-rc5-mm/Documentation/video4linux/CARDLIST.tuner	2005-05-31 23:17:31.000000000 -0300
+++ kernel//Documentation/video4linux/CARDLIST.tuner	2005-05-30 12:30:09.000000000 -0300
@@ -44,3 +44,18 @@
 tuner=43 - Philips NTSC MK3 (FM1236MK3 or FM1236/F)
 tuner=44 - Philips 4 in 1 (ATI TV Wonder Pro/Conexant)
 tuner=45 - Microtune 4049 FM5
+tuner=46 - Panasonic VP27s/ENGE4324D
+tuner=47 - LG NTSC (TAPE series)
+tuner=48 - Tenna TNF 8831 BGFF)
+tuner=49 - Microtune 4042 FI5 ATSC/NTSC dual in
+tuner=50 - TCL 2002N
+tuner=51 - Philips PAL/SECAM_D (FM 1256 I-H3)
+tuner=52 - Thomson DDT 7610 (ATSC/NTSC)
+tuner=53 - Philips FQ1286
+tuner=54 - tda8290+75
+tuner=55 - LG PAL (TAPE series)
+tuner=56 - Philips PAL/SECAM multi (FQ1216AME MK4)
+tuner=57 - Philips FQ1236A MK4
+tuner=58 - Ymec TVision TVF-8531MF
+tuner=59 - Ymec TVision TVF-5533MF
+tuner=60 - Thomson DDT 7611
diff -urN /usr/src/linux-2.6.12-rc5-mm/Documentation/video4linux/hauppauge-wintv-cx88-ir.txt kernel//Documentation/video4linux/hauppauge-wintv-cx88-ir.txt
--- /usr/src/linux-2.6.12-rc5-mm/Documentation/video4linux/hauppauge-wintv-cx88-ir.txt	1969-12-31 21:00:00.000000000 -0300
+++ kernel//Documentation/video4linux/hauppauge-wintv-cx88-ir.txt	2004-08-26 07:03:51.000000000 -0300
@@ -0,0 +1,54 @@
+The controls for the mux are GPIO [0,1] for source, and GPIO 2 for muting.
+
+GPIO0  GPIO1 
+  0        0    TV Audio
+  1        0    FM radio
+  0        1    Line-In
+  1        1    Mono tuner bypass or CD passthru (tuner specific)
+
+GPIO 16(i believe) is tied to the IR port (if present).
+
+------------------------------------------------------------------------------------
+
+>From the data sheet:
+ Register 24'h20004  PCI Interrupt Status
+  bit [18]  IR_SMP_INT Set when 32 input samples have been collected over
+  gpio[16] pin into GP_SAMPLE register.
+
+What's missing from the data sheet:
+
+Setup 4KHz sampling rate (roughly 2x oversampled; good enough for our RC5
+compat remote)
+set register 0x35C050 to  0xa80a80
+
+enable sampling
+set register 0x35C054 to 0x5
+
+Of course, enable the IRQ bit 18 in the interrupt mask register .(and
+provide for a handler)
+
+GP_SAMPLE register is at 0x35C058
+
+Bits are then right shifted into the GP_SAMPLE register at the specified
+rate; you get an interrupt when a full DWORD is recieved.
+You need to recover the actual RC5 bits out of the (oversampled) IR sensor
+bits. (Hint: look for the 0/1and 1/0 crossings of the RC5 bi-phase data)  An
+actual raw RC5 code will span 2-3 DWORDS, depending on the actual alignment.
+
+I'm pretty sure when no IR signal is present the receiver is always in a
+marking state(1); but stray light, etc can cause intermittent noise values
+as well.  Remember, this is a free running sample of the IR receiver state
+over time, so don't assume any sample starts at any particular place.
+
+http://www.atmel.com/dyn/resources/prod_documents/doc2817.pdf
+This data sheet (google search) seems to have a lovely description of the
+RC5 basics
+
+http://users.pandora.be/nenya/electronics/rc5/  and more data
+
+http://www.ee.washington.edu/circuit_archive/text/ir_decode.txt
+and even a reference to how to decode a bi-phase data stream.
+
+http://www.xs4all.nl/~sbp/knowledge/ir/rc5.htm
+still more info
+
diff -urN /usr/src/linux-2.6.12-rc5-mm/Documentation/video4linux/lifeview.txt kernel//Documentation/video4linux/lifeview.txt
--- /usr/src/linux-2.6.12-rc5-mm/Documentation/video4linux/lifeview.txt	1969-12-31 21:00:00.000000000 -0300
+++ kernel//Documentation/video4linux/lifeview.txt	2005-02-18 14:18:23.000000000 -0200
@@ -0,0 +1,42 @@
+collecting data about the lifeview models and the config coding on
+gpio pins 0-9 ...
+==================================================================
+
+bt878:
+ LR50 rev. Q ("PARTS: 7031505116), Tuner wurde als Nr. 5 erkannt, Eingänge 
+ SVideo, TV, Composite, Audio, Remote. CP9..1=100001001 (1: 0-Ohm-Widerstand 
+ gegen GND unbestückt; 0: bestückt)
+
+------------------------------------------------------------------------------
+
+saa7134:
+                /* LifeView FlyTV Platinum FM (LR214WF) */
+                /* "Peter Missel <peter.missel@onlinehome.de> */
+                .name           = "LifeView FlyTV Platinum FM",
+                /*      GP27    MDT2005 PB4 pin 10 */
+                /*      GP26    MDT2005 PB3 pin 9 */
+                /*      GP25    MDT2005 PB2 pin 8 */
+                /*      GP23    MDT2005 PB1 pin 7 */
+                /*      GP22    MDT2005 PB0 pin 6 */
+                /*      GP21    MDT2005 PB5 pin 11 */
+                /*      GP20    MDT2005 PB6 pin 12 */
+                /*      GP19    MDT2005 PB7 pin 13 */
+                /*      nc      MDT2005 PA3 pin 2 */
+                /*      Remote  MDT2005 PA2 pin 1 */
+                /*      GP18    MDT2005 PA1 pin 18 */
+                /*      nc      MDT2005 PA0 pin 17 strap low */
+
+                /*      GP17    Strap "GP7"=High */
+                /*      GP16    Strap "GP6"=High
+                                0=Radio 1=TV
+                                Drives SA630D ENCH1 and HEF4052 A1 pins
+                                to do FM radio through SIF input */
+                /*      GP15    nc */
+                /*      GP14    nc */
+                /*      GP13    nc */
+                /*      GP12    Strap "GP5" = High */
+                /*      GP11    Strap "GP4" = High */
+                /*      GP10    Strap "GP3" = High */
+                /*      GP09    Strap "GP2" = Low */
+                /*      GP08    Strap "GP1" = Low */
+                /*      GP07.00 nc */
diff -urN /usr/src/linux-2.6.12-rc5-mm/Documentation/video4linux/not-in-cx2388x-datasheet.txt kernel//Documentation/video4linux/not-in-cx2388x-datasheet.txt
--- /usr/src/linux-2.6.12-rc5-mm/Documentation/video4linux/not-in-cx2388x-datasheet.txt	1969-12-31 21:00:00.000000000 -0300
+++ kernel//Documentation/video4linux/not-in-cx2388x-datasheet.txt	2004-02-21 22:59:36.000000000 -0300
@@ -0,0 +1,37 @@
+=================================================================================
+MO_OUTPUT_FORMAT (0x310164)
+
+  Previous default from DScaler: 0x1c1f0008
+  Digit 8: 31-28
+  28: PREVREMOD = 1
+
+  Digit 7: 27-24 (0xc = 12 = b1100 )
+  27: COMBALT = 1
+  26: PAL_INV_PHASE
+    (DScaler apparently set this to 1, resulted in sucky picture)
+
+  Digits 6,5: 23-16
+  25-16: COMB_RANGE = 0x1f [default] (9 bits -> max 512)
+
+  Digit 4: 15-12
+  15: DISIFX = 0
+  14: INVCBF = 0
+  13: DISADAPT = 0
+  12: NARROWADAPT = 0
+
+  Digit 3: 11-8
+  11: FORCE2H
+  10: FORCEREMD
+  9: NCHROMAEN
+  8: NREMODEN
+
+  Digit 2: 7-4
+  7-6: YCORE
+  5-4: CCORE
+
+  Digit 1: 3-0
+  3: RANGE = 1
+  2: HACTEXT
+  1: HSFMT
+
+=================================================================================

--------------050901050006080403080704--
