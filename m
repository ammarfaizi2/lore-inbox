Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317603AbSGFEXZ>; Sat, 6 Jul 2002 00:23:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317604AbSGFEXY>; Sat, 6 Jul 2002 00:23:24 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:4370 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S317603AbSGFEXY>; Sat, 6 Jul 2002 00:23:24 -0400
Date: Sat, 6 Jul 2002 00:15:47 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Adrian Bunk <bunk@fs.tum.de>
cc: Jochen Suckfuell <jo-lkml@suckfuell.net>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Disk IO statistics still buggy
In-Reply-To: <Pine.NEB.4.44.0207042030350.14934-100000@mimas.fachschaften.tu-muenchen.de>
Message-ID: <Pine.LNX.3.96.1020706000838.12039A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Jul 2002, Adrian Bunk wrote:

> On Thu, 4 Jul 2002, Jochen Suckfuell wrote:
> 
> > Hi!
> 
> Hi Jochen!
> 
> > The IO statistics displayed in /proc/partitions are still buggy, because
> > after some time, the value for the currently running requests gets too
> > high or too low (see the archives, look for "/proc/partitions").
> >
> > Is anyone working on a fix?
> >...
> Marcelos' BK repository (that will become 2.4.19-rc2) includes a patch to
> remove these statistics completely from /proc/partitions...

Is this the new Linux way of life? Removing modules is hard, GET RID OF
THE FEATURE! Stats in /proc/partitions are not always correct, GET RID OF
THE FEATURE!

The IDE support in 2.5 sucks rocks off the bottom of the ocean, is that
next?

To the point, the stats are there, there are used by many of the widely
used distributions, this is supposed to be stable, that's the excuse for
not adding features, how can that justify taking out a feature? That's one
of the useful things for determining which (if any) partitions have enough
traffic to be best candidates for a separate drive. Yes I know there are
other more complex ways than looking at human readable numbers. Why is
that desirable? Why not fix the feature (I don't agree it's all that far
off in most cases).

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

