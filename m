Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964812AbWGaHbr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964812AbWGaHbr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 03:31:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964811AbWGaHbq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 03:31:46 -0400
Received: from cantor.suse.de ([195.135.220.2]:18379 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S964796AbWGaHbq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 03:31:46 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Mon, 31 Jul 2006 17:31:34 +1000
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 000 of 9] md: Introduction - assorted cleanup and minor fixes
Message-ID: <20060731172842.24323.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Following are 9 patches for md in 2.6-mm-latest that should be
targeted for 2.6.19 (not 2.6.18 material).

Nothing really remarkable, so I'll leave to speak for themselves.

NeilBrown


 [PATCH 001 of 9] md: The scheduled removal of the START_ARRAY ioctl for md
 [PATCH 002 of 9] md: Fix a comment that is wrong in raid5.h
 [PATCH 003 of 9] md: Factor out part of raid1d into a separate function.
 [PATCH 004 of 9] md: Factor out part of raid10d into a separate function.
 [PATCH 005 of 9] md: Replace magic numbers in sb_dirty with well defined bit flags
 [PATCH 006 of 9] md: Remove the working_disks and failed_disks from raid5 state data.
 [PATCH 007 of 9] md: Remove 'working_disks' from raid10 state
 [PATCH 008 of 9] md: Remove working_disks from raid1 state data
 [PATCH 009 of 9] md: Improve locking around error handling.
