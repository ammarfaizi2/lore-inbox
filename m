Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262316AbTINHHy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Sep 2003 03:07:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262319AbTINHHx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Sep 2003 03:07:53 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:26635
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id S262316AbTINHHv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Sep 2003 03:07:51 -0400
Date: Sat, 13 Sep 2003 23:50:04 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Erik Andersen <andersen@codepoet.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: freed_symbols [Re: People, not GPL  [was: Re: Driver Model]]
In-Reply-To: <20030914064144.GA20689@codepoet.org>
Message-ID: <Pine.LNX.4.10.10309132339520.16744-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Erik,

When you can answer why binary only modules are allowed to load regardless
of symbol usage, I will answer your question.  Since binary only modules
are allowed to load, this means they are intended to function.  If they
are intended to function, they must use the API for standard operations.

Removing the abilty for standard functionality means one does not want
them to function?  So if the kernel GPL-ONLY wonder blunders are thinking,
why let them load at all?

Clearly there is a "tainting" process?

If one can detect taint, one can reject loading.

If one reads ./include/linux/module.h

It clearly states any license is acceptable.

So when you can explain about "yes you can but not here", I will explain
the simple rules of how copyright and header files are to be used.

Now what does this have to do with a "freed_symbols" project?

Simple, it restores the symbols back to their original state before
everybody had a whining feast.  When they are restored back to original
state then simple usage of the headers compliance to the "unprotectable
interface" is normalized.  Go look up 1991 copyright rulings wrt SEGA.

It is all or nothing but both ways is not allowed, what do you think, we
all live in San Francisco?

Cheers,

Andre Hedrick
LAD Storage Consulting Group

On Sun, 14 Sep 2003, Erik Andersen wrote:

> On Sat Sep 13, 2003 at 10:32:38PM -0700, Andre Hedrick wrote:
> > 
> > Erik,
> > 
> > Explain how a symbol in 2.4 which was EXPORT_SYMBOL is now
> > EXPORT_SYMBOL_GPL in 2.6 ?
> > 
> > When you can explain why the API for functionallity in 2.4 is ripped off
> > like an old lady's purse by a two-bit punk and made nojn-functional in 2.6
> > you may have a point.
> 
> It doesn't matter what the symbol is called.  I personally agree
> with you on this one point -- changing the symbols to use
> EXPORT_SYMBOL_GPL type naming is deeply stupid.  
> 
> I think it is stupid because by implication, it suggests that any
> exported symbols lacking such tags are somehow NOT under the GPL.
> 
> Per the COPYING file included with each and every copy of the
> kernel, Linux is licensed under the GPL.  There are no provisions
> in the linux kernel COPYING statement allowing non-GPL compatible
> binary only closed source kernel modules.
> 
> You are therefore, entitled to abide by the precise terms and
> conditions for copying, distribution and modification for the
> Linux kernel.  This entitles you to change symbol names to
> whatever makes you feel happy.
> 
> But you are also _required_ to abide by the precise terms and
> conditions for copying, distribution and modification for the
> Linux kernel, which stipulates that unless your code is a "user
> [program] that [uses] kernel services by normal system calls", it
> is a derived work and therefore must abide by the terms of the
> GPL.
> 
> Creating and loading such a symbol renaming module is certainly
> something you are entitled to do.  Using that module for
> circumvention of an "effective technological measure" that
> "effectively protects a right of a copyright owner ... in the
> ordinary course of its operation...." could certainly open you to
> legal action here in the USA.  I do not hold copyright on any of
> the symbols in question, but someone does, and if they do not take
> kindly to your circumvention device....
> 
> But the DMCA issues are merely an aside to the fundamental
> problem.  A problem you have avoided in this thread with
> gratuitous ad hominem attacks, with the "but Billy did it
> first" defence, and similar nonsence.
> 
> When you are done making noise, please explain how a closed
> source binary only product that runs within the context of the
> Linux kernel is not a derivitive work, per the very definition
> given in the kernel COPYING file that grants you your limited
> rights for copying, distribution and modification.
> 
>  -Erik
> 
> --
> Erik B. Andersen             http://codepoet-consulting.com/
> --This message was written using 73% post-consumer electrons--
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

