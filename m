Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293140AbSB1RmL>; Thu, 28 Feb 2002 12:42:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293334AbSB1RkG>; Thu, 28 Feb 2002 12:40:06 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:50068 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S293636AbSB1Rin>; Thu, 28 Feb 2002 12:38:43 -0500
Date: Thu, 28 Feb 2002 10:52:11 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: Richard Thrapp <rthrapp@sbcglobal.net>
Cc: Erik Mouw <J.A.K.Mouw@its.tudelft.nl>, Allo! Allo! <lachinois@hotmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Kernel module ethics.
Message-ID: <20020228105211.B4773@vger.timpanogas.org>
In-Reply-To: <F82zxvoEaZWNaBJjvmZ00001183@hotmail.com> <Pine.LNX.3.95.1020227164752.16918A-100000@chaos.analogic.com> <20020228005152.GB8858@arthur.ubicom.tudelft.nl> <1014868787.3565.127.camel@wizard>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1014868787.3565.127.camel@wizard>; from rthrapp@sbcglobal.net on Wed, Feb 27, 2002 at 09:59:46PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have been shutting up of late and just going heads down and 
cranking code and work and staying out of politics, but I feel 
compelled to address this issue with my understanding of IP law 
and our system of equity.  I've had a few off line discussions
with some folks, attorneys, and tech folks on this list, and as 
near as I can tell, all you guys are out in the weeds (me included).
Here's what I discovered in researching the legal basis for 
the GPL and kernel code development.

There is a belief that the GPL can contaminate upward and 
downward any driver or kernel module written that runs on Linux.
This statement, irregardless of what language is in the GPL, is
total bullsh_t, **EXCEPT** in those states who have adopted 
UCITA.   UCITA is an evil body of legislation approved by 
representatives of various state legislatures that in essence 
makes anything written into a software license (like the GPL) 
enforceable and potentially criminal in those states who adopt
UCITA for any use of a particular software program.  By way of 
example, UCITA makes reverse engineering an illegal act if 
the software owner writes into the license that reverse engineering
is not allowed.   UCITA will also give the GPL enormous "teeth"
to actually enforce this up/down contamination of code written 
on the Linux kernel.  

However, UCITA was lobbied for and pushed by Microsoft, Novell, and
the big software companies.  It was supported and promoted to 
interfere with development efforts just like Linux, and to oppress
software freedom, reversse engineering, competittion, etc..  So
UCITA is not the friend of Linux, and long term, it's designed to
strangle us and as Bill Gates likes to state, "cut off our air 
supply" by preventing Linux and other open source efforts which 
pose a competitive threat to the big players from being able to 
replicate features/functionality and keep up.  It's ironic that
this GPL up/down contamination benefits from something that could 
in time kill Linux or make all of us wanted fugitives.

Now to the arguments in favor of balancing the equities.  If someone
pays an engineer to develop code independent of Linux code which 
does not incorporate Linux GPL code, irregardless of any knowledge
which may have been gained from access to Linux, guess what -- they 
own this code, and they also own any "negative knowledge" created 
as a result of this code being written.  Negative knowledge is 
knowing what does not work which results from the trial and error 
process we all go through when we write new code.  Established 
law and precedence based on years of IP litigation has established 
this through numerous lawsuits.  I do not believe a sitting judge would 
rule in favor of the GPL and compell someone to open source code they 
developed independent of Linux, whether it's a kernel module or not,
simply because someone chose to compile and run it as a kernel module.
It comes down to balancing the equities.  If a company invested 
money developing something, it's their property, and those sections
of the GPL I would expect to be held invalid and unenforceable.  

Enter UCITA which provides a statutory basis to require a sitting judge
to rule in favor of the GPL.  Based upon my analysis, upon application
of a compelling interest test, rational basis test, and a balancing test 
(procedures judges employ using logic to determine whether laws such 
as UCITA can stand based on established Federal and Supreme Court 
Opinions), I firmly believe UCITA would fail these tests, and a sitting 
judge would rule against the GPL.  The overall affect of the GPL in such 
a case would be to perform compulsary conversion of IP into open source 
merely by virtue of the fact that someone ran it on Linux in kernel 
mode -- a ridiculous reality.   A legal brief applying these tests
would be lengthy, so I will not post it here (unless someone 
asks me to), but based upon discussions with folks who do 
IP litigation, the outcome would be that this section of the GPL
would be held invalid and unenforceable.

Application of the GPL as described in this post would be equivalent 
to Microsoft writing a license agreement stating that anything that 
runs on Windows entitles them to a non-compete of the technology on 
other platforms, and states a compulsary conversion of ownership to 
them for all apllications written for windows.   

You can write code independent of Linux which does not incoroporate 
Linux code directly and run it in kernel, and despite what the GPL
says, I do not believe anyone would succeed in getting an order 
to compell it being open sourced.  If you incorporate GPL source
code into program by lifting it "whole cloth" from someone else's 
code and it's GPL, then you have to open source it, and I believe 
someone could obtain an order compelling it to be open sourced.

UCITA would provide a statutory basis for enforcement of this provision,
and chaces are good at least one or more lower courts would rubber 
stamp UCITA (particularly in states like California, where the legal 
systems or more statute based), but I believe UCITA and the GPL 
enforcement wold fail on appeal ni the circuit courts or in any 
state which has not adopted UCITA.

Jeff







On Wed, Feb 27, 2002 at 09:59:46PM -0600, Richard Thrapp wrote:
> On Wed, 2002-02-27 at 18:51, Erik Mouw wrote:
> > On Wed, Feb 27, 2002 at 05:23:41PM -0500, Richard B. Johnson wrote:
> > > So, enter the compromise. Make your proprietary stuff in separate file(s)
> > > known only to your company. This keeps them trade secret. Compile them
> > > into a library. Provide that library with your module. The functions
> > > contained within that library should be documented as well as the
> > > calling parameters (a header file). This helps GPL maintainers
> > > determine if your library is broken.
> > 
> > Brilliant, this violates section 2b from the GPLv2. If that's OK with
> > you, see a lawyer first.
> 
> Hasn't it been said (by people in control) that binary only modules are
> okay to link into the kernel, or do I remember incorrectly?  How is this
> different from a binary only module?  Release an open-source component
> under a BSD license, or even a commercial license if you like, along
> with a closed source component.  Link the two together, and finally
> insmod your non-GPL amalgamation into the kernel.
> 
> Anyway, you're not distributing your kernel with your module linked in,
> so you're not distributing a derivative of a GPLed program, so by my
> understanding section 2b doesn't apply.  Comments?
> 
> -- 
> Richard Thrapp
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
