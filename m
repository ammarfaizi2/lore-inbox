Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261393AbTCGGkn>; Fri, 7 Mar 2003 01:40:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261394AbTCGGkn>; Fri, 7 Mar 2003 01:40:43 -0500
Received: from mx1.elte.hu ([157.181.1.137]:17294 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S261393AbTCGGkm>;
	Fri, 7 Mar 2003 01:40:42 -0500
Date: Fri, 7 Mar 2003 07:50:59 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Aaron Lehmann <aaronl@vitelus.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, Andrew Morton <akpm@digeo.com>,
       Robert Love <rml@tech9.net>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] "HT scheduler", sched-2.5.63-B3
In-Reply-To: <20030307064552.GA21885@vitelus.com>
Message-ID: <Pine.LNX.4.44.0303070748460.3794-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 6 Mar 2003, Aaron Lehmann wrote:

> > But it was definitely there. 3-5 second _pauses_. Not slowdowns.
> 
> I can second this. Using Linux 2.5.5x, untarring a file while
> compiling could cause X to freeze for several seconds at a time.
> I haven't seen this problem recently, [...]

i believe this is rather due to IO scheduling / VM throttling. Andrew 
added some nice improvements lately, so this should really not happen with 
2.5.64 kernels.

> [...] though I do experience my share of XMMS skips.

okay, could you please test BK-curr, or 2.5.64+combo-patch? Do the skips
still persist? Did they get worse perhaps? I guess it might take a few
days of music listening while doing normal desktop activity, to get a good
feel of it though.

	Ingo

