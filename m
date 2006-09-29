Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751350AbWI2Cwx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751350AbWI2Cwx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 22:52:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751368AbWI2Cww
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 22:52:52 -0400
Received: from mail.suse.de ([195.135.220.2]:20623 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751350AbWI2Cww (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 22:52:52 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Fri, 29 Sep 2006 12:52:44 +1000
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 000 of 6] md: Introduction
Message-ID: <20060929125047.14064.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Following are 6 bug fixes and minor improvements for md.
Patches are against 2.6.18-mm2 and are all suitable for
immediate inclusion in 2.6.19.

Thanks,
NeilBrown


 [PATCH 001 of 6] md: Fix duplicity of levels in md.txt
 [PATCH 002 of 6] md: Remove MAX_MD_DEVS which is an arbitrary limit.
 [PATCH 003 of 6] md: Remove 'experimental' classification from raid5 reshape.
 [PATCH 004 of 6] md: Use ffz instead of find_first_set to convert multiplier to shift.
 [PATCH 005 of 6] md: Allow SET_BITMAP_FILE to work on 64bit kernel with 32bit userspace.
 [PATCH 006 of 6] md: Add error reporting to superblock write failure
