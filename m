Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270531AbTGSTwq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jul 2003 15:52:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270533AbTGSTwq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jul 2003 15:52:46 -0400
Received: from zork.zork.net ([64.81.246.102]:47008 "EHLO zork.zork.net")
	by vger.kernel.org with ESMTP id S270531AbTGSTwg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jul 2003 15:52:36 -0400
To: Eric.VanBuggenhaut@AdValvas.be
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test1 fails at insmoding orinoco_cs
References: <20030719195754.GA3687@eric.ath.cx>
From: Sean Neakums <sneakums@zork.net>
Mail-Followup-To: Eric.VanBuggenhaut@AdValvas.be, linux-kernel@vger.kernel.org
Date: Sat, 19 Jul 2003 21:07:21 +0100
In-Reply-To: <20030719195754.GA3687@eric.ath.cx> (Eric Van Buggenhaut's
 message of "Sat, 19 Jul 2003 21:57:54 +0200")
Message-ID: <6uoezq8eme.fsf@zork.zork.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Van Buggenhaut <ericvb@debian.org> writes:

> It's the same driver I used with 2.4.21 and it worked fine. Is this a
> bug ? I'm not a kernel guru... If you need help to debug, lemme know.

Happily using the version shipped with 2.6.0-test1 here.

Jul 19 15:40:47 revox kernel: Linux Kernel Card Services 3.1.22
Jul 19 15:40:47 revox kernel:   options:  [pci] [cardbus] [pm]
Jul 19 15:40:47 revox kernel: PCI: Found IRQ 11 for device 0000:02:01.0
Jul 19 15:40:47 revox kernel: PCI: Sharing IRQ 11 with 0000:02:01.1
Jul 19 15:40:47 revox kernel: Yenta IRQ list 06b8, PCI irq11
Jul 19 15:40:47 revox kernel: Socket status: 30000006
Jul 19 15:40:47 revox kernel: PCI: Found IRQ 11 for device 0000:02:01.1
Jul 19 15:40:47 revox kernel: PCI: Sharing IRQ 11 with 0000:02:01.0
Jul 19 15:40:47 revox kernel: Yenta IRQ list 06b8, PCI irq11
Jul 19 15:40:47 revox kernel: Socket status: 30000010
Jul 19 15:40:48 revox cardmgr[396]: watching 2 sockets
Jul 19 15:40:48 revox cardmgr[397]: starting, version is 3.2.2
Jul 19 15:40:48 revox cardmgr[397]: socket 1: NetGear MA401RA
Jul 19 15:40:48 revox kernel: cs: IO port probe 0x0c00-0x0cff: clean.
Jul 19 15:40:48 revox kernel: cs: IO port probe 0x0800-0x08ff: excluding 0x800-0x817 0x828-0x837 0x
840-0x857 0x860-0x877 0x880-0x88f 0x898-0x89f 0x8a8-0x8cf 0x8e0-0x8ff
Jul 19 15:40:48 revox kernel: cs: IO port probe 0x0100-0x04ff: excluding 0x378-0x37f 0x3c0-0x3df 0x
4d0-0x4d7
Jul 19 15:40:48 revox kernel: cs: IO port probe 0x0a00-0x0aff: clean.
Jul 19 15:40:48 revox kernel: cs: memory probe 0xa0000000-0xa0ffffff: clean.
Jul 19 15:40:48 revox cardmgr[397]: executing: 'modprobe orinoco_cs'
Jul 19 15:40:48 revox kernel: orinoco.c 0.13e (David Gibson <hermes@gibson.dropbear.id.au> and othe
rs)
Jul 19 15:40:48 revox kernel: orinoco_cs.c 0.13e (David Gibson <hermes@gibson.dropbear.id.au> and o
thers)
Jul 19 15:40:48 revox kernel: eth1: Station identity xxxx:xxxx:xxxx:xxxx
Jul 19 15:40:48 revox kernel: eth1: Looks like an Intersil firmware version 1.3.6
Jul 19 15:40:48 revox kernel: eth1: Ad-hoc demo mode supported
Jul 19 15:40:48 revox kernel: eth1: IEEE standard IBSS ad-hoc mode supported
Jul 19 15:40:48 revox kernel: eth1: WEP supported, 104-bit key
Jul 19 15:40:48 revox kernel: eth1: MAC address xx:xx:xx:xx:xx:xx
Jul 19 15:40:48 revox kernel: eth1: Station name "Prism  I"
Jul 19 15:40:48 revox kernel: eth1: ready
Jul 19 15:40:48 revox kernel: eth1: index 0x01: Vcc 5.0, irq 3, io 0x0100-0x013f

