Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312301AbSCTXxe>; Wed, 20 Mar 2002 18:53:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312304AbSCTXxX>; Wed, 20 Mar 2002 18:53:23 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:48657 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S312301AbSCTXwX>; Wed, 20 Mar 2002 18:52:23 -0500
Subject: Re: Linux 2.4.19pre3-ac4: ATTRIB_NORET
To: eyal@eyal.emu.id.au (Eyal Lebedinsky)
Date: Thu, 21 Mar 2002 00:08:30 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3C990E9E.CC23F0AA@eyal.emu.id.au> from "Eyal Lebedinsky" at Mar 21, 2002 09:35:10 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16nq86-0003mM-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> However ATTRIB_NORET is only defined if __KERNEL__, and the above line
> is outside that segment. In may case it is lm_sensors 2.6.2 that fails
> here.

Thats a kernel header so I guess the argument is that lm_sensors user space
shouldnt include it - but send me a diff

> BTW, this undef is still around too:
> depmod: *** Unresolved symbols in
> /lib/modules/2.4.19-pre3-ac4/kernel/drivers/hotplug/ibmphp.o
> depmod:         IO_APIC_get_PCI_irq_vector

I'll take a look - Greg certainly sent me a fix

