Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262843AbVDAS2y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262843AbVDAS2y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 13:28:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262842AbVDAS1A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 13:27:00 -0500
Received: from webmail.topspin.com ([12.162.17.3]:34971 "EHLO
	exch-1.topspincom.com") by vger.kernel.org with ESMTP
	id S262845AbVDASZE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 13:25:04 -0500
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [PATCH][4/6] IB: Trivial FMR printk cleanup
In-Reply-To: <2005411023.09JoUTQ2SAMPiKPQ@topspin.com>
X-Mailer: Roland's Patchbomber
Date: Fri, 1 Apr 2005 10:23:51 -0800
Message-Id: <2005411023.5oEZz0iawuKxVyay@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: akpm@osdl.org
Content-Transfer-Encoding: 7BIT
From: Roland Dreier <roland@topspin.com>
X-OriginalArrivalTime: 01 Apr 2005 18:23:51.0347 (UTC) FILETIME=[F4458830:01C536E7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Libor Michalek <libor@topspin.com>

Add missing newline in printk.

Signed-off-by: Libor Michalek <libor@topspin.com>
Signed-off-by: Roland Dreier <roland@topspin.com>


--- linux-export.orig/drivers/infiniband/core/fmr_pool.c	2005-04-01 10:08:58.240241456 -0800
+++ linux-export/drivers/infiniband/core/fmr_pool.c	2005-04-01 10:08:59.539959345 -0800
@@ -442,7 +442,7 @@
 		list_add(&fmr->list, &pool->free_list);
 		spin_unlock_irqrestore(&pool->pool_lock, flags);
 
-		printk(KERN_WARNING "fmr_map returns %d",
+		printk(KERN_WARNING "fmr_map returns %d\n",
 		       result);
 
 		return ERR_PTR(result);

