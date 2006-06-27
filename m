Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030685AbWF0HFN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030685AbWF0HFN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 03:05:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030680AbWF0HFN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 03:05:13 -0400
Received: from mail.suse.de ([195.135.220.2]:17795 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030675AbWF0HFL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 03:05:11 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Tue, 27 Jun 2006 17:05:01 +1000
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 000 of 12] md: Introduction
Message-ID: <20060627170010.25835.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Following are 12 assorted small patches for md.
They are against 2.6.17-mm2 and are suitable for inclusion in 2.6.18.

They are primarily small bug fixes, many fixing possible races, some
of which have been seen in the wild, some not.

Thanks,
NeilBrown


 [PATCH 001 of 12] md: Possible fix for unplug problem
 [PATCH 002 of 12] md: Set desc_nr correctly for version-1 superblocks.
 [PATCH 003 of 12] md: Delay starting md threads until array is completely setup.
 [PATCH 004 of 12] md: Fix resync speed calculation for restarted resyncs.
 [PATCH 005 of 12] md: Fix a plug/unplug race in raid5
 [PATCH 006 of 12] md: Fix some small races in bitmap plugging in raid5.
 [PATCH 007 of 12] md: Fix usage of wrong variable in raid1
 [PATCH 008 of 12] md: Unify usage of symbolic names for perms.
 [PATCH 009 of 12] md: Require CAP_SYS_ADMIN for (re-)configuring md devices via sysfs.
 [PATCH 010 of 12] md: Remove a variable that is now unused.
 [PATCH 011 of 12] md: Fix "Will Configure" message when interpreting md= kernel parameter.
 [PATCH 012 of 12] md: Include sector number in messages about corrected read errors.
