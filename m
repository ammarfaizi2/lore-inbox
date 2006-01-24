Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964979AbWAXD6Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964979AbWAXD6Y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 22:58:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964974AbWAXD6Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 22:58:24 -0500
Received: from mx2.suse.de ([195.135.220.15]:15798 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964855AbWAXD6X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 22:58:23 -0500
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Tue, 24 Jan 2006 14:58:17 +1100
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 000 of 5] md: Introduction - assorted fixes
Message-ID: <20060124145516.28734.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following 5 patches are assorted fixes for md in 2.6.16-whatever

Patch 4 isn't exactly a 'fix'.  It adds functionality to raid6 to match
raid5.

All should be suitable for 2.6.16-rc2

Thanks,
NeilBrown


 [PATCH 001 of 5] md: Fix device-size updates in md.
 [PATCH 002 of 5] md: Make sure array geometry changes persist with version-1 superblocks.
 [PATCH 003 of 5] md: Don't remove bitmap from md array when switching to read-only
 [PATCH 004 of 5] md: Add sysfs access to raid6 stripe cache size
 [PATCH 005 of 5] md: Make sure QUEUE_FLAG_CLUSTER is set properly for md.
