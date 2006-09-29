Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161090AbWI2DIl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161090AbWI2DIl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 23:08:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161141AbWI2DIl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 23:08:41 -0400
Received: from ns2.suse.de ([195.135.220.15]:4793 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1161090AbWI2DIk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 23:08:40 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Fri, 29 Sep 2006 13:08:34 +1000
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 000 of 8] knfsd: Introduction
Message-ID: <20060929130518.23919.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Follow are 8 knfsd related patches made against 2.6.18-mm2
and suitable for 2.6.19.

1 adds support to tmpfs to make it exportable
2 and 3 are straight forward bugfixes.
4 is a bugfix in dcache.c code, so some external review wouldn't
go astray.
5-8 are more nfsv4 updates.

Thanks,
NeilBrown

 [PATCH 001 of 8] knfsd: Add nfs-export support to tmpfs
 [PATCH 002 of 8] knfsd: lockd: fix refount on nsm.
 [PATCH 003 of 8] knfsd: Fix auto-sizing of nfsd request/reply buffers
 [PATCH 004 of 8] knfsd: Close a race-opportunity in d_splice_alias
 [PATCH 005 of 8] knfsd: nfsd: store export path in export
 [PATCH 006 of 8] knfsd: nfsd4: fslocations data structures
 [PATCH 007 of 8] knfsd: nfsd4: xdr encoding for fs_locations
 [PATCH 008 of 8] knfsd: nfsd4: actually use all the pieces to implement referrals
