Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161080AbWHRS5J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161080AbWHRS5J (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 14:57:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161081AbWHRSzR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 14:55:17 -0400
Received: from ns1.coraid.com ([65.14.39.133]:61029 "EHLO coraid.com")
	by vger.kernel.org with ESMTP id S1161079AbWHRSzI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 14:55:08 -0400
Message-ID: <bbc6a4d60955271fb8c7bde42d5d09b3@coraid.com>
Date: Fri, 18 Aug 2006 13:40:13 -0400
To: linux-kernel@vger.kernel.org
Cc: ecashin@coraid.com, Greg K-H <greg@kroah.com>
Subject: [PATCH 2.6.18-rc4] aoe [12/13]: remove sysfs comment
References: <E1GE8K3-0008Jn-00@kokone.coraid.com>
From: "Ed L. Cashin" <ecashin@coraid.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: "Ed L. Cashin" <ecashin@coraid.com>

Remove unecessary comment.

diff -upr 2.6.18-rc4-orig/drivers/block/aoe/aoeblk.c 2.6.18-rc4-aoe/drivers/block/aoe/aoeblk.c
--- 2.6.18-rc4-orig/drivers/block/aoe/aoeblk.c	2006-08-17 11:32:22.000000000 -0400
+++ 2.6.18-rc4-aoe/drivers/block/aoe/aoeblk.c	2006-08-17 15:38:55.000000000 -0400
@@ -14,7 +14,6 @@
 
 static kmem_cache_t *buf_pool_cache;
 
-/* add attributes for our block devices in sysfs */
 static ssize_t aoedisk_show_state(struct gendisk * disk, char *page)
 {
 	struct aoedev *d = disk->private_data;


-- 
  "Ed L. Cashin" <ecashin@coraid.com>
