Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279612AbRJXWBI>; Wed, 24 Oct 2001 18:01:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279613AbRJXWA7>; Wed, 24 Oct 2001 18:00:59 -0400
Received: from Expansa.sns.it ([192.167.206.189]:2054 "EHLO Expansa.sns.it")
	by vger.kernel.org with ESMTP id <S279612AbRJXWAt>;
	Wed, 24 Oct 2001 18:00:49 -0400
Date: Thu, 25 Oct 2001 00:01:24 +0200 (CEST)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: safemode <safemode@speakeasy.net>
cc: Rik van Riel <riel@conectiva.com.br>, <linux-kernel@vger.kernel.org>
Subject: Re: time tells all about kernel VM's
In-Reply-To: <200110241836.f9OIaa9l002350@Expansa.sns.it>
Message-ID: <Pine.LNX.4.33.0110242357020.3133-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 24 Oct 2001, safemode wrote:

> On Wednesday 24 October 2001 14:05, Luigi Genoni wrote:
> > On Wed, 24 Oct 2001, safemode wrote:
> > > ok.  Reran e2defrag and got the same effect.
> > > This is the vmstat output by the second.  It starts out with my normal
> > > load (but no mp3s playing).  Then i start e2defrag with the same
> > > arguments as before and allow it to run all the way through.  It ends but
> > > i dont close it until near the very end (which is seen by the swap
> > > dropoff.  Then i let my normal load again be displayed a bit.  One thing
> > > i did notice, however, was that the vm handled that quite a lot better
> > > than how it handled it after being up for 5 days even though it created
> > > the 600MB of buffer.
> >
> > If I do remember well e2defrag was working just with ext2 with 1k as block
> > size, and latest version compiled with 2.0.12 kernel, (I made also a patch
> > to compile with 2.0.X kernels after), then ext2 simply evolved and
> > e2defrag did not.  (by the way e2defrag sources are really isstructive to
> > learn how a blockFS works).
>
> e2defrag defaults to 4k blocks.  Version 0.73pjm1   30 Apr 2001
mmm, a new version. The previous one was some year old.
>
> > I used e2defrag since earlier versions, (just with old slow disk, now it
> > is almost useless, and I went to journaled FSes). If I do remember well,
> > the behavoiur you are telling was usual with 2.0 kernels.
> > If the pool is to big, i saw that e2dump shows a lot of inode that left
> > their group (sic!), and also there could be some FS corruption.
> > e2defrag was writter to use buffer cache, and now VM changed in details
> > this behaviour. It could be that what you see is due to those changes?
>
> you say it is the same behavior as 2.0 yet you say that i could be seeing
> this problem due to _changes_ in the vm.  So the comparison to 2.0 doesn't
> really tell us anything since it has nothing to do with what 2.0 was doing.
>

Sorry for bad english, and bad logic.
I said that you could see this behaivour also with 2.0. kernels.
With 2.2 kernels this behaviour disapperared. Now I never tried e2defrag
with 2.4 kernels, since I use reiserFS and JFS now, but my idea
was that probably the different buffer cache management is involved, as it
was with 2.0.

Sorry for bad logic, it is too mutch time that i do not sleep :).

Luigi


