Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932359AbVIJWeh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932359AbVIJWeh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 18:34:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932362AbVIJWed
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 18:34:33 -0400
Received: from styx.suse.cz ([82.119.242.94]:39588 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S932359AbVIJWdw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 18:33:52 -0400
Subject: [PATCH 21/26] HID - add the Trust Predator TH 400 gamepad to the badpad list
In-Reply-To: <11263916532577@midnight.ucw.cz>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Sun, 11 Sep 2005 00:34:14 +0200
Message-Id: <11263916541191@midnight.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: torvalds@osdl.org, dtor_core@ameritech.net, linux-kernel@vger.kernel.org,
       vojtech@suse.cz
Content-Transfer-Encoding: 7BIT
From: Vojtech Pavlik <vojtech@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: [PATCH] Input: HID - add the Trust Predator TH 400 gamepad to the badpad list
From: Vojtech Pavlik <vojtech@suse.cz>
Date: 1125897212 -0500

Reported-by: Karl Relton <karllinuxtest.relton@ntlworld.com>
Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

---

 drivers/usb/input/hid-core.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

61cdecd9f5f602775af1e89c200179d093a94ae2
diff --git a/drivers/usb/input/hid-core.c b/drivers/usb/input/hid-core.c
--- a/drivers/usb/input/hid-core.c
+++ b/drivers/usb/input/hid-core.c
@@ -1370,8 +1370,9 @@ void hid_init_reports(struct hid_device 
 #define USB_VENDOR_ID_A4TECH		0x09da
 #define USB_DEVICE_ID_A4TECH_WCP32PU	0x0006
 
-#define USB_VENDOR_ID_AASHIMA		0x06D6
+#define USB_VENDOR_ID_AASHIMA		0x06d6
 #define USB_DEVICE_ID_AASHIMA_GAMEPAD	0x0025
+#define USB_DEVICE_ID_AASHIMA_PREDATOR	0x0026
 
 #define USB_VENDOR_ID_CYPRESS		0x04b4
 #define USB_DEVICE_ID_CYPRESS_MOUSE	0x0001
@@ -1553,6 +1554,7 @@ static struct hid_blacklist {
 	{ USB_VENDOR_ID_CYPRESS, USB_DEVICE_ID_CYPRESS_MOUSE, HID_QUIRK_2WHEEL_MOUSE_HACK_5 },
 
 	{ USB_VENDOR_ID_AASHIMA, USB_DEVICE_ID_AASHIMA_GAMEPAD, HID_QUIRK_BADPAD },
+	{ USB_VENDOR_ID_AASHIMA, USB_DEVICE_ID_AASHIMA_PREDATOR, HID_QUIRK_BADPAD },
 	{ USB_VENDOR_ID_ALPS, USB_DEVICE_ID_IBM_GAMEPAD, HID_QUIRK_BADPAD },
 	{ USB_VENDOR_ID_CHIC, USB_DEVICE_ID_CHIC_GAMEPAD, HID_QUIRK_BADPAD },
 	{ USB_VENDOR_ID_HAPP, USB_DEVICE_ID_UGCI_DRIVING, HID_QUIRK_BADPAD | HID_QUIRK_MULTI_INPUT },

