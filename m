Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932532AbWF0HGk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932532AbWF0HGk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 03:06:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030720AbWF0HGW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 03:06:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:64163 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030713AbWF0HGG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 03:06:06 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Tue, 27 Jun 2006 17:05:59 +1000
Message-Id: <1060627070559.26070@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 010 of 12] md: Remove a variable that is now unused.
References: <20060627170010.25835.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./drivers/md/raid5.c |    1 -
 1 file changed, 1 deletion(-)

diff .prev/drivers/md/raid5.c ./drivers/md/raid5.c
--- .prev/drivers/md/raid5.c	2006-06-27 12:17:33.000000000 +1000
+++ ./drivers/md/raid5.c	2006-06-27 12:17:34.000000000 +1000
@@ -2846,7 +2846,6 @@ static inline sector_t sync_request(mdde
 	struct stripe_head *sh;
 	int pd_idx;
 	int raid_disks = conf->raid_disks;
-	int data_disks = raid_disks - conf->max_degraded;
 	sector_t max_sector = mddev->size << 1;
 	int sync_blocks;
 	int still_degraded = 0;
