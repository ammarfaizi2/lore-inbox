Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271957AbRHVIER>; Wed, 22 Aug 2001 04:04:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271956AbRHVIEF>; Wed, 22 Aug 2001 04:04:05 -0400
Received: from web9307.mail.yahoo.com ([216.136.129.56]:44298 "HELO
	web9307.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S271955AbRHVID5>; Wed, 22 Aug 2001 04:03:57 -0400
Message-ID: <20010822080412.33733.qmail@web9307.mail.yahoo.com>
Date: Wed, 22 Aug 2001 01:04:12 -0700 (PDT)
From: John paul R <jpr200012@yahoo.com>
Subject: dell inspiron 8000 eepro100 problems
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1747890810-998467452=:33499"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0-1747890810-998467452=:33499
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

i'm using 2.4.9 and have had a problem since 2.2
kernels along with all versions of 2.4. i am having a
problem with 2 laptops, both are dell inspiron 8000
that have intel 82557 mini-pci nic in them. i get no
errors from the kernel but i lose most of my
connection after some use. it is very hard to describe
how to reproduce the problem because it happens some
times after a minute of starting up the computer or
sometimes it may take 10 hours to start. what happens
is i lose my ability to connect to anything whether it
be telnet, web browsing, ssh, etc. but i can still
ping sites by ip address. if i am plugged in behind my
router i can ping and connect to other boxes on my
network (i've been browsing through a proxy on one of
them while trying to figure out what the problem is).
i have tried compiling the driver into the kernel and
as a module, i've tried mandrake 7.0, mandrake 8.0,
and now redhat 7.1 and still have the same problem. i
have also tried replacing the router and cable. when
the problem starts i've tried unloading the module and
bringing the network back up and still no luck. i've
tried plugging the computer straight into the cable
modem and it doesn't work and tried unplugging a
computer that is working and plugging it into this one
and it will not work. i've tried using static ip's and
dhcp. i've also tried forcing the nic to 10mbps and
100mbps. i've tried with it forced to half-duplex and
full duplex. the only thing that fixes the problem is
by rebooting the computer and immediatly works again.
i have talked to a few other people on the dell linux
laptop group and they are having this same problem
(not all of them).

output from dmesg:
eepro100.c:v1.09j-t 9/29/99 Donald Becker
http://cesdis.gsfc.nasa.gov/linux/drivers/eepro100.html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by
Andrey V. Savochkin <saw@saw.sw.com.sg> and others
  Receiver lock-up bug exists -- enabling work-around.
  Board assembly 727095-002, Physical connectors
present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x04f4518b).
  Receiver lock-up workaround activated.

output from lspci -vv:
08:04.0 Ethernet controller: Intel Corporation 82557
[Ethernet Pro 100] (rev 08)        Subsystem: Action
Tec Electronics Inc: Unknown device 1100
        Control: I/O+ Mem+ BusMaster+ SpecCycle-
MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2000ns min, 14000ns max), cache
line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at f8fff000 (32-bit,
non-prefetchable) [size=4K]
        Region 1: I/O ports at ecc0 [size=64]
        Region 2: Memory at f8e00000 (32-bit,
non-prefetchable) [size=1M]
        Expansion ROM at f9000000 [disabled] [size=1M]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+
AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=2
PME-

any ideas?

p.s. i tried with intel's own e100 module and i get
the same problem - maybe it is just the hardware?

__________________________________________________
Do You Yahoo!?
Make international calls for as low as $.04/minute with Yahoo! Messenger
http://phonecard.yahoo.com/
--0-1747890810-998467452=:33499--
