Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264657AbSKDMCx>; Mon, 4 Nov 2002 07:02:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264661AbSKDMCw>; Mon, 4 Nov 2002 07:02:52 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:21256 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S264657AbSKDMCv>; Mon, 4 Nov 2002 07:02:51 -0500
Message-ID: <3DC66385.D521C893@aitel.hist.no>
Date: Mon, 04 Nov 2002 13:09:41 +0100
From: Helge Hafting <helgehaf@aitel.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.5.45 i686)
X-Accept-Language: no, en, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.45-bk1: kernel BUG at drivers/block/ll_rw_blk.c:1949!
References: <3DC3B5AE.E91AF724@aitel.hist.no> <3DC3BD57.DDFCBB9C@digeo.com> <20021102125537.GK807@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> 
> On Sat, Nov 02 2002, Andrew Morton wrote:
> > Helge Hafting wrote:
> > >
> > > I got this during boot. Kernel 2.5.45-bk1,
> > > compiled with gcc 2.95.4, SMP+preempt
> > > The machine has 2 scsi disks and a
> > > tekram controller.
> > >
> > > Helge Hafting
> > >
> > > kernel BUG at drivers/block/ll_rw_blk.c:1949!
> > > invalid operand: 0000
> > > CPU:    1
> > > EIP:    0060:[<c0236c86>]    Not tainted
> > > EFLAGS: 00010246
> > > EIP is at submit_bio+0x16/0xa8
> >
> > RAID0 does that.  Are you using raid?
> 
> raid1 does it too.

I use both raid-1 and raid-0.
Both seems to work when using 2.5.45, but
I got that BUG.

Helge Hafting
