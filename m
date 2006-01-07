Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030570AbWAGTIv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030570AbWAGTIv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 14:08:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030566AbWAGTI2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 14:08:28 -0500
Received: from smtp102.sbc.mail.re2.yahoo.com ([68.142.229.103]:57207 "HELO
	smtp102.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1030547AbWAGTIW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 14:08:22 -0500
Message-Id: <20060107172100.093052000.dtor_core@ameritech.net>
References: <20060107171559.593824000.dtor_core@ameritech.net>
Date: Sat, 07 Jan 2006 12:16:04 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Vojtech Pavlik <vojtech@suse.cz>
Subject: [PATCH 05/24] add the fn key to hid-debug.h
Content-Disposition: inline; filename=hid-debug-add-fn-key.patch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Hanselmann <linux-kernel@hansmi.ch>

Input: add the fn key to hid-debug.h

Signed-off-by: Michael Hanselmann <linux-kernel@hansmi.ch>
Acked-by: Johannes Berg <johannes@sipsolutions.net>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/usb/input/hid-debug.h |    1 +
 1 files changed, 1 insertion(+)

Index: work/drivers/usb/input/hid-debug.h
===================================================================
--- work.orig/drivers/usb/input/hid-debug.h
+++ work/drivers/usb/input/hid-debug.h
@@ -681,6 +681,7 @@ static char *keys[KEY_MAX + 1] = {
 	[KEY_SEND] = "Send",			[KEY_REPLY] = "Reply",
 	[KEY_FORWARDMAIL] = "ForwardMail",	[KEY_SAVE] = "Save",
 	[KEY_DOCUMENTS] = "Documents",
+	[KEY_FN] = "Fn",
 };
 
 static char *relatives[REL_MAX + 1] = {

