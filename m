Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751783AbWFAFNX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751783AbWFAFNX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 01:13:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751640AbWFAFNX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 01:13:23 -0400
Received: from cantor2.suse.de ([195.135.220.15]:9129 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751229AbWFAFNX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 01:13:23 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Thu, 1 Jun 2006 15:13:11 +1000
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 000 of 10] md: Introduction - assorted patches for -mm
Message-ID: <20060601150955.27444.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Following are 10 patches for md in -mm.  None are appropriate for 2.6.17.

First 3 are fixes.
Next 2 are functionality improvements (people keep wanting their spare 
   drives to go to sleep, so now they can).
Remainder are more sysfs access.

Thanks,
NeilBrown


 [PATCH 001 of 10] md: md Kconfig speeling feex
 [PATCH 002 of 10] md: Fix Kconfig error
 [PATCH 003 of 10] md: Fix bug that stops raid5 resync from happening
 [PATCH 004 of 10] md: Allow re-add to work on array without bitmaps.
 [PATCH 005 of 10] md: Don't write dirty/clean update to spares - leave them alone
 [PATCH 006 of 10] md: Set/get state of array via sysfs
 [PATCH 007 of 10] md: Allow rdev state to be set via sysfs.
 [PATCH 008 of 10] md: Allow raid 'layout' to be read and set via sysfs.
 [PATCH 009 of 10] md: Allow resync_start to be set and queried via sysfs.
 [PATCH 010 of 10] md: Allow the write_mostly flag to be set via sysfs.
