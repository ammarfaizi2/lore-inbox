Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287908AbSAUTZY>; Mon, 21 Jan 2002 14:25:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287933AbSAUTZP>; Mon, 21 Jan 2002 14:25:15 -0500
Received: from coffee.Psychology.McMaster.CA ([130.113.218.59]:47297 "EHLO
	coffee.psychology.mcmaster.ca") by vger.kernel.org with ESMTP
	id <S287908AbSAUTZC>; Mon, 21 Jan 2002 14:25:02 -0500
Date: Mon, 21 Jan 2002 14:26:12 -0500 (EST)
From: Mark Hahn <hahn@physics.mcmaster.ca>
X-X-Sender: <hahn@coffee.psychology.mcmaster.ca>
To: <linux-kernel@vger.kernel.org>
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
In-Reply-To: <E16SgwP-0001iN-00@starship.berlin>
Message-ID: <Pine.LNX.4.33.0201211418050.17139-100000@coffee.psychology.mcmaster.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > To me the benefit is clear enough: ASAP scheduling of IO threads, a 
> > > simple heuristic that improves both throughput and latency.
> > 
> > I think of "benefit", perhaps naiively, in terms of something that can
> > be measured or demonstrated rather than just announced.
> 
> But you see why asap scheduling improves latency/throughput *in theory*, 
> don't you?  

NO, IT DOES NOT. why can't you preempt-ophiles get that through your heads? 

	eager scheduling is NOT optimal in general.  

for instance, suppose my disk can only read a sector at a time.
scheduling my sequentially-reading process to wake eagerly
is most definitly PESSIMAL.  laziness is a cardinal virtue!
this doesn't preclude heuristics to sometimes short-cut the laziness.

