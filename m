Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265424AbTASGz5>; Sun, 19 Jan 2003 01:55:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265470AbTASGzT>; Sun, 19 Jan 2003 01:55:19 -0500
Received: from yuzuki.cinet.co.jp ([61.197.228.219]:2691 "EHLO
	yuzuki.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S267666AbTASGxS>; Sun, 19 Jan 2003 01:53:18 -0500
Date: Sun, 19 Jan 2003 16:02:09 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCHSET] PC-9800 sub-arch (29/29) ac-update
Message-ID: <20030119070209.GB2965@yuzuki.cinet.co.jp>
References: <20030119051043.GA2662@yuzuki.cinet.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030119051043.GA2662@yuzuki.cinet.co.jp>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is patchset to support NEC PC-9800 subarchitecture
against 2.5.59 (29/29).

Updates include/asm-i386/upd4990a.h in 2.5.50-ac1.

diff -Nru linux-2.5.50-ac1/include/asm-i386/upd4990a.h linux98-2.5.54/include/asm-i386/upd4990a.h
--- linux-2.5.50-ac1/include/asm-i386/upd4990a.h	2003-01-04 10:47:57.000000000 +0900
+++ linux98-2.5.54/include/asm-i386/upd4990a.h	2003-01-04 13:51:27.000000000 +0900
@@ -13,10 +13,6 @@
 #ifndef _ASM_I386_uPD4990A_H
 #define _ASM_I386_uPD4990A_H
 
-#include <linux/config.h>
-
-#ifdef CONFIG_PC9800
-
 #include <asm/io.h>
 
 #define UPD4990A_IO		(0x0020)
@@ -53,6 +49,4 @@
 /* Caller should ignore all bits except bit0 */
 #define UPD4990A_READ_DATA()	inb(UPD4990A_IO_DATAOUT)
 
-#endif /* CONFIG_PC9800 */
-
 #endif
