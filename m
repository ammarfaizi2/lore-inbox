Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161299AbWJPMCU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161299AbWJPMCU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 08:02:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161302AbWJPMCU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 08:02:20 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:1885 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1161299AbWJPMCT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 08:02:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=us27tuRhZZ/XqTPZ1aIG3E9TXSb15MMJQwvQFnl1bEtN1huoZcxvp35aX5bWlFoW0J+3lEbKmqLj2aKRBOXI/yOJkzYzXi4IkPsnAfzk+WSfUOmH8jgcEOOZFhnkYQ+mBmFA+n2ogpUHtsQXVt5tr4kXsoGMXYtT9RIvyaeRZIw=
Date: Mon, 16 Oct 2006 16:01:56 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] sx: fix user-visible typo (devic)
Message-ID: <20061016120156.GA5483@martell.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 drivers/char/sx.c               |    2 +-
 drivers/mtd/chips/jedec_probe.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/char/sx.c
+++ b/drivers/char/sx.c
@@ -2602,7 +2602,7 @@ static void __exit sx_exit (void)
 		}
 	}
 	if (misc_deregister(&sx_fw_device) < 0) {
-		printk (KERN_INFO "sx: couldn't deregister firmware loader devic\n");
+		printk (KERN_INFO "sx: couldn't deregister firmware loader device\n");
 	}
 	sx_dprintk (SX_DEBUG_CLEANUP, "Cleaning up drivers (%d)\n", sx_initialized);
 	if (sx_initialized)
--- a/drivers/mtd/chips/jedec_probe.c
+++ b/drivers/mtd/chips/jedec_probe.c
@@ -1874,7 +1874,7 @@ static int cfi_jedec_setup(struct cfi_pr
 
 
 /*
- * There is a BIG problem properly ID'ing the JEDEC devic and guaranteeing
+ * There is a BIG problem properly ID'ing the JEDEC device and guaranteeing
  * the mapped address, unlock addresses, and proper chip ID.  This function
  * attempts to minimize errors.  It is doubtfull that this probe will ever
  * be perfect - consequently there should be some module parameters that

