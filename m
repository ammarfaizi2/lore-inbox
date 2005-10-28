Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750783AbVJ1Xos@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750783AbVJ1Xos (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 19:44:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750784AbVJ1Xos
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 19:44:48 -0400
Received: from khc.piap.pl ([195.187.100.11]:1028 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S1750783AbVJ1Xor (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 19:44:47 -0400
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Call for PIIX4 chipset testers
References: <Pine.LNX.4.64.0510251042420.10477@g5.osdl.org>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Sat, 29 Oct 2005 01:44:38 +0200
In-Reply-To: <Pine.LNX.4.64.0510251042420.10477@g5.osdl.org> (Linus
 Torvalds's message of "Tue, 25 Oct 2005 10:51:24 -0700 (PDT)")
Message-ID: <m38xwd6wbd.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> It should report a number of quirks, and the easiest way to get them all 
> is to just do
>
> 	dmesg -s 1000000 | grep PIIX4

Another one - Fujitsu - Siemens Liteline LF6 notebook (Celeron 600 MHz,
i440BX):

PCI quirk: region 8000-803f claimed by PIIX4 ACPI
PCI quirk: region 2180-219f claimed by PIIX4 SMB
PIIX4 devres C PIO at 0372-0373
PIIX4 devres I PIO at 0398-0399

/proc/ioports shows nothing WTR these 2 address ranges.

Another chipset-related thing is:
PCI: Ignore bogus resource 6 [0:0] of 0000:01:00.0.

0:0.0 Host bridge: Intel 440BX/ZX/DX - 82443BX/ZX/DX Host bridge (rev 03)
0:1.0 PCI bridge: Intel 440BX/ZX/DX - 82443BX/ZX/DX AGP bridge (rev 03)
0:7.0 ISA bridge: Intel 82371AB/EB/MB PIIX4 ISA (rev 02)
0:7.1 IDE interface: Intel 82371AB/EB/MB PIIX4 IDE (rev 01)
0:7.2 USB Controller: Intel 82371AB/EB/MB PIIX4 USB (rev 01)
0:7.3 Bridge: Intel 82371AB/EB/MB PIIX4 ACPI (rev 03)
0:a.0 CardBus bridge: Texas Instruments PCI1225 (rev 01)
0:a.1 CardBus bridge: Texas Instruments PCI1225 (rev 01)
0:d.0 Multimedia audio ctrl: ESS Tech ES1983S Maestro-3i PCI Audio Accelerator
0:d.1 Communication ctrl: ESS Tech ES1983S Maestro-3i PCI Modem Accelerator
1:0.0 VGA compatible controller: Silicon Motion, Inc. SM720 Lynx3DM (rev b1)
2:0.0 Ethernet: Digital Equipment Corporation DECchip 21142/43 (rev 41)

Probably not very interresting. Details available on request.
-- 
Krzysztof Halasa
