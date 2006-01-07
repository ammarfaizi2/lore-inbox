Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161018AbWAGTcs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161018AbWAGTcs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 14:32:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161022AbWAGTcs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 14:32:48 -0500
Received: from smtp108.sbc.mail.re2.yahoo.com ([68.142.229.97]:22121 "HELO
	smtp108.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1161018AbWAGTcq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 14:32:46 -0500
Message-Id: <20060107172102.092805000.dtor_core@ameritech.net>
References: <20060107171559.593824000.dtor_core@ameritech.net>
Date: Sat, 07 Jan 2006 12:16:21 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Vojtech Pavlik <vojtech@suse.cz>
Subject: [PATCH 22/24] Add missing keys to hid-debug.h
Content-Disposition: inline; filename=hid-debug-more-definitions.patch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Hanselmann <linux-kernel@hansmi.ch>

Input: add missing keys from input.h to hid-debug.h

Signed-off-by: Michael Hanselmann <linux-kernel@hansmi.ch>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/usb/input/hid-debug.h |   16 +++++++++++++++-
 1 files changed, 15 insertions(+), 1 deletion(-)

Index: work/drivers/usb/input/hid-debug.h
===================================================================
--- work.orig/drivers/usb/input/hid-debug.h
+++ work/drivers/usb/input/hid-debug.h
@@ -681,7 +681,21 @@ static char *keys[KEY_MAX + 1] = {
 	[KEY_SEND] = "Send",			[KEY_REPLY] = "Reply",
 	[KEY_FORWARDMAIL] = "ForwardMail",	[KEY_SAVE] = "Save",
 	[KEY_DOCUMENTS] = "Documents",
-	[KEY_FN] = "Fn",
+	[KEY_FN] = "Fn",			[KEY_FN_ESC] = "Fn+ESC",
+	[KEY_FN_1] = "Fn+1",			[KEY_FN_2] = "Fn+2",
+	[KEY_FN_B] = "Fn+B",			[KEY_FN_D] = "Fn+D",
+	[KEY_FN_E] = "Fn+E",			[KEY_FN_F] = "Fn+F",
+	[KEY_FN_S] = "Fn+S",
+	[KEY_FN_F1] = "Fn+F1",			[KEY_FN_F2] = "Fn+F2",
+	[KEY_FN_F3] = "Fn+F3",			[KEY_FN_F4] = "Fn+F4",
+	[KEY_FN_F5] = "Fn+F5",			[KEY_FN_F6] = "Fn+F6",
+	[KEY_FN_F7] = "Fn+F7",			[KEY_FN_F8] = "Fn+F8",
+	[KEY_FN_F9] = "Fn+F9",			[KEY_FN_F10] = "Fn+F10",
+	[KEY_FN_F11] = "Fn+F11",		[KEY_FN_F12] = "Fn+F12",
+	[KEY_KBDILLUMTOGGLE] = "KbdIlluminationToggle",
+	[KEY_KBDILLUMDOWN] = "KbdIlluminationDown",
+	[KEY_KBDILLUMUP] = "KbdIlluminationUp",
+	[KEY_SWITCHVIDEOMODE] = "SwitchVideoMode",
 };
 
 static char *relatives[REL_MAX + 1] = {

