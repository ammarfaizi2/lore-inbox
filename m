Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133056AbREHSEt>; Tue, 8 May 2001 14:04:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133040AbREHSEk>; Tue, 8 May 2001 14:04:40 -0400
Received: from eagle.verisign.com ([208.206.241.105]:46742 "EHLO
	eagle.verisign.com") by vger.kernel.org with ESMTP
	id <S133029AbREHSEg>; Tue, 8 May 2001 14:04:36 -0400
From: slurn@verisign.com
Message-Id: <200105081804.LAA06108@slurndal-lnx.verisign.com>
Subject: Re: kdb wishlist
To: quintela@mandrakesoft.com (Juan Quintela)
Date: Tue, 8 May 2001 11:04:29 -0700 (PDT)
Cc: slurn@verisign.com, george@mvista.com (george anzinger),
        kaos@melbourne.sgi.com (Keith Owens), kdb@oss.sgi.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <m2itjbspvl.fsf@trasno.mitica> from "Juan Quintela" at May 08, 2001 07:38:06 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> >>>>> "slurn" == slurn  <slurn@verisign.com> writes:
> 
> >> 
> >> Keith Owens wrote:
> >> > 
> >> > This is part of my kdb wishlist, does anybody fancy writing the code to
> >> > add any of these features?  It would be a nice project for anybody
> >> > wanting to start on the kernel.  Replies to kdb@oss.sgi.com please.
> >> > Current patches at http://oss.sgi.com/projects/kdb/download/
> >> > 
> >> > * Change kdb invocation key from ^A to ^X^X^X within 3 seconds.  ^A is
> >> >   used by emacs, bash, minicom etc.
> >> > 
> >> ^X^X swaps point and mark in emacs.  One (well, I) often will do
> >> ^X^X^X^X to examine where mark is and then return to point.
> 
> slurn> How about using the break condition instead.  This is only for the
> slurn> serial port, and most terminal emulators (e.g. kermit, minicom) provide
> slurn> a means to generate a break condition on the serial port. 
> 
> kdb uses BREAK in the serial port (that minicom uses C-a for sending a
> break is an anecdote :)  But the problem at hang is the console.  I
> vote for the ^X^X^X as I a think that it is not a difficult shortcut.
> (and yes, I also use emacs and ^X^X all the time, but I think that
> this combination is not specially bad, and I suppose that the pet
> aplication of other people will have problems with something like:
> ^A^A^A that I never use). 
> 
> Later, Juan.

Unless something has changed, the console uses the 'pause' 
key and the serial port uses ^A (for x86, anyway).

I may be out of date, however.

scott

