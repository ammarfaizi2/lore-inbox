Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932521AbWGZKmv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932521AbWGZKmv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 06:42:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932524AbWGZKmv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 06:42:51 -0400
Received: from [210.76.114.181] ([210.76.114.181]:17590 "EHLO ccoss.com.cn")
	by vger.kernel.org with ESMTP id S932521AbWGZKmu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 06:42:50 -0400
Message-ID: <44C74720.3050306@ccoss.com.cn>
Date: Wed, 26 Jul 2006 18:42:40 +0800
From: liyu <liyu@ccoss.com.cn>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>,
       Peter <peter@maubp.freeserve.co.uk>,
       The Doctor <thedoctor@tardis.homelinux.org>
Subject: [PATCH 2/3] usbhid: Driver for microsoft natural ergonomic keyboard
 4000
Content-Type: multipart/mixed;
 boundary="------------060105010005020007000806"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060105010005020007000806
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

    This driver use "HID device simple driver interface", you must install that 
patch first. This new version get some improvements.

    The patch include change in Makefile of driver.

    I am sorry for sendding patches in the attachment, beacause of my mail client always break TAB into some spaces.

    Good luck

-Liyu

--------------060105010005020007000806
Content-Type: text/x-patch;
 name="msnek4k-keyboard-driver-Makefile.kernel-2.6.17.7.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="msnek4k-keyboard-driver-Makefile.kernel-2.6.17.7.patch"


    This patch include change of Makefile in this driver.

    First, this driver use "HID device simple driver interface", you must apply that patch before use me.

    Signed-off-by:  Yu Li <liyu@ccoss.com.cn>

diff -Naurp linux-2.6.17.6/drivers/usb/input.orig/Makefile linux-2.6.17.6/drivers/usb/input/Makefile
--- linux-2.6.17.6/drivers/usb/input.orig/Makefile	2006-07-16 03:00:43.000000000 +0800
+++ linux-2.6.17.6/drivers/usb/input/Makefile	2006-07-24 14:46:39.000000000 +0800
@@ -44,6 +44,7 @@ obj-$(CONFIG_USB_ACECAD)	+= acecad.o
 obj-$(CONFIG_USB_YEALINK)	+= yealink.o
 obj-$(CONFIG_USB_XPAD)		+= xpad.o
 obj-$(CONFIG_USB_APPLETOUCH)	+= appletouch.o
+obj-$(CONFIG_HID_MSNEK4K)	+= usbnek4k.o
 
 ifeq ($(CONFIG_USB_DEBUG),y)
 EXTRA_CFLAGS += -DDEBUG



--------------060105010005020007000806--
