Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262879AbSJTPT1>; Sun, 20 Oct 2002 11:19:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262913AbSJTPT0>; Sun, 20 Oct 2002 11:19:26 -0400
Received: from franka.aracnet.com ([216.99.193.44]:13211 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S262879AbSJTPTZ>; Sun, 20 Oct 2002 11:19:25 -0400
Date: Sun, 20 Oct 2002 08:22:38 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: "Martin J. Bligh" <mbligh@aracnet.com>
To: Adrian Bunk <bunk@fs.tum.de>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Bug tracking in the run up from 2.5 to 2.6
Message-ID: <2490726024.1035102157@[10.10.2.3]>
In-Reply-To: <Pine.NEB.4.44.0210191415390.28761-100000@mimas.fachschaften.tu-muenchen.de>
References: <Pine.NEB.4.44.0210191415390.28761-100000@mimas.fachschaften.tu-muenchen.de>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 1. Related projects
> 
> 1a Some time ago Dave Jones did something similar [1] and currently
>    Thomas Molina maintains a bug tracking page [2]. These were/are both
>    projects where one person did/does collect bug reports from
>    linux-kernel by hand but roughly spoken it's the same thing you want to
>    start (modulo the additional manpower you can provide). You should
>    at least ask them for their experiences and use Thomas' collection
>    as input for your bug tracking system.

I talked to Thomas already, hadn't seen Davej's list, thanks for that.
I guess the main difference with an full bug tracking system rather
than a web page or text email is that it's easier to distribute the
workload around. I think this is too much for any one person to maintain,
hence the problem with these things getting out of date.

> 1b The Trivial Patch Monkey [3] by Rusty Russell is not very related
>    but it would be good if there was enough communication that it's noted
>    in the bug tracking system whenever a bug is already fixed by a patch
>    submitted to the Trivial Patch Monkey.

Right, some sort of linkage would be needed with both this and the
main Linus tree for checkins - I think the latter is actually a more
major concern ... bugs should be closed when they're (confirmed) fixed
in the mail tree.

> 2. What is the suggested workflow?
> 
>    Let's say I want to report a "xyz doesn't compile in 2.5.44" bug.
> 
>    Currently I'm sending it to the people that seem to be responsible
>    (looking at MAINTAINERS and the contents of the file that doesn't
>    compile) with a Cc to linux-kernel.
> 
>    With a Web-based bug tracking system like Bugzilla it's additional work
>    to add a bug to the bug tracking system, too, and to keep the
>    information that is there updated (e.g. if the maintainer sends a patch
>    a few hours later).
> 
>    What is the suggested workflow to avoid additional work?

Systems like this will normally involve a little additional overhead,
but I think the payback is worthwhile. Bugzilla has email triggers, 
so it would be easy to set up bugs filed against any particular
category to be automatically emailed to the maintainer(s) for that 
category. The bug could then be sanity checked, and sent to lkml.
Or something like that ;-)

M.
