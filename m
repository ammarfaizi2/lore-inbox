Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264028AbRFTXw1>; Wed, 20 Jun 2001 19:52:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264066AbRFTXwI>; Wed, 20 Jun 2001 19:52:08 -0400
Received: from mta01-svc.ntlworld.com ([62.253.162.41]:57244 "EHLO
	mta01-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id <S264028AbRFTXwC>; Wed, 20 Jun 2001 19:52:02 -0400
Content-Type: text/plain; charset=US-ASCII
From: Gav <gavbaker@ntlworld.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.5-ac16 kernel panic
Date: Thu, 21 Jun 2001 00:48:34 +0000
X-Mailer: KMail [version 1.2]
In-Reply-To: <20010619183135.A24337@lightning.swansea.linux.org.uk> <3B3116A3.E89360DE@netpathway.com>
In-Reply-To: <3B3116A3.E89360DE@netpathway.com>
MIME-Version: 1.0
Message-Id: <01062100483400.01222@box.penguin.power>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 20 June 2001 21:33, Gary White (Network Administrator) wrote:

> 2.4.5-ac16 patch applied to clean 2.4.5 tree. 2.4.5-ac15 boots
> with no problem.
>
> model name      : AMD Athlon(tm) Processor
>
> Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev 3).
>
>
> PnP: PNP BIOS installation structure at 0xc00fc2b0
> PnP: PNP BIOS version 1.0, entry at f0000:c2e0, dseg at f0000
> Linux NET4.0 for Linux 2.4
> Based upon Swansea University Computer Society NET3.039
> Initializing RT netlink socket
> invalid operand: 0000
> CPU:    0
> EIP:    0010:[<c01112cf>]
> EFLAGS: 00010286
> eax: 007ec000   ebx: e0800000   ecx: 3f7ec000   edx: c0101000
> esi: 1ffec000   edi: 1ffec000   ebp: 00000000   esp: dffe3f54
> ds: 0018   es: 0018   ss: 0018
> Process swapper (pid: 1, stackpage=dffe3000)
> Stack: e0800000 1ffec000 1ffec000 00000000 00000246 1ffec000 1ffec000
> 1ffec000 c0126384 00000010 007ec000 c0101e08 1ffec000 3f7ec000 c0111521
> e0800000 1ffec000 1ffec000 00000000 1ffec000 c00f6ed8 00000014 000f6ed0
> 3ffd7fff Call Trace: [<e0800000>] [<c0126384>] [<c0101e08>] [<c0111521>]
> [<e0800000>] [<c0105267>] [<c01056e8>]
>
> Code: 0f 0b e9 40 01 00 00 8b 44 24 28 8b 54 24 2c 8b 4c 24 34 8b
>  <0>Kernel panic: Attempted to kill init
> --
> Gary White               Network Administrator
> admin@netpathway.com          Internet Pathway
> Voice 601-776-3355            Fax 601-776-2314
>

Same here Gary. 

While starting kswapd "Kernel BUG at ioremap.c:73!  Invalid operand:0000" etc

AMD Athlon 

00:07.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 
40)
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin ? routed to IRQ 11
        Capabilities: [68] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:00.0 Host bridge: VIA Technologies, Inc.: Unknown device 0305 (rev 03)
        Subsystem: ABIT Computer Corp.: Unknown device a401
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 8
        Region 0: Memory at d8000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [a0] AGP version 2.0
                Status: RQ=31 SBA+ 64bit- FW+ Rate=x1,x2
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-


-- Regards, Gavin Baker

