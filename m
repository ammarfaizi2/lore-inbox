Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317498AbSGRJ0I>; Thu, 18 Jul 2002 05:26:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317522AbSGRJ0I>; Thu, 18 Jul 2002 05:26:08 -0400
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:17927 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S317498AbSGRJ0H>; Thu, 18 Jul 2002 05:26:07 -0400
Date: Thu, 18 Jul 2002 11:29:04 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Ext3 vs Reiserfs benchmarks
Message-ID: <20020718092904.GB4763@merlin.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20020716124956.GK7955@tahoe.alcove-fr> <Pine.LNX.4.44.0207161107550.17919-100000@innerfire.net> <20020716153926.GR7955@tahoe.alcove-fr> <20020716194542.GD22053@merlin.emma.line.org> <20020716150422.A6254@q.mn.rr.com> <20020716161158.A461@shookay.newview.com> <20020716152231.B6254@q.mn.rr.com> <20020717114501.GB28284@merlin.emma.line.org> <20020717190259.GA31503@clusterfs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020717190259.GA31503@clusterfs.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Jul 2002, Andreas Dilger wrote:

> On Jul 17, 2002  13:45 +0200, Matthias Andree wrote:
> > On Tue, 16 Jul 2002, Shawn wrote:
> > > In this case, can you use a RAID mirror or something, then break it?
> > > 
> > > Also, there's the LVM snapshot at the block layer someone already
> > > mentioned, which when used with smaller partions is less overhead.
> > > (less FS delta)
> > 
> > All these "solutions" don't work out, I cannot remount R/O my partition,
> > and LVM low-level snapshots or breaking a RAID mirror simply won't work
> > out. I would have to remount r/o the partition to get a consistent image
> > in the first place, so the first step must fail already...
> 
> Have you been reading my emails at all?  LVM snapshots DO ensure that
> the snapshot filesystem is consistent for journaled filesystems.

Please apologize, I have been busy and only reading partial threads, and had
not come across your LVM-snapshot related mails when I wrote the
previous mail.

-- 
Matthias Andree
