Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317026AbSGHSVA>; Mon, 8 Jul 2002 14:21:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317034AbSGHSU7>; Mon, 8 Jul 2002 14:20:59 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:15368 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S317026AbSGHSUz>; Mon, 8 Jul 2002 14:20:55 -0400
Subject: Re: ISAPNP SB16 card with IDE interface
To: mouschi@wi.rr.com (Ted Kaminski)
Date: Mon, 8 Jul 2002 19:47:08 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <000d01c226ac$436ad360$8a981d41@wi.rr.com> from "Ted Kaminski" at Jul 08, 2002 01:21:22 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17RdXQ-0002tr-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> (a 4x one, model CR-581J, creative labs) connected to a ISAPNP Sound Blaster
> 16 card with an IDE interface on it. (99% sure actual IDE interface, not one
> of those old non-everything ones, SB is model CT2950)
> 
> ide3 at 0x168-1x16f,0x36e on irq 10
> ...(displays CHS stuff for HD)...
> hdg: irq timeout: status=0x51 { DriveReady SeekComplete Error }
> hdg: irq timeout: error=0x60
> hdg: irq timeout: status=0x58 { DriveReady SeekComplete DataRequest }
> hdg: irq timeout: status=0x58 { DriveReady SeekComplete DataRequest }
> hdg: irq timeout: status=0x58 { DriveReady SeekComplete DataRequest }
> hdg: ATAPI reset complete
> 
> and it repeats from the irq timeout again before it end_request's

Is IRQ10 assigned to the ISA bus in your BIOS ?
