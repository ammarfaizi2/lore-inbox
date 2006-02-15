Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422864AbWBOGOH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422864AbWBOGOH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 01:14:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422998AbWBOGOH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 01:14:07 -0500
Received: from smtp111.sbc.mail.re2.yahoo.com ([68.142.229.94]:34490 "HELO
	smtp111.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1422864AbWBOGOF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 01:14:05 -0500
Message-Id: <20060215061150.018375000.dtor_core@ameritech.net>
References: <20060215060140.243794000.dtor_core@ameritech.net>
Date: Wed, 15 Feb 2006 01:01:42 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PATCH 2/6] logips2pp: add new signature (99)
Content-Disposition: inline; filename=logips2pp-add-signature-99.patch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Meelis Roos <mroos@linux.ee>

Input: logips2pp - add new signature (99)

Add Logitech mouse type 99 (Premium Optical Wheel Mouse, model M-BT58,
plain 3 buttons + wheel) to cure the following message: logips2pp: Detected
unknown logitech mouse model 99

Signed-off-by: Meelis Roos <mroos@linux.ee>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/mouse/logips2pp.c |    1 +
 1 files changed, 1 insertion(+)

Index: work/drivers/input/mouse/logips2pp.c
===================================================================
--- work.orig/drivers/input/mouse/logips2pp.c
+++ work/drivers/input/mouse/logips2pp.c
@@ -232,6 +232,7 @@ static struct ps2pp_info *get_model_info
 		{ 88,	PS2PP_KIND_WHEEL,	PS2PP_WHEEL },
 		{ 96,	0,			0 },
 		{ 97,	PS2PP_KIND_TP3,		PS2PP_WHEEL | PS2PP_HWHEEL },
+		{ 99,	PS2PP_KIND_WHEEL,	PS2PP_WHEEL },
 		{ 100,	PS2PP_KIND_MX,					/* MX510 */
 				PS2PP_WHEEL | PS2PP_SIDE_BTN | PS2PP_TASK_BTN |
 				PS2PP_EXTRA_BTN | PS2PP_NAV_BTN },

