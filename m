Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266108AbSL3DW1>; Sun, 29 Dec 2002 22:22:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266122AbSL3DW1>; Sun, 29 Dec 2002 22:22:27 -0500
Received: from jamesconeyisland.com ([66.64.43.2]:21004 "EHLO
	mail.jamesconeyisland.com") by vger.kernel.org with ESMTP
	id <S266108AbSL3DW0> convert rfc822-to-8bit; Sun, 29 Dec 2002 22:22:26 -0500
Content-Type: text/plain; charset=US-ASCII
From: Ron Cooper <rcooper@jamesconeyisland.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.4.21-pre2: CPU0 handles all interrupts
Date: Sun, 29 Dec 2002 21:30:07 -0600
User-Agent: KMail/1.4.3
References: <200212281056.58419.hans.lambrechts@skynet.be> <200212281103.36973.rcooper@jamesconeyisland.com> <1041212142.1474.33.camel@irongate.swansea.linux.org.uk>
In-Reply-To: <1041212142.1474.33.camel@irongate.swansea.linux.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200212292130.07707.rcooper@jamesconeyisland.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 29 December 2002 07:35 pm, Alan Cox wrote:
> On Sat, 2002-12-28 at 17:03, Ron Cooper wrote:
> > Mine does this too.  2.4.20.  Iwill dp400 board running dual
> > 2.4Ghz Xeons with HT enabled.
> >
> > I have to boot by passing "noapic" to the kernel, otherwise
> > /cat/proc/interrupts will show the interrupt numbers wrong,
> > however. not doing this changes nothing.
>
> "noapic" will deliver all IRQ's to IRQ0. Note btw - IRQ numbers
> *do* change in APIC mode
>
> -

Thank you for your reply and for the information.

Any reason to be disturbed by the fact /proc/interrupts only shows 
CPU0 with irq counts while CPU1 is always zero?

All the VIA chipsets I have that are SMP report both CPU's in the 
interrupt counts.  This IWILL board with the I860 chipset does not 
no matter which kernel I try.

I'd like to fix this but I dont know how.  But I  am willing to 
assist and devote any time necessary to someone who may have the 
knowledge fix it.  There have to be others out there experiencing 
this same issue so its not a wasted cause in my estimation.  

Alan, do you have any commentary on this issue?

Cheers

Ron





