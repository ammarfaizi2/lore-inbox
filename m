Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261308AbVCEWs5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261308AbVCEWs5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 17:48:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261332AbVCEWsW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 17:48:22 -0500
Received: from coderock.org ([193.77.147.115]:49573 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261310AbVCEWnL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 17:43:11 -0500
Subject: [patch 05/15] floppy: relocate devfs comment
To: axboe@suse.de
Cc: linux-kernel@vger.kernel.org, domen@coderock.org, james4765@gmail.com
From: domen@coderock.org
Date: Sat, 05 Mar 2005 23:42:55 +0100
Message-Id: <20050305224256.415D91EE1E@trashy.coderock.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


relocate devfs comment

Signed-off-by: James Nelson <james4765@gmail.com>
Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj-domen/drivers/block/floppy.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff -puN drivers/block/floppy.c~comment-drivers_block_floppy.c drivers/block/floppy.c
--- kj/drivers/block/floppy.c~comment-drivers_block_floppy.c	2005-03-05 16:10:00.000000000 +0100
+++ kj-domen/drivers/block/floppy.c	2005-03-05 16:10:00.000000000 +0100
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
@@ -158,10 +162,6 @@ static int print_unex = 1;
 #define FDPATCHES
 #include <linux/fdreg.h>
 
-/*
- * 1998/1/21 -- Richard Gooch <rgooch@atnf.csiro.au> -- devfs support
- */
-
 #include <linux/fd.h>
 #include <linux/hdreg.h>
 
_
