Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135707AbRDSUwT>; Thu, 19 Apr 2001 16:52:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135704AbRDSUwL>; Thu, 19 Apr 2001 16:52:11 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:53254 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S135708AbRDSUv6>; Thu, 19 Apr 2001 16:51:58 -0400
Date: Thu, 19 Apr 2001 13:51:42 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
cc: Ulrich Drepper <drepper@cygnus.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: light weight user level semaphores
In-Reply-To: <20010419222228.J682@nightmaster.csn.tu-chemnitz.de>
Message-ID: <Pine.LNX.4.31.0104191351040.1182-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 19 Apr 2001, Ingo Oeser wrote:
>
> Are you sure, you can implement SMP-safe, atomic operations (which you need
> for all up()/down() in user space) WITHOUT using privileged
> instructions on ALL archs Linux supports?

Why do you care?

Sure, there are broken architectures out there. They'd need system calls.
They'd be slow. That's THEIR problem.

No sane architecture has this limitation.

		Linus

