Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750819AbWGKOQ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750819AbWGKOQ2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 10:16:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750821AbWGKOQ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 10:16:28 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:44562 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750819AbWGKOQ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 10:16:28 -0400
Date: Tue, 11 Jul 2006 16:16:26 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: chirag.kantharia@hp.com, iss_storagedev@hp.com,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/block/cpqarray.c: remove an unused variable
Message-ID: <20060711141626.GP13938@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes a no longer used variable.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 8 Jul 2006

--- linux-2.6.17-mm6-full/drivers/block/cpqarray.c.old	2006-07-06 23:56:36.000000000 +0200
+++ linux-2.6.17-mm6-full/drivers/block/cpqarray.c	2006-07-06 23:56:15.000000000 +0200
@@ -1739,8 +1739,6 @@
 	     (log_index < id_ctlr_buf->nr_drvs)
 	     && (log_unit < NWD);
 	     log_unit++) {
-		struct gendisk *disk = ida_gendisk[ctlr][log_unit];
-
 		size = sizeof(sense_log_drv_stat_t);
 
 		/*

