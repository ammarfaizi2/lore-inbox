Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261992AbVAHIdj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261992AbVAHIdj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 03:33:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261924AbVAHIce
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 03:32:34 -0500
Received: from mail.kroah.org ([69.55.234.183]:12934 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261923AbVAHFsp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 00:48:45 -0500
Subject: Re: [PATCH] USB and Driver Core patches for 2.6.10
In-Reply-To: <11051632581992@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 7 Jan 2005 21:47:38 -0800
Message-Id: <11051632582603@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1938.439.54, 2005/01/07 08:46:29-08:00, david-b@pacbell.net

[PATCH] USB: usb makefile tweaks

Two minor Makefile fixes, catching up to some driver removals.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/usb/Makefile |    3 +--
 1 files changed, 1 insertion(+), 2 deletions(-)


diff -Nru a/drivers/usb/Makefile b/drivers/usb/Makefile
--- a/drivers/usb/Makefile	2005-01-07 15:35:42 -08:00
+++ b/drivers/usb/Makefile	2005-01-07 15:35:42 -08:00
@@ -9,7 +9,7 @@
 obj-$(CONFIG_USB_EHCI_HCD)	+= host/
 obj-$(CONFIG_USB_OHCI_HCD)	+= host/
 obj-$(CONFIG_USB_UHCI_HCD)	+= host/
-obj-$(CONFIG_USB_SL811HS)	+= host/
+obj-$(CONFIG_USB_SL811_HCD)	+= host/
 obj-$(CONFIG_ETRAX_USB_HOST)	+= host/
 
 obj-$(CONFIG_USB_ACM)		+= class/
@@ -49,7 +49,6 @@
 obj-$(CONFIG_USB_RTL8150)	+= net/
 obj-$(CONFIG_USB_USBNET)	+= net/
 
-obj-$(CONFIG_USB_DC2XX)		+= image/
 obj-$(CONFIG_USB_HPUSBSCSI)	+= image/
 obj-$(CONFIG_USB_MDC800)	+= image/
 obj-$(CONFIG_USB_MICROTEK)	+= image/

