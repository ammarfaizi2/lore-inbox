Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261436AbTCGHfV>; Fri, 7 Mar 2003 02:35:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261438AbTCGHfV>; Fri, 7 Mar 2003 02:35:21 -0500
Received: from mx2.elte.hu ([157.181.151.9]:56460 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S261436AbTCGHfU>;
	Fri, 7 Mar 2003 02:35:20 -0500
Date: Fri, 7 Mar 2003 08:45:35 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Mike Galbraith <efault@gmx.de>
Cc: Andrew Morton <akpm@digeo.com>, Linus Torvalds <torvalds@transmeta.com>,
       <rml@tech9.net>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] "HT scheduler", sched-2.5.63-B3
In-Reply-To: <5.2.0.9.2.20030307075851.00cf5448@pop.gmx.net>
Message-ID: <Pine.LNX.4.44.0303070842420.4572-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 7 Mar 2003, Mike Galbraith wrote:

> Weeeeell, FWIW my box (p3-500/128mb/rage128) disagrees.

UP box, right?

> I can still barely control the box when a make -j5 bzImage is running
> under X/KDE in one terminal and a vmstat (SCHED_RR) in another. I'm not
> swapping, though a bit of idle junk does page out.  IOW, I think I'm
> seeing serious cpu starvation.

which precise scheduler are you using, BK-curr? And to see whether the
problem is related to scheduling at all, could you try to renice X to -10?
[this is not a solution, this is just a test to see the problem is
scheduling related.]

is there any way we could exclude/isolate the VM as the source of
interactivity problems? Eg. any chance to get more RAM into that box?

	Ingo

