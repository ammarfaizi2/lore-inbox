Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262730AbUFFCAX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262730AbUFFCAX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jun 2004 22:00:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262766AbUFFCAX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jun 2004 22:00:23 -0400
Received: from 146-235-81-62.libre.auna.net ([62.81.235.146]:32491 "EHLO
	asmtp01.eresmas.com") by vger.kernel.org with ESMTP id S262730AbUFFB7s
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jun 2004 21:59:48 -0400
From: ktech@wanadoo.es
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-rc1 breaks forcedeth
Date: Sun, 6 Jun 2004 03:59:46 +0200
X-MAILER: ARB/3.0
Content-Type: text/plain; charset=iso-8859-1
Message-Id: <E1BWmws-0005aN-Nw@mb04.in.mad.eresmas.com>
X-Spam-Score: 0.5 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm not a coder, so sorry if data seems to be superfluous:



2.6.5 works

2.6.7rc (and somes before) don't work



for 2.6.5

Detected 2126.173 MHz processor.



for 2.6.7rc

Detected 2126.366 MHz processor.



"POSIX conformance test by UNIFIX" appears only in 2.6.5.

"nforce fixup c1 halt disconnect fixup" appears only in 2.6.5



and now the ACPI stuff:



for 2.6.5:

--------------------------------------------------------------



ACPI: Subsystem revision 20040326

ACPI: IRQ9 SCI: Edge set to Level Trigger.

ACPI: Interpreter enabled

ACPI: Using PIC for interrupt routing

ACPI: PCI Root Bridge [PCI0] (00:00)

PCI: Probing PCI hardware (bus 00)

ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]

ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB0._PRT]

ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGPB._PRT]

ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 *5 6 7 10 11 12 14 15)

ACPI: PCI Interrupt Link [LNK2] (IRQs 3 4 5 6 7 10 11 12 14 15)

ACPI: PCI Interrupt Link [LNK3] (IRQs 3 4 5 6 7 10 11 12 14 15)

ACPI: PCI Interrupt Link [LNK4] (IRQs 3 4 5 6 7 *10 11 12 14 15)

ACPI: PCI Interrupt Link [LNK5] (IRQs 3 4 5 6 7 10 11 12 14 15)

ACPI: PCI Interrupt Link [LUBA] (IRQs 3 4 *5 6 7 10 11 12 14 15)

ACPI: PCI Interrupt Link [LUBB] (IRQs 3 4 5 6 7 *10 11 12 14 15)

ACPI: PCI Interrupt Link [LMAC] (IRQs 3 4 5 6 7 10 *11 12 14 15)

ACPI: PCI Interrupt Link [LAPU] (IRQs *3 4 5 6 7 10 11 12 14 15)

ACPI: PCI Interrupt Link [LACI] (IRQs 3 4 5 6 *7 10 11 12 14 15)

ACPI: PCI Interrupt Link [LMCI] (IRQs 3 4 5 6 7 10 11 12 14 15)

ACPI: PCI Interrupt Link [LSMB] (IRQs 3 4 5 6 *7 10 11 12 14 15)

ACPI: PCI Interrupt Link [LUB2] (IRQs 3 4 5 6 7 10 *11 12 14 15)

ACPI: PCI Interrupt Link [LFIR] (IRQs 3 4 5 6 7 10 11 12 14 15)

ACPI: PCI Interrupt Link [L3CM] (IRQs 3 4 5 6 7 10 11 12 14 15)

ACPI: PCI Interrupt Link [LIDE] (IRQs 3 4 5 6 7 10 11 12 14 15)

ACPI: PCI Interrupt Link [APC1] (IRQs *16)

ACPI: PCI Interrupt Link [APC2] (IRQs 17)

ACPI: PCI Interrupt Link [APC3] (IRQs 18)

ACPI: PCI Interrupt Link [APC4] (IRQs *19)

ACPI: PCI Interrupt Link [APCE] (IRQs 16)

ACPI: PCI Interrupt Link [APCF] (IRQs 20 21 22)

ACPI: PCI Interrupt Link [APCG] (IRQs 20 21 22)

ACPI: PCI Interrupt Link [APCH] (IRQs 20 21 22)

ACPI: PCI Interrupt Link [APCI] (IRQs 20 21 22)

ACPI: PCI Interrupt Link [APCJ] (IRQs 20 21 22)

ACPI: PCI Interrupt Link [APCK] (IRQs 20 21 22)

ACPI: PCI Interrupt Link [APCS] (IRQs *23)

ACPI: PCI Interrupt Link [APCL] (IRQs 20 21 22)

ACPI: PCI Interrupt Link [APCM] (IRQs 20 21 22)

ACPI: PCI Interrupt Link [AP3C] (IRQs 20 21 22)

ACPI: PCI Interrupt Link [APCZ] (IRQs 20 21 22)

SCSI subsystem initialized

ACPI: PCI Interrupt Link [LSMB] enabled at IRQ 7

ACPI: PCI Interrupt Link [LUBA] enabled at IRQ 5

ACPI: PCI Interrupt Link [LUBB] enabled at IRQ 10

ACPI: PCI Interrupt Link [LUB2] enabled at IRQ 11

ACPI: PCI Interrupt Link [LMAC] enabled at IRQ 11

ACPI: PCI Interrupt Link [LAPU] enabled at IRQ 3

ACPI: PCI Interrupt Link [LACI] enabled at IRQ 7

ACPI: PCI Interrupt Link [LNK1] enabled at IRQ 5

ACPI: PCI Interrupt Link [LNK4] enabled at IRQ 10

PCI: Using ACPI for IRQ routing

PCI: if you experience problems, try using option 'pci=noacpi' or even 

'acpi=off'





for 2.6.7-rc

---------------------------------------------

ACPI: Subsystem revision 20040326

ACPI: IRQ9 SCI: Edge set to Level Trigger.

ACPI: Interpreter enabled

ACPI: Using PIC for interrupt routing

ACPI: PCI Root Bridge [PCI0] (00:00)

PCI: Probing PCI hardware (bus 00)

PCI: nForce2 C1 Halt Disconnect fixup

ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]

ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB0._PRT]

ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGPB._PRT]

ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 *5 6 7 10 11 12 14 15)

ACPI: PCI Interrupt Link [LNK2] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.

ACPI: PCI Interrupt Link [LNK3] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.

ACPI: PCI Interrupt Link [LNK4] (IRQs 3 4 5 6 7 *10 11 12 14 15)

ACPI: PCI Interrupt Link [LNK5] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.

ACPI: PCI Interrupt Link [LUBA] (IRQs 3 4 *5 6 7 10 11 12 14 15)

ACPI: PCI Interrupt Link [LUBB] (IRQs 3 4 5 6 7 *10 11 12 14 15)

ACPI: PCI Interrupt Link [LMAC] (IRQs 3 4 5 6 7 10 *11 12 14 15)

ACPI: PCI Interrupt Link [LAPU] (IRQs *3 4 5 6 7 10 11 12 14 15)

ACPI: PCI Interrupt Link [LACI] (IRQs 3 4 5 6 *7 10 11 12 14 15)

ACPI: PCI Interrupt Link [LMCI] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.

ACPI: PCI Interrupt Link [LSMB] (IRQs 3 4 5 6 *7 10 11 12 14 15)

ACPI: PCI Interrupt Link [LUB2] (IRQs 3 4 5 6 7 10 *11 12 14 15)

ACPI: PCI Interrupt Link [LFIR] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.

ACPI: PCI Interrupt Link [L3CM] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.

ACPI: PCI Interrupt Link [LIDE] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.

ACPI: PCI Interrupt Link [APC1] (IRQs *16)

ACPI: PCI Interrupt Link [APC2] (IRQs *17), disabled.

ACPI: PCI Interrupt Link [APC3] (IRQs *18), disabled.

ACPI: PCI Interrupt Link [APC4] (IRQs *19)

ACPI: PCI Interrupt Link [APCE] (IRQs *16), disabled.

ACPI: PCI Interrupt Link [APCF] (IRQs 20 21 22) *0

ACPI: PCI Interrupt Link [APCG] (IRQs 20 21 22) *0

ACPI: PCI Interrupt Link [APCH] (IRQs 20 21 22) *0

ACPI: PCI Interrupt Link [APCI] (IRQs 20 21 22) *0

ACPI: PCI Interrupt Link [APCJ] (IRQs 20 21 22) *0

ACPI: PCI Interrupt Link [APCK] (IRQs 20 21 22) *0, disabled.

ACPI: PCI Interrupt Link [APCS] (IRQs *23)

ACPI: PCI Interrupt Link [APCL] (IRQs 20 21 22) *0

ACPI: PCI Interrupt Link [APCM] (IRQs 20 21 22) *0, disabled.

ACPI: PCI Interrupt Link [AP3C] (IRQs 20 21 22) *0, disabled.

ACPI: PCI Interrupt Link [APCZ] (IRQs 20 21 22) *0, disabled.

SCSI subsystem initialized

PCI: Using ACPI for IRQ routing

ACPI: PCI Interrupt Link [LSMB] enabled at IRQ 7

ACPI: PCI interrupt 0000:00:01.1[A] -> GSI 7 (level, low) -> IRQ 7

ACPI: PCI Interrupt Link [LUBA] enabled at IRQ 5

ACPI: PCI interrupt 0000:00:02.0[A] -> GSI 5 (level, low) -> IRQ 5

ACPI: PCI Interrupt Link [LUBB] enabled at IRQ 10

ACPI: PCI interrupt 0000:00:02.1[B] -> GSI 10 (level, low) -> IRQ 10

ACPI: PCI Interrupt Link [LUB2] enabled at IRQ 11

ACPI: PCI interrupt 0000:00:02.2[C] -> GSI 11 (level, low) -> IRQ 11

ACPI: PCI Interrupt Link [LMAC] enabled at IRQ 11

ACPI: PCI interrupt 0000:00:04.0[A] -> GSI 11 (level, low) -> IRQ 11

ACPI: PCI Interrupt Link [LAPU] enabled at IRQ 3

ACPI: PCI interrupt 0000:00:05.0[A] -> GSI 3 (level, low) -> IRQ 3

ACPI: PCI Interrupt Link [LACI] enabled at IRQ 7

ACPI: PCI interrupt 0000:00:06.0[A] -> GSI 7 (level, low) -> IRQ 7

ACPI: PCI Interrupt Link [LNK1] enabled at IRQ 5

ACPI: PCI interrupt 0000:01:08.0[A] -> GSI 5 (level, low) -> IRQ 5

ACPI: PCI interrupt 0000:01:08.1[A] -> GSI 5 (level, low) -> IRQ 5

ACPI: PCI Interrupt Link [LNK4] enabled at IRQ 10

ACPI: PCI interrupt 0000:02:00.0[A] -> GSI 10 (level, low) -> IRQ 10





After initializing of forcedeth part (the part that doesn't work):

--------------------

2.6.5:   Nothing

2.6.7:   ACPI: PCI interrupt 0000:00:04.0[A] -> GSI 11 (level, low) -> IRQ 11



Ater initializing of usb part:

----------------------

2.6.5:    Nothing

2.6.7:    ACPI: PCI interrupt 0000:00:06.0[A] -> GSI 7 (level, low) -> IRQ 7



After sound-card part (intel8x0):

----------------------

2.6.5:    Nothing

2.6.7:    ACPI: PCI interrupt 0000:00:02.2[C] -> GSI 11 (level, low) -> IRQ 11



And this only happens on 2.6.7 (not in 2.6.5):

-----------------------

irq 11: nobody cared!

 [<c01059aa>]

 [<c0105ac3>]

 [<c0105db8>]

 [<c01040a8>]

 [<c01191b0>]

 [<c0119236>]

 [<c0105dc5>]

 [<c01040a8>]

 [<c01e8dbe>]

 [<f8a938a2>]

 [<c0115a38>]

 [<f8a3e870>]

 [<f8a43d6a>]

 [<c01eca72>]

 [<c01ecacc>]

 [<c01ecb0c>]

 [<c0229b9f>]

 [<c0229cf2>]

 [<c0229fb1>]

 [<c022a45f>]

 [<c01ecddc>]

 [<f8a0a020>]

 [<c012bd9f>]

 [<c0103f3b>]

handlers:

[<f8a3f800>]

Disabling IRQ #11





2.6.5

-------------

bash-2.05b# cat /proc/interrupts

           CPU0

  0:    1902184          XT-PIC  timer

  1:       2999          XT-PIC  i8042

  2:          0          XT-PIC  cascade

  5:          3          XT-PIC  Bt87x audio

  7:          0          XT-PIC  NVidia nForce2

  8:          2          XT-PIC  rtc

  9:          0          XT-PIC  acpi

 11:     193338          XT-PIC  ehci_hcd, eth0

 12:      86653          XT-PIC  i8042

 14:      30572          XT-PIC  ide0

 15:        112          XT-PIC  ide1

NMI:          0

ERR:          0







2.6.7rc

------------

           CPU0       

  0:     163490          XT-PIC  timer

  1:        170          XT-PIC  i8042

  2:          0          XT-PIC  cascade

  5:          0          XT-PIC  Bt87x audio

  7:          0          XT-PIC  NVidia nForce2

  8:          2          XT-PIC  rtc

  9:          0          XT-PIC  acpi

 11:     100000          XT-PIC  ehci_hcd

 12:       1162          XT-PIC  i8042

 14:      14766          XT-PIC  ide0

 15:         18          XT-PIC  ide1

NMI:          0 

ERR:          0



Any other test?



Thanks.



Luis Miguel Garcia



El Sunday 06 June 2004 01:50, escribió:

> On Sun, 6 Jun 2004, Luis Miguel García Mancebo wrote:

> > I have not been able to make my ethernet card to work in post-2.6.6

> > kernels. This is a nforce2 motherboard, and as Jeff pointed, nothing has

> > changed in the driver (forcedeth), and the problem could be acpi or

> > routing in the kernel. In fact, I have a "Disabling IRQ #11" message.

> > Here is the dmesg:

> >

> > P.S.: I have tested noapic, acpi=off, pci=noapic. But this doesn't fix

> > nothing.

>

> Can you do a "diff" between the dmesg output of a working kernel, and a

> nonworking one? Also, please do the same with /proc/interrupts...

>

> It sounds like your ethernet card is on irq11 (sharing it with USB), but

> that something has incorrectly decided that it must be somewhere else and

> then when the ethernet irq happens, it continually screams on irq11 until

> the kernel decides that it has to shut it up. At which point both ethernet

> and USB is dead (the former because it is on the wrong interrupt, the

> latter because the kernel had to shut up the irq that it was sharing in

> order to avoid endless irqs).

>

>               Linus



-- 

Luis Miguel García Mancebo

Universidad de Deusto / Deusto University

Spain 

