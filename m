Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261360AbULNArD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261360AbULNArD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 19:47:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261361AbULNArD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 19:47:03 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:59919 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261360AbULNAq4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 19:46:56 -0500
Date: Tue, 14 Dec 2004 01:46:54 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] remove unused include/asm-m68k/adb_mouse.h (fwd)
Message-ID: <20041214004653.GP23151@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The trivial patch forwarded below still applies against 2.6.10-rc3-mm1.

Please apply.


----- Forwarded message from Adrian Bunk <bunk@stusta.de> -----

Date:	Wed, 8 Dec 2004 02:14:36 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] remove unused include/asm-m68k/adb_mouse.h

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

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

----- End forwarded message -----

