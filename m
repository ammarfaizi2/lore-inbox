Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265639AbSKAG3M>; Fri, 1 Nov 2002 01:29:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265641AbSKAG3M>; Fri, 1 Nov 2002 01:29:12 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:50449 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S265639AbSKAG3L>; Fri, 1 Nov 2002 01:29:11 -0500
Date: Fri, 1 Nov 2002 01:34:51 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Chris Friesen <cfriesen@nortelnetworks.com>,
       "Matt D. Robinson" <yakker@aparity.com>,
       Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org,
       lkcd-general@lists.sourceforge.net, lkcd-devel@lists.sourceforge.net
Subject: Re: What's left over.
In-Reply-To: <Pine.LNX.4.44.0210311015380.1410-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.3.96.1021101012947.23822C-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Oct 2002, Linus Torvalds wrote:

> 
> On Thu, 31 Oct 2002, Chris Friesen wrote:
> > 
> > How do you deal with netdump when your network driver is what caused the 
> > crash?
> 
> Actually, from a driver perspective, _the_ most likely driver to crash is 
> the disk driver. 
> 
> That's from years of experience. The network drivers are a lot simpler,
> the hardware is simpler and more standardized, and doesn't do as many
> things. It's just plain _easier_ to write a network driver than a disk
> driver.
> 
> Ask anybody who has done both.

  From the standpoint of just the driver that's true. However, the remote
machine and all the network bits between them are a string of single
points of failure. Isn't it good that both disk and network can be
supported.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

