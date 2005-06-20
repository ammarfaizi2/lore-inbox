Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261820AbVFTV6P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261820AbVFTV6P (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 17:58:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261702AbVFTV4w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 17:56:52 -0400
Received: from coderock.org ([193.77.147.115]:64920 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261712AbVFTVy3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 17:54:29 -0400
Message-Id: <20050620215132.805833000@nd47.coderock.org>
Date: Mon, 20 Jun 2005 23:51:33 +0200
From: domen@coderock.org
To: axboe@suse.de
Cc: linux-kernel@vger.kernel.org, James Nelson <james4765@gmail.com>,
       domen@coderock.org
Subject: [patch 03/12] floppy: relocate devfs comment
Content-Disposition: inline; filename=comment-drivers_block_floppy.c.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: james4765@verizon.net


relocate devfs comment

Signed-off-by: James Nelson <james4765@gmail.com>
Signed-off-by: Domen Puncer <domen@coderock.org>
---
 floppy.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

Index: quilt/drivers/block/floppy.c
===================================================================
--- quilt.orig/drivers/block/floppy.c
+++ quilt/drivers/block/floppy.c
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
 

--
