Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263894AbTDHHXs (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 03:23:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263916AbTDHHXs (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 03:23:48 -0400
Received: from smtp5.wanadoo.fr ([193.252.22.29]:2472 "EHLO
	mwinf0203.wanadoo.fr") by vger.kernel.org with ESMTP
	id S263894AbTDHHXr (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 8 Apr 2003 03:23:47 -0400
From: Duncan Sands <baldrick@wanadoo.fr>
To: linux-usb-devel@lists.sourceforge.net
Subject: [PATCH] USB speedtouch Kconfig fix; CREDITS entry out of order
Date: Tue, 8 Apr 2003 09:35:17 +0200
User-Agent: KMail/1.5.1
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304080935.17620.baldrick@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Follow the style of other entries in Kconfig.

 CREDITS                  |    8 ++++----
 drivers/usb/misc/Kconfig |    2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)


diff -Nru a/CREDITS b/CREDITS
--- a/CREDITS	Tue Apr  8 09:31:12 2003
+++ b/CREDITS	Tue Apr  8 09:31:12 2003
@@ -2750,6 +2750,10 @@
 E: wsalamon@nai.com
 D: portions of the Linux Security Module (LSM) framework and security modules
 
+N: Robert Sanders
+E: gt8134b@prism.gatech.edu
+D: Dosemu
+
 N: Duncan Sands
 E: duncan.sands@wanadoo.fr
 W: http://topo.math.u-psud.fr/~sands
@@ -2757,10 +2761,6 @@
 S: 69 rue Dunois
 S: 75013 Paris
 S: France
-
-N: Robert Sanders
-E: gt8134b@prism.gatech.edu
-D: Dosemu
 
 N: Hannu Savolainen
 E: hannu@opensound.com
diff -Nru a/drivers/usb/misc/Kconfig b/drivers/usb/misc/Kconfig
--- a/drivers/usb/misc/Kconfig	Tue Apr  8 09:31:12 2003
+++ b/drivers/usb/misc/Kconfig	Tue Apr  8 09:31:12 2003
@@ -94,7 +94,7 @@
 	  a module, say M here and read <file:Documentation/modules.txt>.
 
 config USB_SPEEDTOUCH
-	tristate "Alcatel Speedtouch ADSL USB Modem"
+	tristate "Alcatel Speedtouch USB support"
 	depends on USB && ATM
 	help
 	  Say Y here if you have an Alcatel SpeedTouch USB or SpeedTouch 330

