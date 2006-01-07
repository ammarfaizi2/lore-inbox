Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030552AbWAGTIr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030552AbWAGTIr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 14:08:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030546AbWAGTI0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 14:08:26 -0500
Received: from smtp105.sbc.mail.re2.yahoo.com ([68.142.229.100]:61533 "HELO
	smtp105.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1030548AbWAGTIV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 14:08:21 -0500
Message-Id: <20060107172059.847904000.dtor_core@ameritech.net>
References: <20060107171559.593824000.dtor_core@ameritech.net>
Date: Sat, 07 Jan 2006 12:16:02 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Vojtech Pavlik <vojtech@suse.cz>
Subject: [PATCH 03/24] logips2pp: add new signature (85)
Content-Disposition: inline; filename=logips2pp-add-signature-85.patch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jasper Spaans <jasper@vs19.net>

Input: logips2pp - add new signature (85)

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/mouse/logips2pp.c |    1 +
 1 files changed, 1 insertion(+)

Index: work/drivers/input/mouse/logips2pp.c
===================================================================
--- work.orig/drivers/input/mouse/logips2pp.c
+++ work/drivers/input/mouse/logips2pp.c
@@ -226,6 +226,7 @@ static struct ps2pp_info *get_model_info
 		{ 80,	PS2PP_KIND_WHEEL,	PS2PP_SIDE_BTN | PS2PP_WHEEL },
 		{ 81,	PS2PP_KIND_WHEEL,	PS2PP_WHEEL },
 		{ 83,	PS2PP_KIND_WHEEL,	PS2PP_WHEEL },
+		{ 85,	PS2PP_KIND_WHEEL,	PS2PP_WHEEL },
 		{ 86,	PS2PP_KIND_WHEEL,	PS2PP_WHEEL },
 		{ 88,	PS2PP_KIND_WHEEL,	PS2PP_WHEEL },
 		{ 96,	0,			0 },

