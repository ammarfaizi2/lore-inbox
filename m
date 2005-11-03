Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030337AbVKCEa5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030337AbVKCEa5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 23:30:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030321AbVKCEah
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 23:30:37 -0500
Received: from smtp111.sbc.mail.re2.yahoo.com ([68.142.229.94]:18815 "HELO
	smtp111.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1030324AbVKCEac (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 23:30:32 -0500
Message-Id: <20051103042818.730359000.dtor_core@ameritech.net>
References: <20051103042121.394220000.dtor_core@ameritech.net>
Date: Wed, 02 Nov 2005 23:21:27 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Vojtech Pavlik <vojtech@ucw.cz>
Subject: [patch 6/7] logips2pp: add MX3100 signature
Content-Disposition: inline; filename=logips2pp-add-mx3100.patch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mirco Macrelli <pigaz@pigaz.org>

Input: logips2pp - add support for MX3100

Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/mouse/logips2pp.c |    3 +++
 1 files changed, 3 insertions(+)

Index: work/drivers/input/mouse/logips2pp.c
===================================================================
--- work.orig/drivers/input/mouse/logips2pp.c
+++ work/drivers/input/mouse/logips2pp.c
@@ -217,6 +217,9 @@ static struct ps2pp_info *get_model_info
 		{ 61,	PS2PP_KIND_MX,					/* MX700 */
 				PS2PP_WHEEL | PS2PP_SIDE_BTN | PS2PP_TASK_BTN |
 				PS2PP_EXTRA_BTN | PS2PP_NAV_BTN },
+		{ 66,	PS2PP_KIND_MX,					/* MX3100 reciver */
+				PS2PP_WHEEL | PS2PP_SIDE_BTN | PS2PP_TASK_BTN |
+				PS2PP_EXTRA_BTN | PS2PP_NAV_BTN | PS2PP_HWHEEL },
 		{ 73,	0,			PS2PP_SIDE_BTN },
 		{ 75,	PS2PP_KIND_WHEEL,	PS2PP_WHEEL },
 		{ 76,	PS2PP_KIND_WHEEL,	PS2PP_WHEEL },

