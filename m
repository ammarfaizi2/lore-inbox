Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266480AbSLIX7p>; Mon, 9 Dec 2002 18:59:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266487AbSLIX7p>; Mon, 9 Dec 2002 18:59:45 -0500
Received: from pc1-cwma1-5-cust42.swan.cable.ntl.com ([80.5.120.42]:5054 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S266480AbSLIX7o>; Mon, 9 Dec 2002 18:59:44 -0500
Subject: Re: /proc/pci deprecation?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Richard Henderson <rth@twiddle.net>, Patrick Mochel <mochel@osdl.org>,
       Willy Tarreau <willy@w.ods.org>, Petr Vandrovec <VANDROVE@vc.cvut.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       jgarzik@pobox.com
In-Reply-To: <Pine.LNX.4.44.0212090958140.10925-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0212090958140.10925-100000@home.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 10 Dec 2002 00:43:50 +0000
Message-Id: <1039481030.12046.19.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-12-09 at 18:11, Linus Torvalds wrote:
> That's definitely where it should be - the behaviour of the
> PCI_INTERRUPT_LINE register is clearly chip-specific, so it should be in
> the chip-specific drivers..
> 
> It's a kind of strange behaviour, though. What chip is this? It sounds
> kind of convenient, but as far as I can tell it can only work for those
> kinds of PCI devices that are on the same chip as the irq controller..

VIA bridges. In my case its a CLE266 (onchip video, 5.1 audio, ide, usb,
firewire, ethernet, floppy, serial, irda. parallel...) [See why I don't
want to hack each driver 8)]


