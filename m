Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129383AbRAMUNc>; Sat, 13 Jan 2001 15:13:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129401AbRAMUNW>; Sat, 13 Jan 2001 15:13:22 -0500
Received: from smtp-out1.bellatlantic.net ([199.45.40.143]:7065 "EHLO
	smtp-out1.bellatlantic.net") by vger.kernel.org with ESMTP
	id <S129383AbRAMUNS>; Sat, 13 Jan 2001 15:13:18 -0500
Date: Sat, 13 Jan 2001 15:13:14 -0500 (EST)
From: Werner Puschitz <werner.lx@verizon.net>
To: linux-kernel@vger.kernel.org
Subject: Re: HP Pavilion 8290 HANGS on boot 2.4/2.4-test9
In-Reply-To: <Pine.LNX.4.21.0101131444030.1779-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.21.0101131509280.2049-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I guess I confused some people. I didn't copy the kernel from PIII to
PII etc.. I compiled the kernel on all my PCs separately.
I just have problems with one PC, the HP Pavilion.


On Sat, 13 Jan 2001, Werner wrote:

> 
> HP Pavilion 8290, PII 400MHz, 256MB hangs on boot 2.4 and 2.4-test9 on RH7.0.
> I tried to compile 2.4-test9 on RH 7.0 with gcc versions 2.96-54, 2.96-69,
> and with kgcc 1.1.2-40 (egcs-2.91.66) without success.
> 
> The first and last message I get is: 
> "Uncompressing Linux... OK, booting the kernel"
> 
> I never get to the start_kernel() function in main.c
> I had no problems to get 2.4 (testx) running on IBM 300PL (PIII 500MHz, 192MB).
> After running 'make mrproper' and 'make xconfig' I changed only SMP to No.
> 
> Can you please tell me how I can print debug information to the console in
> arch/i386/boot/compressed/head.s and in arch/i386/kernel/head.S
> _without_ impacting the rest of the assembly code?
> 
> # lspci
> 00:00.0 Host bridge: Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge(rev 02)
> 00:01.0 PCI bridge: Intel Corporation 440BX/ZX - 82443BX/ZX AGP bridge(rev 02)
> 00:07.0 ISA bridge: Intel Corporation 82371AB PIIX4 ISA (rev 02)
> 00:07.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01)
> 00:07.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01)
> 00:07.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 02)
> 00:0a.0 Multimedia audio controller: Ensoniq ES1370 [AudioPCI]
> 00:0b.0 Ethernet controller: 3Com Corporation 3c905C-TX [Fast Etherlink] (rev 74)
> 00:0c.0 Ethernet controller: National Semiconductor Corporation: Unknown device 0020
> 01:00.0 VGA compatible controller: ATI Technologies Inc 3D Rage Pro AGP 1X/2X (rev 5c)
> 
> Let me know what I can do.
> 
> Thanks
> Werner
> 
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
> 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
