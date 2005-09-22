Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965245AbVIVHvH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965245AbVIVHvH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 03:51:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965190AbVIVHus
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 03:50:48 -0400
Received: from mail.kroah.org ([69.55.234.183]:36019 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751447AbVIVHuY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 03:50:24 -0400
Date: Thu, 22 Sep 2005 00:49:39 -0700
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       dhollis@davehollis.com
Subject: [patch 16/18] USB: Add Novatel CDMA Wireless PC card IDs to airprime
Message-ID: <20050922074939.GQ15053@kroah.com>
References: <20050922003901.814147000@echidna.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="usb-airprime-id.patch"
In-Reply-To: <20050922074643.GA15053@kroah.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Hollis <dhollis@davehollis.com>


USB: Add device id's for Novatel Wireless CDMA wireless PC card.
     The Novatel CDMA card behaves the same as the AirPrime by providing
     a USB serial port.

Signed-off-by: David Hollis <dhollis@davehollis.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/usb/serial/airprime.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- scsi-2.6.orig/drivers/usb/serial/airprime.c	2005-09-20 06:00:04.000000000 -0700
+++ scsi-2.6/drivers/usb/serial/airprime.c	2005-09-21 17:29:52.000000000 -0700
@@ -16,7 +16,8 @@
 #include "usb-serial.h"
 
 static struct usb_device_id id_table [] = {
-	{ USB_DEVICE(0xf3d, 0x0112) },
+	{ USB_DEVICE(0xf3d, 0x0112) },  /* AirPrime CDMA Wireless PC Card */
+	{ USB_DEVICE(0x1410, 0x1110) }, /* Novatel Wireless Merlin CDMA */
 	{ },
 };
 MODULE_DEVICE_TABLE(usb, id_table);

--
