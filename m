Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271206AbRHOPBG>; Wed, 15 Aug 2001 11:01:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271216AbRHOPAz>; Wed, 15 Aug 2001 11:00:55 -0400
Received: from as2-1-8.va.g.bonet.se ([194.236.117.122]:16912 "EHLO
	boris.prodako.se") by vger.kernel.org with ESMTP id <S271206AbRHOPAo>;
	Wed, 15 Aug 2001 11:00:44 -0400
Date: Wed, 15 Aug 2001 17:00:11 +0200 (CEST)
From: Tobias Ringstrom <tori@ringstrom.mine.nu>
X-X-Sender: <tori@boris.prodako.se>
To: Szabolcs Szakacsits <szaka@f-secure.com>
cc: Alexander Viro <viro@math.psu.edu>, "Magnus Naeslund(f)" <mag@fbab.net>,
        Linus Torvalds <torvalds@transmeta.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.8 Resource leaks + limits
In-Reply-To: <Pine.LNX.4.30.0108151427400.2660-100000@fs131-224.f-secure.com>
Message-ID: <Pine.LNX.4.33.0108151658510.23743-100000@boris.prodako.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Aug 2001, Szabolcs Szakacsits wrote:

> On Wed, 15 Aug 2001, Alexander Viro wrote:
> > > The more serious part of my little alloc adventure is much more dangerous:
> > > Whattaheck happened to my resources?
> > > I _still_ can't log in to that box as a luser (root works).
> > May be memory fragmentation. You need an order 1 allocation for fork(), just
> > to allocate task_struct...
>
> No, 2.4.8 seems to like to soft lockup in cases after it used up all
> swap. I also run some trivial memory stressing tests on a UP, 128 MB,

This may be related to another thread.  See the mail "Re: kswapd using all
cpu for long periods in 2.4.9-pre4" posted by Linus a couple of hours ago.

/Tobias

