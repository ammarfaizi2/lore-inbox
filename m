Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266786AbUHIOoo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266786AbUHIOoo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 10:44:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266766AbUHIOon
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 10:44:43 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:16610 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S266684AbUHIOo3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 10:44:29 -0400
Message-Id: <200408091445.i79EjOeQ079636@northrelay04.pok.ibm.com>
Subject: [PATCH 1/1] blk_queue_export_resize_tags
To: axboe@suse.de
Cc: linux-kernel@vger.kernel.org, brking@us.ibm.com
From: brking@us.ibm.com
Date: Mon, 09 Aug 2004 09:44:19 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Exports blk_queue_resize_tags since it is an exported interface.

Signed-off-by: Brian King <brking@us.ibm.com>
---

 linux-2.6.8-rc3-bjking1/drivers/block/ll_rw_blk.c |    2 ++
 1 files changed, 2 insertions(+)

diff -puN drivers/block/ll_rw_blk.c~blk_queue_export_resize_tags drivers/block/ll_rw_blk.c
--- linux-2.6.8-rc3/drivers/block/ll_rw_blk.c~blk_queue_export_resize_tags	2004-08-09 09:40:46.000000000 -0500
+++ linux-2.6.8-rc3-bjking1/drivers/block/ll_rw_blk.c	2004-08-09 09:41:02.000000000 -0500
@@ -653,6 +653,8 @@ int blk_queue_resize_tags(request_queue_
 	return 0;
 }
 
+EXPORT_SYMBOL(blk_queue_resize_tags);
+
 /**
  * blk_queue_end_tag - end tag operations for a request
  * @q:  the request queue for the device
_
