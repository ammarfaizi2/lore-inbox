Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272132AbRHVVr1>; Wed, 22 Aug 2001 17:47:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272133AbRHVVrH>; Wed, 22 Aug 2001 17:47:07 -0400
Received: from NET.WAU.NL ([137.224.10.12]:27921 "EHLO net.wau.nl")
	by vger.kernel.org with ESMTP id <S272132AbRHVVrF>;
	Wed, 22 Aug 2001 17:47:05 -0400
Date: Wed, 22 Aug 2001 23:47:20 +0200
From: Olivier Sessink <olivier@lx.student.wau.nl>
Subject: probable hardware bug: clock timer configuration lost - probably a
 VIA686a
To: linux-kernel@vger.kernel.org
Message-id: <20010822234720.A12692@fender.fakenet>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-disposition: inline
X-MSMail-priority: High
User-Agent: Mutt/1.2.5i
X-System-Uptime: 11:39pm  up 10 days,  1:59,  3 users,  load average: 0.47,
 0.33, 0.13
X-Reverse-Engineered: High priority for sending SMS messages
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I get a lot of these messages when the system is busy:

probable hardware bug: clock timer configuration lost - probably a VIA686a.
probable hardware bug: restoring chip configuration.
probable hardware bug: clock timer configuration lost - probably a VIA686a.
probable hardware bug: restoring chip configuration.

On: Linux version 2.2.19 (maurice@komodo) (gcc version 2.95.4 20010319
(Debian prerelease)) #3 Wed Aug 22 23:17:20 CEST 2001
Running Debian Potato (stable)

The system is a Intel Pentium 120
The motherboard is a Jetway 542C having the ALI 1542-m1543 aladdin-V chipset
(according to the manual)

This is from /proc/pci:
PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: Acer Labs Unknown device (rev 4).
      Vendor id=10b9. Device id=1541.
      Slow devsel.  Master Capable.  Latency=32.  
      Non-prefetchable 32 bit memory at 0xd0000000 [0xd0000000].
  Bus  0, device   1, function  0:
    PCI bridge: Acer Labs Unknown device (rev 4).
      Vendor id=10b9. Device id=5243.
      Slow devsel.  Master Capable.  Latency=32.  Min Gnt=6.
  Bus  0, device   7, function  0:
    ISA bridge: Acer Labs M1533 Aladdin IV (rev 195).
      Medium devsel.  Master Capable.  No bursts.  
  Bus  0, device   8, function  0:
    VGA compatible controller: ATI 210888GX (rev 1).
      Medium devsel.  IRQ 11.  
      Non-prefetchable 32 bit memory at 0xd5000000 [0xd5000000].
  Bus  0, device  15, function  0:
    IDE interface: Acer Labs M5229 TXpro (rev 194).
      Medium devsel.  Fast back-to-back capable.  Master Capable. 
Latency=32.  
Min Gnt=2.Max Lat=4.
      I/O at 0x2000 [0x2001].

The system further has 2 ISA etherworks3 network cards and that's about it.

Does anyone know what this means? Can I provide useful information (please
tell me how). The system once crashed under heavy load. Memtest86 sais the
memory is OK, so I'm a bit worried the error has something to do with it.

regards,
	Olivier
