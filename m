Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318918AbSHMDRv>; Mon, 12 Aug 2002 23:17:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318919AbSHMDRv>; Mon, 12 Aug 2002 23:17:51 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:21765 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S318918AbSHMDRv>; Mon, 12 Aug 2002 23:17:51 -0400
Date: Mon, 12 Aug 2002 23:15:24 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Helge Hafting <helgehaf@aitel.hist.no>
cc: Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: large page patch (fwd) (fwd)
In-Reply-To: <3D577EA6.204E670D@aitel.hist.no>
Message-ID: <Pine.LNX.3.96.1020812230127.7583D-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Aug 2002, Helge Hafting wrote:

> Rik van Riel wrote:
> 
> > One problem we're running into here is that there are absolutely
> > no tools to measure some of the things rmap is supposed to fix,
> > like page replacement.
> > 
> There are things like running vmstat while running tests or production.
> 
> My office desktop machine (256M RAM) rarely swaps more than 10M
> during work with 2.5.30.  It used to go some 70M into swap
> after a few days of writing, browsing, and those updatedb runs.  

Now tell us how someone who isn't a VM developer can tell if that's bad or
good. Is it good because it didn't swap more than it needed to, or bad
because there were more things it could have swapped to make more buffer
room? 

Serious question, tuning the -aa VM sometimes makes the swap use higher,
even as the response to starting small jobs while doing kernel compiles or
mkisofs gets better. I don't normally tune -ac kernels much, so I can't
comment there.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

