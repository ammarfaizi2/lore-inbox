Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750783AbWB0BdV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750783AbWB0BdV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 20:33:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750785AbWB0BdV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 20:33:21 -0500
Received: from ns2.suse.de ([195.135.220.15]:27822 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750783AbWB0BdU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 20:33:20 -0500
From: NeilBrown <neilb@suse.de>
To: linux-kernel@vger.kernel.org, fs-devel@vger.kernel.org
Date: Mon, 27 Feb 2006 12:32:35 +1100
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Subject: [PATCH 000 of 2] Introduction - make some address_space_operations return void
Message-ID: <20060227122948.24317.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While reading through the address_space_operations code, I discoverred
that two methods return 'int' values that are never used: invalidatepage and
sync_page.
Accordingly, the following two patches convert them to return 'void'.

Any comments?

NeilBrown


 [PATCH 001 of 2] Make address_space_operations->invalidatepage return void
 [PATCH 002 of 2] Make address_space_operations->sync_page return void.
