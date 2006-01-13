Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161639AbWAMDOh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161639AbWAMDOh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 22:14:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161643AbWAMDOh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 22:14:37 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:17324 "EHLO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S1161639AbWAMDOg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 22:14:36 -0500
From: NeilBrown <neilb@cse.unsw.edu.au>
To: Andrew Morton <akpm@osdl.org>
Date: Fri, 13 Jan 2006 14:14:27 +1100
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH kNFSd 000 of 3] Introduction
Message-ID: <20060113141059.4573.patches@notabene>
X-CSE-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on 
	note.orchestra.cse.unsw.EDU.AU
X-CSE-Spam-Level: 
X-CSE-Spam-Status: No, score=-4.5 required=5.0 tests=ALL_TRUSTED,BAYES_00 
	autolearn=ham version=3.0.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Three more assorted nfsd patches.
The last is somewhat embarassing... a previous patch completely left out the
nfsv2 section.  This didn't cause compile errors, but completely broke
NFSv2 service... and it was in -mm for at least a month with noone noticing.

 [PATCH kNFSd 001 of 3] semaphore to mutex conversion.
 [PATCH kNFSd 002 of 3] Fix some more errno/nfserr confusion in vfs.c
 [PATCH kNFSd 003 of 3] Provide missing NFSv2 part of patch for checking vfs_getattr.
