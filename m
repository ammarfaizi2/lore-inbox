Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264001AbTKJSVd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 13:21:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264060AbTKJSVc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 13:21:32 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:24788 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S264001AbTKJSVb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 13:21:31 -0500
Date: Mon, 10 Nov 2003 19:21:24 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Linus Torvalds <torvalds@osdl.org>, cltien@cmedia.com.tw,
       support@cmedia.com.tw
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] fix SOUND_CMPCI Configure.help entry
Message-ID: <20031110182124.GQ22185@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

the issue below is only a minor documentation fix, but it has confused
me when configuring a kernel for such a card.

Please apply
Adrian


--- linux-2.6.0-test9-mm2/sound/oss/Kconfig.old	2003-11-10 19:14:08.000000000 +0100
+++ linux-2.6.0-test9-mm2/sound/oss/Kconfig	2003-11-10 19:14:29.000000000 +0100
@@ -24,9 +24,9 @@
 	tristate "C-Media PCI (CMI8338/8738)"
 	depends on SOUND_PRIME!=n && SOUND && PCI
 	help
 	  Say Y or M if you have a PCI sound card using the CMI8338
-	  or the CMI8378 chipset.  Data on these chips are available at
+	  or the CMI8738 chipset.  Data on these chips are available at
 	  <http://www.cmedia.com.tw/>.
 
 	  A userspace utility to control some internal registers of these
 	  chips is available at
