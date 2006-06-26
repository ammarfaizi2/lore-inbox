Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750870AbWFZU1c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750870AbWFZU1c (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 16:27:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751116AbWFZU1R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 16:27:17 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:23053 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750870AbWFZU1B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 16:27:01 -0400
Date: Mon, 26 Jun 2006 22:27:00 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Neil Brown <neilb@suse.de>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com, linux-raid@vger.kernel.org
Subject: [-mm patch] drivers/md/raid5.c: remove an unused variable
Message-ID: <20060626202700.GA23314@stusta.de>
References: <20060624061914.202fbfb5.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060624061914.202fbfb5.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes an unused variable.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.17-mm2-full/drivers/md/raid5.c.old	2006-06-26 21:17:13.000000000 +0200
+++ linux-2.6.17-mm2-full/drivers/md/raid5.c	2006-06-26 21:17:20.000000000 +0200
@@ -2827,7 +2827,6 @@
 	struct stripe_head *sh;
 	int pd_idx;
 	int raid_disks = conf->raid_disks;
-	int data_disks = raid_disks - conf->max_degraded;
 	sector_t max_sector = mddev->size << 1;
 	int sync_blocks;
 	int still_degraded = 0;

