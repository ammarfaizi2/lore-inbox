Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932604AbWFTLjf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932604AbWFTLjf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 07:39:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932605AbWFTLjf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 07:39:35 -0400
Received: from spirit.analogic.com ([204.178.40.4]:14350 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP id S932604AbWFTLje convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 07:39:34 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
X-OriginalArrivalTime: 20 Jun 2006 11:39:33.0889 (UTC) FILETIME=[3385EF10:01C6945E]
Content-class: urn:content-classes:message
Subject: Re: [RFC/SERIOUS] grilling troubled CPUs for fun and profit?
Date: Tue, 20 Jun 2006 07:39:33 -0400
Message-ID: <Pine.LNX.4.61.0606200729280.7695@chaos.analogic.com>
In-Reply-To: <20060619224130.GA17134@redhat.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [RFC/SERIOUS] grilling troubled CPUs for fun and profit?
thread-index: AcaUXjOPcFEgVHTtQNqcP4fc5LB/fw==
References: <20060619191543.GA17187@rhlx01.fht-esslingen.de> <Pine.LNX.4.61.0606191542050.4926@chaos.analogic.com> <20060619202354.GD26759@redhat.com> <20060619222528.GC1648@openzaurus.ucw.cz> <20060619224130.GA17134@redhat.com>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Dave Jones" <davej@redhat.com>
Cc: "Pavel Machek" <pavel@ucw.cz>,
       "Andreas Mohr" <andi@rhlx01.fht-esslingen.de>,
       <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 19 Jun 2006, Dave Jones wrote:

> On Tue, Jun 20, 2006 at 12:25:29AM +0200, Pavel Machek wrote:
>
> > > Another anecdote: Upon fan failure, I once had an athlon MP *completely shatter*
> > > (as in broke in two pieces) under extreme heat.
> > >
> > > This _does_ happen.
> >
> > If it happens to you... you needed a new cpu anyway. Anything non-historical
> > *has* thermal protection.
>
> That's the single dumbest thing I've read today.
>
> newsflash: you don't get to dictate when I (or anyone else) buys new hardware.
> Before its accident, that box happily was my home firewall for 3 years, and
> its replacement is actually an /older/ box.  I didn't "need a new cpu" at all.
>
> (incidentally, it was replaced with a VIA C3 that doesn't need a fan :)
>
> > BTW I doubt those old athlons can be saved by cli; hlt . (Someone willing to try if old
> > athlon can run cli; hlt code w/o heatsink?).
>
> you snipped the important part of my mail.
>
> "cpu_relax() and friends aren't going to save a box"
>
> We have two completely different things being discussed in this thread.
>
> 1. Fan failure, and the possibility to keep running.
> IMO, there's nothing we can do here, and nor should we try.
>
> 2. Situations where we forcibly lock up and spin the CPU in a tight loop,
> producing heat.

The CPU produces heat. It's efficiency as a heater is nearly 100%
because it doesn't produce much noise or anything else to transfer
its 50+ watts into anything but heat. Spinning doesn't make friction.
It doesn't make more heat. The total box dissipation might even
be reduced because there is little memory activity and no seeks
of hard disks.

Some CPUs will go to a low-power 'sleep' mode if halted. Some require
more than that, they must fetch 'pause', i.e., rep nop to stay in
a low power mode. Other CPUs will throttle back their power
consumption when the instruction cache is inactive, read spinning.
These CPUs are normally used in lap-tops to maximize battery life.

So relax. The CPU isn't going to get dizzy because it's spinning!

[SNIPPED]


Cheers,
Dick Johnson
Penguin : Linux version 2.6.16.4 on an i686 machine (5592.72 BogoMips).
New book: http://www.AbominableFirebug.com/
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
