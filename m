Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261640AbTA1W7W>; Tue, 28 Jan 2003 17:59:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261689AbTA1W7W>; Tue, 28 Jan 2003 17:59:22 -0500
Received: from mailrelay1.lanl.gov ([128.165.4.101]:51157 "EHLO
	mailrelay1.lanl.gov") by vger.kernel.org with ESMTP
	id <S261640AbTA1W7V>; Tue, 28 Jan 2003 17:59:21 -0500
Subject: [PATCH] 2.5.59 add two help texts to drivers/media/video/Kconfig
From: Steven Cole <elenstev@mesatop.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: trivial@rustcorp.com.au
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 28 Jan 2003 16:06:21 -0700
Message-Id: <1043795181.2576.165.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are some help texts from 2.4.21-pre3 Configure.help which are
needed in 2.5.59 drivers/media/video/Kconfig.

Steven

--- linux-2.5.59/drivers/media/video/Kconfig.orig	Tue Jan 28 15:39:41 2003
+++ linux-2.5.59/drivers/media/video/Kconfig	Tue Jan 28 15:42:36 2003
@@ -177,10 +177,16 @@
 config VIDEO_ZORAN_DC10
 	tristate "Miro DC10(+) support"
 	depends on VIDEO_ZORAN
+	help
+	  Say Y to support the Pinnacle Systems Studio DC10 plus TV/Video
+	  card.  Vendor page at <http://www.pinnaclesys.com/>.
 
 config VIDEO_ZORAN_LML33
 	tristate "Linux Media Labs LML33 support"
 	depends on VIDEO_ZORAN
+	help
+	  Say Y here to support the Linux Media Labs LML33 TV/Video card.
+	  Resources page is at <http://www.linuxmedialabs.com/lml33doc.html>.
 
 config VIDEO_ZR36120
 	tristate "Zoran ZR36120/36125 Video For Linux"




