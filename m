Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313563AbSHRKY2>; Sun, 18 Aug 2002 06:24:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313628AbSHRKY1>; Sun, 18 Aug 2002 06:24:27 -0400
Received: from cibs9.sns.it ([192.167.206.29]:6916 "EHLO cibs9.sns.it")
	by vger.kernel.org with ESMTP id <S313563AbSHRKY0>;
	Sun, 18 Aug 2002 06:24:26 -0400
Date: Sun, 18 Aug 2002 12:28:12 +0200 (CEST)
From: venom@sns.it
To: Larry McVoy <lm@bitmover.com>
cc: Ruth Ivimey-Cook <Ruth.Ivimey-Cook@ivimey.org>,
       Matti Aarnio <matti.aarnio@zmailer.org>, Dax Kelson <dax@gurulabs.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Does Solaris really scale this well?
In-Reply-To: <20020817175517.A31128@work.bitmover.com>
Message-ID: <Pine.LNX.4.43.0208181223390.25581-100000@cibs9.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 17 Aug 2002, Larry McVoy wrote:

> Date: Sat, 17 Aug 2002 17:55:17 -0700
> From: Larry McVoy <lm@bitmover.com>
> To: Ruth Ivimey-Cook <Ruth.Ivimey-Cook@ivimey.org>
> Cc: Matti Aarnio <matti.aarnio@zmailer.org>, Dax Kelson <dax@gurulabs.com>,
>      "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
> Subject: Re: Does Solaris really scale this well?
>
> On Sun, Aug 18, 2002 at 12:03:24AM +0100, Ruth Ivimey-Cook wrote:
> > >> "When you take a 99-way UltraSPARC III machine and add a 100th processor,
> > >> you get 94 percent linear scalability. You can't get 94 percent linear
> > >> scalability on your first Intel chip. It's very, very hard to do, and they
> > >> have not done it."
> >
> > I've seen scientific reports of scalability that good in non-shared memory
> > computers (mostly in transputer arrays) where (with a scalable algorithm)
> > unless you got >90% you were doing something wrong.  However, if you insist on
> > sharing main memory, I still don't believe you can get anywhere near that...
> > IMO 30% is doing very well once past the first few CPUs.
>
> Please reconsider your opinion.  Both Sun and SGI scale past 100 CPUs on
> reasonable workloads in shared memory.  Where "reasonable" != easy to do.


And where reasonable != 94%. Seriously, 94% scalability could be on a
8 CPUs 880, but, for example, I have a 64 CPUS domain on a E10k which is
far from 94% scalability (ok, an old E10k with an 83Mhz bus).
For what I saw, maybe SGI Origin 3000 is scaling
a little better with a lot of CPUS, but I also never had an E15000 around
for now...





