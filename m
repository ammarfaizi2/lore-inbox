Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932867AbWKLKWo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932867AbWKLKWo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Nov 2006 05:22:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932871AbWKLKWo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Nov 2006 05:22:44 -0500
Received: from frigate.technologeek.org ([62.4.21.148]:26016 "EHLO
	frigate.technologeek.org") by vger.kernel.org with ESMTP
	id S932867AbWKLKWn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Nov 2006 05:22:43 -0500
From: Julien BLACHE <jb@jblache.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: vojtech@suse.cz
Subject: [PATCH] hid-core: Add quirk for new Apple keyboard/trackpad
Date: Sun, 12 Nov 2006 11:22:42 +0100
Message-ID: <87y7qhotfx.fsf@frigate.technologeek.org>
User-Agent: Gnus/5.110006 (No Gnus v0.6) XEmacs/21.4.19 (linux)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

Hi,

The new Core2 Duo MacBook Pro have a new keyboard+trackpad device.

The following patch adds the needed HID quirk for the Fn key.

Signed-off-by: Julien BLACHE <jb@jblache.org>


--=-=-=
Content-Type: text/x-patch
Content-Disposition: inline; filename=mbp-c2d-hid-quirk.patch
Content-Description: Add quirk for new Apple keyboard/trackpad

--- hid-core.c.orig	2006-11-12 10:11:07.131877000 +0100
+++ hid-core.c	2006-11-12 10:11:17.612877000 +0100
@@ -1802,6 +1802,7 @@
 	{ USB_VENDOR_ID_APPLE, 0x0217, HID_QUIRK_POWERBOOK_HAS_FN },
 	{ USB_VENDOR_ID_APPLE, 0x0218, HID_QUIRK_POWERBOOK_HAS_FN },
 	{ USB_VENDOR_ID_APPLE, 0x0219, HID_QUIRK_POWERBOOK_HAS_FN },
+	{ USB_VENDOR_ID_APPLE, 0x021B, HID_QUIRK_POWERBOOK_HAS_FN },
 	{ USB_VENDOR_ID_APPLE, 0x030A, HID_QUIRK_POWERBOOK_HAS_FN },
 	{ USB_VENDOR_ID_APPLE, 0x030B, HID_QUIRK_POWERBOOK_HAS_FN },
 

--=-=-=


JB.

-- 
Julien BLACHE                                   <http://www.jblache.org> 
<jb@jblache.org>                                  GPG KeyID 0xF5D65169

--=-=-=--
