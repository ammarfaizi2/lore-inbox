Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312521AbSCUWBV>; Thu, 21 Mar 2002 17:01:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312524AbSCUWBL>; Thu, 21 Mar 2002 17:01:11 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:12560 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S312521AbSCUWBE>; Thu, 21 Mar 2002 17:01:04 -0500
Subject: Re: BUG: 2.4.18 & ALI15X3 DMA hang on boot
To: jcl@cs.cmu.edu (John Langford)
Date: Thu, 21 Mar 2002 22:17:17 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200203212047.g2LKlrc28867@gs176.sp.cs.cmu.edu> from "John Langford" at Mar 21, 2002 03:47:53 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16oAs1-0006SJ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> There seems to be some fundamental incompatibility between the kernel
> and the IDE chipset.  On several kernels in the 2.4 series including
> 2.4.18, I observe a hang in the bootsequence at:
> 
> ALI15X3: IDE controller on PCI bus 00 dev 78
> PCI: No IRQ known for interrupt pin A of device 00:0f.0. Please try using pci=biosirq.
> ALI15X3: chipset revision 195
> ALI15X3: not 100% native mode: will probe irqs later
> <hang>

And does pci=bios help ?

The kernel can't find out how the IDE IRQ routing is happening.
