Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261343AbVCEWxR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261343AbVCEWxR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 17:53:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261323AbVCEWwn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 17:52:43 -0500
Received: from coderock.org ([193.77.147.115]:62373 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261322AbVCEWnr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 17:43:47 -0500
Subject: [patch 15/15] remove unused LOCAL_END_REQUEST
To: axboe@suse.de
Cc: linux-kernel@vger.kernel.org, domen@coderock.org
From: domen@coderock.org
Date: Sat, 05 Mar 2005 23:43:30 +0100
Message-Id: <20050305224330.01A941F23C@trashy.coderock.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Remove last occurence of LOCAL_END_REQUEST.

domen@nd47:~/kernel/c$ grep LOCAL_END_REQUEST -R .
./drivers/block/floppy.c:#define LOCAL_END_REQUEST

Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj-domen/drivers/block/floppy.c |    1 -
 1 files changed, 1 deletion(-)

diff -puN drivers/block/floppy.c~unused_define-drivers_block_floppy drivers/block/floppy.c
--- kj/drivers/block/floppy.c~unused_define-drivers_block_floppy	2005-03-05 16:13:19.000000000 +0100
+++ kj-domen/drivers/block/floppy.c	2005-03-05 16:13:19.000000000 +0100
@@ -242,7 +242,6 @@ static int allowed_drive_mask = 0x33;
 
 static int irqdma_allocated;
 
-#define LOCAL_END_REQUEST
 #define DEVICE_NAME "floppy"
 
 #include <linux/blkdev.h>
_
