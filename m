Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262697AbSI1EUH>; Sat, 28 Sep 2002 00:20:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262699AbSI1EUH>; Sat, 28 Sep 2002 00:20:07 -0400
Received: from ns.commfireservices.com ([216.6.9.162]:43278 "HELO
	hemi.commfireservices.com") by vger.kernel.org with SMTP
	id <S262697AbSI1EUG>; Sat, 28 Sep 2002 00:20:06 -0400
Date: Sat, 28 Sep 2002 00:24:20 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Marek Michalkiewicz <marekm@amelek.gda.pl>
Cc: twaugh@redhat.com, <serial24@macrolink.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] fix parport_serial / serial link order (for 2.4.20-pre8)
In-Reply-To: <E17uoir-00086v-00@alf.amelek.gda.pl>
Message-ID: <Pine.LNX.4.44.0209280021030.32347-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Sep 2002, Marek Michalkiewicz wrote:

> > Ahh return of the 9835 =) This POS never goes away...
> 
> Just curions, what does POS mean here? :)

Piece-Of-Shh... ;)

> These "ST Lab" 2S1P cards are the only kind of PCI I/O card that I was
> able to find here at a reasonable price (about $25), and it took me
> quite some time to find a company that actually sells them (in stock,
> not only in the price list - but if asked, "maybe in two weeks" for 3
> months now...).  In general, it is difficult to buy anything non-USB
> here at reasonable (not "industrial PC") prices.  Without these cards,
> I'd have to buy USB hubs and USB/serial converters instead...
> 
> The patch fixes a bug for _all_ PCI parallel+serial cards, and does
> not add NM9835 support yet (I'd like to submit that next - I would
> really like to see it in the standard kernel).

True;

00:0e.0 Communication controller: NetMos Technology 222N-2 I/O Card (2S+1P) (rev 01)

PCI parallel port detected: 9710:9835, I/O at 0xb000(0xa800)
parport0: PC-style at 0xb000 (0xa800) [PCSPP,TRISTATE]
ttyS04 at port 0xb800 (irq = 5) is a 16550A
ttyS05 at port 0xb400 (irq = 5) is a 16550A

I'm running this with shared parport IRQs since i have another PCI device 
sharing that IRQ too (its a real mess)

I have been using this setup for a while now.

	Zwane
-- 
function.linuxpower.ca

