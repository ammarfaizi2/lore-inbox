Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751630AbWJWHHv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751630AbWJWHHv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 03:07:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751642AbWJWHHv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 03:07:51 -0400
Received: from ns2.suse.de ([195.135.220.15]:19915 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751630AbWJWHHu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 03:07:50 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Mon, 23 Oct 2006 17:07:42 +1000
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: stable@kernel.org
Subject: [PATCH 000 of 4] md: assorted bugfixes - one serious.
Message-ID: <20061023170347.29132.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I rang my regression test suite on md for the first time in a 
while (obviously too long :-().
Found two bugs resulting in patches 1 and 3.
Others are fixes for more subtle issues.

All patches are suitable for 2.6.19, patch 1 is quite serious and should go in 2.6.18.2.

Thanks,
NeilBrown


 [PATCH 001 of 4] md: Fix bug where spares don't always get rebuilt properly when they become live.
 [PATCH 002 of 4] md: Simplify checking of available size when resizing an array
 [PATCH 003 of 4] md: Fix up maintenance of ->degraded in multipath.
 [PATCH 004 of 4] md: Fix printk format warnings, seen on powerpc64:
