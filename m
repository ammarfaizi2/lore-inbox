Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130696AbQLFL5P>; Wed, 6 Dec 2000 06:57:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130816AbQLFL5F>; Wed, 6 Dec 2000 06:57:05 -0500
Received: from inet-smtp3.oracle.com ([205.227.43.23]:14741 "EHLO
	inet-smtp3.oracle.com") by vger.kernel.org with ESMTP
	id <S130696AbQLFL44>; Wed, 6 Dec 2000 06:56:56 -0500
Message-ID: <3A2E224E.B96CF48E@oracle.com>
Date: Wed, 06 Dec 2000 12:26:06 +0100
From: Alessandro Suardi <alessandro.suardi@oracle.com>
Organization: Oracle Support Services
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test12-pre6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.0-t12pre6: PCI IRQ messages [PCMCIA]
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Everything seems to work, though. Didn't happen in t12pre5.

 Excerpt from dmesg:

Linux PCMCIA Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
PCI: Found IRQ 11 for device 00:03.0
PCI: The same IRQ used for device 00:03.1
PCI: The same IRQ used for device 00:07.2
PCI: Found IRQ 11 for device 00:03.1
PCI: The same IRQ used for device 00:03.0
PCI: The same IRQ used for device 00:07.2
Yenta IRQ list 0618, PCI irq11
Socket status: 30000020
Yenta IRQ list 0618, PCI irq11
Socket status: 30000006
cs: cb_alloc(bus 5): vendor 0x115d, device 0x0003
  got res[1800:187f] for resource 0 of PCI device 115d:0003
  got res[11000000:110007ff] for resource 1 of PCI device 115d:0003
  got res[11000800:11000fff] for resource 2 of PCI device 115d:0003
  got res[10c00000:10c03fff] for resource 6 of PCI device 115d:0003
PCI: Enabling device 05:00.0 (0000 -> 0003)
IRQ routing conflict in pirq table! Try 'pci=autoirq'
  got res[1880:1887] for resource 0 of PCI device 115d:0103
  got res[11001000:110017ff] for resource 1 of PCI device 115d:0103
  got res[11001800:11001fff] for resource 2 of PCI device 115d:0103
  got res[10c04000:10c07fff] for resource 6 of PCI device 115d:0103
PCI: Enabling device 05:00.1 (0000 -> 0003)
IRQ routing conflict in pirq table! Try 'pci=autoirq'
tulip_attach(05:00.0)
PCI: Found IRQ 11 for device 05:00.0
PCI: The same IRQ used for device 00:03.0
PCI: The same IRQ used for device 00:03.1
PCI: The same IRQ used for device 00:07.2
PCI: The same IRQ used for device 05:00.1
PCI: Setting latency timer of device 05:00.0 to 64
xircom_tulip_cb.c:v0.91 4/14/99 becker@cesdis.gsfc.nasa.gov (modified by danilo@cs.uni-magdeburg.de for XIRCOM CBE, fixed by Doug Ledford)
eth0: Xircom Cardbus Adapter (DEC 21143 compatible mode) rev 3 at 0x1800, 00:10:A4:F9:19:A0, IRQ 11.
eth0:  MII transceiver #0 config 3100 status 7809 advertising 01e1.
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0800-0x08ff: clean.
cs: IO port probe 0x0100-0x04ff: excluding 0x210-0x217 0x290-0x297 0x378-0x37f 0x388-0x38f 0x4d0-0x4d7
cs: IO port probe 0x0a00-0x0aff: clean.
PCI: Found IRQ 11 for device 05:00.1
PCI: The same IRQ used for device 00:03.0
PCI: The same IRQ used for device 00:03.1
PCI: The same IRQ used for device 00:07.2
PCI: The same IRQ used for device 05:00.0



This is a Dell Latitude CPi D300XT with a:

PCI: Using IRQ router PIIX [8086/7110] at 00:07.0
  got res[10000000:10000fff] for resource 0 of Texas Instruments PCI1131
  got res[10001000:10001fff] for resource 0 of Texas Instruments PCI1131 (#2)


Thanks & ciao,
-- 
--alessandro      <alessandro.suardi@oracle.com> <asuardi@uninetcom.it>

Linux:  kernel 2.2.18p24/2.4.0-t12p6 glibc-2.2 gcc-2.95.2 binutils-2.10.1.0.2
Oracle: Oracle8i 8.1.7.0.0 Enterprise Edition for Linux
motto:  Tell the truth, there's less to remember.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
