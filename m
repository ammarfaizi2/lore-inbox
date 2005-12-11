Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750867AbVLKUap@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750867AbVLKUap (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Dec 2005 15:30:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750868AbVLKUap
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Dec 2005 15:30:45 -0500
Received: from hansmi.home.forkbomb.ch ([213.144.146.165]:41244 "EHLO
	hansmi.home.forkbomb.ch") by vger.kernel.org with ESMTP
	id S1750866AbVLKUap (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Dec 2005 15:30:45 -0500
Date: Sun, 11 Dec 2005 21:30:38 +0100
From: Michael Hanselmann <linux-kernel@hansmi.ch>
To: linux-kernel@vger.kernel.org
Cc: linux-input@atrey.karlin.mff.cuni.cz, johannes@sipsolutions.net
Subject: [PATCH 1/1] usb/input: Add fn key to hid-debug.h
Message-ID: <20051211203038.GA13130@hansmi.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the fn key to hid-debug.h.

Signed-off-by: Michael Hanselmann <linux-kernel@hansmi.ch>
Acked-by: Johannes Berg <johannes@sipsolutions.net>
---
Applies to 2.6.15-rc5.

--- linux-2.6.15-rc5/drivers/usb/input/hid-debug.h.orig	2005-12-11 20:54:24.000000000 +0100
+++ linux-2.6.15-rc5/drivers/usb/input/hid-debug.h	2005-12-11 20:54:35.000000000 +0100
@@ -681,6 +681,7 @@ static char *keys[KEY_MAX + 1] = {
 	[KEY_SEND] = "Send",			[KEY_REPLY] = "Reply",
 	[KEY_FORWARDMAIL] = "ForwardMail",	[KEY_SAVE] = "Save",
 	[KEY_DOCUMENTS] = "Documents",
+	[KEY_FN] = "Fn",
 };
 
 static char *relatives[REL_MAX + 1] = {
