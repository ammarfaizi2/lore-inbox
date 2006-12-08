Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1164304AbWLHBFR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1164304AbWLHBFR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 20:05:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1164309AbWLHBFQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 20:05:16 -0500
Received: from ns.suse.de ([195.135.220.2]:57908 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1164304AbWLHBFP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 20:05:15 -0500
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Fri, 8 Dec 2006 12:05:24 +1100
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 000 of 5] md: Assorted minor fixes for mainline
Message-ID: <20061208120132.21203.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Following are 5 patches for md in 2.6.19-rc6-mm2 that are suitable for 2.6.20.

Patch 4 might fix an outstanding bug against md which manifests as an
oops early in boot, but I don't have test results yet.

NeilBrown

 [PATCH 001 of 5] md: Remove some old ifdefed-out code from raid5.c
 [PATCH 002 of 5] md: Return a non-zero error to bi_end_io as appropriate in raid5.
 [PATCH 003 of 5] md: Assorted md and raid1 one-liners
 [PATCH 004 of 5] md: Close a race between destroying and recreating an md device.
 [PATCH 005 of 5] md: Allow mddevs to live a bit longer to avoid a loop with udev.
