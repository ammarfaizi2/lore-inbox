Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312891AbSDYDg1>; Wed, 24 Apr 2002 23:36:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312895AbSDYDg0>; Wed, 24 Apr 2002 23:36:26 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:4108 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S312891AbSDYDgX>; Wed, 24 Apr 2002 23:36:23 -0400
Date: Wed, 24 Apr 2002 23:33:23 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Stephen Samuel <samuel@bcgreen.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: A CD with errors (scratches etc.) blocks the whole system while reading damadged files
In-Reply-To: <3CC738AD.50905@bcgreen.com>
Message-ID: <Pine.LNX.3.96.1020424232237.4586B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Apr 2002, Stephen Samuel wrote:

> I said:
> > where the bulk of Linux system are running. Putting the CD on another
> > cable is realistic (the system I hung does that) but putting the CD on IDE
> > and the disk on SCSI is not cost effective compared to fixing the hang in
> > software.
> 
> Note that this problem is a HARDWARE one -- not a software one.
> It's kinda like trying to cross a Singapore highway... You can
> do it faster, if you don't mind dealing with the nasty side of
> a (data) bus. (read: SPLAT)

I don't know how to say this any other way, reread my second sentence
again. I have the disk and CD on separate cables, it still hangs. I NEVER
mix a CD with anything and expect good response. The IDE devices are
hanging, not just the one sharing the cable, nothing shares the cable but
a ZIP drive I use a few times a year when someone sends me a ZIP,
otherwise it's unused. The disk drive is all by itself, as I said the
first time I mentioned this.

I suspect (without having a good way to check) that all IDE devices
sharing the IRQ with the error device *may* be affected. That's the only
thing which comes to mind, I'll add a Promise controller and disk on a
totally separate board and see if that changes anything. Hopefully it will
not share the IRQ :-(

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

