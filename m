Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266089AbRF2OVM>; Fri, 29 Jun 2001 10:21:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266093AbRF2OVC>; Fri, 29 Jun 2001 10:21:02 -0400
Received: from web13907.mail.yahoo.com ([216.136.175.70]:16911 "HELO
	web13907.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S266089AbRF2OU4>; Fri, 29 Jun 2001 10:20:56 -0400
Message-ID: <20010629142055.49246.qmail@web13907.mail.yahoo.com>
Date: Fri, 29 Jun 2001 07:20:55 -0700 (PDT)
From: szonyi calin <caszonyi@yahoo.com>
Subject: Re: [Re: gcc: internal compiler error: program cc1 got fatal signal 11]
To: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200106291248.HAA02327@tomcat.admin.navo.hpc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
wrote:
> > 
> > 
> > "This is almost always the result of flakiness in
> your hardware - either
> > RAM (most likely), or motherboard (less likely). 
> "
> >                          
> >                               I cannot understand
> this. There are many other
> > stuffs that I compiled with gcc without any
> problem. Again compilation is only
> > a application. It  only parse and gernerates
> object files. How can RAM or
> > motherboard makes different
> 
> It's most likely flackey memory.
> 
> Remember- a single bit that dropps can cause the
> signal 11. It doesn't have
> to happen consistently either. I had the same
> problem until I slowed down
> memory access (that seemd to cover the borderline
> chip).
> 
> The compiler uses different amounts of memory
> depending on the source file,
> number of symbols defined (via include headers).
> When the multiple passes
> occur simultaneously, there is higher memory
> pressure, and more of the
> free space used. One of the pages may flake out.
> Compiling the kernel
> puts more pressure on memory than compiling most
> applications.
> 
>
-------------------------------------------------------------------------
> Jesse I Pollard, II
> Email: pollard@navo.hpc.mil
> 
> Any opinions expressed are solely my own.
> -
> To unsubscribe from this list: send the line
> "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at 
> http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

Almost always ?
It seems like gcc is THE ONLY program which gets
signal 11
Why the X server doesn't get signal 11 ?
Why others programs don't get signal 11 ?

I remember that once Bill Gates was asked about
crashes in windows and he said: It's a hardware
problem.
It was also a joke on that subject:
Winerr xxx: Hardware problem (it's not our fault, it's
not, it's not, it's not, it's not...)


Seems to me like Micro$oft way of handling problems.

We must agree that gcc is full of bugs (xanim does not

run corectly if it is compiled with gcc 2.95.3 
and other programs which use floating point
calculations do the same (spice 3f5))

Some time ago I installed Linux (Redhat 6.0) on my 
pc (Cx486 8M RAM) and gcc had a lot of signal 11 (a
couple every hour) I was upgrading
the kernel every time there was a new kernel and
from 2.2.12(or 14) no more signal 11 (very rare)
Is this still a hardware problem ?
Was a bug in kernel ?

I think the last answer is more obvious.(or the gcc
had a bug and the kernel -- a workaround).

Sorry for bothering you but in every piece of linux
documentation signal 11 seems to be __identic__ with
hardware problem.
Bye

__________________________________________________
Do You Yahoo!?
Get personalized email addresses from Yahoo! Mail
http://personal.mail.yahoo.com/
