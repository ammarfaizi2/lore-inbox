Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750987AbWAJHUJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750987AbWAJHUJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 02:20:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750995AbWAJHUJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 02:20:09 -0500
Received: from smtp109.sbc.mail.re2.yahoo.com ([68.142.229.96]:42592 "HELO
	smtp109.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1750987AbWAJHUH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 02:20:07 -0500
Message-Id: <20060110071650.505132000.dtor_core@ameritech.net>
References: <20060110070945.912712000.dtor_core@ameritech.net>
Date: Tue, 10 Jan 2006 02:09:46 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Vojtech Pavlik <vojtech@suse.cz>, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/5] grip_mp: small cleanup
Content-Disposition: inline; filename=grip_mp-cleanup.patch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Input: grip_mp - kill commented out code

Kill leftovers of dynalloc conversion.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/joystick/grip_mp.c |    9 ---------
 1 files changed, 9 deletions(-)

Index: work/drivers/input/joystick/grip_mp.c
===================================================================
--- work.orig/drivers/input/joystick/grip_mp.c
+++ work/drivers/input/joystick/grip_mp.c
@@ -53,17 +53,8 @@ struct grip_port {
 struct grip_mp {
 	struct gameport *gameport;
 	struct grip_port *port[GRIP_MAX_PORTS];
-//	struct input_dev *dev[4];
-//	int mode[4];
-//	int registered[4];
 	int reads;
 	int bads;
-
-	/* individual gamepad states */
-//	int buttons[4];
-//	int xaxes[4];
-//	int yaxes[4];
-//	int dirty[4];     /* has the state been updated? */
 };
 
 /*

