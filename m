Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317853AbSFSLde>; Wed, 19 Jun 2002 07:33:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317854AbSFSLde>; Wed, 19 Jun 2002 07:33:34 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:61704 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S317853AbSFSLdc>; Wed, 19 Jun 2002 07:33:32 -0400
Date: Wed, 19 Jun 2002 07:29:04 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Rusty Russell <rusty@rustcorp.com.au>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Question about sched_yield()
In-Reply-To: <20020619045606.3566a8cc.rusty@rustcorp.com.au>
Message-ID: <Pine.LNX.3.96.1020619072548.1119D-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Jun 2002, Rusty Russell wrote:

> On Mon, 17 Jun 2002 17:46:29 -0700
> David Schwartz <davids@webmaster.com> wrote:
> > "The sched_yield() function shall force the running thread to relinquish the 
> > processor until it again becomes the head of its thread list. It takes no 
> > arguments."
> 
> Notice how incredibly useless this definition is.  It's even defined in terms
> of UP.

I think you parse this differently than I, I see no reference to UP. The
term "the processor" clearly (to me at least) means the processor running
in that thread at the time of the yeild.

The number of processors running in a single thread at any one time is an
integer number in the range zero to one.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

