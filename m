Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752553AbWCQHXF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752553AbWCQHXF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 02:23:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752559AbWCQHXB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 02:23:01 -0500
Received: from cantor2.suse.de ([195.135.220.15]:408 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1752556AbWCQHWw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 02:22:52 -0500
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Fri, 17 Mar 2006 18:21:36 +1100
Message-Id: <1060317072136.28638@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 003 of 6] md: Remove an unused variable.
References: <20060317181912.28543.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./drivers/md/raid5.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff ./drivers/md/raid5.c~current~ ./drivers/md/raid5.c
--- ./drivers/md/raid5.c~current~	2006-03-17 18:18:32.000000000 +1100
+++ ./drivers/md/raid5.c	2006-03-17 18:18:35.000000000 +1100
@@ -2186,7 +2186,7 @@ static int run(mddev_t *mddev)
 		 * increase, and we must be past the point where
 		 * a stripe over-writes itself
 		 */
-		sector_t here_new, here_old, there_new;
+		sector_t here_new, here_old;
 		int old_disks;
 
 		if (mddev->new_level != mddev->level ||
