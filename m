Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133025AbRDRFun>; Wed, 18 Apr 2001 01:50:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133027AbRDRFue>; Wed, 18 Apr 2001 01:50:34 -0400
Received: from relay2.scripps.edu ([137.131.200.30]:20438 "EHLO
	relay2.scripps.edu") by vger.kernel.org with ESMTP
	id <S133025AbRDRFuU>; Wed, 18 Apr 2001 01:50:20 -0400
Date: Tue, 17 Apr 2001 22:47:09 -0700 (PDT)
From: Andy Arvai <arvai@scripps.edu>
Message-Id: <200104180547.WAA25629@astra.scripps.edu>
To: linux-smp@vger.kernel.org
Subject: pirq boot parameter for tyan S2520
Cc: linux-kernel@vger.kernel.org
X-Sun-Charset: US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I have a Tyan S2520 motherboard and I am getting IO-APIC errors. I
looked in the documentation in IO-APIC.txt and there was the following
one-liner:

	echo -n pirq=; echo `scanpci | grep T_L | cut -c56-` | sed 's/ /,/g'

Unfortunately, this doesn't work for me. There is no "T_L" in the
output of scanpci for me. Any idea's would be greatly appreciated.
Below is the output of scanpci on my system. Thanks for any help.

Andy
arvai@scripps.edu



PCI says configuration type 1

PCI probing configuration type 1

Probing for devices on PCI bus 0:

pci bus 0x0 cardnum 0x00 function 0x0000: vendor 0x8086 device 0x1a21
 Intel  Device unknown

pci bus 0x0 cardnum 0x01 function 0x0000: vendor 0x8086 device 0x1a23
 Intel  Device unknown

pci bus 0x0 cardnum 0x02 function 0x0000: vendor 0x8086 device 0x1a24
 Intel  Device unknown

pci bus 0x0 cardnum 0x1e function 0x0000: vendor 0x8086 device 0x244e
 Intel  Device unknown

pci bus 0x0 cardnum 0x1f function 0x0000: vendor 0x8086 device 0x2440
 Intel  Device unknown

pci bus 0x0 cardnum 0x1f function 0x0001: vendor 0x8086 device 0x244b
 Intel  Device unknown

Probing for devices on PCI bus 1:

Probing for devices on PCI bus 2:

pci bus 0x2 cardnum 0x1f function 0x0000: vendor 0x8086 device 0x1360
 Intel  Device unknown

Probing for devices on PCI bus 3:

pci bus 0x1 cardnum 0x08 function 0x0000: vendor 0x8086 device 0x2449
 Intel  Device unknown

pci bus 0x1 cardnum 0x0b function 0x0000: vendor 0x1002 device 0x4752
 ATI Mach64 GR

pci bus 0x1 cardnum 0x0d function 0x0000: vendor 0x8086 device 0x1229
 Intel 82557/8 10/100MBit network controller

Probing for devices on PCI bus 4:

pci bus 0x3 cardnum 0x00 function 0x0000: vendor 0x8086 device 0x1161
 Intel  Device unknown

pci bus 0x3 cardnum 0x04 function 0x0000: vendor 0x9005 device 0x00c0
 Adaptec  Device unknown

pci bus 0x3 cardnum 0x04 function 0x0001: vendor 0x9005 device 0x00c0
 Adaptec  Device unknown

pci bus 0x3 cardnum 0x05 function 0x0000: vendor 0x8086 device 0x1004
 Intel  Device unknown

pci bus 0x3 cardnum 0x07 function 0x0000: vendor 0x9005 device 0x00c0
 Adaptec  Device unknown

pci bus 0x3 cardnum 0x07 function 0x0001: vendor 0x9005 device 0x00c0
 Adaptec  Device unknown
