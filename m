Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261263AbVE2HhZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261263AbVE2HhZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 May 2005 03:37:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261265AbVE2HhZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 May 2005 03:37:25 -0400
Received: from smtp816.mail.sc5.yahoo.com ([66.163.170.2]:20564 "HELO
	smtp816.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261263AbVE2HhU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 May 2005 03:37:20 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: [patch 14/13] Fix broken mapping for right "win" key
Date: Sun, 29 May 2005 02:37:16 -0500
User-Agent: KMail/1.8
Cc: Linus Torvalds <torvalds@osdl.org>, Vojtech Pavlik <vojtech@suse.cz>,
       Andrew Morton <akpm@osdl.org>
References: <20050529044813.711249000.dtor_core@ameritech.net>
In-Reply-To: <20050529044813.711249000.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505290237.16480.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vojtech Pavlik <vojtech@suse.cz>

Input: Fix fast scrolling scancodes in atkbd.c

Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/keyboard/atkbd.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

Index: work/drivers/input/keyboard/atkbd.c
===================================================================
--- work.orig/drivers/input/keyboard/atkbd.c
+++ work/drivers/input/keyboard/atkbd.c
@@ -171,9 +171,9 @@ static struct {
 	unsigned char set2;
 } atkbd_scroll_keys[] = {
 	{ ATKBD_SCR_1,     0xc5 },
-	{ ATKBD_SCR_2,     0xa9 },
-	{ ATKBD_SCR_4,     0xb6 },
-	{ ATKBD_SCR_8,     0xa7 },
+	{ ATKBD_SCR_2,     0x9d },
+	{ ATKBD_SCR_4,     0xa4 },
+	{ ATKBD_SCR_8,     0x9b },
 	{ ATKBD_SCR_CLICK, 0xe0 },
 	{ ATKBD_SCR_LEFT,  0xcb },
 	{ ATKBD_SCR_RIGHT, 0xd2 },
