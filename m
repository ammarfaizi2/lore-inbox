Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310828AbSCHMoo>; Fri, 8 Mar 2002 07:44:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310836AbSCHMoY>; Fri, 8 Mar 2002 07:44:24 -0500
Received: from swazi.realnet.co.sz ([196.28.7.2]:34788 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S310828AbSCHMoV>; Fri, 8 Mar 2002 07:44:21 -0500
Date: Fri, 8 Mar 2002 14:29:22 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH][2.5] BUG check in elevator.c:237
In-Reply-To: <3C88B049.5030906@evision-ventures.com>
Message-ID: <Pine.LNX.4.44.0203081426060.5383-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Mar 2002, Martin Dalecki wrote:
> > So are you suggesting perhaps that we change the request servicing to 
> > polling? I'm a bit confused as to how this would fit in with 
> 
> At lest we should change the way the transition between intr
> controlled mode and polling is done.

To something like what some other subsystem  drivers do? ie

interrupt triggered
ISR hands off work to a BH

Or is that different from what you had in mind?

> Well if your error is deterministically reproducable, it's
> quite propably I would dare to have a look after it.
> Could you just explain how to trigger it (Unfortunately I have
> already deleted yours mail about this...)

I forwarded the email to you. Its easily reproducible, but i haven't used 
any other CD apart from the FreeBSD 4.4-REL install disk which initially 
triggered it.

Cheers,
	Zwane


