Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263264AbUJ2Ac5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263264AbUJ2Ac5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 20:32:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263205AbUJ2AXO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 20:23:14 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:27142 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S263156AbUJ2ATm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 20:19:42 -0400
Date: Fri, 29 Oct 2004 02:19:07 +0200
From: Adrian Bunk <bunk@stusta.de>
To: kraxel@bytesex.org
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] media/video/bw-qcam.c: remove an unused function
Message-ID: <20041029001907.GL29142@stusta.de>
References: <20041028222904.GR3207@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041028222904.GR3207@stusta.de>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ this time without the problems due to a digital signature... ]

The patch below removes an unused function from media/video/bw-qcam.c


diffstat output:
 drivers/media/video/bw-qcam.c |    5 -----
 1 files changed, 5 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

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
