Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753494AbWKGWJT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753494AbWKGWJT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 17:09:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753491AbWKGWJS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 17:09:18 -0500
Received: from cantor2.suse.de ([195.135.220.15]:36041 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1753486AbWKGWJR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 17:09:17 -0500
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Wed, 8 Nov 2006 09:09:21 +1100
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 000 of 9] md: udev notification, raid5 read improvements etc
Message-ID: <20061108085917.12064.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Following are 9 patches for md in 2.6.19-rc4-mm2.
The first two are suitable for 2.6.19.
The third might be.  It seems straight forward, but is awkward to test.
Possibly safest to keep it for .20...
The rest should be held for .20.

4 is a minor tidyup
5 is a resend with a bug fixed.
6-9 are resends with attribution improved.

Thanks,
NeilBrown


 [PATCH 001 of 9] md: Change ONLINE/OFFLINE events to a single CHANGE event
 [PATCH 002 of 9] md: Fix sizing problem with raid5-reshape and CONFIG_LBD=n
 [PATCH 003 of 9] md: Do not freeze md threads for suspend.
 [PATCH 004 of 9] md: Tidy up device-change notification when an md array is stopped
 [PATCH 005 of 9] md: Change lifetime rules for 'md' devices.
 [PATCH 006 of 9] md: Define raid5_mergeable_bvec
 [PATCH 007 of 9] md: Handle bypassing the read cache (assuming nothing fails).
 [PATCH 008 of 9] md: Allow reads that have bypassed the cache to be retried on failure.
 [PATCH 009 of 9] md: Enable bypassing cache for reads.
