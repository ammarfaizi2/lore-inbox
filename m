Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751128AbWABXhc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751128AbWABXhc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jan 2006 18:37:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751129AbWABXhc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jan 2006 18:37:32 -0500
Received: from hansmi.home.forkbomb.ch ([213.144.146.165]:52764 "EHLO
	hansmi.home.forkbomb.ch") by vger.kernel.org with ESMTP
	id S1751128AbWABXhc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jan 2006 18:37:32 -0500
Date: Tue, 3 Jan 2006 00:37:30 +0100
From: Michael Hanselmann <linux-kernel@hansmi.ch>
To: dtor_core@ameritech.net
Cc: linux-kernel@vger.kernel.org, linux-input@atrey.karlin.mff.cuni.cz
Subject: [PATCH 1/1] usb/input: Add missing keys to hid-debug.h
Message-ID: <20060102233730.GA29826@hansmi.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the missing keys from input.h to hid-debug.h.

Signed-off-by: Michael Hanselmann <linux-kernel@hansmi.ch>
---
Dmitry: This patch replaces the one I submitted on December 11, 2005.
The old one had only KEY_FN while this one has all keys. If wanted, I
can submit a patch that applies over the old patch.

--- linux-2.6.15-rc7.orig/drivers/usb/input/hid-debug.h	2006-01-01 00:41:15.000000000 +0100
+++ linux-2.6.15-rc7/drivers/usb/input/hid-debug.h	2006-01-03 00:26:17.000000000 +0100
@@ -681,6 +681,21 @@ static char *keys[KEY_MAX + 1] = {
 	[KEY_SEND] = "Send",			[KEY_REPLY] = "Reply",
 	[KEY_FORWARDMAIL] = "ForwardMail",	[KEY_SAVE] = "Save",
 	[KEY_DOCUMENTS] = "Documents",
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
