Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267884AbTCFHh0>; Thu, 6 Mar 2003 02:37:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267885AbTCFHh0>; Thu, 6 Mar 2003 02:37:26 -0500
Received: from mx2.elte.hu ([157.181.151.9]:61660 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S267884AbTCFHhZ>;
	Thu, 6 Mar 2003 02:37:25 -0500
Date: Thu, 6 Mar 2003 08:47:38 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@digeo.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, <rml@tech9.net>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [patch] "HT scheduler", sched-2.5.63-B3
In-Reply-To: <20030305234553.715f975e.akpm@digeo.com>
Message-ID: <Pine.LNX.4.44.0303060845510.4248-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 5 Mar 2003, Andrew Morton wrote:

> The current interactivity booster heuristic does appear to work very
> well - I did an A/B comparison with 2.4.x a while back, and 2.5 is
> distinctly better.

> Let me redescribe the problem:
> 
> - Dual 850MHz PIII, 900M of RAM.
> - Start a `make -j3 vmlinux', everything in pagecache
> - Start using X applications.  Moving a window about is the usual trigger.

please do another thing as well: in addition to applying the -A4 patch,
also renice X to -10.

> But last time I tested Ingo's interactivity patch things were a lot
> better.  I shall retest his latest now.

please do.

	Ingo

