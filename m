Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131300AbRCWR13>; Fri, 23 Mar 2001 12:27:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131305AbRCWR1L>; Fri, 23 Mar 2001 12:27:11 -0500
Received: from linux.kappa.ro ([194.102.255.131]:38819 "EHLO linux.kappa.ro")
	by vger.kernel.org with ESMTP id <S131300AbRCWR1H>;
	Fri, 23 Mar 2001 12:27:07 -0500
X-RAV-AntiVirus: This e-mail has been scanned for viruses on host: linux.kappa.ro
Date: Fri, 23 Mar 2001 19:26:01 +0200
From: Mircea Damian <dmircea@kappa.ro>
To: linux-kernel@vger.kernel.org
Subject: [dmircea@kappa.ro: OOPS]
Message-ID: <20010323192601.A10894@linux.kappa.ro>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="vtzGhvizbBRQ85DL"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Resend. I got no answer.

-- 
Mircea Damian
E-mails: dmircea@kappa.ro, dmircea@roedu.net
WebPage: http://taz.mania.k.ro/~dmircea/

--vtzGhvizbBRQ85DL
Content-Type: message/rfc822
Content-Disposition: inline

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [199.183.24.194])
	by linux.kappa.ro (8.10.2/8.10.2) with ESMTP id f2KFGGv12248
	for <dmircea@linux.kappa.ro>; Tue, 20 Mar 2001 17:16:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130381AbRCTPJQ>; Tue, 20 Mar 2001 10:09:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130383AbRCTPJI>; Tue, 20 Mar 2001 10:09:08 -0500
Received: from linux.kappa.ro ([194.102.255.131]:53379 "EHLO linux.kappa.ro")
	by vger.kernel.org with ESMTP id <S130381AbRCTPI4>;
	Tue, 20 Mar 2001 10:08:56 -0500
Received: (from dmircea@localhost)
	by linux.kappa.ro (8.10.2/8.10.2) id f2KF87K11922
	for linux-kernel@vger.kernel.org; Tue, 20 Mar 2001 17:08:07 +0200
X-RAV-AntiVirus: This e-mail has been scanned for viruses on host: linux.kappa.ro
X-Authentication-Warning: linux.kappa.ro: dmircea set sender to dmircea@kappa.ro using -f
Date: Tue, 20 Mar 2001 17:08:07 +0200
From: Mircea Damian <dmircea@kappa.ro>
To: linux-kernel@vger.kernel.org
Subject: OOPS
Message-ID: <20010320170807.B4128@linux.kappa.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

[1.] One line summary of the problem:    
Kernel OOPS. Machine hanged under heavy load.

[2.] Full description of the problem/report:
The computer that is handling our e-mail hanged with an OOPS from which I
recovered only the EIP.

[3.] Keywords (i.e., modules, networking, kernel):
networking, kernel

[4.] Kernel version (from /proc/version):
Linux version 2.4.3-pre4 (root@k) (gcc version egcs-2.91.66 19990314/Linux
(egcs-1.1.2 release)) #1 SMP Tue Mar 13 11:00:08 EET 2001

[5.] Output of Oops.. message (if applicable) with symbolic information 
     resolved (see Documentation/oops-tracing.txt)
This is all that I could save:

Unable to handle kernel paging request 86c90cc0
OOPS:000  CPU1:  EIP=0010:[<c01f7d08>]

I could not get the stack trace. Next-time I'll log the message on a serial
console.

If I read from System.map the address is between: 

00000000c01f7b98 T tcp_v4_rcv
00000000c01f81b0 t __tcp_v4_rehash

[6.] A small shell script or example program which triggers the
     problem (if possible)
[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)
Linux k 2.4.3-pre4 #1 SMP Tue Mar 13 11:00:08 EET 2001 i686 unknown
 
 Gnu C                  egcs-2.91.66
 Gnu make               3.79
 binutils               2.10.1.0.2
 util-linux             2.10o
 modutils               2.4.2
 e2fsprogs              1.19
 PPP                    2.3.11
 Linux C Library        2.2.1
 ldd: version 1.9.9
 Procps                 2.0.7
 Net-tools              1.57
 Kbd                    0.99
 Sh-utils               2.0
 Modules Loaded         

[7.2.] Processor information (from /proc/cpuinfo):
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 3
cpu MHz         : 736.019
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 mmx fxsr sse
bogomips        : 1468.00

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 3
cpu MHz         : 736.019
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 mmx fxsr sse
bogomips        : 1471.28

[7.3.] Module information (from /proc/modules):
none
[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
02f8-02ff : serial(auto)
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
5000-500f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
6000-607f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
9000-9fff : PCI Bus #01
  9000-907f : Silicon Integrated Systems [SiS] 86C326
a000-a00f : VIA Technologies, Inc. Bus Master IDE
  a000-a007 : ide0
  a008-a00f : ide1
ac00-ac07 : Triones Technologies, Inc. HPT366
b000-b003 : Triones Technologies, Inc. HPT366
b400-b407 : Triones Technologies, Inc. HPT366
b800-b803 : Triones Technologies, Inc. HPT366
bc00-bcff : Triones Technologies, Inc. HPT366
  bc00-bc07 : ide2
  bc08-bc0f : ide3
  bc10-bcff : HPT370
c000-c0ff : Realtek Semiconductor Co., Ltd. RTL-8139
  c000-c0ff : eth0

00000000-0009fbff : System RAM
0009fc00-0009ffff : System RAM
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-1fffffff : System RAM
  00100000-00220086 : Kernel code
  00220087-00286b7f : Kernel data
d0000000-d3ffffff : VIA Technologies, Inc. VT82C693A/694x [Apollo PRO133x]
d4000000-d5ffffff : PCI Bus #01
  d5000000-d500ffff : Silicon Integrated Systems [SiS] 86C326
d7000000-d77fffff : PCI Bus #01
  d7000000-d77fffff : Silicon Integrated Systems [SiS] 86C326
d7800000-d78000ff : Realtek Semiconductor Co., Ltd. RTL-8139
  d7800000-d78000ff : eth0
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
ffff0000-ffffffff : reserved

[7.5.] PCI information ('lspci -vvv' as root)

00:00.0 Host bridge: VIA Technologies, Inc. VT82C691 [Apollo PRO] (rev c4)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 8
	Region 0: Memory at d0000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598 [Apollo MVP3 AGP] (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 00009000-00009fff
	Memory behind bridge: d4000000-d5ffffff
	Prefetchable memory behind bridge: d7000000-d77fffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super] (rev 40)
	Subsystem: VIA Technologies, Inc. VT82C686/A PCI to ISA Bridge
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev 06) (prog-if 8a [Master SecP PriP])
	Subsystem: VIA Technologies, Inc. VT82C586 IDE [Apollo]
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Region 4: I/O ports at a000 [size=16]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40)
	Subsystem: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Capabilities: [68] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:08.0 Unknown mass storage controller: Triones Technologies, Inc. HPT366 (rev 03)
	Subsystem: Triones Technologies, Inc.: Unknown device 0001
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 120 (2000ns min, 2000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at ac00 [size=8]
	Region 1: I/O ports at b000 [size=4]
	Region 2: I/O ports at b400 [size=8]
	Region 3: I/O ports at b800 [size=4]
	Region 4: I/O ports at bc00 [size=256]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0a.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev 10)
	Subsystem: Realtek Semiconductor Co., Ltd. RT8139
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (8000ns min, 16000ns max)
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at c000 [size=256]
	Region 1: Memory at d7800000 (32-bit, non-prefetchable) [size=256]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0-,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable+ DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: Silicon Integrated Systems [SiS] 86C326 (rev 0b) (prog-if 00 [VGA])
	Subsystem: Palit Microsystems Inc. SiS6326 GUI Accelerator
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (500ns min)
	Interrupt: pin A routed to IRQ 12
	Region 0: Memory at d7000000 (32-bit, prefetchable) [size=8M]
	Region 1: Memory at d5000000 (32-bit, non-prefetchable) [size=64K]
	Region 2: I/O ports at 9000 [size=128]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: [40] Power Management version 1
		Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [50] AGP version 1.0
		Status: RQ=1 SBA- 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

[7.6.] SCSI information (from /proc/scsi/scsi)
no scsi adapters

[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):
This is a very loaded server running lots of apache processes and sendmail.

[X.] Other notes, patches, fixes, workarounds:


-- 
Mircea Damian
E-mails: dmircea@kappa.ro, dmircea@roedu.net
WebPage: http://taz.mania.k.ro/~dmircea/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

--vtzGhvizbBRQ85DL--
