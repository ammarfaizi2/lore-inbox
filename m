Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261541AbSKRGox>; Mon, 18 Nov 2002 01:44:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261550AbSKRGox>; Mon, 18 Nov 2002 01:44:53 -0500
Received: from c3p0.cc.swin.edu.au ([136.186.1.10]:59652 "EHLO
	net.cc.swin.edu.au") by vger.kernel.org with ESMTP
	id <S261541AbSKRGox>; Mon, 18 Nov 2002 01:44:53 -0500
From: Tim Connors <tconnors@astro.swin.edu.au>
To: linux-kernel@vger.kernel.org, Mike Galbraith <efault@gmx.de>
Subject: Re: 2.5.47 scheduler problems?
In-Reply-To: <5.1.1.6.2.20021118070215.00cb8f98@wen-online.de>
References: <5.1.1.6.2.20021118070215.00cb8f98@wen-online.de>
X-Face: "/6m>=uJ8[yh+S{nuW'%UG"H-:QZ$'XRk^sOJ/XE{d/7^|mGK<-"*e>]JDh/b[aqj)MSsV`X1*pA~Uk8C:el[*2TT]O/eVz!(BQ8fp9aZ&RM=Ym&8@.dGBW}KDT]MtT"<e(`rn*-w$3tF&:%]KHf"{~`X*i]=gqAi,ScRRkbv&U;7Aw4WvC
X-Face-Author: David Bonde mailto:i97_bed@i.kth.se.REMOVE.THIS.TO.REPLY -- If you want to use it please also use this Authorline.
Message-ID: <slrn-0.9.7.4-16621-21084-200211181750-j.$random.luser@swin.edu.au>
Date: Mon, 18 Nov 2002 17:51:51 +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In linux.kernel, you wrote:
> Greetings,
> 
> For testing swap throughput, I like to run make -j30 bzImage on my 500Mhz 
> PIII w. 128Mb ram.  For testing interactivity, I fire up KDE, start a 
> smaller make -j, grab a window, and wave it around.
> 
> With 2.4.20rc2+rc1aa1, running a -j10 build (not swapping) is very very 
> bad.  However, if I set all tasks in the system to SCHED_FIFO or SCHED_RR 
> prior to this light make -j, I have a ~pretty smooth system.
> 
> If I do the same in 2.5.47, I have no control of my box.  Setting all tasks 
> to SCHED_FIFO or SCHED_RR prior to starting make -j10 bzImage, I can regain 
> control, but interactivity under load is basically not present.

Funny that.

> I used to be able to wave a window poorly at make -j25 (swapping heftily), 
> fairly smoothly at make -j20, and smoothly at make -j15 or below.  This 
> with no SCHED_RR/SCHED_FIFO.  (I haven't done much testing like this in 
> quite a while though)

Perhaps you should consider buying an extra 29 CPU's for you desktop?

-- 
TimC -- http://astronomy.swin.edu.au/staff/tconnors/

A Chemist who falls in acid is absorbed in work.

