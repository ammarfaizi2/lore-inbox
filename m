Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262652AbSI1DH6>; Fri, 27 Sep 2002 23:07:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262689AbSI1DH5>; Fri, 27 Sep 2002 23:07:57 -0400
Received: from dhcp101-dsl-usw4.w-link.net ([208.161.125.101]:1675 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S262652AbSI1DH5>;
	Fri, 27 Sep 2002 23:07:57 -0400
Message-ID: <3D951E46.5070402@candelatech.com>
Date: Fri, 27 Sep 2002 20:13:10 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jes Sorensen <jes@trained-monkey.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: can't run two acenics in the same machine??
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since the e1000 keeps scribbling over my memory (it appears), I tried
to tie-break with two NetGear GA 620 nics.

Well, it only finds one!!

In the meantime, I hear that tigonIII is a reasonably good performer.
Anyone suggest a NIC based on this chipset that is well supported?

 From dmesg:

acenic.c: v0.92 08/05/2002  Jes Sorensen, linux-acenic@SunSITE.dk
                             http://home.cern.ch/~jes/gige/acenic.html
eth2: NetGear GA620 Gigabit Ethernet at 0xf4000000, irq 10
   Tigon II (Rev. 6), Firmware: 12.4.11, MAC: 00:a0:cc:73:37:3a
   PCI bus width: 64 bits, speed: 66MHz, latency: 64 clks
   Disabling PCI memory write and invalidate
eth2: Firmware NOT running!
eth2: NetGear GA620 Gigabit Ethernet at 0xf4004000, irq 9
   Tigon II (Rev. 6), Firmware: 12.4.11, MAC: 00:a0:cc:73:35:d6
   PCI bus width: 64 bits, speed: 66MHz, latency: 64 clks
   Disabling PCI memory write and invalidate
eth2: Firmware up and running

from lspci -v:


00:08.0 Ethernet controller: Netgear GA620 (rev 01)
         Subsystem: Netgear: Unknown device 0001
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 64 (16000ns min), cache line size 10
         Interrupt: pin A routed to IRQ 10
         Region 0: Memory at f4000000 (32-bit, non-prefetchable) [size=16K]

00:09.0 Ethernet controller: Netgear GA620 (rev 01)
         Subsystem: Netgear: Unknown device 0001
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 64 (16000ns min), cache line size 10
         Interrupt: pin A routed to IRQ 9
         Region 0: Memory at f4004000 (32-bit, non-prefetchable) [size=16K]


Any ideas?

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


