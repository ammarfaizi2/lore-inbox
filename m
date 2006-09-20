Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932276AbWITS7k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932276AbWITS7k (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 14:59:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932269AbWITS5S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 14:57:18 -0400
Received: from ns1.coraid.com ([65.14.39.133]:47480 "EHLO coraid.com")
	by vger.kernel.org with ESMTP id S932264AbWITS5K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 14:57:10 -0400
Message-ID: <76c77cef8d932d014f284f44fec130fc@coraid.com>
Date: Wed, 20 Sep 2006 14:36:51 -0400
To: linux-kernel@vger.kernel.org
Cc: ecashin@coraid.com, Greg K-H <greg@kroah.com>
Subject: [PATCH 2.6.18-rc4] aoe [12/14]: remove sysfs comment
References: <E1GQ6uv-0001qi-00@kokone>
From: "Ed L. Cashin" <ecashin@coraid.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unecessary comment.

Signed-off-by: "Ed L. Cashin" <ecashin@coraid.com>
---

diff -upr 2.6.18-rc4-orig/drivers/block/aoe/aoeblk.c 2.6.18-rc4-aoe/drivers/block/aoe/aoeblk.c
--- 2.6.18-rc4-orig/drivers/block/aoe/aoeblk.c	2006-09-20 14:29:36.000000000 -0400
+++ 2.6.18-rc4-aoe/drivers/block/aoe/aoeblk.c	2006-09-20 14:29:36.000000000 -0400
@@ -14,7 +14,6 @@
 
 static kmem_cache_t *buf_pool_cache;
 
-/* add attributes for our block devices in sysfs */
 static ssize_t aoedisk_show_state(struct gendisk * disk, char *page)
 {
 	struct aoedev *d = disk->private_data;


-- 
  "Ed L. Cashin" <ecashin@coraid.com>
