Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272386AbTHKGeJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 02:34:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272411AbTHKGeJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 02:34:09 -0400
Received: from adsl-216-102-91-59.dsl.snfc21.pacbell.net ([216.102.91.59]:52996
	"EHLO nasledov.com") by vger.kernel.org with ESMTP id S272386AbTHKGeA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 02:34:00 -0400
Date: Sun, 10 Aug 2003 23:34:03 -0700
To: Daniela Engert <dani@ngrt.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: VIA Serial ATA chipset
Message-ID: <20030811063403.GA11723@nasledov.com>
References: <20030811060634.GA10852@nasledov.com> <20030811062839.76F9216F24@mail.medav.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030811062839.76F9216F24@mail.medav.de>
User-Agent: Mutt/1.5.4i
From: Misha Nasledov <misha@nasledov.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 11, 2003 at 08:29:07AM +0200, Daniela Engert wrote:
> Thanks. I'm sorry, my fault. It should have read "lspci -s 0:f.0
> -vvxxx" as root. This will show the full 256 bytes PCI config space.

00:0f.0 RAID bus controller: VIA Technologies, Inc.: Unknown device
3149 (rev 80)
        Subsystem: VIA Technologies, Inc.: Unknown device 3149
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Step                         
ping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort                         
- <MAbort- >SERR- <PERR-
        Latency: 32
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at 8800 [size=8]
        Region 1: I/O ports at 8400 [size=4]
        Region 2: I/O ports at 8000 [size=8]
        Region 3: I/O ports at 7800 [size=4]
        Region 4: I/O ports at 7400 [size=16]
        Region 5: I/O ports at 7000 [size=256]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot                         
-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 06 11 49 31 07 00 90 02 80 00 04 01 00 20 80 00
10: 01 88 00 00 01 84 00 00 01 80 00 00 01 78 00 00
20: 01 74 00 00 01 70 00 00 00 00 00 00 06 11 49 31
30: 00 00 00 00 c0 00 00 00 00 00 00 00 0b 01 00 00
40: 13 03 f1 44 0e af 00 00 00 82 65 03 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 10 10 00 05 00 30 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 01 00 01 00 11 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 01 00 02 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 80 01 49 31 06 11 49 31 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

-- 
Misha Nasledov
misha@nasledov.com
http://nasledov.com/misha/
