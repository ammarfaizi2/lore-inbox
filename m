Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262314AbTINGlx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Sep 2003 02:41:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262316AbTINGlx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Sep 2003 02:41:53 -0400
Received: from codepoet.org ([166.70.99.138]:40109 "EHLO mail.codepoet.org")
	by vger.kernel.org with ESMTP id S262314AbTINGlv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Sep 2003 02:41:51 -0400
Date: Sun, 14 Sep 2003 00:41:45 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Andre Hedrick <andre@linux-ide.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: freed_symbols [Re: People, not GPL  [was: Re: Driver Model]]
Message-ID: <20030914064144.GA20689@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Andre Hedrick <andre@linux-ide.org>, linux-kernel@vger.kernel.org
References: <20030914053902.GA20198@codepoet.org> <Pine.LNX.4.10.10309132225330.16744-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10309132225330.16744-100000@master.linux-ide.org>
X-Operating-System: Linux 2.4.19-rmk7, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat Sep 13, 2003 at 10:32:38PM -0700, Andre Hedrick wrote:
> 
> Erik,
> 
> Explain how a symbol in 2.4 which was EXPORT_SYMBOL is now
> EXPORT_SYMBOL_GPL in 2.6 ?
> 
> When you can explain why the API for functionallity in 2.4 is ripped off
> like an old lady's purse by a two-bit punk and made nojn-functional in 2.6
> you may have a point.

It doesn't matter what the symbol is called.  I personally agree
with you on this one point -- changing the symbols to use
EXPORT_SYMBOL_GPL type naming is deeply stupid.  

I think it is stupid because by implication, it suggests that any
exported symbols lacking such tags are somehow NOT under the GPL.

Per the COPYING file included with each and every copy of the
kernel, Linux is licensed under the GPL.  There are no provisions
in the linux kernel COPYING statement allowing non-GPL compatible
binary only closed source kernel modules.

You are therefore, entitled to abide by the precise terms and
conditions for copying, distribution and modification for the
Linux kernel.  This entitles you to change symbol names to
whatever makes you feel happy.

But you are also _required_ to abide by the precise terms and
conditions for copying, distribution and modification for the
Linux kernel, which stipulates that unless your code is a "user
[program] that [uses] kernel services by normal system calls", it
is a derived work and therefore must abide by the terms of the
GPL.

Creating and loading such a symbol renaming module is certainly
something you are entitled to do.  Using that module for
circumvention of an "effective technological measure" that
"effectively protects a right of a copyright owner ... in the
ordinary course of its operation...." could certainly open you to
legal action here in the USA.  I do not hold copyright on any of
the symbols in question, but someone does, and if they do not take
kindly to your circumvention device....

But the DMCA issues are merely an aside to the fundamental
problem.  A problem you have avoided in this thread with
gratuitous ad hominem attacks, with the "but Billy did it
first" defence, and similar nonsence.

When you are done making noise, please explain how a closed
source binary only product that runs within the context of the
Linux kernel is not a derivitive work, per the very definition
given in the kernel COPYING file that grants you your limited
rights for copying, distribution and modification.

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
