Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261820AbUKHJbr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261820AbUKHJbr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 04:31:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261789AbUKHJbq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 04:31:46 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:22494 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S261810AbUKHJEI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 04:04:08 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Mon, 8 Nov 2004 09:54:35 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: Andrew Morton <akpm@osdl.org>, Kernel List <linux-kernel@vger.kernel.org>
Subject: [patch] media/video/bw-qcam.c: remove an unused function
Message-ID: <20041108085435.GA19362@bytesex>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below removes an unused function from media/video/bw-qcam.c

Signed-off-by: Adrian Bunk <bunk@stusta.de>
Signed-off-by: Gerd Knorr <kraxel@bytesex.org>
---
 drivers/media/video/bw-qcam.c |    5 -----
 1 files changed, 5 deletions(-)

--- linux-2.6.10-rc1-mm1-full/drivers/media/video/bw-qcam.c.old	2004-10-28 23:16:36.000000000 +0200
+++ linux-2.6.10-rc1-mm1-full/drivers/media/video/bw-qcam.c	2004-10-28 23:17:06.000000000 +0200
@@ -91,11 +91,6 @@
 	return parport_read_status(q->pport);
 }
 
-static inline int read_lpcontrol(struct qcam_device *q)
-{
-	return parport_read_control(q->pport);
-}
-
 static inline int read_lpdata(struct qcam_device *q)
 {
 	return parport_read_data(q->pport);

-- 
#define printk(args...) fprintf(stderr, ## args)
