Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274862AbSAUKHc>; Mon, 21 Jan 2002 05:07:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276424AbSAUKHX>; Mon, 21 Jan 2002 05:07:23 -0500
Received: from flubber.jvb.tudelft.nl ([130.161.76.47]:37808 "EHLO
	mail.jvb.tudelft.nl") by vger.kernel.org with ESMTP
	id <S274862AbSAUKHK>; Mon, 21 Jan 2002 05:07:10 -0500
Date: Mon, 21 Jan 2002 11:06:55 +0100 (CET)
From: Robbert Kouprie <robbert@jvb.tudelft.nl>
To: Mark Hahn <hahn@physics.mcmaster.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: NIC lockup in 2.4.17 (SMP/APIC/Intel 82557)
In-Reply-To: <Pine.LNX.4.33.0201201531570.6499-100000@coffee.psychology.mcmaster.ca>
Message-ID: <Pine.LNX.4.43.0201211053510.28659-100000@flubber.jvb.tudelft.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I know the bad reputation of the BP6, I see APIC errors every day since
the specific printk was added in 2.4.0, but system is fairly stable. Last
time it was unstable the cause was the Intel eepro100, which turned out
to suffer from a chipset bug, which is now corrected for in the
eepro100.c driver.

I ran 2.4 kernels with this NIC and the corrected driver since 2.4.14 or
so and never had problems. 2.4.16 ran for 40 days without trouble.

My BP6 bios is the most recent (RU revision). I can't really say "noapic"
helps as I have no way to reproduce this. It was just a one time message, which was
very similar to the earlier bug report to lkml I mentioned, that's why I
reported it.

If someone has any clues on how to reproduce this I am happy to do some
testing.

Regards,
- Robbert


On Sun, 20 Jan 2002, Mark Hahn wrote:

> > I have an Abit BP6 Dual Celeron 433, 192 Mb RAM, Intel NIC on 100 Mbit,
>
> I assume you know that the BP6 is quite notorious for it's
> rather ignoble irq and apic handling?  is it safe to assume
> you have a recent bios installed?  does booting "noapic" help?
>
>

