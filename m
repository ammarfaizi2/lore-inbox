Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751118AbWH3IOr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751118AbWH3IOr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 04:14:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751119AbWH3IOr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 04:14:47 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:62169 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S1751118AbWH3IOq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 04:14:46 -0400
Subject: Re: Linux v2.6.18-rc5
From: Kasper Sandberg <lkml@metanurb.dk>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Nathan Scott <nathans@sgi.com>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <9a8748490608281630v26db3164y4f104d13a3b201b6@mail.gmail.com>
References: <Pine.LNX.4.64.0608272122250.27779@g5.osdl.org>
	 <9a8748490608280310q65c1335cr2603b044c340a489@mail.gmail.com>
	 <1156760869.24904.1.camel@localhost>
	 <9a8748490608280335w4474b489u45b3b0b05b7f2f44@mail.gmail.com>
	 <20060829083643.A3150749@wobbly.melbourne.sgi.com>
	 <9a8748490608281630v26db3164y4f104d13a3b201b6@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 30 Aug 2006 10:14:27 +0200
Message-Id: <1156925667.28597.1.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-08-29 at 01:30 +0200, Jesper Juhl wrote:
> On 29/08/06, Nathan Scott <nathans@sgi.com> wrote:
> > On Mon, Aug 28, 2006 at 12:35:00PM +0200, Jesper Juhl wrote:
> > > On 28/08/06, Kasper Sandberg <lkml@metanurb.dk> wrote:
> > > > On Mon, 2006-08-28 at 12:10 +0200, Jesper Juhl wrote:
> > > > > Not really a regression, more like a long standing bug, but XFS has
> > > > > issues in 2.6.18-rc* (and earlier kernels, at least post 2.6.11).
> > > > and you are saying this issue exists in all post .11 kernels?
> >
> > I would be surprised if this is not a day one bug, it probably
> > even affects the IRIX version of XFS.  Our problem is the lack
> > of a test case to find it - my efforts have come to naught so
> > far.  I'm having to cross my fingers that Jesper can extract a
> > bit more information when he's next able to hit it.
> >
> I'm trying my best, but it's difficult. Often I can only run the -rc
> kernel for a few hours on the box that currently shows the problem,
> and that's not enough to hit the fault.
> I've configured a XFS partition on my home workstation and I'm keeping
> that one busy doing various rsync's and running benchmarks etc -
> putting as much different stress on the XFS filesystem as I can. I'm
> also setting up a test box at work to try and duplicate the problem on
> a non-production server. I won't be able to duplicate the setup
> exactly, but it'll be close.

i have nyself tested xfs in -rc5 now, doing rsync over and over, and
been unable to hit any problem, it indeed seems very hard to reproduce.

> 
> > > > > See the thread titled "2.6.18-rc3-git3 - XFS - BUG: unable to handle
> > > > > kernel NULL pointer dereference at virtual address 00000078" for the
> > > > > full story.
> >
> > That, and another story - Jesper hijacked that thread ;) - the
> 
> Sorry ;)
> 
> > inital bug there was found and fixed, and the fix has now been
> > merged.  But (fyi, Kasper) much of that thread is discussing a
> > different bug to this one.
> >
> 
> True. I should have emphasised that.
> 
> 

