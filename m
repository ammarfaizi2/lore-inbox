Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270411AbTGSR6F (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jul 2003 13:58:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270423AbTGSR6F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jul 2003 13:58:05 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:24024 "EHLO
	smtp.bitmover.com") by vger.kernel.org with ESMTP id S270411AbTGSR6B
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jul 2003 13:58:01 -0400
Date: Sat, 19 Jul 2003 11:12:49 -0700
From: Larry McVoy <lm@bitmover.com>
To: Ga?l Le Mignot <kilobug@freesurf.fr>
Cc: Larry McVoy <lm@bitmover.com>,
       Christian Reichert <c.reichert@resolution.de>,
       John Bradford <john@grabjohn.com>, lkml@lrsehosting.com,
       linux-kernel@vger.kernel.org, rms@gnu.org, Valdis.Kletnieks@vt.edu
Subject: Re: [OT] HURD vs Linux/HURD
Message-ID: <20030719181249.GA24197@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Ga?l Le Mignot <kilobug@freesurf.fr>, Larry McVoy <lm@bitmover.com>,
	Christian Reichert <c.reichert@resolution.de>,
	John Bradford <john@grabjohn.com>, lkml@lrsehosting.com,
	linux-kernel@vger.kernel.org, rms@gnu.org, Valdis.Kletnieks@vt.edu
References: <200307191503.h6JF3tac002376@81-2-122-30.bradfords.org.uk> <1058626962.30424.6.camel@stargate> <plopm3lluu8mv0.fsf@drizzt.kilobug.org> <20030719172311.GA23246@work.bitmover.com> <plopm3he5i8l4h.fsf@drizzt.kilobug.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <plopm3he5i8l4h.fsf@drizzt.kilobug.org>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=0,
	required 7)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 19, 2003 at 07:46:54PM +0200, Ga?l Le Mignot wrote:
> Hello Larry!
> 
> Sat, 19 Jul 2003 10:23:11 -0700, you wrote: 
> 
>  >> - GNU/Hurd, the  whole systems, is  actually GNU tools  (libc, linker,
>  >> ...)  on top  of the  GNU Hurd  (set of  servers) and  the  GNU Mach
>  >> microkernel.
> 
>  > Mach wasn't written by GNU, it's a BSD based kernel
> 
> Totally wrong. You're confusing the  Mach operating system (with UX, a
> BSD-server on top of the  Mach micro-kernel) and the Mach micro-kernel
> itself.

The microkernel part of any reasonable microkernel is tiny.  The QNX 
microkernel used to fit in a 4K instruction cache.  To say that the
microkernel is the operating system is ludicrous, that's like say
this series of 5 instructions which happen to get run a lot are the
whole program.

Without the BSD part, you had no operating system, no devices, no nothing.
What you had was a mechanism which can context switch, something that 
every first year OS student has written (or should have).

I stand behind the statement and I've read all the Mach papers, all
the Mach code, and lectured on it at little places like Stanford
University.  I'm pretty sure I know what I'm talking about.

> > pried apart into chunks by people at CMU.
> 
> GNU Mach is  a modified version of OSF Mach  which is modified version
> of CMU Mach.

Whatever.  That's your label.  Personally, I despise this business of
taking someone else's code and renaming it.  It's not GNU code, the
GNU people didn't write it.

>  > Drivers and networking account for about 50% of the total lines of code.
>  > The bulk of the work in any operating system is typically drivers.  The
>  > generic part of Linux (non-driver, non-file system) is tiny compared to 
>  > the rest.
> 
> Maybe  for  you,  an  OS  is  drivers.  For  me,  it's  a  design,  an
> architecture, a  philosophy, and a way  to defend a value  that is not
> important for you: Freedom.

I've got a shelf of OS texts, probably close to 90% of all the OS texts
written and I don't recall any of them teaching that you should take other
people's code, rename it, and claim it as your own in the name of freedom.

>  > If the Hurd gets its drivers from Linux then it should rightfully be called
>  > Linux/HURD (or Linux/HURD/GNU).
> 
> Stop trolling, thank you.

Hey, you want to spout nonsense then be prepared to be challenged.  I'm
just responding to something that is obviously incorrect, that's not
trolling, that's setting the record straight.  I think it was Dave Miller
who told me the other night that an unchallenged incorrect statement 
becomes true by default and I agree.
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
