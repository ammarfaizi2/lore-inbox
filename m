Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261620AbTCGOdD>; Fri, 7 Mar 2003 09:33:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261621AbTCGOdD>; Fri, 7 Mar 2003 09:33:03 -0500
Received: from mx1.elte.hu ([157.181.1.137]:49089 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S261620AbTCGOdC>;
	Fri, 7 Mar 2003 09:33:02 -0500
Date: Fri, 7 Mar 2003 15:43:18 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Mike Galbraith <efault@gmx.de>
Cc: Andrew Morton <akpm@digeo.com>, Linus Torvalds <torvalds@transmeta.com>,
       Robert Love <rml@tech9.net>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] "interactivity changes", sched-2.5.64-B2
In-Reply-To: <5.2.0.9.2.20030307142155.00c90050@pop.gmx.net>
Message-ID: <Pine.LNX.4.44.0303071541300.12493-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 7 Mar 2003, Mike Galbraith wrote:

> >Spiffy :)  /Me thinks desktop users will like this patch a bunch.
> 
> (I can even play asteroids [fly little rocket ship around, shoot at and
> ram space rocks] with make -j25 bzImage and some swapping [sucks when
> you hit heavy swap of course, but quite playable as long as swap is
> light])

cool! Could you please also play a bit with various WAKER_BONUS_RATIO
values? If the default '0' value is the best-performing variant then i'll
nuke it from the patch altogether.

	Ingo


