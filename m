Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261485AbVALWJS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261485AbVALWJS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 17:09:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261484AbVALWIY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 17:08:24 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:39078 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S261485AbVALVsF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 16:48:05 -0500
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
In-Reply-To: <20051121347.3xXrBXJCB2Hv1qHb@topspin.com>
X-Mailer: Roland's Patchbomber
Date: Wed, 12 Jan 2005 13:47:45 -0800
Message-Id: <20051121347.SllTsxtwWAwPk3Gh@topspin.com>
Mime-Version: 1.0
To: akpm@osdl.org
From: Roland Dreier <roland@topspin.com>
X-SA-Exim-Connect-IP: 127.0.0.1
X-SA-Exim-Mail-From: roland@topspin.com
Subject: [PATCH][2/18] InfiniBand/mthca: trivial formatting fix
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on eddore)
X-OriginalArrivalTime: 12 Jan 2005 21:47:46.0110 (UTC) FILETIME=[5A1FF5E0:01C4F8F0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trivial formatting fix for empty for loops.

Signed-off-by: Roland Dreier <roland@topspin.com>

--- linux/drivers/infiniband/hw/mthca/mthca_mr.c	(revision 1420)
+++ linux/drivers/infiniband/hw/mthca/mthca_mr.c	(revision 1421)
@@ -197,7 +197,7 @@
 	for (i = dev->limits.mtt_seg_size / 8, mr->order = 0;
 	     i < list_len;
 	     i <<= 1, ++mr->order)
-		/* nothing */ ;
+		; /* nothing */
 
 	mr->first_seg = mthca_alloc_mtt(dev, mr->order);
 	if (mr->first_seg == -1)
@@ -337,7 +337,7 @@
 	for (i = 1, dev->mr_table.max_mtt_order = 0;
 	     i < dev->limits.num_mtt_segs;
 	     i <<= 1, ++dev->mr_table.max_mtt_order)
-		/* nothing */ ;
+		; /* nothing */
 
 	dev->mr_table.mtt_buddy = kmalloc((dev->mr_table.max_mtt_order + 1) *
 					  sizeof (long *),

