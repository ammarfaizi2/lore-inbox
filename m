Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318769AbSHLSY4>; Mon, 12 Aug 2002 14:24:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318782AbSHLSY4>; Mon, 12 Aug 2002 14:24:56 -0400
Received: from mailrelay2.lanl.gov ([128.165.4.103]:62852 "EHLO
	mailrelay2.lanl.gov") by vger.kernel.org with ESMTP
	id <S318769AbSHLSY4>; Mon, 12 Aug 2002 14:24:56 -0400
Subject: PATCH] 2.5.31 add two help texts to drivers/media/video/Config.help
From: Steven Cole <elenstev@mesatop.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Dave Jones <davej@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 12 Aug 2002 12:25:52 -0600
Message-Id: <1029176752.14756.64.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This adds two help texts to drivers/media/video/Config.help for
CONFIG_VIDEO_ZORAN_DC10 and CONFIG_VIDEO_ZORAN_LML33.

This has been in the -dj tree since about 2.5.7.
The texts were obtained from ESR's v2.97 Configure.help.

Steven

--- linux-2.5.31/drivers/media/video/Config.help.orig	Mon Aug 12 12:13:28 2002
+++ linux-2.5.31/drivers/media/video/Config.help	Mon Aug 12 12:14:14 2002
@@ -54,6 +54,16 @@
   Say Y here to include support for the Iomega Buz video card.  There
   is a Buz/Linux homepage at <http://www.lysator.liu.se/~gz/buz/>.
 
+CONFIG_VIDEO_ZORAN_DC10
+  Say Y to support the Pinnacle Systems Studio DC10 plus TV/Video
+  card.  Linux page at
+  <http://lhd.datapower.com/db/dispproduct.php3?DISP?1511>.  Vendor
+  page at <http://www.pinnaclesys.com/>.
+
+CONFIG_VIDEO_ZORAN_LML33
+  Say Y here to support the Linux Media Labs LML33 TV/Video card.
+  Resources page is at <http://www.linuxmedialabs.com/lml33doc.html>.
+
 CONFIG_VIDEO_ZR36120
   Support for ZR36120/ZR36125 based frame grabber/overlay boards.
   This includes the Victor II, WaveWatcher, Video Wonder, Maxi-TV,



