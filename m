Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263252AbUDEVRJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 17:17:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263214AbUDEVPG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 17:15:06 -0400
Received: from gprs214-195.eurotel.cz ([160.218.214.195]:38016 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S263225AbUDEVN5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 17:13:57 -0400
Date: Mon, 5 Apr 2004 23:13:47 +0200
From: Pavel Machek <pavel@ucw.cz>
To: vojtech@ucw.cz, kernel list <linux-kernel@vger.kernel.org>
Subject: Remove extra whitespace in input.h
Message-ID: <20040405211347.GA3605@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Perhaps this is good idea? BTN_0 vs. KEY_0 puzzled me for a while.

						Pavel

Index: linux/include/linux/input.h
===================================================================
--- linux.orig/include/linux/input.h	2004-04-05 22:47:34.000000000 +0200
+++ linux/include/linux/input.h	2004-02-20 12:39:34.000000000 +0100
@@ -330,6 +330,7 @@
 
 #define KEY_UNKNOWN		240
 
+/* This is for keys 0..9 on remote control etc. */
 #define BTN_MISC		0x100
 #define BTN_0			0x100
 #define BTN_1			0x101
@@ -776,7 +777,6 @@
 		__old; })
 
 struct input_dev {
-
 	void *private;
 
 	char *name;
@@ -858,7 +858,6 @@
 	(INPUT_DEVICE_ID_MATCH_DEVICE | INPUT_DEVICE_ID_MATCH_VERSION)
 
 struct input_device_id {
-
 	unsigned long flags;
 
 	struct input_id id;
@@ -878,7 +877,6 @@
 struct input_handle;
 
 struct input_handler {
-
 	void *private;
 
 	void (*event)(struct input_handle *handle, unsigned int type, unsigned int code, int value);
@@ -897,7 +895,6 @@
 };
 
 struct input_handle {
-
 	void *private;
 
 	int open;

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
