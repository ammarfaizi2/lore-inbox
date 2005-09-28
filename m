Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751123AbVI1Xlv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751123AbVI1Xlv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 19:41:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751248AbVI1Xlu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 19:41:50 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:32916 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S1751123AbVI1Xlu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 19:41:50 -0400
Date: Wed, 28 Sep 2005 16:42:54 -0700
From: Deepak Saxena <dsaxena@plexity.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: [PATCH] Fix ixp4xx MTD driver module build
Message-ID: <20050928234254.GA21547@plexity.net>
Reply-To: dsaxena@plexity.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Plexity Networks
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Missing ';' breaks module build.

Signed-off-by: Deepak Saxena <dsaxena@plexity.net>

diff --git a/drivers/mtd/maps/ixp4xx.c b/drivers/mtd/maps/ixp4xx.c
--- a/drivers/mtd/maps/ixp4xx.c
+++ b/drivers/mtd/maps/ixp4xx.c
@@ -254,6 +255,6 @@ module_init(ixp4xx_flash_init);
 module_exit(ixp4xx_flash_exit);
 
 MODULE_LICENSE("GPL");
-MODULE_DESCRIPTION("MTD map driver for Intel IXP4xx systems")
+MODULE_DESCRIPTION("MTD map driver for Intel IXP4xx systems");
 MODULE_AUTHOR("Deepak Saxena");
 
