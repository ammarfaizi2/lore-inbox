Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266185AbUHIGok@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266185AbUHIGok (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 02:44:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266189AbUHIGok
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 02:44:40 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:29328 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S266185AbUHIGnt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 02:43:49 -0400
Date: Mon, 9 Aug 2004 08:43:22 +0200
From: Jens Axboe <axboe@suse.de>
To: bil@beeb.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: problems with Mandrake 10.0 + kernel 2.6.8-rc2
Message-ID: <20040809064321.GF10418@suse.de>
References: <200408061409.56670.bil@beeb.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408061409.56670.bil@beeb.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 06 2004, bil@beeb.net wrote:
> Hi,
> I've recently moved to Mandrake 10.0 (prompted by a defunct hard disk
> which neccesitated a complete re-install) and have had several problems.
> As a result I have upgraded my kernel from 2.6.3 to 2.6.7 and then 2.6.8-rc2.
> Unfortunately the fire may be hotter than the frying-pan (Old English
> Proverb) and I'm now in a state where I can't mount CDroms. I can
> read the raw device OK, so the basic driver (ide-cd) is OK, or at least
> it seems to be. I've added traces to isofs.ko and established that this
> initialises OK, but when I attempt to mount the driver it gets a return
> code of -EINVAL when it tries to read the superblock (get_sb_bdev?()).
> 
> I'm pretty sure that this must be something set up wrong somewhere as
> it's unlikely that 2.6.7 (or 2.6.8) would be released without someone
> somewhere needing to mount a cdrom, but I have no idea where to go from
> here. I am not a kernel-hacker, though I did some many moons ago, but
> I know enough to patch and rebuild modules and test them. I took a look at
> the source code of ide-cd.c but can't make much sense of the way things are
> done these days, and have too many other things to do....
> Can anyone give me advice (or even better a fix)?

First step in bug reporting is including a step-by-step way to reproduce
(ie what you do when it fails). Also please include a dmesg -s100000
from a booted system, and your .config from 2.6.7.

-- 
Jens Axboe

