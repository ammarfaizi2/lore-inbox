Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282833AbRLGLDc>; Fri, 7 Dec 2001 06:03:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285449AbRLGLDW>; Fri, 7 Dec 2001 06:03:22 -0500
Received: from [212.3.242.3] ([212.3.242.3]:29203 "HELO mail.i4gate.net")
	by vger.kernel.org with SMTP id <S282833AbRLGLDM>;
	Fri, 7 Dec 2001 06:03:12 -0500
Message-Id: <5.1.0.14.2.20011207115458.02fd2968@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Fri, 07 Dec 2001 11:56:10 +0100
To: spyro@armlinux.org
From: DevilKin <devilkin@gmx.net>
Subject: Re: Bug?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011207103311.386e54fe.spyro@armlinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 10:33 7/12/2001 +0000, you wrote:
>Hi.
>
>Havent had time to investigate, but I have seen a locup on the ASUS A7M
>mobo, with a via-rhine (100Mb/se, fdx) ethernet card.
>
>With the ethernet card in one PCI slot, the USB (95% of the time) will
>freeze the system solid when usb-uhci.o is loaded.
>
>Since moving the card to another slot, it seems to works fine.
>
>if anyone suggests 'things to look for' I will have a look (but it isnt my
>box, so it may take time).
>
>For reference, I have a (similar) box with the same CPU and mobo, but
>different cards, and have never seen this (or any similar) lockup.
>
>the mobo in the machine in question has been replaced, and the replacement
>shows the same problem.

I suppose that the USB hub on the mainboard and the PCI slot share IRQ's... 
and I've noticed that USB ain't too happy about sharing IRQ's.

Check the manual of the motherboard about this... or do an lspci -v and 
report the irq numbers.

DK

