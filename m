Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262905AbSKSDT7>; Mon, 18 Nov 2002 22:19:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263215AbSKSDT7>; Mon, 18 Nov 2002 22:19:59 -0500
Received: from web12903.mail.yahoo.com ([216.136.174.70]:27428 "HELO
	web12903.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S262905AbSKSDT6>; Mon, 18 Nov 2002 22:19:58 -0500
Message-ID: <20021119032700.81890.qmail@web12903.mail.yahoo.com>
Date: Tue, 19 Nov 2002 14:27:00 +1100 (EST)
From: =?iso-8859-1?q?dee=20jay?= <deejay2shoes@yahoo.com.au>
Subject: APIC? IO-APIC? (was Re: 2.4.xx: 8139 isn't working)
To: Ducrot Bruno <poup@poupinou.org>,
       Michael Knigge <Michael.Knigge@set-software.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20021118105631.GA27595@poup.poupinou.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi, if i may interject at this point in time, and ask something
related, is there any reason why we should enable APIC or IO-APIC on a
uniprocessor system? What's the difference between the 2, or what's the
practical usage of these?


I'm reading the Configure.help and Documentation/i386/IO-APIC.txt for
these 2 items and i'm confused.

Thanks.
-dj

 --- Ducrot Bruno <poup@poupinou.org> wrote: > On Mon, Nov 18, 2002 at
10:20:03AM +0000, Michael Knigge wrote:
> > Hi,
> > 
> > my new board (GA-8ST, P4, single-CPU, SiS Chipset) has a RealTek
> 8139 
> > on board which isn't working with Linux 2.4.xx (tried 2.4.18,
> 2.4.19, 
> > 2.4.20rc1 and  2.4.20rc2).
> > 
> > I've attached lspci, dmesg and config from my  2.4.20rc2 and from a
> 
> > 2.2.20, where the NIC is working like a charm....
> > 
> 
> 
> I have the same ethernet card as you, but do not have any trouble.
> Reading your config etc., I guess that your motherboard do not have a
> good support for local IOAPIC.
> 
> You should definitely compile without SMP and without local IOAPIC.
> 
> Cheers,
> 
> -- 
> Ducrot Bruno
> http://www.poupinou.org        Page profaissionelle
> http://toto.tu-me-saoules.com  Haume page


http://www.yahoo.promo.com.au/hint/ - Yahoo! Hint Dropper
- Avoid getting hideous gifts this Christmas with Yahoo! Hint Dropper!
