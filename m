Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129267AbQLLW55>; Tue, 12 Dec 2000 17:57:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129521AbQLLW5h>; Tue, 12 Dec 2000 17:57:37 -0500
Received: from uucp.nl.uu.net ([193.79.237.146]:47240 "EHLO uucp.nl.uu.net")
	by vger.kernel.org with ESMTP id <S129267AbQLLW50>;
	Tue, 12 Dec 2000 17:57:26 -0500
Date: Tue, 12 Dec 2000 23:13:25 +0100 (CET)
From: kees <kees@schoen.nl>
To: linux-kernel@vger.kernel.org
Subject: EMU10K1 not working under 2.2.18 (fwd)
Message-ID: <Pine.LNX.4.21.0012122312310.1108-100000@schoen3.schoen.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,
I have a SMP mobo MSI 694D with (2xPIII667MHz).
Under 2.2.18 the EMU10K1 *is* recognised (var/log/boot)

<6>Creative EMU10K1 PCI Audio Driver, version 0.6, 18:26:49 Dec  6 2000
<6>emu10k1: EMU10K1 rev 8 model 0x8027 found, IO at 0xe400-0xe41f, IRQ 18

But produce no mixer device for instance. 

Booting 2.2.17 back up: all is normal. Basically I did make oldconfig with
only:
> CONFIG_MICROCODE=y
> CONFIG_X86_MSR=y
> CONFIG_X86_CPUID=m 
and a couple of usb selections as modules. 
The other odd thing is that the 2 penguins are displayed correct with 
2.2.17 buth in a weird color with 2.2.18.
Both versions are build with the same compiler (SuSE 7.0)


Kees

P.S. Why is there no '/dev/sndstat' ?


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
