Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263986AbTJFF3W (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 01:29:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263984AbTJFF3W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 01:29:22 -0400
Received: from TYO201.gate.nec.co.jp ([202.32.8.214]:12026 "EHLO
	TYO201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S263986AbTJFF3V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 01:29:21 -0400
To: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH][v850]  Triple the memory size used on the v850 gdb simulator
Cc: linux-kernel@vger.kernel.org
Reply-To: Miles Bader <miles@gnu.org>
Message-Id: <20031006052905.4ED8037C9@mcspd15.ucom.lsi.nec.co.jp>
Date: Mon,  6 Oct 2003 14:29:05 +0900 (JST)
From: miles@lsi.nec.co.jp (Miles Bader)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please apply.

diff -ruN -X../cludes linux-2.6.0-test6-moo/include/asm-v850/sim.h linux-2.6.0-test6-moo-v850-20031006/include/asm-v850/sim.h
--- linux-2.6.0-test6-moo/include/asm-v850/sim.h	2003-06-16 14:53:02.000000000 +0900
+++ linux-2.6.0-test6-moo-v850-20031006/include/asm-v850/sim.h	2003-10-03 18:21:48.000000000 +0900
@@ -25,7 +25,7 @@
 /* We use a weird value for RAM, not just 0, for testing purposes.
    These must match the values used in the linker script.  */
 #define RAM_ADDR		0x8F000000
-#define RAM_SIZE		0x01000000
+#define RAM_SIZE		0x03000000
 
 
 /* For <asm/page.h> */
