Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293074AbSB1Wuo>; Thu, 28 Feb 2002 17:50:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310192AbSB1Wsg>; Thu, 28 Feb 2002 17:48:36 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:61458 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S310182AbSB1Wqy>; Thu, 28 Feb 2002 17:46:54 -0500
Date: Thu, 28 Feb 2002 17:45:24 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Christoph Hellwig <hch@caldera.de>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.19-preX: What we really need: -AA patches finally in the tree
In-Reply-To: <20020226175322.A31217@caldera.de>
Message-ID: <Pine.LNX.3.96.1020228174142.2006I-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Feb 2002, Christoph Hellwig wrote:

> They shouldn't,  But many old drivers do (and _had to_):
> 
> 	current->policy = SCHED_YIELD;
> 	schedule();
> 
> which isn't possible with the new scheduler.

Let's see, the choices are to (a) keep the old scheduler which has many
performance issues, or (b) put in the new scheduler and let people who
need the old drivers either fix them or stop upgrading.

Bad performance should go the way of a.out kernels and xiafs (which at
least did have utility), not be justified as a way to force people to
patch their kernel.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

