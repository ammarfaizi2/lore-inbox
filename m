Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261152AbTIYNNt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 09:13:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261159AbTIYNNs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 09:13:48 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:27850 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S261152AbTIYNNs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 09:13:48 -0400
Date: Thu, 25 Sep 2003 15:13:41 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: greg@kroah.com
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] fix USB_MOUSE help text
Message-ID: <20030925131341.GT15696@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The USB_MOUSE help text was obviously copied from the USB_KBD help text. 
The patch below does a s/keyboard/mouse/g

Please apply
Adrian

--- linux-2.6.0-test5-mm4/drivers/usb/input/Kconfig.old	2003-09-25 15:10:18.000000000 +0200
+++ linux-2.6.0-test5-mm4/drivers/usb/input/Kconfig	2003-09-25 15:10:42.000000000 +0200
@@ -112,8 +112,8 @@
 	depends on USB && INPUT
 	---help---
 	  Say Y here only if you are absolutely sure that you don't want
-	  to use the generic HID driver for your USB keyboard and prefer
-	  to use the keyboard in its limited Boot Protocol mode instead.
+	  to use the generic HID driver for your USB mouse and prefer
+	  to use the mouse in its limited Boot Protocol mode instead.
 
 	  This is almost certainly not what you want.  This is mostly
 	  useful for embedded applications or simple mice.
