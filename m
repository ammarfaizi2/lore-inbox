Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130827AbRCJCCj>; Fri, 9 Mar 2001 21:02:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130829AbRCJCC3>; Fri, 9 Mar 2001 21:02:29 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:63750 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130828AbRCJCCR>; Fri, 9 Mar 2001 21:02:17 -0500
Subject: Re: 2.4.2-ac16 PIIX4 ACPI getting wrong IRQ?
To: jdthoodREMOVETHIS@yahoo.co.uk (Thomas Hood)
Date: Sat, 10 Mar 2001 02:04:56 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org, linux-thinkpad@www.bm-soft.com
In-Reply-To: <3AA9868C.A5226735@yahoo.co.uk> from "Thomas Hood" at Mar 09, 2001 08:42:36 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14bYkc-00067B-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> With 2.4.2-ac16, /proc/pci contains:
> >  Bus  0, device   7, function  3:
> >    Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 1).
> >      IRQ 9.
> 
> So the ACPI function of the PIIX4 is now being given
> IRQ 9.  I don't want this.  I was using IRQ 9 for a
> PCMCIA device.

It was always being given IRQ 9, now we correctly handle this. 


