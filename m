Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263023AbTCLIIO>; Wed, 12 Mar 2003 03:08:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263084AbTCLIIO>; Wed, 12 Mar 2003 03:08:14 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:10900 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S263023AbTCLIIN>;
	Wed, 12 Mar 2003 03:08:13 -0500
Date: Wed, 12 Mar 2003 09:18:53 +0100
From: Jens Axboe <axboe@suse.de>
To: scott thomason <scott-kernel@thomasons.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: bio too big device
Message-ID: <20030312081853.GF811@suse.de>
References: <200303112055.31854.scott-kernel@thomasons.org> <200303112117.30926.scott-kernel@thomasons.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200303112117.30926.scott-kernel@thomasons.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 11 2003, scott thomason wrote:
> After a little more digging in drivers/block/ll_rw_blk.c, it 
> seems that Jens might be the best person to discuss the 
> following with.
> 
> Apparently I have a system that is making bio requests of a size 
> that exceeds the max sector size for the device? How is that 
> possible, and more to the point, how can I help get it fixed? 
> 
> Or am I misinterpreting something?

Search the lkml archives, this has been answered before in more detail.
In short, it's a raid bug.

-- 
Jens Axboe

