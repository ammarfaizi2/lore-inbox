Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278695AbRJXSgF>; Wed, 24 Oct 2001 14:36:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278699AbRJXSfz>; Wed, 24 Oct 2001 14:35:55 -0400
Received: from mail6.speakeasy.net ([216.254.0.206]:29701 "EHLO
	mail6.speakeasy.net") by vger.kernel.org with ESMTP
	id <S278695AbRJXSfp>; Wed, 24 Oct 2001 14:35:45 -0400
Content-Type: text/plain; charset=US-ASCII
From: safemode <safemode@speakeasy.net>
To: Luigi Genoni <kernel@Expansa.sns.it>
Subject: Re: time tells all about kernel VM's
Date: Wed, 24 Oct 2001 14:36:19 -0400
X-Mailer: KMail [version 1.3.2]
Cc: Rik van Riel <riel@conectiva.com.br>, <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0110241957170.1991-100000@Expansa.sns.it>
In-Reply-To: <Pine.LNX.4.33.0110241957170.1991-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011024183547Z278695-17408+4448@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 24 October 2001 14:05, Luigi Genoni wrote:
> On Wed, 24 Oct 2001, safemode wrote:
> > ok.  Reran e2defrag and got the same effect.
> > This is the vmstat output by the second.  It starts out with my normal
> > load (but no mp3s playing).  Then i start e2defrag with the same
> > arguments as before and allow it to run all the way through.  It ends but
> > i dont close it until near the very end (which is seen by the swap
> > dropoff.  Then i let my normal load again be displayed a bit.  One thing
> > i did notice, however, was that the vm handled that quite a lot better
> > than how it handled it after being up for 5 days even though it created
> > the 600MB of buffer.
>
> If I do remember well e2defrag was working just with ext2 with 1k as block
> size, and latest version compiled with 2.0.12 kernel, (I made also a patch
> to compile with 2.0.X kernels after), then ext2 simply evolved and
> e2defrag did not.  (by the way e2defrag sources are really isstructive to
> learn how a blockFS works).

e2defrag defaults to 4k blocks.  Version 0.73pjm1   30 Apr 2001

> I used e2defrag since earlier versions, (just with old slow disk, now it
> is almost useless, and I went to journaled FSes). If I do remember well,
> the behavoiur you are telling was usual with 2.0 kernels.
> If the pool is to big, i saw that e2dump shows a lot of inode that left
> their group (sic!), and also there could be some FS corruption.
> e2defrag was writter to use buffer cache, and now VM changed in details
> this behaviour. It could be that what you see is due to those changes?

you say it is the same behavior as 2.0 yet you say that i could be seeing 
this problem due to _changes_ in the vm.  So the comparison to 2.0 doesn't 
really tell us anything since it has nothing to do with what 2.0 was doing.  

