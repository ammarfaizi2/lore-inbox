Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261447AbTCGIFQ>; Fri, 7 Mar 2003 03:05:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261443AbTCGIFO>; Fri, 7 Mar 2003 03:05:14 -0500
Received: from mx1.elte.hu ([157.181.1.137]:42134 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S261441AbTCGIFC>;
	Fri, 7 Mar 2003 03:05:02 -0500
Date: Fri, 7 Mar 2003 09:15:18 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Mike Galbraith <efault@gmx.de>
Cc: Andrew Morton <akpm@digeo.com>, Linus Torvalds <torvalds@transmeta.com>,
       <rml@tech9.net>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] "HT scheduler", sched-2.5.63-B3
In-Reply-To: <5.2.0.9.2.20030307085949.00ce8008@pop.gmx.net>
Message-ID: <Pine.LNX.4.44.0303070913370.5173-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 7 Mar 2003, Mike Galbraith wrote:

> I can (could with your earlier patches anyway) eliminate the X stalls by
> setting X junk to SCHED_FIFO.  I don't have ram to plug in, but I'm as
> certain as I can be without actually doing so that it's not ram
> shortage.

okay. Can you eliminate the X stalls with setting X priority to -10 or so
(or SCHED_FIFO - although SCHED_FIFO is much more dangerous). And how does
interactivity under the same load look like with vanilla .64, as compared
to .64+combo? First step is to ensure that the new changes did not
actually hurt interactivity.

	Ingo

