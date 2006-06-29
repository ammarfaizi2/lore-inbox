Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750800AbWF2MuT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750800AbWF2MuT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 08:50:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750817AbWF2MuT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 08:50:19 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:40131 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1750800AbWF2MuR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 08:50:17 -0400
Date: Thu, 29 Jun 2006 08:49:04 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Russell King <rmk+lkml@arm.linux.org.uk>
cc: Esben Nielsen <nielsen.esben@googlemail.com>,
       Milan Svoboda <msvoboda@ra.rockwell.com>,
       LKML <linux-kernel@vger.kernel.org>,
       Deepak Saxena <dsaxena@plexity.net>, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [BUG] Linux-2.6.17-rt3 on arm ixdp465
In-Reply-To: <20060629122541.GB9709@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.58.0606290846170.28104@gandalf.stny.rr.com>
References: <OF92240490.78BE8F01-ONC125719C.0037A4FD-C125719C.00389E07@ra.rockwell.com>
 <Pine.LNX.4.64.0606291334540.10401@localhost.localdomain>
 <Pine.LNX.4.58.0606290803190.25935@gandalf.stny.rr.com>
 <20060629122541.GB9709@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Russell,

Thanks for replying!


On Thu, 29 Jun 2006, Russell King wrote:

> On Thu, Jun 29, 2006 at 08:09:24AM -0400, Steven Rostedt wrote:
> >
> > Well, the following patch may not be the best but I don't see it being any
> > worse than what is already there.  I don't have any arm platforms or even
> > an arm compiler, so I haven't even tested this patch with a compile.  But
> > it should be at least a temporary fix.
>
> Guys, look at what's in the latest -git from Linus.
>

Yep, this looks like a non issue when 2.6.18(-rcX?) comes out, and Ingo
updates his -rt patch against it.

I did say what I had wasn't the best and only a temporary fix.  But I
guess it can still work as a temporary solution until 2.6.18-rt1, where
we will have the fixes from Linus's tree.

Now maybe a copy of the arch/arm/common/dmabounce.c from git to Ingo's -rt
patch will work out of the box too. But I don't know what other changes
are dependent on that.

Thanks,

-- Steve


