Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291962AbSBNWbu>; Thu, 14 Feb 2002 17:31:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291965AbSBNWbk>; Thu, 14 Feb 2002 17:31:40 -0500
Received: from tstac.esa.lanl.gov ([128.165.46.3]:665 "EHLO tstac.esa.lanl.gov")
	by vger.kernel.org with ESMTP id <S291962AbSBNWbZ>;
	Thu, 14 Feb 2002 17:31:25 -0500
Message-Id: <200202142143.OAA05098@tstac.esa.lanl.gov>
Content-Type: text/plain; charset=US-ASCII
From: Steven Cole <elenstev@mesatop.com>
Reply-To: elenstev@mesatop.com
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.5-pre1 add two help texts to drivers/media/video/Config.help
Date: Thu, 14 Feb 2002 15:30:15 -0700
X-Mailer: KMail [version 1.3.1]
Cc: Dave Jones <davej@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds two help texts for CONFIG_VIDEO_ZORAN_DC10
and CONFIG_VIDEO_ZORAN_LML33 in drivers/media/video/Config.help.

Steven

--- linux-2.5.5-pre1/drivers/media/video/Config.help.orig       Thu Feb 14 15:08:11 2002
+++ linux-2.5.5-pre1/drivers/media/video/Config.help    Thu Feb 14 15:11:49 2002
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

