Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315593AbSFTVh5>; Thu, 20 Jun 2002 17:37:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315546AbSFTVhz>; Thu, 20 Jun 2002 17:37:55 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:2573 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S315593AbSFTVhV>; Thu, 20 Jun 2002 17:37:21 -0400
Date: Thu, 20 Jun 2002 14:37:35 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Martin Dalecki <dalecki@evision-ventures.com>
cc: Cort Dougan <cort@fsmlabs.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Benjamin LaHaise <bcrl@redhat.com>,
       Rusty Russell <rusty@rustcorp.com.au>, Robert Love <rml@tech9.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: latest linus-2.5 BK broken
In-Reply-To: <3D1248BB.6070007@evision-ventures.com>
Message-ID: <Pine.LNX.4.44.0206201428481.8225-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 20 Jun 2002, Martin Dalecki wrote:
>
> Linus you forget one simple fact - a HT CPU is *not* two CPUs.
> It is one CPU with a slightly better utilization of the
> super scalar pipelines.

Doesn't matter. It's SMP to software, _and_ it is a perfect example of how
integration, in the form of almost free transistors, changes the
economics.

> Just another way of increasind the fill reate of the pipelines
> for some specific tasks.

Integration is _not_ "just another way".

Integration fundamentally changes the whole equation.

When you integrate the SMP capabilities on the CPU, suddenly the world
changes, because suddenly SMP is cheap and easy to do for motherboard
manufacturers that would never have done it before. Suddenly SMP is
available at mass-market prices.

When you integrate multiple CPU's on one standard die (either HT or real
CPU's), the same thing happens.

When you start integrating crossbars etc "numa-like" stuff, like Hammer
apparently is doing, you get the same old technology, but it _behaves_
differently.

You see this outside CPU's too.

When people started integrating high-performance 3D onto a single die, the
_market_ changed. The way people used it changed. It's largely the same
technology that has been around for a long time in visual workstations,
but it's DIFFERENT thanks to low prices and easy integration into
bog-standard PC's.

A 3D tech person might say that the technology is still the same.

But a real human will notice that it's radically different.

> Did I mention that ARMs are the most sold CPUs out there?

Doesn't matter. Did I mention that microbes are the most populous form of
living beings? Does that make any difference to us as humans? Should that
make us think we want to be microbes? Or should it mean that we're somehow
inferior? Obviously not.

Did you mention that there are a lot more resistors in computers than
CPU's? No. It is irrelevant. It doesn't drive technology in fundamental
ways - even though the amount of fundamental technolgy inherent on a
modern motherboard in _just_ the passive components like the resistor
network is way beyond what people built just a few years ago.

			Linus

