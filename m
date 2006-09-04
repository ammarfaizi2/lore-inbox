Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932235AbWIDXP3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932235AbWIDXP3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 19:15:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932238AbWIDXP3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 19:15:29 -0400
Received: from ns2.suse.de ([195.135.220.15]:34221 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932235AbWIDXP2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 19:15:28 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Tue, 5 Sep 2006 09:15:21 +1000
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 000 of 9] knfsd: minor gss/v4 cleanups and major ACL surgery.
Message-ID: <20060905090617.21303.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Following are 9 patches for nfsd from Bruce Fields.  First 5 are minor
cleanups around gss code and elsewhere.  Last 4 make substantial
changes to ACL handling, particularly for mapping between Posix draft
ACLs and NFSv4 ACLs.

Thanks,
NeilBrown


 [PATCH 001 of 9] knfsd: svcrpc: gss: factor out some common wrapping code
 [PATCH 002 of 9] knfsd: svcrpc: gss: fix failure on SVC_DENIED in integrity case
 [PATCH 003 of 9] knfsd: svcrpc: use consistent variable name for the reply state
 [PATCH 004 of 9] knfsd: nfsd4: refactor exp_pseudoroot
 [PATCH 005 of 9] knfsd: nfsd4: clean up exp_pseudoroot
 [PATCH 006 of 9] knfsd: nfsd4: acls: relax the nfsv4->posix mapping
 [PATCH 007 of 9] knfsd: nfsd4: acls: fix inheritance
 [PATCH 008 of 9] knfsd: nfsd4: acls: simplify nfs4_acl_nfsv4_to_posix interface
 [PATCH 009 of 9] knfsd: nfsd4: acls: fix handling of zero-length acls
