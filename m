Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932298AbWELXpy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932298AbWELXpy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 19:45:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932208AbWELXop
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 19:44:45 -0400
Received: from mx.pathscale.com ([64.160.42.68]:57001 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932214AbWELXod (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 19:44:33 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 23 of 53] ipath - [TRIVIAL] typo fixes
X-Mercurial-Node: 8b882bb46a320431f64467773588b8e5ed8f3eb6
Message-Id: <8b882bb46a320431f644.1147477388@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1147477365@eng-12.pathscale.com>
Date: Fri, 12 May 2006 16:43:08 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: rdreier@cisco.com
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A few typo fixes.

Signed-off-by: Bryan O'Sullivan <bos@pathscale.com>

diff -r 1887e7b3e2a3 -r 8b882bb46a32 drivers/infiniband/hw/ipath/ipath_intr.c
--- a/drivers/infiniband/hw/ipath/ipath_intr.c	Fri May 12 15:55:28 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_intr.c	Fri May 12 15:55:28 2006 -0700
@@ -753,7 +753,7 @@ irqreturn_t ipath_intr(int irq, void *da
 	}
 
 	/*
-	 * We try to avoid readint the interrupt status register, since
+	 * We try to avoid reading the interrupt status register, since
 	 * that's a PIO read, and stalls the processor for up to about
 	 * ~0.25 usec. The idea is that if we processed a port0 packet,
 	 * we blindly clear the  port 0 receive interrupt bits, and nothing
diff -r 1887e7b3e2a3 -r 8b882bb46a32 drivers/infiniband/hw/ipath/ipath_layer.c
--- a/drivers/infiniband/hw/ipath/ipath_layer.c	Fri May 12 15:55:28 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_layer.c	Fri May 12 15:55:28 2006 -0700
@@ -882,7 +882,7 @@ static void copy_io(u32 __iomem *piobuf,
 /**
  * ipath_verbs_send - send a packet from the verbs layer
  * @dd: the infinipath device
- * @hdrwords: the number of works in the header
+ * @hdrwords: the number of words in the header
  * @hdr: the packet header
  * @len: the length of the packet in bytes
  * @ss: the SGE to send
