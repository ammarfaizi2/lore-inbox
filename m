Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1164303AbWLHBNJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1164303AbWLHBNJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 20:13:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1164322AbWLHBNJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 20:13:09 -0500
Received: from mail.suse.de ([195.135.220.2]:58409 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1164303AbWLHBNG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 20:13:06 -0500
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Fri, 8 Dec 2006 12:13:18 +1100
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 000 of 18] knfsd: Introduction - NFSv4 updates and more
Message-ID: <20061208120939.30428.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Following are 18 patches against 2.6.19-rc6-mm2 which are suitable for 2.6.20.

First 16 are from the NFSv4 team at umich (thanks Bruce).  Mostly
fixing minor bugs and tidying-up code.

Last 2 from me.  We haven't been testing against old versions of
nfs-utils and bit-rot has set in.  Some of that (hopefully all) has
been fixed.

 [PATCH 001 of 18] knfsd: nfsd4: remove a dprink from nfsd4_lock
 [PATCH 002 of 18] knfsd: svcrpc: fix gss krb5i memory leak
 [PATCH 003 of 18] knfsd: nfsd4: clarify units of COMPOUND_SLACK_SPACE
 [PATCH 004 of 18] knfsd: nfsd: make exp_rootfh handle exp_parent errors
 [PATCH 005 of 18] knfsd: nfsd: simplify exp_pseudoroot
 [PATCH 006 of 18] knfsd: nfsd4: handling more nfsd_cross_mnt errors in nfsd4 readdir
 [PATCH 007 of 18] knfsd: nfsd: don't drop silently on upcall deferral
 [PATCH 008 of 18] knfsd: svcrpc: remove another silent drop from deferral code
 [PATCH 009 of 18] knfsd: nfsd4: pass saved and current fh together into nfsd4 operations.
 [PATCH 010 of 18] knfsd: nfsd4: remove spurious replay_owner check
 [PATCH 011 of 18] knfsd: nfsd4: move replay_owner to cstate
 [PATCH 012 of 18] knfsd: nfsd4: don't inline nfsd4 compound op functions
 [PATCH 013 of 18] knfsd: nfsd4: make verify and nverify wrappers
 [PATCH 014 of 18] knfsd: nfsd4: reorganize compound ops
 [PATCH 015 of 18] knfsd: nfsd4: simplify migration op check
 [PATCH 016 of 18] knfsd: nfsd4: simplify filehandle check
 [PATCH 017 of 18] knfsd: Don't ignore kstrdup failure in rpc caches.
 [PATCH 018 of 18] knfsd: Fix up some bit-rot in exp_export
