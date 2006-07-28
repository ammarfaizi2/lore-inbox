Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932581AbWG1FKb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932581AbWG1FKb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 01:10:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932582AbWG1FKb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 01:10:31 -0400
Received: from ns2.suse.de ([195.135.220.15]:46032 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932581AbWG1FK3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 01:10:29 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Fri, 28 Jul 2006 15:09:40 +1000
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: "J. Bruce Fields" <bfields@fieldses.org>
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 000 of 4] knfsd: Introduction
Message-ID: <20060728150606.29533.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Following are 4 patches for knfsd in 2.6-mm-latest.  They address some
issues found by Bruce Fields greatly appreciated patch review.  Thanks Bruce.
They (like the patches they build on) are *not* 2.6.18 material.

NeilBrown


 [PATCH 001 of 4] knfsd: Drop 'serv' option to svc_recv and svc_process
 [PATCH 002 of 4] knfsd: Check return value of lockd_up in write_ports
 [PATCH 003 of 4] knfsd: Move makesock failed warning into make_socks.
 [PATCH 004 of 4] knfsd: Correctly handle error condition from lockd_up
