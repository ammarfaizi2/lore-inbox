Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263994AbTJFFbA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 01:31:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263984AbTJFF3e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 01:29:34 -0400
Received: from TYO201.gate.nec.co.jp ([202.32.8.214]:15866 "EHLO
	TYO201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S263989AbTJFF3V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 01:29:21 -0400
To: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH][v850]  Remove some old debugging stuff on the v850
Cc: linux-kernel@vger.kernel.org
Reply-To: Miles Bader <miles@gnu.org>
Message-Id: <20031006052905.A644237DE@mcspd15.ucom.lsi.nec.co.jp>
Date: Mon,  6 Oct 2003 14:29:05 +0900 (JST)
From: miles@lsi.nec.co.jp (Miles Bader)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please apply.

diff -ruN -X../cludes linux-2.6.0-test6-moo/include/asm-v850/sim85e2.h linux-2.6.0-test6-moo-v850-20031006/include/asm-v850/sim85e2.h
--- linux-2.6.0-test6-moo/include/asm-v850/sim85e2.h	2003-07-28 10:14:26.000000000 +0900
+++ linux-2.6.0-test6-moo-v850-20031006/include/asm-v850/sim85e2.h	2003-10-03 17:40:13.000000000 +0900
@@ -38,11 +38,7 @@
 #define ERAM_SIZE		0x07f00000 /* 127MB (max) */
 /* Dynamic RAM; uses memory controller.  */
 #define SDRAM_ADDR		0x10000000
-#if 0
 #define SDRAM_SIZE		0x01000000 /* 16MB */
-#else
-#define SDRAM_SIZE		0x00200000 /* Only use 2MB for testing */
-#endif
 
 
 /* Simulator specific control registers.  */
