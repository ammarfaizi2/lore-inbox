Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265192AbSJRT2u>; Fri, 18 Oct 2002 15:28:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265200AbSJRT2u>; Fri, 18 Oct 2002 15:28:50 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:63238 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S265192AbSJRT2t>; Fri, 18 Oct 2002 15:28:49 -0400
Date: Fri, 18 Oct 2002 15:34:26 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Shawn <core@enodev.com>
cc: Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.5.43
In-Reply-To: <20021016163515.C2874@q.mn.rr.com>
Message-ID: <Pine.LNX.3.96.1021018152918.23760A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Oct 2002, Shawn wrote:

> On 10/16, Bill Davidsen said something like:

> > I hope you haven't broken running WITH ide-scsi, because most people still
> > run 2.4 kernels in real life and only test 2.5 because someone has to do
> > it. Reconfiguring the system to use ide-scsi or not is just one more PITA
> > thing which needs to be done, or more likely forgotten, with every new
> > kernel.
> 
> Honestly, I think it's ok to bust the old stuff if needed. This is
> simply my opinion from a user standpoint.
> 
> It's really just one kernel argument or /etc/modules.conf modification
> to fix the old setup, asnd likely, if you set it up in the first place,
> you can un-set it up.

And change every script from dev=b,d,l to dev=/dev/cdN. Without hitting
the actual SCSI CD's, and of course the scd0 (ATAPI on ide-scsi) goes away
so you have to rename all of your real SCSI CD's.

On a simple system with one ATAPI CD the problem is small, but on a larger
and busier system with a fair number of CD-RW drives, it is likely to be a
real pain, and if you forget to convert back you mess up production stuff.

It's not impossible, just something I would rather not do unless the
system is going permanently to 2.6, maybe not even then, since what I have
works fine.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

