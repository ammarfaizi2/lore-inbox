Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266762AbRGFRMF>; Fri, 6 Jul 2001 13:12:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266760AbRGFRLz>; Fri, 6 Jul 2001 13:11:55 -0400
Received: from smarty.smart.net ([207.176.80.102]:7186 "EHLO smarty.smart.net")
	by vger.kernel.org with ESMTP id <S266758AbRGFRLl>;
	Fri, 6 Jul 2001 13:11:41 -0400
From: Rick Hohensee <humbubba@smarty.smart.net>
Message-Id: <200107061724.NAA14777@smarty.smart.net>
Subject: Re: Why Plan 9 C compilers don't have asm("")
To: linux-kernel@vger.kernel.org
Date: Fri, 6 Jul 2001 13:24:48 -0400 (EDT)
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Cort Dougan writes:
> > I'm talking about _modern_ processors, not processors that dominate
>the
> > modern age.  This isn't x86.
>
>Linus mentioned Alpha specifically.  I don't see how any of the things
>he said were x86-centric in any way shape or form.
>
>All of his examples are entirely accurate on sparc64 for example, and
>to even moreso his Alpha commentary can nearly directly be applied to
>the MIPS.
>
>Calls suck ass, even on modern cpus.  I've seen several hundreds of
>

Modern? How many stacks?
There's a couple of Forth engines out there that pay the usual for a call
and get returns in zero time. Forth code, and Forth engine machine
instructions, have about twice as many calls as Linux code,
proportionately. Therefor, a return on some designs is one bit in every
instruction. Every instruction is "...and maybe do a return in parallel."
Forth engines don't have caches. They have on-chip stacks, or the Novix
has separate busses to the stacks. Both stacks, return and data. 

Forth chips aren't modern in the true-multi-user sense, but if an
individual were to design such a beast they could get several of them,
hundreds maybe, on FPGAs available now. Such things are coming, because a 
Forth chip IS something an individual can design.

Rick Hohensee
		www.clienux.com
