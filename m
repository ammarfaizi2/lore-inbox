Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750936AbWEPBNQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750936AbWEPBNQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 21:13:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750932AbWEPBNQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 21:13:16 -0400
Received: from mx1.suse.de ([195.135.220.2]:51605 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750928AbWEPBNP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 21:13:15 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Tue, 16 May 2006 11:12:56 +1000
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Reuben Farrelly <reuben-lkml@reub.net>
Subject: [PATCH 000 of 3] md: Introduction - 3 bugfixs for -mm
Message-ID: <20060516111036.2649.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The first of these fixes issues with the new bmap based bitmap file
access code, and possibly should be an -mm hotfix, and without it,
'internal' bitmaps don't work any more :-(

Others are minor and unrelated.

Thanks,
NeilBrown


 [PATCH 001 of 3] md: Change md/bitmap file handling to use bmap to file blocks-fix
 [PATCH 002 of 3] md: Fix inverted test for 'repair' directive.
 [PATCH 003 of 3] md: Calculate correct array size for raid10 in new offset mode.
