Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262926AbREWAec>; Tue, 22 May 2001 20:34:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262934AbREWAeW>; Tue, 22 May 2001 20:34:22 -0400
Received: from mta6-rme.xtra.co.nz ([203.96.92.19]:47879 "EHLO
	mta6-rme.xtra.co.nz") by vger.kernel.org with ESMTP
	id <S262926AbREWAeO>; Tue, 22 May 2001 20:34:14 -0400
Message-ID: <005901c0e31f$fa89cc80$2bfefe0a@dyatron.co.nz>
From: "John at Dyatron" <jd@dyatron.co.nz>
To: <linux-kernel@vger.kernel.org>
Subject: 2.4.4 -  I2O printer port weirdness
Date: Wed, 23 May 2001 12:33:24 +1200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What is wrong with this picture ?

I2O Printer port detects , then
0x378 detects too
but both are parport0 ?

Intel 815 M Board
PIII 800
265mb ram
Parallel Port is a
  Bus  1, device   9, function  0:
    Network controller: PLX Technology, Inc. PCI <-> IOBus Bridge (rev 1).
      IRQ 9.
      Non-prefetchable 32 bit memory at 0xff8ff400 [0xff8ff47f].
      I/O at 0xdc00 [0xdc7f].
      I/O at 0xdff0 [0xdff7].
.....
Linux version 2.4.4 (root@strawberry) (gcc version egcs-2.91.66
19990314/Linux (egcs-1.1.2 release)) #7 Wed May 23 11:48:34 NZST 2001
......
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfda95, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Using IRQ router PIIX [8086/2440] at 00:1f.0
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.14)
Starting kswapd v1.8
Winbond Super-IO detection, now testing ports 3F0,370,250,4E,2E ...
SMSC Super-IO detection, now testing Ports 2F0, 370 ...
parport0: PC-style at 0x378 [PCSPP,TRISTATE,EPP]
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
i2c-core.o: i2c core module
i2c-dev.o: i2c /dev entries driver module
i2c-core.o: driver i2c-dev dummy driver registered.
i2c-algo-bit.o: i2c bit algorithm module
i2c-philips-par.o: i2c Philips parallel port adapter module
i2c-philips-par.o: attaching to parport0
i2c-dev.o: Registered 'Philips Parallel port adapter' as minor 0
i2c-core.o: adapter Philips Parallel port adapter registered as adapter 0.
pty: 256 Unix98 ptys configured
parport0: no more devices allowed
lp: driver loaded but no devices found
block: queued sectors max/low 168674kB/56224kB, 512 slots per queue
Uniform Multi-Platform E-IDE driver Revision: 6.31


--
John Duthie <john@dyatron.co.nz>
Dyatron Systems
1 Rankin Ave                       P.O. BOX 15001
New Lynn                           New Lynn
Auckland.                          Auckland.
Phone:  +64 9 8260030
Fax:    +64 9 8260047




