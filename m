Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265042AbUGGKPy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265042AbUGGKPy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 06:15:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265043AbUGGKPy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 06:15:54 -0400
Received: from [194.243.27.136] ([194.243.27.136]:6670 "HELO
	venere.pandoraonline.it") by vger.kernel.org with SMTP
	id S265042AbUGGKP3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 06:15:29 -0400
X-Qmail-Scanner-Mail-From: devel@integra-sc.it via venere.pandoraonline.it
X-Qmail-Scanner-Rcpt-To: fabian.frederick@skynet.be,linux-kernel@vger.kernel.org
X-Qmail-Scanner: 1.22 (Clear:RC:1(213.140.22.76):. Processed in 0.095023 secs)
Date: Wed, 7 Jul 2004 12:19:54 +0200
From: Devel <devel@integra-sc.it>
To: FabF <fabian.frederick@skynet.be>
Cc: linux-kernel@vger.kernel.org
Subject: Re: swap_dup: Bad swap file entry 76747774 with kernel
 2.4.26+patch_kraxel-2.4.26
Message-Id: <20040707121954.19752b00.devel@integra-sc.it>
In-Reply-To: <1089193857.3692.8.camel@localhost.localdomain>
References: <20040707111225.49607c54.devel@integra-sc.it>
	<1089193857.3692.8.camel@localhost.localdomain>
Organization: Integra Solutions
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Its a singol processor (AMD Athlon(tm) XP 2400+) linux box with with a 512 MB swap partition  and 1GB of RAM.

Il Wed, 07 Jul 2004 11:50:57 +0200
FabF <fabian.frederick@skynet.be> scrisse:

> Hi :)
> 
> 	SMP box I guess ? Are you using swap files or a dedicated swap
> partition ?
> 
> Regards,
> FabF
> 
> On Wed, 2004-07-07 at 11:12, Devel wrote:
> > Hi all,
> > on my linux box RedHat 7.3 with kernel 2.4.26+patch_kraxel-2.4.26 on havy load on acquisition from 12 device videograbber i have this error: swap_dup: Bad swap file entry 76747774 with kernel 2.4.26+patch_kraxel-2.4.26
> > After all the system become instable. Any ideas or suggest to avoid this problem?
> > 
> > ps: in bottom thereis the output of dmesg and lspci -v
> > 
> > Jul  6 18:10:35 machine kernel: swap_dup: Bad swap file entry 76747774
> > Jul  6 18:10:41 machine last message repeated 129 times
> > 
> > Jul  6 18:10:41 machine kernel: Unable to handle kernel paging request at virtual address 23232673
> > Jul  6 18:10:41 machine kernel:  printing eip:
> > Jul  6 18:10:41 machine kernel: f8a54954
> > Jul  6 18:10:41 machine kernel: *pde = 00000000
> > Jul  6 18:10:41 machine kernel: Oops: 0000
> > Jul  6 18:10:41 machine kernel: CPU:    0
> > Jul  6 18:10:41 machine kernel: EIP:    0010:[<f8a54954>]    Not tainted
> > Jul  6 18:10:41 machine kernel: EFLAGS: 00010297
> > Jul  6 18:10:41 machine kernel: eax: 23232323   ebx: f4e3bee8   ecx: 23232323   edx: 08072a04
> > Jul  6 18:10:41 machine kernel: esi: 40307603   edi: f4e3bee8   ebp: f4ade000   esp: f4e3bc74
> > Jul  6 18:10:41 machine kernel: ds: 0018   es: 0018   ss: 0018
> > Jul  6 18:10:41 machine kernel: Process grabber (pid: 727, stackpage=f4e3b000)
> > Jul  6 18:10:41 machine kernel: Stack: f7498f00 c0278500 f7498f00 23232323 c0109d08 00000047 c0109d2c 0000000b
> > Jul  6 18:10:41 machine kernel:        f7498f00 f23577e4 c028806f f7498f00 c010c008 f6ad5878 00000001 f6b18800
> > Jul  6 18:10:41 machine kernel:        f779da80 00000000 f7498f00 f6b18800 f6ad7878 f779da80 f7498f00 f7498f00
> > Jul  6 18:10:41 machine kernel: Call Trace:    [<c0278500>] [<c0109d08>] [<c0109d2c>] [<c028806f>] [<c010c008>]
> > Jul  6 18:10:41 machine kernel:   [<c02883f3>] [<c01ad56d>] [<c029c3bd>] [<c02975e9>] [<c0293223>] [<c0298031>]
> > Jul  6 18:10:41 machine kernel:   [<c0295659>] [<c0274d05>] [<c0295a3a>] [<c0275c65>] [<c029d059>] [<c029cfae>]
> > Jul  6 18:10:41 machine kernel:   [<c029d504>] [<c012006d>] [<c0109b99>] [<c02859bf>] [<f8a434e4>] [<f8a6b008>]
> > Jul  6 18:10:41 machine kernel:   [<c0278b2d>] [<c011bd91>] [<f8a55c5c>] [<f8a548a0>] [<c0142e46>] [<c01087d3>]
> > Jul  6 18:10:41 machine kernel:
> > Jul  6 18:10:41 machine kernel: Code: 8b 81 50 03 00 00 85 c0 74 07 51 e8 4c e2 ff ff 5f 81 fe 03
> > Jul  6 18:10:41 machine kernel:  <1>Unable to handle kernel paging request at virtual address 23232323
> > Jul  6 18:10:41 machine kernel:  printing eip:
> > Jul  6 18:10:41 machine kernel: f8a5b9d0
> > Jul  6 18:10:41 machine kernel: *pde = 00000000
> > Jul  6 18:10:41 machine kernel: Oops: 0000
> > Jul  6 18:10:41 machine kernel: CPU:    0
> > Jul  6 18:10:41 machine kernel: EIP:    0010:[<f8a5b9d0>]    Not tainted
> > Jul  6 18:10:41 machine kernel: EFLAGS: 00010286
> > Jul  6 18:10:41 machine kernel: eax: 00000000   ebx: f3df55e4   ecx: f3df562c   edx: f4e3bab0
> > Jul  6 18:10:41 machine kernel: esi: f3df55c0   edi: 23232323   ebp: f53ad0c0   esp: f4e3bad0
> > Jul  6 18:10:41 machine kernel: ds: 0018   es: 0018   ss: 0018
> > Jul  6 18:10:41 machine kernel: Process grabber (pid: 727, stackpage=f4e3b000)
> > Jul  6 18:10:41 machine kernel: Stack: f3df55e4 f3df55c0 00000000 00000000 f573a400 00000020 0000001f f8a4d94c
> > Jul  6 18:10:41 machine kernel:        23232323 f3df55c0 f53ad0c0 01040000 f630d540 4032a000 c012790f f53ad0c0
> > Jul  6 18:10:41 machine kernel:        f53addc0 f6fe3f64 00000046 f4e3bb3c 00000086 f630d540 f8a54954 f4e3a000
> > Jul  6 18:10:41 machine kernel: Call Trace:    [<f8a4d94c>] [<c012790f>] [<f8a54954>] [<c011737a>] [<c011b6ca>]
> > Jul  6 18:10:41 machine kernel:   [<c011505e>] [<c0108d9c>] [<f8a54954>] [<c01153e8>] [<c0115070>] [<c01088c4>]
> > Jul  6 18:10:41 machine kernel:   [<f8a54954>] [<c0278500>] [<c0109d08>] [<c0109d2c>] [<c028806f>] [<c010c008>]
> > Jul  6 18:10:41 machine kernel:   [<c02883f3>] [<c01ad56d>] [<c029c3bd>] [<c02975e9>] [<c0293223>] [<c0298031>]
> > Jul  6 18:10:41 machine kernel:   [<c0295659>] [<c0274d05>] [<c0295a3a>] [<c0275c65>] [<c029d059>] [<c029cfae>]
> > Jul  6 18:10:41 machine kernel:   [<c029d504>] [<c012006d>] [<c0109b99>] [<c02859bf>] [<f8a434e4>] [<f8a6b008>]
> > Jul  6 18:10:41 machine kernel:   [<c0278b2d>] [<c011bd91>] [<f8a55c5c>] [<f8a548a0>] [<c0142e46>] [<c01087d3>]
> > Jul  6 18:10:41 machine kernel:
> > Jul  6 18:10:41 machine kernel: Code: ff 37 e8 39 0c ff ff 53 e8 a3 0c ff ff 8d 86 b4 00 00 00 50
> > Jul  6 18:10:41 machine kernel:  <3>swap_dup: Bad swap file entry 76747774
> > Jul  6 18:10:41 machine kernel: swap_dup: Bad swap file entry 76747774
> > Jul  6 18:10:44 machine last message repeated 53 times
> > 
> > 
> > lspci -vv
> > 
> > 00:00.0 Host bridge: VIA Technologies, Inc.: Unknown device 3189 (rev 80)
> >         Subsystem: Giga-byte Technology: Unknown device 5000
> >         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> >         Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR+
> >         Latency: 8
> >         Region 0: Memory at d0000000 (32-bit, prefetchable) [size=128M]
> >         Capabilities: [80] AGP version 3.5
> >                 Status: RQ=31 SBA+ 64bit- FW+ Rate=x1,x2
> >                 Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
> >         Capabilities: [c0] Power Management version 2
> >                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
> >                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> >                                                                                                                              
> > 00:01.0 PCI bridge: VIA Technologies, Inc.: Unknown device b198 (prog-if 00 [Normal decode])
> >         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
> >         Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> >         Latency: 0
> >         Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
> >         I/O behind bridge: 0000d000-0000dfff
> >         Memory behind bridge: e0000000-e1ffffff
> >         Prefetchable memory behind bridge: d8000000-dfffffff
> >         BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
> >         Capabilities: [80] Power Management version 2
> >                 Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
> >                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> >                                                                                                                              
> > 00:09.0 PCI bridge: Hint Corp HB1-SE33 PCI-PCI Bridge (rev 15) (prog-if 00 [Normal decode])
> >         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
> >         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> >         Latency: 32, cache line size 08
> >         Bus: primary=00, secondary=02, subordinate=02, sec-latency=32
> >         Prefetchable memory behind bridge: 00000000e2000000-00000000e2000000
> >         BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
> >         Capabilities: [80] Power Management version 2
> >                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
> >                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> >         Capabilities: [90] #06 [0080]
> >         Capabilities: [a0] Vital Product Data
> > 
> > 00:0a.0 PCI bridge: Hint Corp HB1-SE33 PCI-PCI Bridge (rev 15) (prog-if 00 [Normal decode])
> >         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
> >         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> >         Latency: 32, cache line size 08
> >         Bus: primary=00, secondary=03, subordinate=03, sec-latency=32
> >         Prefetchable memory behind bridge: 00000000e2100000-00000000e2100000
> >         BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
> >         Capabilities: [80] Power Management version 2
> >                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
> >                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> >         Capabilities: [90] #06 [0080]
> >         Capabilities: [a0] Vital Product Data
> >                                                                                                                              
> > 00:0b.0 PCI bridge: Hint Corp HB1-SE33 PCI-PCI Bridge (rev 15) (prog-if 00 [Normal decode])
> >         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
> >         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> >         Latency: 32, cache line size 08
> >         Bus: primary=00, secondary=04, subordinate=04, sec-latency=32
> >         Prefetchable memory behind bridge: 00000000e2200000-00000000e2200000
> >         BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
> >         Capabilities: [80] Power Management version 2
> >                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
> >                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> >         Capabilities: [90] #06 [0080]
> >         Capabilities: [a0] Vital Product Data
> >                                                                                                                              
> > 00:0d.0 Communication controller: Conexant HSF 56k HSFi Modem (rev 01)
> >         Subsystem: Conexant: Unknown device 2004
> >         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> >         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> >         Latency: 32
> >         Interrupt: pin A routed to IRQ 6
> >         Region 0: Memory at e2300000 (32-bit, non-prefetchable) [size=64K]
> >         Region 1: I/O ports at e000 [size=8]
> >         Capabilities: [40] Power Management version 2
> >                 Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
> >                 Status: D0 PME-Enable+ DSel=0 DScale=0 PME-
> > 
> > 00:11.0 ISA bridge: VIA Technologies, Inc.: Unknown device 3177
> >         Subsystem: Giga-byte Technology: Unknown device 5001
> >         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
> >         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> >         Latency: 0
> >         Capabilities: [c0] Power Management version 2
> >                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
> >                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> >                                                                                                                              
> > 00:11.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
> >         Subsystem: Giga-byte Technology: Unknown device 5002
> >         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> >         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> >         Latency: 32
> >         Interrupt: pin A routed to IRQ 11
> >         Region 4: I/O ports at e400 [size=16]
> >         Capabilities: [c0] Power Management version 2
> >                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
> >                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> >                                                                                                                              
> > 00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II] (rev 74)
> >         Subsystem: Giga-byte Technology: Unknown device e000
> >         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> >         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> >         Latency: 32 (750ns min, 2000ns max), cache line size 08
> >         Interrupt: pin A routed to IRQ 11
> >         Region 0: I/O ports at e800 [size=256]
> >         Region 1: Memory at e2310000 (32-bit, non-prefetchable) [size=256]
> >         Capabilities: [40] Power Management version 2
> >                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
> >                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> > 
> > 01:00.0 VGA compatible controller: ATI Technologies Inc Radeon VE QY (prog-if 00 [VGA])
> >         Subsystem: Palit Microsystems Inc.: Unknown device 5159
> >         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
> >         Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> >         Latency: 32 (2000ns min), cache line size 08
> >         Interrupt: pin A routed to IRQ 11
> >         Region 0: Memory at d8000000 (32-bit, prefetchable) [size=128M]
> >         Region 1: I/O ports at d000 [size=256]
> >         Region 2: Memory at e1000000 (32-bit, non-prefetchable) [size=64K]
> >         Expansion ROM at <unassigned> [disabled] [size=128K]
> >         Capabilities: [58] AGP version 2.0
> >                 Status: RQ=47 SBA+ 64bit- FW- Rate=x1,x2
> >                 Command: RQ=0 SBA+ AGP- 64bit- FW- Rate=<none>
> >         Capabilities: [50] Power Management version 2
> >                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
> >                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> >                                                                                                                              
> > 02:04.0 Multimedia video controller: Brooktree Corporation Bt878 Video Capture (rev 11)
> >         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> >         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> >         Latency: 32 (4000ns min, 10000ns max)
> >         Interrupt: pin A routed to IRQ 6
> >         Region 0: Memory at e2000000 (32-bit, prefetchable) [size=4K]
> >         Capabilities: [44] Vital Product Data
> >         Capabilities: [4c] Power Management version 2
> >                 Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
> >                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> >                                                                                                                              
> > 02:04.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture (rev 11)
> >         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> >         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> >         Latency: 32 (1000ns min, 63750ns max)
> >         Interrupt: pin A routed to IRQ 6
> >         Region 0: Memory at e2001000 (32-bit, prefetchable) [size=4K]
> >         Capabilities: [44] Vital Product Data
> >         Capabilities: [4c] Power Management version 2
> >                 Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
> >                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> >                                                                                                                              
> > 02:05.0 Multimedia video controller: Brooktree Corporation Bt878 Video Capture (rev 11)
> >         Subsystem: Unknown device 0001:a155
> >         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> >         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> >         Latency: 32 (4000ns min, 10000ns max)
> >         Interrupt: pin A routed to IRQ 10
> >         Region 0: Memory at e2002000 (32-bit, prefetchable) [size=4K]
> >         Capabilities: [44] Vital Product Data
> >         Capabilities: [4c] Power Management version 2
> >                 Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
> >                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> >                                                                                                                              
> > 02:05.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture (rev 11)
> >         Subsystem: Unknown device 0001:a155
> >         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> >         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> >         Latency: 32 (1000ns min, 63750ns max)
> >         Interrupt: pin A routed to IRQ 10
> >         Region 0: Memory at e2003000 (32-bit, prefetchable) [size=4K]
> >         Capabilities: [44] Vital Product Data
> >         Capabilities: [4c] Power Management version 2
> >                 Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
> >                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> >                                                                                                                              
> > 02:06.0 Multimedia video controller: Brooktree Corporation Bt878 Video Capture (rev 11)
> >         Subsystem: Unknown device 0002:a155
> >         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> >         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> >         Latency: 32 (4000ns min, 10000ns max)
> >         Interrupt: pin A routed to IRQ 5
> >         Region 0: Memory at e2004000 (32-bit, prefetchable) [size=4K]
> >         Capabilities: [44] Vital Product Data
> >         Capabilities: [4c] Power Management version 2
> >                 Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
> >                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> >                                                                                                                              
> > 02:06.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture (rev 11)
> >         Subsystem: Unknown device 0002:a155
> >         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> >         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> >         Latency: 32 (1000ns min, 63750ns max)
> >         Interrupt: pin A routed to IRQ 5
> >         Region 0: Memory at e2005000 (32-bit, prefetchable) [size=4K]
> >         Capabilities: [44] Vital Product Data
> >         Capabilities: [4c] Power Management version 2
> >                 Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
> >                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> >                                                                                                                              
> > 02:07.0 Multimedia video controller: Brooktree Corporation Bt878 Video Capture (rev 11)
> >         Subsystem: Unknown device 0003:a155
> >         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> >         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> >         Latency: 32 (4000ns min, 10000ns max)
> >         Interrupt: pin A routed to IRQ 11
> >         Region 0: Memory at e2006000 (32-bit, prefetchable) [size=4K]
> >         Capabilities: [44] Vital Product Data
> >         Capabilities: [4c] Power Management version 2
> >                 Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
> >                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> >                                                                                                                              
> > 02:07.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture (rev 11)
> >         Subsystem: Unknown device 0003:a155
> >         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> >         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> >         Latency: 32 (1000ns min, 63750ns max)
> >         Interrupt: pin A routed to IRQ 11
> >         Region 0: Memory at e2007000 (32-bit, prefetchable) [size=4K]
> >         Capabilities: [44] Vital Product Data
> >         Capabilities: [4c] Power Management version 2
> >                 Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
> >                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> > 
> > 03:04.0 Multimedia video controller: Brooktree Corporation Bt878 Video Capture (rev 11)
> >         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> >         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> >         Latency: 32 (4000ns min, 10000ns max)
> >         Interrupt: pin A routed to IRQ 10
> >         Region 0: Memory at e2100000 (32-bit, prefetchable) [size=4K]
> >         Capabilities: [44] Vital Product Data
> >         Capabilities: [4c] Power Management version 2
> >                 Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
> >                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> >                                                                                                                              
> > 03:04.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture (rev 11)
> >         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> >         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> >         Latency: 32 (1000ns min, 63750ns max)
> >         Interrupt: pin A routed to IRQ 10
> >         Region 0: Memory at e2101000 (32-bit, prefetchable) [size=4K]
> >         Capabilities: [44] Vital Product Data
> >         Capabilities: [4c] Power Management version 2
> >                 Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
> >                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> >                                                                                                                              
> > 03:05.0 Multimedia video controller: Brooktree Corporation Bt878 Video Capture (rev 11)
> >         Subsystem: Unknown device 0001:a155
> >         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> >         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> >         Latency: 32 (4000ns min, 10000ns max)
> >         Interrupt: pin A routed to IRQ 5
> >         Region 0: Memory at e2102000 (32-bit, prefetchable) [size=4K]
> >         Capabilities: [44] Vital Product Data
> >         Capabilities: [4c] Power Management version 2
> >                 Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
> >                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> >                                                                                                                              
> > 03:05.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture (rev 11)
> >         Subsystem: Unknown device 0001:a155
> >         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> >         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> >         Latency: 32 (1000ns min, 63750ns max)
> >         Interrupt: pin A routed to IRQ 5
> >         Region 0: Memory at e2103000 (32-bit, prefetchable) [size=4K]
> >         Capabilities: [44] Vital Product Data
> >         Capabilities: [4c] Power Management version 2
> >                 Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
> >                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> >                                                                                                                              
> > 03:06.0 Multimedia video controller: Brooktree Corporation Bt878 Video Capture (rev 11)
> >         Subsystem: Unknown device 0002:a155
> >         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> >         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> >         Latency: 32 (4000ns min, 10000ns max)
> >         Interrupt: pin A routed to IRQ 11
> >         Region 0: Memory at e2104000 (32-bit, prefetchable) [size=4K]
> >         Capabilities: [44] Vital Product Data
> >         Capabilities: [4c] Power Management version 2
> >                 Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
> >                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> >                                                                                                                              
> > 03:06.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture (rev 11)
> >         Subsystem: Unknown device 0002:a155
> >         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> >         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> >         Latency: 32 (1000ns min, 63750ns max)
> >         Interrupt: pin A routed to IRQ 11
> >         Region 0: Memory at e2105000 (32-bit, prefetchable) [size=4K]
> >         Capabilities: [44] Vital Product Data
> >         Capabilities: [4c] Power Management version 2
> >                 Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
> >                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> >                                                                                                                              
> > 03:07.0 Multimedia video controller: Brooktree Corporation Bt878 Video Capture (rev 11)
> >         Subsystem: Unknown device 0003:a155
> >         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> >         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> >         Latency: 32 (4000ns min, 10000ns max)
> >         Interrupt: pin A routed to IRQ 6
> >         Region 0: Memory at e2106000 (32-bit, prefetchable) [size=4K]
> >         Capabilities: [44] Vital Product Data
> >         Capabilities: [4c] Power Management version 2
> >                 Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
> >                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> >                                                                                                                              
> > 03:07.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture (rev 11)
> >         Subsystem: Unknown device 0003:a155
> >         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> >         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> >         Latency: 32 (1000ns min, 63750ns max)
> >         Interrupt: pin A routed to IRQ 6
> >         Region 0: Memory at e2107000 (32-bit, prefetchable) [size=4K]
> >         Capabilities: [44] Vital Product Data
> >         Capabilities: [4c] Power Management version 2
> >                 Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
> >                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> >                                                                                                                              
> > 04:04.0 Multimedia video controller: Brooktree Corporation Bt878 Video Capture (rev 11)
> >         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> >         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> >         Latency: 32 (4000ns min, 10000ns max)
> >         Interrupt: pin A routed to IRQ 5
> >         Region 0: Memory at e2200000 (32-bit, prefetchable) [size=4K]
> >         Capabilities: [44] Vital Product Data
> >         Capabilities: [4c] Power Management version 2
> >                 Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
> >                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> >                                                                                                                              
> > 04:04.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture (rev 11)
> >         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> >         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> >         Latency: 32 (1000ns min, 63750ns max)
> >         Interrupt: pin A routed to IRQ 5
> >         Region 0: Memory at e2201000 (32-bit, prefetchable) [size=4K]
> >         Capabilities: [44] Vital Product Data
> >         Capabilities: [4c] Power Management version 2
> >                 Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
> >                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> >                                                                                                                              
> > 04:05.0 Multimedia video controller: Brooktree Corporation Bt878 Video Capture (rev 11)
> >         Subsystem: Unknown device 0001:a155
> >         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> >         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> >         Latency: 32 (4000ns min, 10000ns max)
> >         Interrupt: pin A routed to IRQ 11
> >         Region 0: Memory at e2202000 (32-bit, prefetchable) [size=4K]
> >         Capabilities: [44] Vital Product Data
> >         Capabilities: [4c] Power Management version 2
> >                 Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
> >                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> >                                                                                                                              
> > 04:05.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture (rev 11)
> >         Subsystem: Unknown device 0001:a155
> >         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> >         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> >         Latency: 32 (1000ns min, 63750ns max)
> >         Interrupt: pin A routed to IRQ 11
> >         Region 0: Memory at e2203000 (32-bit, prefetchable) [size=4K]
> >         Capabilities: [44] Vital Product Data
> >         Capabilities: [4c] Power Management version 2
> >                 Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
> >                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> >                                                                                                                              
> > 
> > 04:06.0 Multimedia video controller: Brooktree Corporation Bt878 Video Capture (rev 11)
> >         Subsystem: Unknown device 0002:a155
> >         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> >         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> >         Latency: 32 (4000ns min, 10000ns max)
> >         Interrupt: pin A routed to IRQ 6
> >         Region 0: Memory at e2204000 (32-bit, prefetchable) [size=4K]
> >         Capabilities: [44] Vital Product Data
> >         Capabilities: [4c] Power Management version 2
> >                 Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
> >                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> >                                                                                                                              
> > 04:06.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture (rev 11)
> >         Subsystem: Unknown device 0002:a155
> >         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> >         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> >         Latency: 32 (1000ns min, 63750ns max)
> >         Interrupt: pin A routed to IRQ 6
> >         Region 0: Memory at e2205000 (32-bit, prefetchable) [size=4K]
> >         Capabilities: [44] Vital Product Data
> >         Capabilities: [4c] Power Management version 2
> >                 Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
> >                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> >                                                                                                                              
> > 04:07.0 Multimedia video controller: Brooktree Corporation Bt878 Video Capture (rev 11)
> >         Subsystem: Unknown device 0003:a155
> >         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> >         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> >         Latency: 32 (4000ns min, 10000ns max)
> >         Interrupt: pin A routed to IRQ 10
> >         Region 0: Memory at e2206000 (32-bit, prefetchable) [size=4K]
> >         Capabilities: [44] Vital Product Data
> >         Capabilities: [4c] Power Management version 2
> >                 Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
> >                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> >                                                                                                                              
> > 04:07.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture (rev 11)
> >         Subsystem: Unknown device 0003:a155
> >         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> >         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> >         Latency: 32 (1000ns min, 63750ns max)
> >         Interrupt: pin A routed to IRQ 10
> >         Region 0: Memory at e2207000 (32-bit, prefetchable) [size=4K]
> >         Capabilities: [44] Vital Product Data
> >         Capabilities: [4c] Power Management version 2
> >                 Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
> >                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> >                                                                                                                              
> >                                                                                    
> > 
> > 
> >                                                                                                                              
> > 
> >                                                                                                                              
> > 
> > 
> >                                                                                                                              
> > 
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> > 
> 
> 
