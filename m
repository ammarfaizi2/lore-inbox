Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265967AbSKBMud>; Sat, 2 Nov 2002 07:50:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265963AbSKBMtq>; Sat, 2 Nov 2002 07:49:46 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:46537 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S265958AbSKBMtW>;
	Sat, 2 Nov 2002 07:49:22 -0500
Date: Sat, 2 Nov 2002 13:55:37 +0100
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@digeo.com>
Cc: Helge Hafting <helgehaf@aitel.hist.no>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.45-bk1: kernel BUG at drivers/block/ll_rw_blk.c:1949!
Message-ID: <20021102125537.GK807@suse.de>
References: <3DC3B5AE.E91AF724@aitel.hist.no> <3DC3BD57.DDFCBB9C@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DC3BD57.DDFCBB9C@digeo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 02 2002, Andrew Morton wrote:
> Helge Hafting wrote:
> > 
> > I got this during boot. Kernel 2.5.45-bk1,
> > compiled with gcc 2.95.4, SMP+preempt
> > The machine has 2 scsi disks and a
> > tekram controller.
> > 
> > Helge Hafting
> > 
> > kernel BUG at drivers/block/ll_rw_blk.c:1949!
> > invalid operand: 0000
> > CPU:    1
> > EIP:    0060:[<c0236c86>]    Not tainted
> > EFLAGS: 00010246
> > EIP is at submit_bio+0x16/0xa8
> 
> RAID0 does that.  Are you using raid?

raid1 does it too.

-- 
Jens Axboe

