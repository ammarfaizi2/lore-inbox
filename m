Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313020AbSC0OYG>; Wed, 27 Mar 2002 09:24:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313021AbSC0OX4>; Wed, 27 Mar 2002 09:23:56 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:33039 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S313020AbSC0OXo>; Wed, 27 Mar 2002 09:23:44 -0500
Date: Wed, 27 Mar 2002 09:21:38 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Emmanuel Michon <emmanuel_michon@realmagic.fr>
cc: linux-kernel@vger.kernel.org
Subject: Re: SMP motherboards (760 MPX chipset) and SMP howto
In-Reply-To: <7wsn6mx6up.fsf@frog.soft.sdesigns.com>
Message-ID: <Pine.LNX.3.96.1020327090603.12827A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 27 Mar 2002, Emmanuel Michon wrote:

> I'm sorry to write here for a problem only about SMP: there used to be
> a linux-smp mailing list but it seems it's not active anymore.

  I, too, am (was?) a member of that list. I believe it has died because
SMP is mainline now, instead of cutting edge. Discussion is probably
appropriate here more than anywhere else.
 
> It seems AMD Athlon SMP spec is compatible with Intel's one; can
> someone report that the A7M266-D motherboard with the 760 MPX chipset
> is running fine linux SMP?

  There is at least one significant difference between MP and MPX
chipsets, or at least there appears to be one from board specs. Both seem
to work if you can get part the BIOS, but one is faster, or cheaper, or
supports more memory. I did an eval of boards the other day and noted that
there was an issue, but the paperwork is not here.
 
> People reported that this combo works properly even with two Athlon XP's
> instead of MP's: how do you force this motherboard into SMP mode?

  You put two CPUs in it (duh). Note that not all XP processors are SMP
enabled, you need to do hardware hacking on the new ones, which is fine if
you like hacking but hardly worth risking a chip just to save a few bucks.
 
> I'm also looking for a ``howto'' explaining where non-SMP-aware module
> code will most probably crash a SMP box, it seems there is no such
> thing.

  A non-SMP module can crash an SMP kernel at any time, the where and how
seem irrelevant. Why would you do that?
 
> SMP gurus must have a discussion room more specific than linux-kernel
> mailing list at some hidden place!

AFAIK, not. Don't really see the need. Let us know if you find a list with
useful content, however.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

