Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261246AbVE2FDV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261246AbVE2FDV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 May 2005 01:03:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261248AbVE2FC7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 May 2005 01:02:59 -0400
Received: from smtp825.mail.sc5.yahoo.com ([66.163.171.11]:34144 "HELO
	smtp825.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261250AbVE2FBM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 May 2005 01:01:12 -0400
Message-Id: <20050529045847.024772000.dtor_core@ameritech.net>
References: <20050529044813.711249000.dtor_core@ameritech.net>
Date: Sat, 28 May 2005 23:48:17 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: [patch 04/13] i8042: remove unused variable
Content-Disposition: inline; filename=i8042-kill-unused-variable.patch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vojtech Pavlik <vojtech@suse.cz>

Input: Remove (now) unused variable in i8042.c

Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/serio/i8042.c |    2 --
 1 files changed, 2 deletions(-)

Index: work/drivers/input/serio/i8042.c
===================================================================
--- work.orig/drivers/input/serio/i8042.c
+++ work/drivers/input/serio/i8042.c
@@ -802,8 +802,6 @@ static int i8042_controller_init(void)
  */
 static void i8042_controller_reset(void)
 {
-	unsigned char param;
-
 /*
  * Reset the controller if requested.
  */

