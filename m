Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932094AbWDMQWT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932094AbWDMQWT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 12:22:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932081AbWDMQWT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 12:22:19 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:62736 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932094AbWDMQWS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 12:22:18 -0400
Date: Thu, 13 Apr 2006 18:22:16 +0200
From: Adrian Bunk <bunk@stusta.de>
To: axboe@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: [RFC: 2.6 patch] block/elevator.c: remove unused exports
Message-ID: <20060413162216.GB4162@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes the following unused EXPORT_SYMBOL's:
- elv_requeue_request
- elv_completed_request

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 block/elevator.c |    2 --
 1 file changed, 2 deletions(-)

--- linux-2.6.17-rc1-mm2-full/block/elevator.c.old	2006-04-13 17:33:52.000000000 +0200
+++ linux-2.6.17-rc1-mm2-full/block/elevator.c	2006-04-13 17:34:59.000000000 +0200
@@ -895,10 +895,8 @@
 EXPORT_SYMBOL(elv_dispatch_sort);
 EXPORT_SYMBOL(elv_add_request);
 EXPORT_SYMBOL(__elv_add_request);
-EXPORT_SYMBOL(elv_requeue_request);
 EXPORT_SYMBOL(elv_next_request);
 EXPORT_SYMBOL(elv_dequeue_request);
 EXPORT_SYMBOL(elv_queue_empty);
-EXPORT_SYMBOL(elv_completed_request);
 EXPORT_SYMBOL(elevator_exit);
 EXPORT_SYMBOL(elevator_init);

