Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130424AbQKQROc>; Fri, 17 Nov 2000 12:14:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130468AbQKQROW>; Fri, 17 Nov 2000 12:14:22 -0500
Received: from cerebus-ext.cygnus.co.uk ([194.130.39.252]:57838 "EHLO
	passion.cygnus") by vger.kernel.org with ESMTP id <S130450AbQKQROP>;
	Fri, 17 Nov 2000 12:14:15 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <3A155F6A.28783D4A@mandrakesoft.com> 
In-Reply-To: <3A155F6A.28783D4A@mandrakesoft.com>  <Pine.LNX.4.10.10011170814440.2272-100000@penguin.transmeta.com> <5178.974478881@redhat.com> 
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Russell King <rmk@arm.linux.org.uk>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, David Hinds <dhinds@valinux.com>,
        tytso@valinux.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pcmcia event thread. (fwd) 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 17 Nov 2000 16:43:49 +0000
Message-ID: <5997.974479429@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


jgarzik@mandrakesoft.com said:
>  For these two, it sounds to me like you need to be doing a PCI probe,
> and getting the irq and I/O port info from pci_dev.  And calling
> pci_enable_device, which may or may not be a showstopper here... 

Yep. The same code is already present in David Hinds' i82365.c, but appears 
to have been stripped out when CardBus sockets started to be supported 
elsewhere. 

--
dwmw2


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
