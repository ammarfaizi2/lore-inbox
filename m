Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278492AbRKSM3X>; Mon, 19 Nov 2001 07:29:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278630AbRKSM3O>; Mon, 19 Nov 2001 07:29:14 -0500
Received: from NET.WAU.NL ([137.224.10.12]:48396 "EHLO net.wau.nl")
	by vger.kernel.org with ESMTP id <S278492AbRKSM3H>;
	Mon, 19 Nov 2001 07:29:07 -0500
Date: Mon, 19 Nov 2001 13:29:05 +0100
From: Olivier Sessink <lists@olivier.pk.wau.nl>
Subject: PCMCIA kernel freezes (yenta_socket) - more info
To: linux-kernel@vger.kernel.org
Message-id: <20011119132905.6c0591f8.lists@olivier.pk.wau.nl>
Organization: Wageningen Multimedia Software Labs
MIME-version: 1.0
X-Mailer: Sylpheed version 0.6.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

when I insert a PCMCIA card (3 cards tested) in my Sony Vaio R600HEK the
system freezes. When I remove the card it runs again. logs show nothing,
dmesg shows nothing.. 

When I boot the system with a PCMCIA card in the slot, it works AND I can
remove it and add it again without a problem!!??!!

So the workaround it to boot it with a card always, but that is not really
convenient..

it is a Debian testing (Woody) system with kernel 2.4.14, the following
modules are loaded: cb_enabler, ds, yenta_socket and pcmcia_core

I also have some weird kernel messages when the PCMCIA is started:

Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
PCI: No IRQ known for interrupt pin A of device 01:02.0. Please try using
pci=biosirq.
Yenta IRQ list 04b8, PCI irq0
Socket status: 30000410
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0800-0x08ff: clean.
cs: IO port probe 0x0100-0x04ff: excluding 0x170-0x177 0x370-0x37f
0x4d0-0x4d7
cs: IO port probe 0x0a00-0x0aff: clean.
cs: memory probe 0xa0000000-0xa0ffffff: clean.

More info on this laptop can be found on
http://lx.student.wau.nl/~olivier/linux_on_r600hek/linux_on_r600hek.html
including dmesg output and lspci output and stuff like that

anybody an idea?

regards,
	Olivier
