Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268760AbUJKKNY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268760AbUJKKNY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 06:13:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268762AbUJKKNY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 06:13:24 -0400
Received: from smtp8.poczta.onet.pl ([213.180.130.48]:17029 "EHLO
	smtp8.poczta.onet.pl") by vger.kernel.org with ESMTP
	id S268760AbUJKKNW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 06:13:22 -0400
Message-ID: <PC17102004101112155306979abdf62e@us-pc3>
X-Mailer: Ultrafunk Popcorn 1.71 (20-Sep-2004)
X-Priority: 1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type: text/plain; charset=US-ASCII
Date: Mon, 11 Oct 2004 12:15:53 +0200
From: Daniel Johnson <gijoe@poczta.onet.pl>
To: linux-kernel@vger.kernel.org
Cc: torvalds@osdl.org, alan@redhat.com, vojtech@suse.cz
Subject: [PATCH] Add support for Logitech MX300 in PS2++ driver
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

This little patch adds support for Logitech MX300 mices.
It is to be applied against 2.6.x kernel series.
Please, have a look at it.

Patch follows  ===


diff -u a/drivers/input/mouse/logips2pp.c b/drivers/input/mouse/logips2pp.c
--- a/drivers/input/mouse/logips2pp.c	2004-06-16 13:08:08.000000000 +0200
+++ b/drivers/input/mouse/logips2pp.c	2004-06-16 13:08:08.000000000 +0200
@@ -172,6 +172,10 @@
		{ 100,	PS2PP_KIND_MX,
				PS2PP_WHEEL | PS2PP_SIDE_BTN | PS2PP_TASK_BTN |
				PS2PP_EXTRA_BTN | PS2PP_NAV_BTN },	/* MX510 */
+
+		{ 111,	PS2PP_KIND_MX,
+				PS2PP_WHEEL | PS2PP_EXTRA_BTN | PS2PP_TASK_BTN }, /* MX300 */
+
		{ 112,	PS2PP_KIND_MX,
 				PS2PP_WHEEL | PS2PP_SIDE_BTN | PS2PP_TASK_BTN |
 				PS2PP_EXTRA_BTN | PS2PP_NAV_BTN },	/* MX500 */ 
