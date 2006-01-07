Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030560AbWAGTPJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030560AbWAGTPJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 14:15:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030553AbWAGTPJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 14:15:09 -0500
Received: from smtp113.sbc.mail.re2.yahoo.com ([68.142.229.92]:15550 "HELO
	smtp113.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1030557AbWAGTIX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 14:08:23 -0500
Message-Id: <20060107172100.328298000.dtor_core@ameritech.net>
References: <20060107171559.593824000.dtor_core@ameritech.net>
Date: Sat, 07 Jan 2006 12:16:06 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Vojtech Pavlik <vojtech@suse.cz>
Subject: [PATCH 07/24] alps: add signature for HP ze1115
Content-Disposition: inline; filename=alps-add-ze1115.patch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Larry Finger <Larry.Finger@lwfinger.net>

Input: ALPS - add signature for HP ze1115

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/mouse/alps.c |    1 +
 1 files changed, 1 insertion(+)

Index: work/drivers/input/mouse/alps.c
===================================================================
--- work.orig/drivers/input/mouse/alps.c
+++ work/drivers/input/mouse/alps.c
@@ -40,6 +40,7 @@ static struct alps_model_info alps_model
 	{ { 0x33, 0x02, 0x0a },	0x88, 0xf8, ALPS_OLDPROTO },		/* UMAX-530T */
 	{ { 0x53, 0x02, 0x0a },	0xf8, 0xf8, 0 },
 	{ { 0x53, 0x02, 0x14 },	0xf8, 0xf8, 0 },
+	{ { 0x60, 0x03, 0xc8 }, 0xf8, 0xf8, 0 },			/* HP ze1115 */
 	{ { 0x63, 0x02, 0x0a },	0xf8, 0xf8, 0 },
 	{ { 0x63, 0x02, 0x14 },	0xf8, 0xf8, 0 },
 	{ { 0x63, 0x02, 0x28 },	0xf8, 0xf8, ALPS_FW_BK_2 },		/* Fujitsu Siemens S6010 */

