Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317232AbSFLJYG>; Wed, 12 Jun 2002 05:24:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317672AbSFLJYF>; Wed, 12 Jun 2002 05:24:05 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:22021 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S317232AbSFLJYE>; Wed, 12 Jun 2002 05:24:04 -0400
Subject: Re: 2.4.18 ooops when modprobe'ing if pci=biosirq
To: Eric.VanBuggenhaut@AdValvas.be
Date: Wed, 12 Jun 2002 10:36:51 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020609173654.GC2350@eric.ath.cx> from "Eric Van Buggenhaut" at Jun 09, 2002 07:36:55 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17I4Yd-0007Qg-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Loading modules: 3c59x Unable to handle kernel paging request at
> virtual address 00009a28
>  printing eip:
> c00f7241
> *pde = 00000000

That looks like a bios32 bug not a linux one

> kernel: PCI: No IRQ known for interrupt pin A of device 00:09.0. Please try
> using pci=biosirq.

Ok

> When trying to get a Ricoh RL5c475 CardBus bridge working.

What chipset motherboard ?
