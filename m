Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278177AbRJLWQK>; Fri, 12 Oct 2001 18:16:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278178AbRJLWQA>; Fri, 12 Oct 2001 18:16:00 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:27744 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S278177AbRJLWPp>; Fri, 12 Oct 2001 18:15:45 -0400
Date: Sat, 13 Oct 2001 00:15:53 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Duncan Sands <duncan.sands@math.u-psud.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: xine pauses with recent (not -ac) kernels
Message-ID: <20011013001553.F714@athlon.random>
In-Reply-To: <01101208552800.00838@baldrick> <20011012161052.R714@athlon.random> <01101300085600.00832@baldrick>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01101300085600.00832@baldrick>; from duncan.sands@math.u-psud.fr on Sat, Oct 13, 2001 at 12:08:56AM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 13, 2001 at 12:08:56AM +0200, Duncan Sands wrote:
> On Friday 12 October 2001  4:10 pm, Andrea Arcangeli wrote:
> > On Fri, Oct 12, 2001 at 08:55:28AM +0200, Duncan Sands wrote:
> > > Subject: xine pauses with recent (not -ac) kernels
> > >
> > > Problem: using xine to view an (encrypted) DVD, xine is slow to move
> > > on to the second .vob file: at the end of the first file, it at best
> > > waits a few seconds with a black screen and consuming no CPU, before
> > > moving on to the second file, but sometimes it waits for a long time.
> > >
> > > Correct behaviour: the second .vob file starts playing at once.
> > >
> > > I think this is a kernel problem because it did not occur up to
> > > 2.4.9.  The problem appeared between 2.4.10-pre10 and 2.4.10-pre13.
> > > It is present in 2.4.12.  It doesn't seem to occur in any -ac kernels.
> > >
> > > linux-2.4.9 : correct
> > > ...
> > > linux-2.4.10-pre10 : correct
> > > linux-2.4.10-pre11 : fails to compile
> > > linux-2.4.10-pre12 : oops during system init
> > > linux-2.4.10-pre13 : problem present
> > > ...
> > > linux-2.4.12 : problem present
> > >
> > > If I replay the DVD several times, the length of the pause varies, and
> > > sometimes it does not occur at all.
> > >
> > > Any ideas?
> >
> > can you reproduce also on 2.4.12aa1?
> >
> > 	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.12
> >aa1.bz2
> >
> > Andrea
> 
> Yes, it seems to have the same problem.  It even seems a bit worse
> (just my impression, I didn't do any statistics).

can you send me a `vmstat 1` during the skips?

are you swapping or making use of applications that uses MAP_SHARED?

Andrea
