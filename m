Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262000AbTFFQba (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 12:31:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262001AbTFFQba
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 12:31:30 -0400
Received: from 66-122-194-202.ded.pacbell.net ([66.122.194.202]:50587 "HELO
	mail.keyresearch.com") by vger.kernel.org with SMTP id S262000AbTFFQb2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 12:31:28 -0400
Subject: [PATCH] Teach BitKeeper about files to ignore for x86_64
From: "Bryan O'Sullivan" <bos@serpentine.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1054917901.28218.7.camel@serpentine.internal.keyresearch.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 06 Jun 2003 09:45:01 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please apply, as Andi doesn't use BK.  This patch is against BK
current.

	<b


===== BitKeeper/etc/ignore 1.61 vs edited =====
--- 1.61/BitKeeper/etc/ignore   Sat May 24 17:23:20 2003
+++ edited/BitKeeper/etc/ignore Fri Jun  6 09:41:59 2003
@@ -132,3 +132,14 @@
 drivers/video/logo/logo_linux_clut224.c
 tags
 arch/i386/boot/mtools.conf
+arch/x86_64/kernel/mtrr/*.[ch]
+include/asm-x86_64/offset.h
+arch/x86_64/kernel/bootflag.c
+arch/x86_64/ia32/vsyscall.so
+arch/x86_64/boot/bootsect
+arch/x86_64/boot/bzImage
+arch/x86_64/boot/setup
+arch/x86_64/boot/vmlinux.bin
+arch/x86_64/boot/compressed/vmlinux.bin
+arch/x86_64/boot/compressed/vmlinux.bin.gz
+arch/x86_64/boot/tools/build

