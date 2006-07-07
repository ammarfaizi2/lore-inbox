Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932406AbWGGXeU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932406AbWGGXeU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 19:34:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932403AbWGGXeU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 19:34:20 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:9489 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932406AbWGGXeU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 19:34:20 -0400
Date: Sat, 8 Jul 2006 01:34:20 +0200
From: Adrian Bunk <bunk@stusta.de>
To: chirag.kantharia@hp.com
Cc: iss_storagedev@hp.com, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/block/cpqarray.c: remove an unused variable
Message-ID: <20060707233420.GF26941@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes a no longer used variable.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

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

