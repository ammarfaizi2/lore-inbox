Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130657AbRBAPb0>; Thu, 1 Feb 2001 10:31:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130691AbRBAPbR>; Thu, 1 Feb 2001 10:31:17 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:39438 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130658AbRBAPa6>; Thu, 1 Feb 2001 10:30:58 -0500
Subject: Re: 2.4.1 DAC960 driver bug or what's going on?
To: silviu@delrom.ro (Silviu Marin-Caea)
Date: Thu, 1 Feb 2001 15:31:44 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010201171928.3e8e964c.silviu@delrom.ro> from "Silviu Marin-Caea" at Feb 01, 2001 05:19:28 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14OLi6-0004So-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> PCI: Found IRQ 11 for device 00:0d.1
> PCI: The same IRQ used for device 00:07.2

That bit is fine

> DAC960: ***** DAC960 RAID Driver version 2.4.9 of 7 September 2000 *****
> DAC960: Copyright 1998-2000 by Leonard N. Zubkoff <lnz@dandelion.com>
> Kernel panic: DAC960: Logical Drive Block Size 0 not supported
> 
> I really don't know what the other device on IRQ 11 would be, since
> there are no other add-in cards than video and RAID controller.

That IMHO isnt the problem

> Same thing happened on an EPoX mainboard, before I tried the controller
> with this hardware.  No matter what IRQ Mylex gets, linux says there's
> another device using it.  What would be that device?  PS/2 mouse
> controller, perhaps?  Why does it stick to Mylex?

Which compiler out of curiosity
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
