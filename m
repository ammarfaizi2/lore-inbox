Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280041AbRKRU3c>; Sun, 18 Nov 2001 15:29:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278592AbRKRU3X>; Sun, 18 Nov 2001 15:29:23 -0500
Received: from Olivier.PK.WAU.NL ([137.224.145.16]:24328 "EHLO
	olivier.pk.wau.nl") by vger.kernel.org with ESMTP
	id <S278587AbRKRU3J>; Sun, 18 Nov 2001 15:29:09 -0500
Date: Sun, 18 Nov 2001 21:29:02 +0100
To: linux-kernel@vger.kernel.org
Subject: lockup: 2.2.14 PCMCIA on Vaio R600HEK
Message-ID: <20011118212902.A7057@olivier>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
From: lists@olivier.pk.wau.nl (List Account)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

when I insert a PCMCIA card (I tested 2 cards from a friend) in my Sony Vaio R600HEK I get a complete lockup. 

I also have some weird kernel messages when the PCMCIA is started:

Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
PCI: No IRQ known for interrupt pin A of device 01:02.0. Please try using pci=biosirq.
Yenta IRQ list 04b8, PCI irq0
Socket status: 30000410
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0800-0x08ff: clean.
cs: IO port probe 0x0100-0x04ff: excluding 0x170-0x177 0x370-0x37f 0x4d0-0x4d7
cs: IO port probe 0x0a00-0x0aff: clean.
cs: memory probe 0xa0000000-0xa0ffffff: clean.

I use the yenta_socket module, everything on a Debian testing (Woody) system. When the PCMCIA card is in the slot during boot it is correctly detected.

More info on this laptop can be found on
http://lx.student.wau.nl/~olivier/linux_on_r600hek/linux_on_r600hek.html
including dmesg output and lspci output and stuff like that

thanks for help
	Olivier



