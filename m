Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266274AbSKZOCI>; Tue, 26 Nov 2002 09:02:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266112AbSKZOCI>; Tue, 26 Nov 2002 09:02:08 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:38545 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S266101AbSKZOCH>; Tue, 26 Nov 2002 09:02:07 -0500
Subject: Re: IO-APIC on SiS P4 messes interrupts
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: devik <devik@cdi.cz>
Cc: linux-smp@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0211261307200.530-100000@devix>
References: <Pine.LNX.4.33.0211261307200.530-100000@devix>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 26 Nov 2002 14:40:07 +0000
Message-Id: <1038321607.2594.5.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-11-26 at 12:21, devik wrote: 
> I used two MSI 8533 mobos for our 1U rack servers.
> These mobos are for P4 and uses SiS 5513 chipset.
> They have integrated VGA and NIC (RTL8139).
> 
> When I boot 2.4.19 or 2.4.20rc2 with IO-APIC enabled
> the NIC doesn't work. It get IRQ 18 (instead of
> IRQ 11 in non-ioapic mode) but IRQ routing is bad
> because it got no irqs at that line.

SiS IO-APICs are not supported currently. Ollie at SiS kindly provided
the relevant information to fix that so I hope to have support included
soon.

For uniprocessors just skip using the apic

