Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750783AbWHXHk6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750783AbWHXHk6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 03:40:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750772AbWHXHk6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 03:40:58 -0400
Received: from mx1.suse.de ([195.135.220.2]:33492 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750762AbWHXHk5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 03:40:57 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Thu, 24 Aug 2006 17:40:56 +1000
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 000 of 4] md: Introduction
Message-ID: <20060824173647.19026.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Following are 4 patches against 2.6.18-rc4-mm2

The first 2 are bug fixes which should go in 2.6.18, and apply
equally well to that tree as to -mm.

The latter two should stay in -mm until after 2.6.18.

The second patch is maybe bigger than it absolutely needs to be as a bugfix.
If you like I can stripe out all the rcu-extra-carefulness as a separate
patch and just leave the important bit which involves moving the
atomic_add down twenty-something lines.

Thanks,
NeilBrown

 [PATCH 001 of 4] md: Fix recent breakage of md/raid1 array checking
 [PATCH 002 of 4] md: Fix issues with referencing rdev in md/raid1.
 [PATCH 003 of 4] md: new sysfs interface for setting bits in the write-intent-bitmap
 [PATCH 004 of 4] md: Remove unnecessary variable x in stripe_to_pdidx().
