Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161337AbWASTNE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161337AbWASTNE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 14:13:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161341AbWASTMh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 14:12:37 -0500
Received: from ns1.coraid.com ([65.14.39.133]:19880 "EHLO coraid.com")
	by vger.kernel.org with ESMTP id S1161339AbWASTL4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 14:11:56 -0500
Message-ID: <860a198ae6c2045a65db36a0227cd5a6@coraid.com>
Date: Thu, 19 Jan 2006 13:46:29 -0500
To: linux-kernel@vger.kernel.org
CC: ecashin@coraid.com, Greg K-H <greg@kroah.com>
Subject: [PATCH 2.6.15-git9] aoe [7/8]: update driver compatibility string
From: "Ed L. Cashin" <ecashin@coraid.com>
References: <E1EzelK-0006sT-00@kokone>
Gcc: nnfolder:Mail/sent-200601
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: "Ed L. Cashin" <ecashin@coraid.com>

The aoe driver is not compatible with 2.6 kernels older
than 2.6.2.

diff -upr 2.6.15-git9-orig/drivers/block/aoe/aoemain.c 2.6.15-git9-aoe/drivers/block/aoe/aoemain.c
--- 2.6.15-git9-orig/drivers/block/aoe/aoemain.c	2006-01-19 13:31:22.000000000 -0500
+++ 2.6.15-git9-aoe/drivers/block/aoe/aoemain.c	2006-01-19 13:31:23.000000000 -0500
@@ -11,7 +11,7 @@
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Sam Hopkins <sah@coraid.com>");
-MODULE_DESCRIPTION("AoE block/char driver for 2.6.[0-9]+");
+MODULE_DESCRIPTION("AoE block/char driver for 2.6.2 and newer 2.6 kernels");
 MODULE_VERSION(VERSION);
 
 enum { TINIT, TRUN, TKILL };


-- 
  "Ed L. Cashin" <ecashin@coraid.com>
