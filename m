Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751245AbWIHW4A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751245AbWIHW4A (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 18:56:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751237AbWIHWze
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 18:55:34 -0400
Received: from tetsuo.zabbo.net ([207.173.201.20]:19595 "EHLO tetsuo.zabbo.net")
	by vger.kernel.org with ESMTP id S1751241AbWIHWzT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 18:55:19 -0400
From: Zach Brown <zach.brown@oracle.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Message-Id: <20060908225519.9340.46049.sendpatchset@kaori.pdx.zabbo.net>
In-Reply-To: <20060908225438.9340.69862.sendpatchset@kaori.pdx.zabbo.net>
References: <20060908225438.9340.69862.sendpatchset@kaori.pdx.zabbo.net>
Subject: [PATCH 8/10] ifb: replace missing comma to separate pr_debug arguments
Date: Fri,  8 Sep 2006 15:55:19 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ifb: replace missing comma to separate pr_debug arguments 

Signed-off-by: Zach Brown <zach.brown@oracle.com>
---

 drivers/net/ifb.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: 2.6.18-rc6-debug-args/drivers/net/ifb.c
===================================================================
--- 2.6.18-rc6-debug-args.orig/drivers/net/ifb.c
+++ 2.6.18-rc6-debug-args/drivers/net/ifb.c
@@ -200,8 +200,8 @@ static struct net_device_stats *ifb_get_
 
 	pr_debug("tasklets stats %ld:%ld:%ld:%ld:%ld:%ld:%ld:%ld:%ld \n",
 		dp->st_task_enter, dp->st_txq_refl_try, dp->st_rxq_enter, 
-		dp->st_rx2tx_tran dp->st_rxq_notenter, dp->st_rx_frm_egr,
-		dp->st_rx_frm_ing, dp->st_rxq_check, dp->st_rxq_rsch );
+		dp->st_rx2tx_tran, dp->st_rxq_notenter, dp->st_rx_frm_egr,
+		dp->st_rx_frm_ing, dp->st_rxq_check, dp->st_rxq_rsch);
 
 	return stats;
 }
