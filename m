Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313743AbSDPQD4>; Tue, 16 Apr 2002 12:03:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313732AbSDPQDO>; Tue, 16 Apr 2002 12:03:14 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:43013 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S313737AbSDPQBr>; Tue, 16 Apr 2002 12:01:47 -0400
Subject: Re: Problems with emu10k1 on SMP machine
To: ekuznetsov@divxnetworks.com
Date: Tue, 16 Apr 2002 17:19:49 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <68851843.20020416085149@divxnetworks.com> from "Eugene Kuznetsov" at Apr 16, 2002 08:51:49 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16xVgM-0000Hb-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Creative EMU10K1 PCI Audio Driver, version 0.18, 08:34:52 Apr 16 2002
> PCI: Enabling device 00:09.0 (0004 -> 0005)
> PCI: No IRQ known for interrupt pin A of device 00:09.0. Please try using pci=biosirq.
> emu10k1: IRQ in use

Your system hasn't allocated the Emu10K an interrupt and it cannot find an
interrupt for it. We don't have AMD762 IRQ router support in 2.4.18 at the
moment although I believe we have the needed documentation. 

> Is there a way to fix it?

I think so.. care to be the test pilot ?

Alan

