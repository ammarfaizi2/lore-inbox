Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935962AbWK1Rjb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935962AbWK1Rjb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 12:39:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935963AbWK1Rjb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 12:39:31 -0500
Received: from smtp-01.mandic.com.br ([200.225.81.132]:20145 "EHLO
	smtp-01.mandic.com.br") by vger.kernel.org with ESMTP
	id S935962AbWK1Rja (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 12:39:30 -0500
Message-ID: <456C744D.3080901@mandic.com.br>
Date: Tue, 28 Nov 2006 15:39:25 -0200
From: "Renato S. Yamane" <renatoyamane@mandic.com.br>
User-Agent: Thunderbird 1.5.0.8 (X11/20060911)
MIME-Version: 1.0
To: Jesper Juhl <jesper.juhl@gmail.com>
CC: =?ISO-8859-1?Q?Hanno_B=F6ck?= <mail@hboeck.de>,
       linux-kernel@vger.kernel.org
Subject: Re: kernel: Please report the result to linux-kernel to fix this
 permanently
References: <200611271242.59642.mail@hboeck.de> <9a8748490611270400t1ac8e1eesed9be5a0d308e829@mail.gmail.com>
In-Reply-To: <9a8748490611270400t1ac8e1eesed9be5a0d308e829@mail.gmail.com>
X-Enigmail-Version: 0.94.1.0
OpenPGP: id=D420515A;
	url=http://pgp.mit.edu
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Jesper Juhl escreveu:
>> Oct  7 18:25:00 laverne kernel: PCI: Bus #04 (-#07) is hidden behind
>> transparent bridge #02 (-#04) (try 'pci=assign-busses')
>> Oct  7 18:25:00 laverne kernel: Please report the result to
>> linux-kernel to
>> fix this permanently
> 
> And what are the results when you use "pci=assign-busses" as your
> kernel asks you to do ?

I have the same error message with Kernel 2.6.18.3, shown to report
this, but when I use this option (pci=assign-busses), my laptop Toshiba
M45-S355 don't turn-off monitor when idle:

kernel: PCI: PCI BIOS revision 2.10 entry at 0xea7d4, last bus=5
kernel: PCI: Using configuration type 1
kernel: Setting up standard PCI resources
kernel: ACPI: Interpreter enabled
kernel: ACPI: Using PIC for interrupt routing
kernel: ACPI: PCI Root Bridge [PCI0] (0000:00)
kernel: PCI: Probing PCI hardware (bus 00)
kernel: Boot video device is 0000:00:02.0
kernel: PCI quirk: region 1000-107f claimed by ICH6 ACPI/GPIO/TCO
kernel: PCI quirk: region 1300-133f claimed by ICH6 GPIO
kernel: PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.2
kernel: PCI: Transparent bridge - 0000:00:1e.0
kernel: PCI: Bus #06 (-#09) is hidden behind transparent bridge #05
(-#05) (try 'pci=assign-busses')
kernel: Please report the result to linux-kernel to fix this permanently
kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP01._PRT]
kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP02._PRT]
kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIB._PRT]
kernel: ACPI: PCI Interrupt Link [LNKA] (IRQs 5 *11)
kernel: ACPI: PCI Interrupt Link [LNKB] (IRQs 5 *10 11)
SuSEfirewall2: Warning: ip6tables does not support state matching.
Extended IPv6 support disabled.
kernel: ACPI: PCI Interrupt Link [LNKC] (IRQs 5 *11)
SuSEfirewall2: Setting up rules from /etc/sysconfig/SuSEfirewall2 ...
kernel: ACPI: PCI Interrupt Link [LNKD] (IRQs 5 10 *11)
kernel: ACPI: PCI Interrupt Link [LNKE] (IRQs *5 11)
kernel: ACPI: PCI Interrupt Link [LNKF] (IRQs 5 10) *0, disabled.
kernel: ACPI: PCI Interrupt Link [LNKG] (IRQs 6) *11
kernel: ACPI: PCI Interrupt Link [LNKH] (IRQs 5 10) *11
kernel: ACPI: Embedded Controller [EC0] (gpe 16) interrupt mode.
kernel: ACPI: Power Resource [PFA1] (off)
kernel: Linux Plug and Play Support v0.97 (c) Adam Belay

Best regards,
- --
Renato S. Yamane
Fingerprint: 68AE A381 938A F4B9 8A23  D11A E351 5030 D420 515A
PGP Server: http://pgp.mit.edu/ --> KeyID: 0xD420515A
<http://www.renatoyamane.com>
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFFbHRN41FQMNQgUVoRAtawAJ4l0MQr8wHxchN0JVPFAgp+aQPl8wCeIfm+
OSfpO77HKw5Z3UfRK1KdZfI=
=JXEi
-----END PGP SIGNATURE-----
