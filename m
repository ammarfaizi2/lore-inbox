Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261513AbULYONT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261513AbULYONT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Dec 2004 09:13:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261514AbULYONI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Dec 2004 09:13:08 -0500
Received: from golobica.uni-mb.si ([164.8.100.4]:36568 "EHLO
	golobica.uni-mb.si") by vger.kernel.org with ESMTP id S261513AbULYONB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Dec 2004 09:13:01 -0500
Subject: [patch 1/1] floppy: relocate devfs comment
To: axboe@suse.de
Cc: linux-kernel@vger.kernel.org, domen@coderock.org, james4765@gmail.com
From: domen@coderock.org
Date: Sat, 25 Dec 2004 15:13:04 +0100
Message-Id: <20041225141254.567F94DC08C@golobica.uni-mb.si>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Oops, forgot Signed-off-by: line.

Signed-off-by: James Nelson <james4765@gmail.com>
Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj-domen/drivers/block/floppy.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff -puN drivers/block/floppy.c~comment-drivers_block_floppy.c drivers/block/floppy.c
--- kj/drivers/block/floppy.c~comment-drivers_block_floppy.c	2004-12-25 01:35:26.000000000 +0100
+++ kj-domen/drivers/block/floppy.c	2004-12-25 01:35:26.000000000 +0100
@@ -98,6 +98,10 @@
  */
 
 /*
+ * 1998/1/21 -- Richard Gooch <rgooch@atnf.csiro.au> -- devfs support
+ */
+
+/*
  * 1998/05/07 -- Russell King -- More portability cleanups; moved definition of
  * interrupt and dma channel to asm/floppy.h. Cleaned up some formatting &
  * use of '0' for NULL.
@@ -159,10 +163,6 @@ static int print_unex = 1;
 #define FDPATCHES
 #include <linux/fdreg.h>
 
-/*
- * 1998/1/21 -- Richard Gooch <rgooch@atnf.csiro.au> -- devfs support
- */
-
 #include <linux/fd.h>
 #include <linux/hdreg.h>
 
_
