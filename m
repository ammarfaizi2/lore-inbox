Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161336AbWASTLv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161336AbWASTLv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 14:11:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161339AbWASTLv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 14:11:51 -0500
Received: from ns1.coraid.com ([65.14.39.133]:18344 "EHLO coraid.com")
	by vger.kernel.org with ESMTP id S1161338AbWASTLu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 14:11:50 -0500
Message-ID: <960c425eac860dfded074773260f0e74@coraid.com>
Date: Thu, 19 Jan 2006 13:46:22 -0500
To: linux-kernel@vger.kernel.org
CC: ecashin@coraid.com, Greg K-H <greg@kroah.com>
Subject: [PATCH 2.6.15-git9] aoe [4/8]: use less confusing driver name
From: "Ed L. Cashin" <ecashin@coraid.com>
References: <E1EzelK-0006sT-00@kokone>
Gcc: nnfolder:Mail/sent-200601
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: "Ed L. Cashin" <ecashin@coraid.com>

Users were confused by the driver being called "aoe-2.6-$version".
This form looks less like a Linux kernel version number.

diff -upr 2.6.15-git9-orig/drivers/block/aoe/aoemain.c 2.6.15-git9-aoe/drivers/block/aoe/aoemain.c
--- 2.6.15-git9-orig/drivers/block/aoe/aoemain.c	2006-01-19 13:31:22.000000000 -0500
+++ 2.6.15-git9-aoe/drivers/block/aoe/aoemain.c	2006-01-19 13:31:22.000000000 -0500
@@ -89,7 +89,7 @@ aoe_init(void)
 	}
 
 	printk(KERN_INFO
-	       "aoe: aoe_init: AoE v2.6-%s initialised.\n",
+	       "aoe: aoe_init: AoE v%s initialised.\n",
 	       VERSION);
 	discover_timer(TINIT);
 	return 0;


-- 
  "Ed L. Cashin" <ecashin@coraid.com>
