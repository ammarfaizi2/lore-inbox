Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315171AbSEUQ2s>; Tue, 21 May 2002 12:28:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315182AbSEUQ2r>; Tue, 21 May 2002 12:28:47 -0400
Received: from post2.fast.net ([209.92.1.22]:48601 "EHLO post2.fast.net")
	by vger.kernel.org with ESMTP id <S315171AbSEUQ2q>;
	Tue, 21 May 2002 12:28:46 -0400
Message-Id: <200205211628.g4LGSZb24258@post2.fast.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: cardbus/pcmcia/pci bridge problems? 
In-Reply-To: Your message of "Tue, 21 May 2002 14:22:31 BST."
             <E17A9ax-0007o9-00@the-village.bc.nu> 
Date: Tue, 21 May 2002 12:30:22 -0400
From: Paul Davis <pbd@op.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> >May 16 15:15:32 badass-bukvic kernel: PCI: Found IRQ 5 for device
>> >02:03.0
>> >May 16 15:15:33 badass-bukvic kernel: Hammerfall memory allocator:
>> >buffers allocated for 1 cards
>> >May 16 15:15:33 badass-bukvic kernel: PCI: No IRQ known for interrupt
>> >pin A of device . Please try using pci=biosirq.
>
>The $PIR table in the BIOS provided no useful information on what IRQ
>to use, or we didn't know the IRQ router concerned to set it up.

alan: let me check what you're saying: despite the fact that lspci -vv
shows the relevant information, there is still a problem? 

the problem is either in the BIOS or its an issue with the kernel not
knowing which IRQ router to use when setting up the interrupt? sorry
to be repetitive, but i'm just trying to check that i fully understand
this.
