Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262221AbUDEMlv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 08:41:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262329AbUDEMlv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 08:41:51 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:55715 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S262221AbUDEMll
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 08:41:41 -0400
X-Envelope-From: kraxel@bytesex.org
Date: Mon, 5 Apr 2004 14:41:03 +0200
From: Gerd Knorr <kraxel@bytesex.org>
To: Andrew Morton <akpm@osdl.org>, Kernel List <linux-kernel@vger.kernel.org>
Subject: [patch] v4l: documentation update
Message-ID: <20040405124103.GA30293@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

This patch updates the documentation for the v4l drivers.

I'd like also remove the Documentation/video4linux/bttv/Mod*.conf files,
how to do that best?  Tell Linus to "bk remove" them?  Just mail a GNU
patch which does?

  Gerd

diff -up linux-2.6.5/Documentation/video4linux/CARDLIST.bttv linux/Documentation/video4linux/CARDLIST.bttv
--- linux-2.6.5/Documentation/video4linux/CARDLIST.bttv	2004-04-05 10:39:12.262059268 +0200
+++ linux/Documentation/video4linux/CARDLIST.bttv	2004-04-05 10:49:59.279023751 +0200
@@ -113,3 +113,9 @@ card=111 - IVC-120G
 card=112 - pcHDTV HD-2000 TV
 card=113 - Twinhan DST + clones
 card=114 - Winfast VC100
+card=115 - Teppro TEV-560/InterVision IV-560
+card=116 - SIMUS GVC1100
+card=117 - NGS NGSTV+
+card=118 - LMLBT4
+card=119 - Tekram M205 PRO
+card=120 - Conceptronic CONTVFMi
diff -up linux-2.6.5/Documentation/video4linux/CARDLIST.saa7134 linux/Documentation/video4linux/CARDLIST.saa7134
--- linux-2.6.5/Documentation/video4linux/CARDLIST.saa7134	2004-04-05 10:38:38.000000000 +0200
+++ linux/Documentation/video4linux/CARDLIST.saa7134	2004-04-05 10:49:59.282023186 +0200
@@ -1,23 +1,34 @@
   0 -> UNKNOWN/GENERIC                         
   1 -> Proteus Pro [philips reference design]   [1131:2001,1131:2001]
-  2 -> LifeView FlyVIDEO3000                    [5168:0138]
+  2 -> LifeView FlyVIDEO3000                    [5168:0138,4e42:0138]
   3 -> LifeView FlyVIDEO2000                    [5168:0138]
   4 -> EMPRESS                                  [1131:6752]
   5 -> SKNet Monster TV                         [1131:4e85]
   6 -> Tevion MD 9717                          
-  7 -> KNC One TV-Station RDS / Typhoon TV+Radio 90031 [1131:fe01]
-  8 -> Terratec Cinergy 400 TV                  [153B:1142]
-  9 -> Medion 5044                             
- 10 -> Kworld/KuroutoShikou SAA7130-TVPCI      
- 11 -> Terratec Cinergy 600 TV                  [153B:1143]
- 12 -> Medion 7134                              [16be:0003]
- 13 -> ELSA EX-VISION 300TV                     [1048:226b]
- 14 -> ELSA EX-VISION 500TV                     [1048:226b]
- 15 -> ASUS TV-FM 7134                          [PCI_VENDOR_ID_ASUSTEK:4842,PCI_VENDOR_ID_ASUSTEK:4830]
- 16 -> AOPEN VA1000 POWER                       [1131:7133]
- 17 -> 10MOONS PCI TV CAPTURE CARD              [1131:2001]
- 18 -> BMK MPEX No Tuner                       
- 19 -> Compro VideoMate TV                      [185b:c100]
- 20 -> Matrox CronosPlus                        [PCI_VENDOR_ID_MATROX:48d0]
- 21 -> Medion 2819                              [1461:a70b]
- 22 -> BMK MPEX Tuner                          
+  7 -> KNC One TV-Station RDS / Typhoon TV Tuner RDS [1131:fe01,1894:fe01]
+  8 -> KNC One TV-Station DVR                   [1894:a006]
+  9 -> Terratec Cinergy 400 TV                  [153B:1142]
+ 10 -> Medion 5044                             
+ 11 -> Kworld/KuroutoShikou SAA7130-TVPCI      
+ 12 -> Terratec Cinergy 600 TV                  [153B:1143]
+ 13 -> Medion 7134                              [16be:0003]
+ 14 -> Typhoon TV+Radio 90031                  
+ 15 -> ELSA EX-VISION 300TV                     [1048:226b]
+ 16 -> ELSA EX-VISION 500TV                     [1048:226b]
+ 17 -> ASUS TV-FM 7134                          [1043:4842,1043:4830,1043:4840]
+ 18 -> AOPEN VA1000 POWER                       [1131:7133]
+ 19 -> 10MOONS PCI TV CAPTURE CARD              [1131:2001]
+ 20 -> BMK MPEX No Tuner                       
+ 21 -> Compro VideoMate TV                      [185b:c100]
+ 22 -> Matrox CronosPlus                        [102B:48d0]
+ 23 -> Medion 2819/ AverMedia M156              [1461:a70b,1461:2115]
+ 24 -> BMK MPEX Tuner                          
+ 25 -> ASUS TV-FM 7133                          [1043:4843]
+ 26 -> Pinnacle PCTV Stereo (saa7134)           [11bd:002b]
+ 27 -> Manli MuchTV M-TV002                    
+ 28 -> Manli MuchTV M-TV001                    
+ 29 -> Nagase Sangyo TransGear 3000TV           [1461:050c]
+ 30 -> Elitegroup ECS TVP3XP FM1216 Tuner Card(PAL-BG,FM)  [1019:4cb4]
+ 31 -> Elitegroup ECS TVP3XP FM1236 Tuner Card (NTSC,FM) [1019:4cb5]
+ 32 -> AVACS SmartTV                           
+ 33 -> AVerMedia DVD EZMaker                    [1461:10ff]
diff -up linux-2.6.5/Documentation/video4linux/CARDLIST.tuner linux/Documentation/video4linux/CARDLIST.tuner
--- linux-2.6.5/Documentation/video4linux/CARDLIST.tuner	2004-04-05 10:41:35.404049219 +0200
+++ linux/Documentation/video4linux/CARDLIST.tuner	2004-04-05 10:49:59.285022621 +0200
@@ -31,7 +31,7 @@ tuner=29 - LG PAL_BG (TPI8PSB11D)
 tuner=30 - Temic PAL* auto + FM (4009 FN5)
 tuner=31 - SHARP NTSC_JP (2U5JF5540)
 tuner=32 - Samsung PAL TCPM9091PD27
-tuner=33 - MT2032 universal
+tuner=33 - MT20xx universal
 tuner=34 - Temic PAL_BG (4106 FH5)
 tuner=35 - Temic PAL_DK/SECAM_L (4012 FY5)
 tuner=36 - Temic NTSC (4136 FY5)
@@ -41,3 +41,6 @@ tuner=39 - LG NTSC (newer TAPC series)
 tuner=40 - HITACHI V7-J180AT
 tuner=41 - Philips PAL_MK (FI1216 MK)
 tuner=42 - Philips 1236D ATSC/NTSC daul in
+tuner=43 - Philips NTSC MK3 (FM1236MK3 or FM1236/F)
+tuner=44 - Philips 4 in 1 (ATI TV Wonder Pro/Conexant)
+tuner=45 - Microtune 4049 FM5
diff -up linux-2.6.5/Documentation/video4linux/README.cx88 linux/Documentation/video4linux/README.cx88
--- linux-2.6.5/Documentation/video4linux/README.cx88	2004-04-05 10:40:04.036289223 +0200
+++ linux/Documentation/video4linux/README.cx88	2004-04-05 10:49:59.288022055 +0200
@@ -9,20 +9,29 @@ current status
 ==============
 
 video
-	Basically works.  Some minor quality glitches.  For now
-	only capture, overlay support isn't completed yet.
+	- Basically works.
+	- Some minor image quality glitches.
+	- Red and blue are swapped sometimes for not-yet known
+	  reasons (seems to depend on the image size, try to resize
+	  your tv app window as workaround ...).
+	- For now only capture, overlay support isn't completed yet.
 
 audio
-	Doesn't work.  Also the chip specs for the on-chip TV sound
-	decoder are next to useless :-/
-	Most tuner chips do provide mono sound, which may or may not
-	be useable depending on the board design.  With the Hauppauge
-	cards it works, so there is at least mono sound.  Not nice,
-	but better than nothing.
+	- The chip specs for the on-chip TV sound decoder are next
+	  to useless :-/
+	- Neverless the builtin TV sound decoder starts working now,
+          at least for PAL-BG.  Other TV norms need other code ...
+          FOR ANY REPORTS ON THIS PLEASE MENTION THE TV NORM YOU ARE
+          USING.
+	- Most tuner chips do provide mono sound, which may or may not
+	  be useable depending on the board design.  With the Hauppauge
+	  cards it works, so there is mono sound available as fallback.
+	- audio data dma (i.e. recording without loopback cable to the
+	  sound card) should be possible, but there is no code yet ...
 
 vbi
-	not implemented yet (but I don't expect problems here, just
-	found no time for that yet).
+	- some code present.  Doesn't crash any more, but also doesn't
+	  work yet ...
 
 
 how to add support for new cards
@@ -38,18 +47,22 @@ like this one:
 		34xxx models [card=1,autodetected]
 
 If your card is listed as "board: UNKNOWN/GENERIC" it is unknown to
-the driver.
+the driver.  What to do then?
 
-You can try to create a new entry yourself, or you can mail me the
-config information.  I need at least the following informations to
-add the card:
-
- * the PCI Subsystem ID ("0070:3400" from the line above, "lspci -v"
-   output is fine too).
- * the tuner type used by the card.  You can try to find one by
-   trial-and-error using the tuner=<n> insmod option.  If you
-   know which one the card has you can also have a look at the
-   list in CARDLIST.tuner
+ (1) Try upgrading to the latest snapshot, maybe it has been added
+     meanwhile.
+ (2) You can try to create a new entry yourself, have a look at
+     cx88-cards.c.  If that worked, mail me your changes as unified
+     diff ("diff -u").
+ (3) Or you can mail me the config information.  I need at least the
+     following informations to add the card:
+
+     * the PCI Subsystem ID ("0070:3400" from the line above,
+       "lspci -v" output is fine too).
+     * the tuner type used by the card.  You can try to find one by
+       trial-and-error using the tuner=<n> insmod option.  If you
+       know which one the card has you can also have a look at the
+       list in CARDLIST.tuner
 
 Have fun,
 

-- 
http://bigendian.bytesex.org
