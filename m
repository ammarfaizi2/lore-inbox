Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129716AbQLKVMG>; Mon, 11 Dec 2000 16:12:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129983AbQLKVL5>; Mon, 11 Dec 2000 16:11:57 -0500
Received: from front4.grolier.fr ([194.158.96.54]:64234 "EHLO
	front4.grolier.fr") by vger.kernel.org with ESMTP
	id <S129716AbQLKVLp> convert rfc822-to-8bit; Mon, 11 Dec 2000 16:11:45 -0500
Date: Mon, 11 Dec 2000 20:40:59 +0100 (CET)
From: Gérard Roudier <groudier@club-internet.fr>
To: davej@suse.de
cc: Jamie Lokier <lk@tantalophile.demon.co.uk>, Martin Mares <mj@suse.cz>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: pdev_enable_device no longer used ?
In-Reply-To: <Pine.LNX.4.21.0012110018180.19534-100000@neo.local>
Message-ID: <Pine.LNX.4.10.10012112028170.1912-100000@linux.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 11 Dec 2000 davej@suse.de wrote:

> On Mon, 11 Dec 2000, Jamie Lokier wrote:
> 
> > Here are a few more:
> > 
> >  net/acenic.c: pci_write_config_byte(ap->pdev, PCI_CACHE_LINE_SIZE,
> 
> Acenic is at least setting it to the correct values, not hardcoding it.
> 
> >  net/gmac.c: PCI_CACHE_LINE_SIZE, 8);
> 
> Ick.
> 
> >  scsi/sym53c8xx.c: printk(NAME53C8XX ": PCI_CACHE_LINE_SIZE set to %d (fix-up).\n",
> 
> **vomit**

A BASTARD you are. Linux was born thanks to volunteers that spent
thousands of hours on their free time for helping development. If you
vomit on me, let me shit on you.

> On the plus side, they made it arch independant. Shame it's incomplete.
> If you look at the x86 path, its missing Pentium 4 support (x86==15).

Most of the code in Linux was there years ago prior to the Pentium 4 that, 
by the way, looks like the buggiest thing that are ever existed.

> It also screws up on Athlon where it should be set to 16, but gets 8.

Same for this one.

> I wouldn't be surprised if the other arch's were missing some definitions
> too.  The fact that this driver is a port of FreeBSD driver may be the
> reason why SMP_CACHE_BYTES wasn't used instead, and the author opted
> for that monster. But still, the whole thing is completely unnecessary.

The driver is back to FreeBSD and is intended to go to other Free O/Ses as 
I will find time for.

[...]

  Gérard.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
