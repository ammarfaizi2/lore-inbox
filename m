Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318418AbSGaRph>; Wed, 31 Jul 2002 13:45:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318419AbSGaRph>; Wed, 31 Jul 2002 13:45:37 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:1550 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S318418AbSGaRpg>; Wed, 31 Jul 2002 13:45:36 -0400
Date: Wed, 31 Jul 2002 13:43:15 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Guillaume Boissiere <boissiere@adiglobal.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6] The List, pass #2
In-Reply-To: <3D3761A9.23960.8EB1A2@localhost>
Message-ID: <Pine.LNX.3.96.1020731133038.10066A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Jul 2002, Guillaume Boissiere wrote:

> I've reorganized the list into 5 categories based on the feedback 
> I received.  Now let's see what happens  :-)

Much better format.

> ----------------------------------------------------
> "The pressure is on! (TM)":
> (either gets merged before feature freeze or has to wait till 2.7)
> 
>   o Rewrite of the console layer                    
>   o XFS (A journaling filesystem from SGI)

Is this something which has not been forward ported from 2.4 to 2.5? Or is
there a serious problem which hasn't bitten me?

> ----------------------------------------------------
> Would be nice to have before feature freeze, but most likely 2.7:
> 
>   o Full compliance with IPv6

Hopefully the core parts of this could make 2.5, allowing final
corrections later.

>   o Add support for NFS v4

Sorry to repeat, this seems to be a feature which will be in many if not
most other systems before any possible release date for 2.8. Is it really
that far out? (that's a status request, not a statement)

> 
> ----------------------------------------------------
> Definitely 2.7:
> 
> o InfiniBand support
> o Add thrashing control
> o Remove all hardwired drivers from kernel

I really hope this means drivers MAY be used as modules, not MUST. There
is some overhead in doing things as modules, and added complexity usually
means "harder to debug." Particularly with modules where there can be
corner conditions and races on [un]load.

Again, thanks for the status!

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

