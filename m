Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312546AbSCUWlO>; Thu, 21 Mar 2002 17:41:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312547AbSCUWlF>; Thu, 21 Mar 2002 17:41:05 -0500
Received: from GS176.SP.CS.CMU.EDU ([128.2.198.136]:56457 "EHLO
	gs176.sp.cs.cmu.edu") by vger.kernel.org with ESMTP
	id <S312546AbSCUWkr>; Thu, 21 Mar 2002 17:40:47 -0500
Message-Id: <200203212241.g2LMfuH29045@gs176.sp.cs.cmu.edu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: BUG: 2.4.18 & ALI15X3 DMA hang on boot 
In-Reply-To: Your message of "Thu, 21 Mar 2002 22:17:17 GMT."
             <E16oAs1-0006SJ-00@the-village.bc.nu> 
Date: Thu, 21 Mar 2002 17:41:56 -0500
From: John Langford <jcl@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> There seems to be some fundamental incompatibility between the kernel
>> and the IDE chipset.  On several kernels in the 2.4 series including
>> 2.4.18, I observe a hang in the bootsequence at:
>> 
>> ALI15X3: IDE controller on PCI bus 00 dev 78
>> PCI: No IRQ known for interrupt pin A of device 00:0f.0. Please try using pc
>i=biosirq.
>> ALI15X3: chipset revision 195
>> ALI15X3: not 100% native mode: will probe irqs later
>> <hang>
>
>And does pci=bios help ?

pci=biosirq doesn't help.  Same failure mode.

>The kernel can't find out how the IDE IRQ routing is happening.

I haven't tried reserving IRQs in the bios (which is possible, but too
much like blind search unless I get some more advice).

-John
