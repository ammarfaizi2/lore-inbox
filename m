Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261865AbVAHHpI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261865AbVAHHpI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 02:45:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261863AbVAHHoD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 02:44:03 -0500
Received: from mail.kroah.org ([69.55.234.183]:46469 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261865AbVAHFsS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 00:48:18 -0500
Subject: Re: [PATCH] USB and Driver Core patches for 2.6.10
In-Reply-To: <11051632622393@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 7 Jan 2005 21:47:42 -0800
Message-Id: <11051632623391@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1938.444.24, 2004/12/21 11:20:03-08:00, oliver@neukum.org

[PATCH] USB: additional device id for kaweth driver

thanks to Magnus an additional device id.

Signed-Off-By: Oliver Neukum <oliver@neukum.name>


 drivers/usb/net/kaweth.c |    1 +
 1 files changed, 1 insertion(+)


diff -Nru a/drivers/usb/net/kaweth.c b/drivers/usb/net/kaweth.c
--- a/drivers/usb/net/kaweth.c	2005-01-07 15:41:01 -08:00
+++ b/drivers/usb/net/kaweth.c	2005-01-07 15:41:01 -08:00
@@ -160,6 +160,7 @@
 	{ USB_DEVICE(0x1342, 0x0204) }, /* Mobility USB-Ethernet Adapter */
 	{ USB_DEVICE(0x13d2, 0x0400) }, /* Shark Pocket Adapter */
 	{ USB_DEVICE(0x1485, 0x0001) },	/* Silicom U2E */
+	{ USB_DEVICE(0x1485, 0x0002) }, /* Psion Dacom Gold Port Ethernet */
 	{ USB_DEVICE(0x1645, 0x0005) }, /* Entrega E45 */
 	{ USB_DEVICE(0x1645, 0x0008) }, /* Entrega USB Ethernet Adapter */
 	{ USB_DEVICE(0x1645, 0x8005) }, /* PortGear Ethernet Adapter */

