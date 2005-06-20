Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261957AbVFUGPI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261957AbVFUGPI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 02:15:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261739AbVFUGNZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 02:13:25 -0400
Received: from coderock.org ([193.77.147.115]:13209 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261736AbVFTVzG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 17:55:06 -0400
Message-Id: <20050620215138.006121000@nd47.coderock.org>
Date: Mon, 20 Jun 2005 23:51:39 +0200
From: domen@coderock.org
To: axboe@suse.de
Cc: linux-kernel@vger.kernel.org, domen@coderock.org
Subject: [patch 09/12] remove unused LOCAL_END_REQUEST
Content-Disposition: inline; filename=unused_define-drivers_block_floppy.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Domen Puncer <domen@coderock.org>



Remove last occurence of LOCAL_END_REQUEST.

domen@nd47:~/kernel/c$ grep LOCAL_END_REQUEST -R .
./drivers/block/floppy.c:#define LOCAL_END_REQUEST

Signed-off-by: Domen Puncer <domen@coderock.org>
---
 floppy.c |    1 -
 1 files changed, 1 deletion(-)

Index: quilt/drivers/block/floppy.c
===================================================================
--- quilt.orig/drivers/block/floppy.c
+++ quilt/drivers/block/floppy.c
@@ -242,7 +242,6 @@ static int allowed_drive_mask = 0x33;
 
 static int irqdma_allocated;
 
-#define LOCAL_END_REQUEST
 #define DEVICE_NAME "floppy"
 
 #include <linux/blkdev.h>

--
