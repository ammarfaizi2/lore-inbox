Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275684AbRIZXIw>; Wed, 26 Sep 2001 19:08:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275688AbRIZXIm>; Wed, 26 Sep 2001 19:08:42 -0400
Received: from adsl-209-76-109-63.dsl.snfc21.pacbell.net ([209.76.109.63]:896
	"EHLO adsl-209-76-109-63.dsl.snfc21.pacbell.net") by vger.kernel.org
	with ESMTP id <S275684AbRIZXIa>; Wed, 26 Sep 2001 19:08:30 -0400
Date: Wed, 26 Sep 2001 16:08:47 -0700
From: Wayne Whitney <whitney@math.berkeley.edu>
Message-Id: <200109262308.f8QN8ln01180@adsl-209-76-109-63.dsl.snfc21.pacbell.net>
To: Mikael Pettersson <mikpe@csd.uu.se>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: spurious 8259A interrupt: IRQ7. AND VM: killing process ..
In-Reply-To: <200109262027.WAA05553@harpo.it.uu.se>
In-Reply-To: <200109262027.WAA05553@harpo.it.uu.se>
Reply-To: whitney@math.berkeley.edu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In mailing-lists.linux-kernel, Mikael Pettersson wrote:

> Please try either 2.4.10 with CONFIG_X86_UP_IOAPIC=n (don't worry,
> you don't need it and won't lose any performance) or 2.4.9-ac with
> CONFIG_X86_UP_IOAPIC=n and CONFIG_X86_UP_APIC=y.

I have an ASUS A7V with BIOS 1008.  Once per boot I get the kernel
message "spurious 8259A interrupt: IRQ7".  Also, the ERR field in
/proc/interrupts does seem to slowly increase with uptime.  These
symptoms occur with all three kernels I have checked: 2.4.10 with
UP_IOAPIC=y, 2.4.9-ac15 with UP_IOAPIC=y and UP_APIC=y, and 2.4.9-ac15
with UP_IOAPIC=n and UP_APIC=y.

This situation seems harmless enough, but if anyone would like more
data I'd be happy to try out stuff.

Cheers, Wayne

