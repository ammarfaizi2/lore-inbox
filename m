Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261759AbUKUCnI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261759AbUKUCnI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 21:43:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261754AbUKUCnH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 21:43:07 -0500
Received: from shinjuku.zaphods.net ([194.97.108.52]:20962 "EHLO
	shinjuku.zaphods.net") by vger.kernel.org with ESMTP
	id S261759AbUKUCmh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 21:42:37 -0500
Date: Sun, 21 Nov 2004 03:42:26 +0100
From: Stefan Schmidt <zaphodb@zaphods.net>
To: Lukas Hejtmanek <xhejtman@mail.muni.cz>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Nick Piggin <piggin@cyberone.com.au>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.6.9 Multiple Page Allocation Failures
Message-ID: <20041121024226.GK4999@zaphods.net>
References: <20041109224423.GC18366@mail.muni.cz> <20041109203348.GD8414@logos.cnet> <20041110212818.GC25410@mail.muni.cz> <20041110181148.GA12867@logos.cnet> <20041111214435.GB29112@mail.muni.cz> <4194A7F9.5080503@cyberone.com.au> <20041113144743.GL20754@zaphods.net> <20041116093311.GD11482@logos.cnet> <20041116170527.GA3525@mail.muni.cz> <20041121014350.GJ4999@zaphods.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041121014350.GJ4999@zaphods.net>
User-Agent: Mutt/1.5.6+20040907i
X-SA-Exim-Connect-IP: 194.97.1.3
X-SA-Exim-Mail-From: zaphodb@boombox.zaphods.net
X-SA-Exim-Scanned: No (on shinjuku.zaphods.net); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 21, 2004 at 02:43:50AM +0100, Stefan Schmidt wrote:
> > It seems that both Stefan and me are using XFS. Does someone have this problems
> > with another filesystem? Unfortunately I cannot change fs. Can you Stefen?
> Yes, i'll switch to EXT2 now. We'll see. Needs about 1d to fill up again and
> i think if there is no filesystem corruption after say 5d i'll blame xfs. ;)
Err, later...
After aborting badblocks on the first disks xfs partition (ctrl-c) and then
running "mkfs.ext2 -v -T largefile4 -O dir_index,sparse_super -m 0" i got a 
"Kernel panic - not syncing: Attempting to free lock on active lock list"
via serial. Still on 2.6.10-rc1-bk23-watermark. I will provide you with a
screenshot monday morning if there is any.
I just updated the debian/unstable i386 installation so it should be debian
version 1.35-8 of the e2fsprogs package.

*sigh*,
	Stefan
