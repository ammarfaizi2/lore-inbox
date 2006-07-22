Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750870AbWGVQ1Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750870AbWGVQ1Y (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jul 2006 12:27:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750871AbWGVQ1Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jul 2006 12:27:24 -0400
Received: from ns2.g-housing.de ([81.169.133.75]:1170 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S1750865AbWGVQ1Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jul 2006 12:27:24 -0400
Date: Sat, 22 Jul 2006 17:27:24 +0100 (BST)
From: Christian Kujau <evil@g-house.de>
X-X-Sender: evil@prinz64.housecafe.de
To: Nathan Scott <nathans@sgi.com>
cc: Torsten Landschoff <torsten@debian.org>, linux-kernel@vger.kernel.org,
       xfs@oss.sgi.com
Subject: Re: XFS breakage in 2.6.18-rc1
In-Reply-To: <20060719085731.C1935136@wobbly.melbourne.sgi.com>
Message-ID: <Pine.LNX.4.64.0607221722500.8407@prinz64.housecafe.de>
References: <20060718222941.GA3801@stargate.galaxy>
 <20060719085731.C1935136@wobbly.melbourne.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

On Wed, 19 Jul 2006, Nathan Scott wrote:
> 2.6.18-rc1 should be fine (contains the corruption fix).  Did you
> mkfs and restore?  Or at least get a full repair run?  If you did,
> and you still see issues in .18-rc1, please let me know asap.

well, at least for me, corruption/errors *started* with 2.6.18-rc1:

http://oss.sgi.com/archives/xfs/2006-07/msg00151.html

I downgraded to 2.6.17.5 and the errors stopped. Now I've upgraded to 
2.6.18-rc2 and see the same errors:

xfs_da_do_buf: bno 16777216
dir: inode 24472381
Filesystem "md0": XFS internal error xfs_da_do_buf(1) at line 1992 of file fs/xfs/xfs_da_btree.c.  Caller 0xc0219230
Filesystem "md0": XFS internal error xfs_trans_cancel at line 1138 of file fs/xfs/xfs_trans.c.  Caller 0xc024d717

Please see the whole error/.config/logs here:

http://nerdbynature.de/bits/2.6.18-rc2/

Thanks,
Christian.
-- 
BOFH excuse #38:

secretary plugged hairdryer into UPS
