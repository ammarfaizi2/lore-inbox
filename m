Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263164AbUDZSwK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263164AbUDZSwK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 14:52:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263191AbUDZSwK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 14:52:10 -0400
Received: from mail03.agrinet.ch ([81.221.250.52]:50948 "EHLO
	mail03.agrinet.ch") by vger.kernel.org with ESMTP id S263164AbUDZSwG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 14:52:06 -0400
Date: Mon, 26 Apr 2004 20:52:03 +0200
From: Andreas Tscharner <starfire@dplanet.ch>
To: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: ACPI problems with 2.4.26 and Toshiba
Message-Id: <20040426205203.480404c9@akasha.yshara.ch>
Organization: No Such Penguin
X-Mailer: Sylpheed version 0.9.10claws (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello World,

Since kernel 2.4.21 (or so), ACPI is recognised on my Toshiba Satellite.
Now with kernel 2.4.26, I've read the following lines in dmesg:

ACPI: Subsystem revision 20040326
PCI: PCI BIOS revision 2.10 entry at 0xfd49f, last bus=5
PCI: Using configuration type 1
ACPI: IRQ9 SCI: Level Trigger.
    ACPI-1133: *** Error: Method execution failed
[\_SB_.PCI0.PCIB.MPC0._PRW] ($    ACPI-0154: *** Error: Method execution
failed [\_SB_.PCI0.PCIB.MPC0._PRW] ($ ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: System [ACPI] (supports S0 S3 S4 S5)
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 *11)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *11)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 *11)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 *11)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 *11)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 *11)
ACPI: PCI Interrupt Link [LNKG] (IRQs *10)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 *11)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 00:1f.1
Transparent bridge - Intel Corp. 82801BA/CA/DB/EB PCI Bridge
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIB._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
ACPI: Power Resource [PFAN] (off)
PCI: Probing PCI hardware
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
...
...


I haven't had this error with kernel 2.4.25. Is this a known problem? If
there is a need for further information I'd like to help.

Best regards
	Andreas
-- 
Andreas Tscharner                                  starfire@dplanet.ch
----------------------------------------------------------------------
"Programming today is a race between software engineers striving to
build bigger and better idiot-proof programs, and the Universe trying
to produce bigger and better idiots. So far, the Universe is winning."
                                                          -- Rich Cook 
