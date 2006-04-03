Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964836AbWDCFTu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964836AbWDCFTu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 01:19:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751414AbWDCFTu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 01:19:50 -0400
Received: from cantor2.suse.de ([195.135.220.15]:31900 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751417AbWDCFTt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 01:19:49 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Mon, 3 Apr 2006 15:18:01 +1000
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 000 of 16] knfsd: Introduction
Message-ID: <20060403151452.1567.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Groan, I missed the merge-window, but that's for new features, and this
is bug fixes...

The following 16 patches fix various bugs in the nfs server, mostly
related to NFSv4, but there are a couple that are more generally
applicable (005 in particular).

They are against 2.6.16-mm2 and should be suitable for 2.6.17-rc2.

Thanks,
NeilBrown


 [PATCH 001 of 16] knfsd: locks: flag NFSv4-owned locks
 [PATCH 002 of 16] knfsd: nfsd4: Wrong error handling in nfs4acl
 [PATCH 003 of 16] knfsd: nfsd4: better nfs4acl errors
 [PATCH 004 of 16] knfsd: nfsd4: fix acl xattr length return
 [PATCH 005 of 16] knfsd: nfsd: oops exporting nonexistent directory
 [PATCH 006 of 16] knfsd: nfsd: nfsd_setuser doesn't really need to modify rqstp->rq_cred.
 [PATCH 007 of 16] knfsd: nfsd4: remove nfsd_setuser from putrootfh
 [PATCH 008 of 16] knfsd: nfsd4: fix corruption of returned data when using 64k pages
 [PATCH 009 of 16] knfsd: nfsd4: fix corruption on readdir encoding with 64k pages
 [PATCH 010 of 16] knfsd: svcrpc: gss: don't call svc_take_page unnecessarily
 [PATCH 011 of 16] knfsd: svcrpc: WARN() instead of returning an error from svc_take_page
 [PATCH 012 of 16] knfsd: nfsd4: fix laundromat shutdown race
 [PATCH 013 of 16] knfsd: nfsd4: nfsd4_probe_callback cleanup
 [PATCH 014 of 16] knfsd: nfsd4: add missing rpciod_down()
 [PATCH 015 of 16] knfsd: nfsd4: limit number of delegations handed out.
 [PATCH 016 of 16] knfsd: nfsd4: grant delegations more frequently
