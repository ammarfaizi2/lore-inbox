Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131041AbQKVB5F>; Tue, 21 Nov 2000 20:57:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132054AbQKVB44>; Tue, 21 Nov 2000 20:56:56 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:36111 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S131041AbQKVB4q>; Tue, 21 Nov 2000 20:56:46 -0500
Date: Tue, 21 Nov 2000 17:26:06 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Tobias Ringstrom <tori@tellus.mine.nu>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>, andrewm@uow.edu.au,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 3c59x: Using bad IRQ 0
In-Reply-To: <3A1ACCE0.42B93664@mandrakesoft.com>
Message-ID: <Pine.LNX.4.10.10011211723380.4687-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 21 Nov 2000, Jeff Garzik wrote:
> 
> A caveat to this whole scheme is that usb-uhci -already- calls
> pci_enable_device before checking dev->irq, and yet cannot get around
> the "assign IRQ to USB: no" setting in BIOS.  I hope that is an
> exception rather than the rule.

Do we have a recent report of this with full PCI debug output? It might
just be another unlisted intel irq router..

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
