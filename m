Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287436AbSAMBoW>; Sat, 12 Jan 2002 20:44:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287907AbSAMBoM>; Sat, 12 Jan 2002 20:44:12 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:23715 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S287436AbSAMBn4>;
	Sat, 12 Jan 2002 20:43:56 -0500
Date: Sat, 12 Jan 2002 20:43:54 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Erik Andersen <andersen@codepoet.org>
cc: Felix von Leitner <felix-dietlibc@fefe.de>, Greg KH <greg@kroah.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] klibc requirements, round 2
In-Reply-To: <20020112122152.GA24994@codepoet.org>
Message-ID: <Pine.GSO.4.21.0201122038480.24774-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 12 Jan 2002, Erik Andersen wrote:

> On Fri Jan 11, 2002 at 02:31:50PM +0100, Felix von Leitner wrote:
> > > How about responses from the dietlibc and uClibc people on the odds of
> > > them being able to port to the remaining platforms?
> > 
> > I think I can speak for both Erik and myself when I say that we don't
> > hate architectures and because of that don't support them.  If we get a
> > chance (and maybe a little help from someone who knows those platform),
> > we will port our libc to that platform.
> > 
> > Sadly, I don't have the deep pockets to buy myself a hardware lab with a
> > VAX to port my libc to it.  So I (and Erik, too, obviously) would need
> > at least an account on one of those boxes, with gcc, binutils, strace
> > and gdb installed.

There are several VAX emulators with varying degrees of b0rkenness.
At least one of them manages to boot NetBSD...
 
> Fully agreed.  Porting libc (diet or uClibc) is an issue of
> hardware access, access to the instruction set docs for the arch,
> access to a gnu toolchain, and (the biggest issue) an issue of
> time and motivation.
> 
> > In my eyes that is a waste of time, really.
> > But it's your time, so don't let that stand in your way ;)
> 
> I agree here.  dietlibc is GPL.  uClibc is LGPL.  I think they
> both address the problem space pretty well.  Felix and I are
> both willing to accept patches.
> 
> Lets look at it the other way...  Suppose you start making a
> separate klibc.  You skip/eliminate a ton of stuff and next week
> someone complains that it's missing, say, the pivot_root syscall.
> So you add it.  Then the week after, someone complains that you
> are missing varargs.  So you add that too.  Pretty soon, someone
> will complain about how printf feature foo is missing, and they
> just _need_ SuS2 wordexp compatibility, etc, etc.  Trust me when

... at which point you tell them to bugger off.  If they refuse -
man procmailrc.  Problem solved.

