Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964886AbWFAFOd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964886AbWFAFOd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 01:14:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964887AbWFAFON
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 01:14:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:10921 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751640AbWFAFNx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 01:13:53 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Thu, 1 Jun 2006 15:13:17 +1000
Message-Id: <1060601051317.27547@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Justin Piszcz <jpiszcz@lucidpixels.com>
Subject: [PATCH 001 of 10] md: md Kconfig speeling feex
References: <20060601150955.27444.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Justin Piszcz <jpiszcz@lucidpixels.com>

I was experimenting with Linux SW raid today and found a spelling error 
when reading the help menus...
(and fly spell found more).

Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./drivers/md/Kconfig |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff ./drivers/md/Kconfig~current~ ./drivers/md/Kconfig
--- ./drivers/md/Kconfig~current~	2006-06-01 15:03:29.000000000 +1000
+++ ./drivers/md/Kconfig	2006-06-01 15:04:25.000000000 +1000
@@ -90,7 +90,7 @@ config MD_RAID10
 	depends on BLK_DEV_MD && EXPERIMENTAL
 	---help---
 	  RAID-10 provides a combination of striping (RAID-0) and
-	  mirroring (RAID-1) with easier configuration and more flexable
+	  mirroring (RAID-1) with easier configuration and more flexible
 	  layout.
 	  Unlike RAID-0, but like RAID-1, RAID-10 requires all devices to
 	  be the same size (or at least, only as much as the smallest device
@@ -147,7 +147,7 @@ config MD_RAID5_RESHAPE
 	  is online.  However it is still EXPERIMENTAL code.  It should
 	  work, but please be sure that you have backups.
 
-	  You will need mdadm verion 2.4.1 or later to use this
+	  You will need mdadm version 2.4.1 or later to use this
 	  feature safely.  During the early stage of reshape there is
 	  a critical section where live data is being over-written.  A
 	  crash during this time needs extra care for recovery.  The
@@ -221,7 +221,7 @@ config DM_SNAPSHOT
        tristate "Snapshot target (EXPERIMENTAL)"
        depends on BLK_DEV_DM && EXPERIMENTAL
        ---help---
-         Allow volume managers to take writeable snapshots of a device.
+         Allow volume managers to take writable snapshots of a device.
 
 config DM_MIRROR
        tristate "Mirror target (EXPERIMENTAL)"
