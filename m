Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269091AbRG3XlC>; Mon, 30 Jul 2001 19:41:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269090AbRG3Xkv>; Mon, 30 Jul 2001 19:40:51 -0400
Received: from ns3.keyaccesstech.com ([209.47.245.85]:274 "EHLO
	terbidium.openservices.net") by vger.kernel.org with ESMTP
	id <S269089AbRG3Xkr>; Mon, 30 Jul 2001 19:40:47 -0400
Date: Mon, 30 Jul 2001 19:40:55 -0400 (EDT)
From: Ignacio Vazquez-Abrams <ignacio@openservices.net>
To: Linux kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Support for serial console on legacy free machines
In-Reply-To: <200107302332.f6UNWbxg001791@webber.adilger.int>
Message-ID: <Pine.LNX.4.33.0107301938360.13779-100000@terbidium.openservices.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-scanner: scanned by Inflex 1.0.7 - (http://pldaniels.com/inflex/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Mon, 30 Jul 2001, Andreas Dilger wrote:

> OK, maybe I'm misunderstanding here, but even if I put in a PCI serial
> card in such a machine, can I get serial console support without ACPI?
> Not that it matters in my case, because there are no PCI slots on the
> motherboard either.

Serial driver version 5.05a (2001-03-20) with MANY_PORTS MULTIPORT SHARE_IRQ
SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A  <---On-board
ttyS01 at 0x02f8 (irq = 3) is a 16550A  <-/
PCI: Found IRQ 11 for device 00:0c.0
ttyS04 at port 0xb400 (irq = 11) is a 16550A  <---Lava DSerial-PCI
ttyS05 at port 0xb000 (irq = 11) is a 16550A  <-/
ttyS02 at port 0x03e8 (irq = 5) is a 16550A  <--ISA PnP modem

I guess the question is, how do I tell if my machine is using ACPI?

-- 
Ignacio Vazquez-Abrams  <ignacio@openservices.net>

