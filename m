Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266062AbRGQLXj>; Tue, 17 Jul 2001 07:23:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266130AbRGQLX3>; Tue, 17 Jul 2001 07:23:29 -0400
Received: from mail005.syd.optusnet.com.au ([203.2.75.229]:48023 "EHLO
	mail005.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id <S266062AbRGQLXX>; Tue, 17 Jul 2001 07:23:23 -0400
Message-ID: <3B54206A.B4B241A4@dingoblue.net.au>
Date: Tue, 17 Jul 2001 20:54:26 +0930
From: Austin <amarrows@dingoblue.net.au>
Organization: Nitsua Enterprises
X-Mailer: Mozilla 4.77 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: kernel 2.4.6 won't boot.
Content-Type: multipart/mixed;
 boundary="------------6FAF4C9DF30CBBB55FE139F0"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------6FAF4C9DF30CBBB55FE139F0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Upon compiling this fresh new kernel, and rebooting, I received this
lovely screen.

Thought I'd let someone "in the know", know about it!

Austin.

===============================================

LILO Boot:
Loading 2.4.6............
Uncompressing Linux... OK. booting the kernel .
Linux version 2.4.6 (austin@Server) (gcc version 2.95.3 20010315
(release)) #1Tue Jul 17 13:34:50 CST 2001
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000a000000 (usable)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
On node 0 totalpages: 40960
zone(0): 4096 pages.
zone(1): 36864 pages.
zone(2): 0 pages.
Kernel command line: auto BOOT_IMAGE=2.4.6 ro root=303
Initializing CPU #0
Detected 187.505MHz processor.
Console: colour VGA+ 80x60
kernel BUG at softirq.c:206!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c0113c7e>]
EFLAGS: 00010082
eax: 0000001d   ebx: c02b89e0   ecx: 00000001   edx: c0258c28
esi: c02b89e0   edi: 00000001   ebp: 00000000   esp: c026defc
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0. stackpage=c026d000)
Stack: c020ebcc c020ec68 000000ce 00000009 c02a05c0 c02a05c0 c026df40
c0113a8f
       c02c05c0 00000000 c029e900 00000000 c0107e5d c025fc20 c026df9f
0000027c
       c0258800 0000027c c0106b60 c025fc20 00000000 0000027c c026df9f
0000027c
Call Trace: [<c0113a8f>] [<c0107e5d>] [<c0106b60>] [<c01106af>]
[<c0105000>]

Code: Of Ob 83 c4 0c 8b 43 08 85 c0 75 18 fb 8b 43 10 50 8b 43 0c
Kernel Panic: Aiee, killing interrupt handler!
In interrupt handler - not synching

--------------6FAF4C9DF30CBBB55FE139F0
Content-Type: text/plain; charset=us-ascii;
 name="ver_linux_output.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ver_linux_output.txt"

[austin@Server linux]$ sh scripts/ver_linux 
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux Server 2.4.4 #2 Fri May 18 19:07:03 CST 2001 i686 unknown
 
Gnu C                  egcs-2.91.66
Gnu make               3.78.1
binutils               2.9.5.0.22
util-linux             2.10f
mount                  2.10f
modutils               2.3.10-pre1
e2fsprogs              1.18
pcmcia-cs              3.1.8
PPP                    2.3.11
Linux C Library        2.1.3
Dynamic linker (ldd)   2.1.3
Procps                 2.0.6
Net-tools              1.54
Console-tools          0.3.3
Sh-utils               2.0
Modules Loaded 

--------------6FAF4C9DF30CBBB55FE139F0
Content-Type: text/plain; charset=us-ascii;
 name="proc_iomem_output.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="proc_iomem_output.txt"

00000000-0009ffff : System RAM
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-09ffffff : System RAM
  00100000-002102a7 : Kernel code
  002102a8-00272a77 : Kernel data
e0000000-e3ffffff : S3 Inc. ViRGE/DX or /GX
e4000000-e40000ff : Davicom Semiconductor, Inc. Ethernet 100/10 MBit
  e4000000-e40000ff : dmfe
ffff0000-ffffffff : reserved

--------------6FAF4C9DF30CBBB55FE139F0
Content-Type: text/plain; charset=us-ascii;
 name="proc_ioports_output.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="proc_ioports_output.txt"

0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
0213-0213 : isapnp read
02f8-02ff : serial(auto)
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0a79-0a79 : isapnp write
0cf8-0cff : PCI conf1
6000-600f : VIA Technologies, Inc. Bus Master IDE
6200-621f : Realtek Semiconductor Co., Ltd. RTL-8029(AS)
  6200-621f : ne2k-pci
6300-63ff : Davicom Semiconductor, Inc. Ethernet 100/10 MBit
  6300-63ff : dmfe

--------------6FAF4C9DF30CBBB55FE139F0
Content-Type: text/plain; charset=us-ascii;
 name="lspci_output.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lspci_output.txt"

00:00.0 Host bridge: VIA Technologies, Inc. VT82C585VP [Apollo VP1/VPX] (rev 23)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 set

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C586/A/B PCI-to-ISA [Apollo VP] (rev 27)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 set

00:07.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev 06) (prog-if 8a [Master SecP PriP])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 set
	Region 4: I/O ports at 6000 [size=16]

00:08.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8029(AS)
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at 6200 [size=32]

00:09.0 Ethernet controller: Davicom Semiconductor, Inc. Ethernet 100/10 MBit (rev 31)
	Subsystem: Unknown device 3030:5032
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 20 min, 40 max, 32 set
	Interrupt: pin A routed to IRQ 12
	Region 0: I/O ports at 6300 [size=256]
	Region 1: Memory at e4000000 (32-bit, non-prefetchable) [disabled] [size=256]
	Expansion ROM at <unassigned> [disabled] [size=256K]
	Capabilities: [50] Power Management version 1
		Flags: PMEClk- AuxPwr+ DSI+ D1- D2- PME-
		Status: D0 PME-Enable+ DSel=0 DScale=0 PME-

00:0b.0 VGA compatible controller: S3 Inc. ViRGE/DX or /GX (rev 01) (prog-if 00 [VGA])
	Subsystem: S3 Inc. ViRGE/DX
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 4 min, 255 max, 32 set
	Interrupt: pin A routed to IRQ 0
	Region 0: Memory at e0000000 (32-bit, non-prefetchable) [size=64M]
	Expansion ROM at <unassigned> [disabled] [size=64K]


--------------6FAF4C9DF30CBBB55FE139F0--

