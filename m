Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265693AbTFXFNf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 01:13:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265697AbTFXFNe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 01:13:34 -0400
Received: from TYO202.gate.nec.co.jp ([202.32.8.202]:51622 "EHLO
	TYO202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S265693AbTFXFN0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 01:13:26 -0400
To: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH][v850]  Use <asm-generic/statsfs.h> on v850
Cc: linux-kernel@vger.kernel.org
Reply-To: Miles Bader <miles@gnu.org>
Message-Id: <20030624052716.DF85B3733@mcspd15.ucom.lsi.nec.co.jp>
Date: Tue, 24 Jun 2003 14:27:16 +0900 (JST)
From: miles@lsi.nec.co.jp (Miles Bader)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -ruN -X../cludes linux-2.5.73-moo/include/asm-v850/statfs.h linux-2.5.73-moo-v850-20030624/include/asm-v850/statfs.h
--- linux-2.5.73-moo/include/asm-v850/statfs.h	2002-11-05 11:25:32.000000000 +0900
+++ linux-2.5.73-moo-v850-20030624/include/asm-v850/statfs.h	2003-06-24 13:31:04.000000000 +0900
@@ -1,25 +1,6 @@
 #ifndef __V850_STATFS_H__
 #define __V850_STATFS_H__
 
-#ifndef __KERNEL_STRICT_NAMES
-
-#include <linux/types.h>
-
-typedef __kernel_fsid_t	fsid_t;
-
-#endif
-
-struct statfs {
-	long f_type;
-	long f_bsize;
-	long f_blocks;
-	long f_bfree;
-	long f_bavail;
-	long f_files;
-	long f_ffree;
-	__kernel_fsid_t f_fsid;
-	long f_namelen;
-	long f_spare[6];
-};
+#include <asm-generic/statfs.h>
 
 #endif /* __V850_STATFS_H__ */
