Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964938AbWACVbK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964938AbWACVbK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 16:31:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964928AbWACVbI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 16:31:08 -0500
Received: from ns1.coraid.com ([65.14.39.133]:59593 "EHLO coraid.com")
	by vger.kernel.org with ESMTP id S1751484AbWACV3j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 16:29:39 -0500
To: linux-kernel@vger.kernel.org
CC: ecashin@coraid.com, Greg K-H <greg@kroah.com>
Subject: [PATCH 2.6.15-rc7] aoe [4/7]: use less confusing driver name
From: "Ed L. Cashin" <ecashin@coraid.com>
References: <87hd8l2fb4.fsf@coraid.com>
Date: Tue, 03 Jan 2006 16:08:05 -0500
Message-ID: <871wzp10lm.fsf@coraid.com>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: "Ed L. Cashin" <ecashin@coraid.com>

Users were confused by the driver being called "aoe-2.6-$version".
This form looks less like a Linux kernel version number.

Index: 2.6.15-rc7-aoe/drivers/block/aoe/aoemain.c
===================================================================
--- 2.6.15-rc7-aoe.orig/drivers/block/aoe/aoemain.c	2006-01-02 13:35:13.000000000 -0500
+++ 2.6.15-rc7-aoe/drivers/block/aoe/aoemain.c	2006-01-02 13:35:14.000000000 -0500
@@ -89,7 +89,7 @@
 	}
 
 	printk(KERN_INFO
-	       "aoe: aoe_init: AoE v2.6-%s initialised.\n",
+	       "aoe: aoe_init: aoe6-%s initialised.\n",
 	       VERSION);
 	discover_timer(TINIT);
 	return 0;


-- 
  Ed L. Cashin <ecashin@coraid.com>

