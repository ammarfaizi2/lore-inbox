Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261416AbTCGHZ7>; Fri, 7 Mar 2003 02:25:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261418AbTCGHZ7>; Fri, 7 Mar 2003 02:25:59 -0500
Received: from mx2.elte.hu ([157.181.151.9]:64139 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S261413AbTCGHZ6>;
	Fri, 7 Mar 2003 02:25:58 -0500
Date: Fri, 7 Mar 2003 08:36:12 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Aaron Lehmann <aaronl@vitelus.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, Andrew Morton <akpm@digeo.com>,
       Robert Love <rml@tech9.net>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] "HT scheduler", sched-2.5.63-B3
In-Reply-To: <20030307070005.GB21885@vitelus.com>
Message-ID: <Pine.LNX.4.44.0303070832430.4401-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 6 Mar 2003, Aaron Lehmann wrote:

> > okay, could you please test BK-curr, or 2.5.64+combo-patch? Do the skips
> > still persist? Did they get worse perhaps? I guess it might take a few
> > days of music listening while doing normal desktop activity, to get a good
> > feel of it though.
> 
> I was able to reproduce them by selecting text in Mathematica (ugh, not
> a very helpful example). The skips were shorter and about three times as
> hard to trigger as on 2.5.63.

okay, just as a data point, could you try to renice the player
process/thread to -2? Does it make the skipping harder to trigger?
How about -5, or -10?

	Ingo

