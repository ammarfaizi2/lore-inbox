Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932279AbWCLXyV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932279AbWCLXyV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 18:54:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932262AbWCLXyV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 18:54:21 -0500
Received: from cantor.suse.de ([195.135.220.2]:40327 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932204AbWCLXyV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 18:54:21 -0500
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Mon, 13 Mar 2006 10:53:11 +1100
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 000 of 4] Introduction: VFS documentation and tidy up
Message-ID: <20060313104910.15881.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following 4 patches improve the documentation for vfs address_space
operations, and clean up some code oddities I found while writing it.

All have been sent the these lists before for review and only one
comment was received: a positive note about the documentation.

Please target them for 2.6.17.

Thanks,
NeilBrown


 [PATCH 001 of 4] Update some VFS documentation.
 [PATCH 002 of 4] Honour AOP_TRUNCATE_PAGE returns in page_symlink
 [PATCH 003 of 4] Make address_space_operations->sync_page return void.
 [PATCH 004 of 4] Make address_space_operations->invalidatepage return void
