Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750849AbWFTNd7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750849AbWFTNd7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 09:33:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750851AbWFTNd7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 09:33:59 -0400
Received: from 83-64-96-243.bad-voeslau.xdsl-line.inode.at ([83.64.96.243]:18360
	"EHLO mognix.dark-green.com") by vger.kernel.org with ESMTP
	id S1750837AbWFTNd5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 09:33:57 -0400
Message-ID: <4497F945.1020307@ed-soft.at>
Date: Tue, 20 Jun 2006 15:33:57 +0200
From: Edgar Hucek <hostmaster@ed-soft.at>
User-Agent: Thunderbird 1.5.0.4 (X11/20060615)
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/1] Addition Apple USB id's for Keyboards
X-Enigmail-Version: 0.94.0.0
Content-Type: multipart/mixed;
 boundary="------------070107010401090007070804"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070107010401090007070804
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

This Patch add support for the Keyboard found on the
new intel macs.

Signed-off-by: Edgar Hucek <hostmaster@ed-soft.at>

--------------070107010401090007070804
Content-Type: text/x-patch;
 name="keyboard_hid.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="keyboard_hid.patch"

diff -uNr linux-2.6.16.1/drivers/usb/input/hid-core.c linux-2.6.16.1-imac/drivers/usb/input/hid-core.c
--- linux-2.6.16.1/drivers/usb/input/hid-core.c	2006-03-20 05:53:29.000000000 +0000
+++ linux-2.6.16.1-imac/drivers/usb/input/hid-core.c	2006-04-01 23:51:38.000000000 +0000
@@ -1602,6 +1602,8 @@
 	{ USB_VENDOR_ID_APPLE, 0x0214, HID_QUIRK_POWERBOOK_HAS_FN },
 	{ USB_VENDOR_ID_APPLE, 0x0215, HID_QUIRK_POWERBOOK_HAS_FN },
 	{ USB_VENDOR_ID_APPLE, 0x0216, HID_QUIRK_POWERBOOK_HAS_FN },
+	{ USB_VENDOR_ID_APPLE, 0x0217, HID_QUIRK_POWERBOOK_HAS_FN },
+	{ USB_VENDOR_ID_APPLE, 0x0218, HID_QUIRK_POWERBOOK_HAS_FN },
 	{ USB_VENDOR_ID_APPLE, 0x030A, HID_QUIRK_POWERBOOK_HAS_FN },
 	{ USB_VENDOR_ID_APPLE, 0x030B, HID_QUIRK_POWERBOOK_HAS_FN },
 

--------------070107010401090007070804--
