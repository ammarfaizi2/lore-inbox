Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318918AbSH1Tk5>; Wed, 28 Aug 2002 15:40:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318929AbSH1Tk5>; Wed, 28 Aug 2002 15:40:57 -0400
Received: from mail2.uklinux.net ([80.84.72.32]:58515 "EHLO mail2.uklinux.net")
	by vger.kernel.org with ESMTP id <S318918AbSH1Tk4>;
	Wed, 28 Aug 2002 15:40:56 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.5.32] CPU frequency and voltage scaling (0/4)
References: <20020828134600.A19189@brodo.de>
	<Pine.LNX.4.33.0208281140030.4507-100000@penguin.transmeta.com>
	<20020828124839.F5492@host110.fsmlabs.com>
	<1030562708.7190.59.camel@irongate.swansea.linux.org.uk>
From: Peter Riocreux <peter.riocreux@cakes.org.uk>
Date: 28 Aug 2002 20:41:03 +0100
In-Reply-To: <1030562708.7190.59.camel@irongate.swansea.linux.org.uk>
Message-ID: <9ksn0yn54g.fsf@homer.cakes.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> On Wed, 2002-08-28 at 19:48, Cort Dougan wrote:
> > It's even worse for some of the very new P4's that don't have their
> > heatsink seated properly.  They heat up every few minutes and then throttle
> > themselves due to thermal overload.  I think this situation is going to
> > become more and more common, now.  We're at the mercy of every BIOS and
> 
> Systems designers are designing on the basis of thermal slowdowns being
> the optimal way to build some systems. Its actually quite reasonable for
> many workloads.

Don't forget the low end of the scale too...

An interface of this type even has applicability in the absence of a
clock. Research in the Amulet group at Manchester University (home of
the Amulet processors - self-timed ARM cores) and elsewhere is looking
at management of /maximum/ power consumption (instantaneous power
consumption is a function of the work to be done) by constraining the
maximum number of instructions in flight, rather than the clocked
equivalent of capping the clock frequency. This might be done where
the power supply's capability is very limited (solar, wireless
induction, smartcard, wind, etc).  

This number can be managed by the processor if you build the right
peripheral into the system, and this would need an equivalent
interface for control - it wouldn't be a clock frequency, but it would
be a number controlling the /maximum/ speed of the processor.

Peter
