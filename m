Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271182AbRIGFUh>; Fri, 7 Sep 2001 01:20:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271186AbRIGFU2>; Fri, 7 Sep 2001 01:20:28 -0400
Received: from maynard.mail.mindspring.net ([207.69.200.243]:36386 "EHLO
	maynard.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S271182AbRIGFUR>; Fri, 7 Sep 2001 01:20:17 -0400
Subject: Re: Linux Preemptive patch success 2.4.10-pre4 + lots of other
	patches
From: Robert Love <rml@tech9.net>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Christoph Lameter <christoph@lameter.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20010907051231Z16200-26183+114@humbolt.nl.linux.org>
In-Reply-To: <Pine.LNX.4.33.0109062135280.1643-100000@devel.office>
	<999837964.865.3.camel@phantasy> 
	<20010907051231Z16200-26183+114@humbolt.nl.linux.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.13.99+cvs.2001.09.05.07.08 (Preview Release)
Date: 07 Sep 2001 01:20:40 -0400
Message-Id: <999840042.1164.14.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2001-09-07 at 01:19, Daniel Phillips wrote:
> On September 7, 2001 06:45 am, Robert Love wrote:
> > On Fri, 2001-09-07 at 00:36, Christoph Lameter wrote:
> > > Given the minimal nature of the patch I would suggest that it become part
> > > of 2.4.10 or 11
> > 
> > Are you kidding?  We will be lucky to see this in during 2.5.
> > Its a pretty big change.  It makes the Linux kernel preemptible.
> 
> CONFIG_PREEMPT

and... ?

> > This is a fairly big move, one I don't think any of the major Unices have
> > done.
> 
> The other Unices are at least evenly split, or mostly preemptible.
> Typically, a more complex strategy is used where spinlocks can sleep
> after a few spins.  This patch is very conservative in that regard,
> it basically just uses the structure we already have, SMP spinlocks.

I did not know other Unices were (in general) preemptible.  Solaris is?
The only one I thought was preemptible was Irix.

Anyhow, you are right about the simplistic approach we take.  There are
a few alternatives: mixing mutexes and shorter locks, priority-bearing
semaphores, changing the way the preemption count works, etc.

> > The only reason the patch is not _huge_ is because the Linux
> > kernel is already setup for concurrency of this nature -- it does SMP.
> > 
> > I suggest you read
> > http://www.linuxdevices.com/articles/AT4185744181.html
> > http://www.linuxdevices.com/articles/AT5152980814.html
> > http://kpreempt.sourceforge.net
> > 
> > and my previous threads on this issue, for more informaiton.
> 
> Hmm, how did you read those and come to such a different conclusion?

What different conclusion? What are you even arguing with me about? 

Do you think I am against a preemptible kernel?  I _posted_ the damn
patch, of course I am not.

I probably agree with whatever you are thinking.

-- 
Robert M. Love
rml at ufl.edu
rml at tech9.net

