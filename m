Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266467AbUGUIeO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266467AbUGUIeO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jul 2004 04:34:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266476AbUGUIeO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jul 2004 04:34:14 -0400
Received: from tentacle.s2s.msu.ru ([193.232.119.109]:60549 "EHLO
	tentacle.sectorb.msk.ru") by vger.kernel.org with ESMTP
	id S266467AbUGUIeJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jul 2004 04:34:09 -0400
Date: Wed, 21 Jul 2004 12:34:06 +0400
From: "Vladimir B. Savkin" <master@sectorb.msk.ru>
To: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: r8169 in 2.6.7: transfer stops after few seconds
Message-ID: <20040721083406.GA5785@usr.lcm.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
X-Organization: Moscow State Univ., Dept. of Mechanics and Mathematics
X-Operating-System: Linux 2.4.26
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

My realtek-8169 based NIC doesn't work with 2.6.
Kernel versions tried: 2.6.7, 2.6.7-mm7.
Works OK with 2.4.26.

Symptoms: after few dozen packets, transfer stops,
both with TCP and with flood ping.
I can revive NIC by doing ifdown and ifup again.

The card is NetInfo NA-G32:

0000:00:0a.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8169 Gigabit Ethernet (rev 10)
        Subsystem: Realtek Semiconductor Co., Ltd. RTL-8169 Gigabit Ethernet
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (8000ns min, 16000ns max), Cache Line Size: 0x08 (32 bytes)
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at c800 [size=256]
        Region 1: Memory at efffbf00 (32-bit, non-prefetchable) [size=256]
        Expansion ROM at effd0000 [disabled] [size=64K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [60] Vital Product Data

I'm trying to use this NIC with AMD750-based motherboard (Gigabyte 7IXE4).

Is there any other info I can supply you with to debug this problem?

~
:wq
                                        With best regards, 
                                           Vladimir Savkin. 

