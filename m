Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269628AbTGJWMx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 18:12:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269589AbTGJWMw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 18:12:52 -0400
Received: from air-2.osdl.org ([65.172.181.6]:15756 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269633AbTGJWLm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 18:11:42 -0400
Date: Thu, 10 Jul 2003 15:26:09 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Russell King <rmk@arm.linux.org.uk>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.75
In-Reply-To: <20030710223548.A20214@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0307101512350.4757-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 10 Jul 2003, Russell King wrote:
> 
> Well, only two words from me.  Oh Shit.

Hey, this is already much later than it should have been, so it's not as
if this is a huge surprise.

> The 2.5.70 ARM patch currently looks like this:

We can sort it out later. Obviously, clearly arm-specific patches (ie
stuff in arch/arm and include/asm-arm) I wouldn't mind per se, but I'd
rather hold back on even those just to make the patches and the changlogs
not be mixed up with the "main bugfixes".

We've never had a first stable release that has all architectures
up-to-date, and I'm not planning on changing that for 2.6.x. This is _not_
the time to try to make my tree build on arm (or other architectures
either), considering that my tree hasn't been the main ARM tree for a long 
time.

> Frustrated such an understatement.

To be blunt, which part of "we want to release 2.6.x this year" came as a
surprise to you? I

That means that I'm not willing to hold stuff up any more. Stuff that 
hasn't followed the development tree doesn't magically just "get fixed". 

Also, the only real point of a stable release is for distribution makers.
That pretty much cuts the list of "needs to be supported" down to x86,
ia64, x86-64 and possibly sparc/alpha.

So everything else is a bonus, but can equally well just play catch-up
later. Embedded people tend to want to stay back anyway, which is 
obviously why they don't follow the development tree in the first place. 

			Linus

