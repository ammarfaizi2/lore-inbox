Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318026AbSHaVqJ>; Sat, 31 Aug 2002 17:46:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318027AbSHaVqJ>; Sat, 31 Aug 2002 17:46:09 -0400
Received: from ids.big.univali.br ([200.169.51.11]:32385 "EHLO
	mail.big.univali.br") by vger.kernel.org with ESMTP
	id <S318026AbSHaVqJ>; Sat, 31 Aug 2002 17:46:09 -0400
Date: Sat, 31 Aug 2002 18:50:30 -0300 (EST)
From: Marcus Grando <marcus@big.univali.br>
To: linux-kernel@vger.kernel.org
Subject: e100 auto-negociation 2.1.15-k1
Message-ID: <Pine.LNX.4.44.0208311844590.1461-100000@ids.big.univali.br>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi list,

On boot kernel 2.4.20-pre5, Intel driver not show auto negociation
Before this version auto negociation running ok.

Intel(R) PRO/100 Network Driver - version 2.1.15-k1
Copyright (c) 2002 Intel Corporation

e100: eth0: Intel(R) 8255x-based Ethernet Adapter
  Mem:0xfecff000  IRQ:16  Speed:0 Mbps  Dx:N/A
  Failed to detect cable link
  Speed and duplex will be determined at time of connection
  Hardware receive checksums enabled
  cpu cycle saver enabled

lspci -vvv
00:08.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100]
(rev 08)
        Subsystem: Hewlett-Packard Company: Unknown device 10cb
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr+ Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 66 (2000ns min, 14000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 16
        Region 0: Memory at fecff000 (32-bit, non-prefetchable) [size=4K]
        Region 1: I/O ports at fcc0 [size=64]
        Region 2: Memory at fed00000 (32-bit, non-prefetchable) [size=1M]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-


Regards

--
Marcus Grando
<marcus at big dot univali dot br>
<marcus at sbh dot eng dot br>

