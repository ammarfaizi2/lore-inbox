Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132520AbRDUUvK>; Sat, 21 Apr 2001 16:51:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132514AbRDUUuv>; Sat, 21 Apr 2001 16:50:51 -0400
Received: from romulus.cs.ut.ee ([193.40.5.125]:44730 "EHLO romulus.cs.ut.ee")
	by vger.kernel.org with ESMTP id <S132503AbRDUUug>;
	Sat, 21 Apr 2001 16:50:36 -0400
Date: Sat, 21 Apr 2001 22:50:32 +0200 (EET)
From: Meelis Roos <mroos@linux.ee>
To: <linux-kernel@vger.kernel.org>
Subject: RTL8139 problem with 2.4.4-pre5
Message-ID: <Pine.GSO.4.32.0104212246260.29571-100000@romulus.cs.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have used this card since september with no problems on my DSL link.
Now after  upgrading to 2.2.4-pr5 I got the following messages. This may
also be a DSL problem so if this is only trouble report then just ignore
it. However, here it is:

NETDEV WATCHDOG: eth0: transmit timed out
eth0: Tx queue start entry 9358  dirty entry 9354.
eth0:  Tx descriptor 0 is 00002000.
eth0:  Tx descriptor 1 is 00002000.
eth0:  Tx descriptor 2 is 00002000. (queue head)
eth0:  Tx descriptor 3 is 00002000.
eth0: Setting half-duplex based on auto-negotiated partner ability 0000.

The bootup messages:
8139too Fast Ethernet driver 0.9.16
PCI: Found IRQ 11 for device 00:09.0
eth0: RealTek RTL8139 Fast Ethernet at 0xc8842000, 00:c0:df:04:7f:9b, IRQ 11
eth0:  Identified 8139 chip type 'RTL-8139B'

lspci output:
00:09.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev 10)
        Subsystem: Realtek Semiconductor Co., Ltd. RT8139
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 min, 64 max, 32 set
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at e800 [size=256]
        Region 1: Memory at d9000000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- AuxPwr- DSI- D1+ D2+ PME-
                Status: D0 PME-Enable+ DSel=0 DScale=0 PME-

---
Meelis Roos (mroos@linux.ee)

