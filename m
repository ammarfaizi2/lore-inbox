Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130175AbQKFFWX>; Mon, 6 Nov 2000 00:22:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130190AbQKFFWE>; Mon, 6 Nov 2000 00:22:04 -0500
Received: from mail.dotcast.com ([63.80.240.20]:43016 "EHLO
	DC-SRVR1.dotcast.com") by vger.kernel.org with ESMTP
	id <S130175AbQKFFVz>; Mon, 6 Nov 2000 00:21:55 -0500
Message-ID: <52C41B218DE28244B071A1B96DD474F628013B@DC-SRVR1.dotcast.com>
From: Marty Fouts <marty@dotcast.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux on IA64 (was RE: non-gcc linux?)
Date: Sun, 5 Nov 2000 21:20:21 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If I understand the SGI compiler's history correctly, it's more than "some
code."  (I would guess that it would be 70-80% of the volume of a compiler,
as Pro64 appears to only share the front end with gcc, the entire backend is
from scratch.) IA64 is architecturally very different than the sort of ISA
that GCC is appropriate for handling, and the problem is structural, and
possibly fundamental.  Pro64, on the other hand, as described on its web
site, and from a quick scan of the code, appears to be derived from a long
line of compilers that were aimed at ISA architectures similar at some level
to IA64.  It has, for example, a completely different IR (Whirl) and code
generation strategy.

I would be very surprised if anyone could make a case acceptable to SGI that
it assign the copyright to that much technology to any third party.
Besides, the whole idea of copyright on substantially derived work and
assigning copyright to ensure defensibility of copyright is an extremely
gray area in copyright law.

Anyway, if your concern is an efficient Linux kernel on UnObtaninum, there
are going to be a lot more interesting opportunities than merely converting
the base kernel so that Pro64 will compile it.  Provided that Intel left in
certain features from HP, UnObtanium is going to want a very different
underlying architecture for the most efficient kernel design.



> -----Original Message-----
> From: Tim Riker [mailto:Tim@Rikers.org]
> Sent: Sunday, November 05, 2000 1:18 PM
> To: Jakub Jelinek
> Cc: Alan Cox; Linux Kernel Mailing List
> Subject: Re: non-gcc linux?
> 
> 
> yes, exactly what my comments stated.
> 
> Jakub Jelinek wrote:
> > 
> > On Sun, Nov 05, 2000 at 01:52:24PM -0700, Tim Riker wrote:
> > > Alan,
> > >
> > > Perhaps I did not explain myself, or perhaps I misunderstand your
> > > comments. I was responding to a comment that we could 
> just copy some of
> > > the optimizations from Pro64 over into gcc.
> > 
> > That's hard to do, because the whole gcc has copyright 
> assigned to FSF,
> > which means that either gcc steering committee would have to make an
> > exception from this for SGI, or SGI would have to be 
> willing to assign some
> > code to FSF.
> > 
> >         Jakub
> 
> -- 
> Tim Riker - http://rikers.org/ - short SIGs! <g>
> All I need to know I could have learned in Kindergarten
> ... if I'd just been paying attention.
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
> 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
