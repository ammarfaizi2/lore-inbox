Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272579AbTG1AeI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 20:34:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272578AbTG1AEn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 20:04:43 -0400
Received: from zeus.kernel.org ([204.152.189.113]:28659 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S272717AbTG0W6O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 18:58:14 -0400
Date: Sun, 27 Jul 2003 21:14:42 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200307272014.h6RKEgJ7029713@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: PATCH: fix build of asix usb ethernet
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0-test2/drivers/usb/Makefile linux-2.6.0-test2-ac1/drivers/usb/Makefile
--- linux-2.6.0-test2/drivers/usb/Makefile	2003-07-10 21:14:51.000000000 +0100
+++ linux-2.6.0-test2-ac1/drivers/usb/Makefile	2003-07-23 15:43:04.000000000 +0100
@@ -35,6 +35,7 @@
 obj-$(CONFIG_USB_STV680)	+= media/
 obj-$(CONFIG_USB_VICAM)		+= media/
 
+obj-$(CONFIG_USB_AX8817X)       += net/
 obj-$(CONFIG_USB_CATC)		+= net/
 obj-$(CONFIG_USB_KAWETH)	+= net/
 obj-$(CONFIG_USB_PEGASUS)	+= net/
