Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262000AbULHBQb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262000AbULHBQb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 20:16:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261998AbULHBPs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 20:15:48 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:18962 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261990AbULHBOl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 20:14:41 -0500
Date: Wed, 8 Dec 2004 02:14:36 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] remove unused include/asm-m68k/adb_mouse.h
Message-ID: <20041208011436.GI5496@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below removes a completely unused header file.


diffstat output:
 include/asm-m68k/adb_mouse.h |   23 -----------------------
 1 files changed, 23 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc2-mm4-full/include/asm-m68k/adb_mouse.h	2004-10-18 23:54:55.000000000 +0200
+++ /dev/null	2004-11-25 03:16:25.000000000 +0100
@@ -1,23 +0,0 @@
-#ifndef _ASM_ADB_MOUSE_H
-#define _ASM_ADB_MOUSE_H
-
-/*
- * linux/include/asm-m68k/adb_mouse.h
- * header file for Macintosh ADB mouse driver
- * 27-10-97 Michael Schmitz
- * copied from:
- * header file for Atari Mouse driver
- * by Robert de Vries (robert@and.nl) on 19Jul93
- */
-
-struct mouse_status {
-	char		buttons;
-	short		dx;
-	short		dy;
-	int		ready;
-	int		active;
-	wait_queue_head_t wait;
-	struct fasync_struct *fasyncptr;
-};
-
-#endif

