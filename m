Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315440AbSGUX4j>; Sun, 21 Jul 2002 19:56:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315449AbSGUX4j>; Sun, 21 Jul 2002 19:56:39 -0400
Received: from mx1.elte.hu ([157.181.1.137]:46536 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S315440AbSGUX4i>;
	Sun, 21 Jul 2002 19:56:38 -0400
Date: Mon, 22 Jul 2002 01:58:33 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Christoph Hellwig <hch@lst.de>, Linus Torvalds <torvalds@transmeta.com>,
       <linux-kernel@vger.kernel.org>, Robert Love <rml@tech9.net>
Subject: Re: [patch] "big IRQ lock" removal, 2.5.27-A9
In-Reply-To: <20020722004728.T26376@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0207220157510.4428-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 22 Jul 2002, Russell King wrote:

> > > Actually its to cover the case where you have a floppy drive, and you've
> > > booted the kernel from a floppy disk, and the kernel doesn't have the
> > > floppy driver built in.  It turns the floppy drive off, cause there's
> > > nothing else to do that.
> > 
> > this should then be done by the floppy boot code?
> 
> Sounds like a better idea to me.  Although I'm not one to try it out. 8)

i've started adding it, just to realize that bootsect.S already turns off 
the floppy motor.

so i think the issue got solved the easy way ;)

	Ingo

