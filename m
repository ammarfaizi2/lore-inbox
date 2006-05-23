Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932065AbWEWTG5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932065AbWEWTG5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 15:06:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932121AbWEWTG5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 15:06:57 -0400
Received: from wr-out-0506.google.com ([64.233.184.239]:44452 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932065AbWEWTG4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 15:06:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=jBTYAuOV90uHVET4SllqCIcOJ7/8R5lnwmht5xrB2NQC9GhYCjShaNkzlLvzovOdWgQUOfYVes0zZanmHJ/3329CcVQDXfDZLCE1+kDC+ynDHp9ZqagvBSBv6G3OhQGWI5zPY4/7NfqlNrauFGHQeEovqzM4eN6BmisLV2aRg5M=
Message-ID: <5716d8b80605231206i6079d403hb8ed1378c672247b@mail.gmail.com>
Date: Tue, 23 May 2006 21:06:55 +0200
From: "asdewq4@gmail.com" <asdewq4@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: Kernel oops!
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

Sometimes I get so kernel oops. I use 2.6.16.17.

Thank you.

Oops:
-------------------------
May 23 20:13:41 localhost kernel: Unable to handle kernel paging
request at virtual address ffffffcc
May 23 20:13:41 localhost kernel:  printing eip:
May 23 20:13:41 localhost kernel: c013b941
May 23 20:13:41 localhost kernel: *pde = 00002067
May 23 20:13:41 localhost kernel: *pte = 00000000
May 23 20:13:41 localhost kernel: Oops: 0002 [#1]
May 23 20:13:41 localhost kernel: PREEMPT
May 23 20:13:41 localhost kernel: Modules linked in: n_hdlc
snd_seq_dummy snd_seq_oss snd_seq_midi_event snd_seq snd_pcm_oss
snd_mixer_oss snd_ad1816a snd_pcm snd_page_alloc snd_opl3_lib
snd_timer snd_hwdep snd_mpu401_uart snd_rawmidi snd_seq_device snd
loop nls_cp437 firmware_class usbatm uhci_hcd usbcore
May 23 20:13:41 localhost kernel: CPU:    0
May 23 20:13:41 localhost kernel: EIP:    0060:[balance_pgdat+235/780]
   Not tainted VLI
May 23 20:13:41 localhost kernel: EIP:    0060:[<c013b941>]    Not tainted VLI
May 23 20:13:41 localhost kernel: EFLAGS: 00010293   (2.6.16.17 #1)
May 23 20:13:41 localhost kernel: EIP is at balance_pgdat+0xeb/0x30c
May 23 20:13:41 localhost tcplog: microsoft-ds request from
dls37.neoplus.adsl.tpnet.pl
May 23 20:13:41 localhost kernel: eax: 00000250   ebx: c038de30   ecx:
c038dbe0   edx: c038dbe0
May 23 20:13:41 localhost kernel: esi: 00000002   edi: c0341828   ebp:
0000000c   esp: c10d9f24
May 23 20:13:41 localhost kernel: ds: 007b   es: 007b   ss: 0068
May 23 20:13:41 localhost kernel: Process kswapd0 (pid: 68,
threadinfo=c10d8000 task=c10d6070)
May 23 20:13:41 localhost kernel: Stack: <0>c10d6070 00000000 c10d9f90
00000000 00000000 00000001 00000073 c14a75a0
May 23 20:13:41 localhost kernel:        c3231ec4 00002019 c031f5d0
000000d0 00000001 00000001 c3f04030 00000b5a
May 23 20:13:41 localhost kernel:        8c1e5967 00000163 00000000
c10d9fac c0341828 c038dbe0 c013bc5a c038dbe0
May 23 20:13:42 localhost kernel: Call Trace:
May 23 20:13:42 localhost kernel:  [schedule+1346/1365] schedule+0x542/0x555
May 23 20:13:42 localhost kernel:  [<c031f5d0>] schedule+0x542/0x555
May 23 20:13:42 localhost kernel:  [kswapd+248/253] kswapd+0xf8/0xfd
May 23 20:13:42 localhost kernel:  [<c013bc5a>] kswapd+0xf8/0xfd
May 23 20:13:42 localhost kernel:  [autoremove_wake_function+0/58]
autoremove_wake_function+0x0/0x3a
May 23 20:13:42 localhost kernel:  [<c0128c58>]
autoremove_wake_function+0x0/0x3a
May 23 20:13:42 localhost kernel:  [ret_from_fork+6/32] ret_from_fork+0x6/0x20
May 23 20:13:42 localhost tcplog: microsoft-ds request from
dls37.neoplus.adsl.tpnet.pl
May 23 20:13:42 localhost kernel:  [<c0102af6>] ret_from_fork+0x6/0x20
May 23 20:13:42 localhost kernel:  [autoremove_wake_function+0/58]
autoremove_wake_function+0x0/0x3a
May 23 20:13:42 localhost kernel:  [<c0128c58>]
autoremove_wake_function+0x0/0x3a
May 23 20:13:42 localhost kernel:  [kswapd+0/253] kswapd+0x0/0xfd
May 23 20:13:42 localhost kernel:  [<c013bb62>] kswapd+0x0/0xfd
May 23 20:13:42 localhost kernel:  [kernel_thread_helper+5/11]
kernel_thread_helper+0x5/0xb
May 23 20:13:42 localhost kernel:  [<c01012fd>] kernel_thread_helper+0x5/0xb
May 23 20:13:43 localhost kernel: Code: 5c 8b 82 04 05 00 00 75 53 89
c6 4e 0f 88 f0 01 00 00 69 c6 28 01 00 00 8d 1c 02 83 bb 20 01 00 00
00 74 26 83 bb f0 00 00 00 00 <74> 05 83 fd 0c 75 18 6a 00 6a 00 ff 73
0c ff 74 24 70 53 e8 80
-------------------------

scripts/ver_linux:
-------------------------
Linux localhost 2.6.16.17 #1 PREEMPT Sun May 21 19:32:52 CEST 2006
i586 AMD-K6(tm) 3D processor unknown GNU/Linux

Gnu C                  3.3.6
Gnu make               3.80
binutils               2.16.91.0.2
util-linux             2.12q
mount                  2.12q
module-init-tools      3.2-pre8
e2fsprogs              1.38
jfsutils               1.1.7
reiserfsprogs          3.6.19
reiser4progs           line
xfsprogs               2.6.36
PPP                    2.4.3
nfs-utils              1.0.7
Linux C Library        2.3.5
Dynamic linker (ldd)   2.3.5
Procps                 3.2.5
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.2.1
udev                   068
Modules Loaded         n_hdlc snd_seq_dummy snd_seq_oss
snd_seq_midi_event snd_seq snd_pcm_oss snd_mixer_oss snd_ad1816a
snd_pcm snd_page_alloc snd_opl3_lib snd_timer snd_hwdep
snd_mpu401_uart snd_rawmidi snd_seq_device snd loop nls_cp437
firmware_class usbatm uhci_hcd usbcore
-------------------------

cat /proc/cpuinfo:
-------------------------
processor	: 0
vendor_id	: AuthenticAMD
cpu family	: 5
model		: 8
model name	: AMD-K6(tm) 3D processor
stepping	: 12
cpu MHz		: 451.105
cache size	: 64 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr mce cx8 pge mmx syscall 3dnow k6_mtrr
bogomips	: 903.88
-------------------------

cat /proc/ioports:
-------------------------
0000-001f : dma1
0020-0021 : pic1
0040-0043 : timer0
0050-0053 : timer1
0060-006f : keyboard
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
0208-020f : pnp 00:0b
0213-0213 : ISAPnP
0300-0301 : MPU401 UART
0376-0376 : ide1
0388-0389 : OPL2/3 (left)
038a-038b : OPL2/3 (right)
03c0-03df : vga+
03f6-03f6 : ide0
0500-050f : AD1816A
0a79-0a79 : isapnp write
0cf8-0cff : PCI conf1
6000-60ff : 0000:00:07.3
c000-cfff : PCI Bus #01
  c000-c0ff : 0000:01:00.0
e000-e01f : 0000:00:07.2
  e000-e01f : uhci_hcd
e400-e40f : 0000:00:07.1
  e400-e407 : ide0
  e408-e40f : ide1

cat /proc/iomem:
-------------------------
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-03feffff : System RAM
  00100000-00321b62 : Kernel code
  00321b63-003efe7f : Kernel data
03ff0000-03ff07ff : ACPI Non-volatile Storage
03ff0800-03ffffff : ACPI Tables
e0000000-e3ffffff : 0000:00:00.0
e4000000-e5ffffff : PCI Bus #01
  e4000000-e401ffff : 0000:01:00.0
  e5000000-e5000fff : 0000:01:00.0
e6000000-e6ffffff : PCI Bus #01
  e6000000-e6ffffff : 0000:01:00.0
e7000000-e70000ff : 0000:00:09.0
ffff0000-ffffffff : reserved

lspci -vvv:
-------------------------
00:00.0 Host bridge: VIA Technologies, Inc. VT82C598 [Apollo MVP3] (rev 04)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR+
	Latency: 16
	Region 0: Memory at e0000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [a0] AGP version 1.0
		Status: RQ=8 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit-
FW- AGP3- Rate=x1,x2
		Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo
MVP3/Pro133x AGP] (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000c000-0000cfff
	Memory behind bridge: e4000000-e5ffffff
	Prefetchable memory behind bridge: e6000000-e6ffffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C586/A/B PCI-to-ISA
[Apollo VP] (rev 41)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr-
Stepping+ SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:07.1 IDE interface: VIA Technologies, Inc.
VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)
(prog-if 8a [Master SecP PriP])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Region 4: I/O ports at e400 [size=16]

00:07.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
Controller (rev 02) (prog-if 00 [UHCI])
	Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64, cache line size 08
	Interrupt: pin D routed to IRQ 9
	Region 4: I/O ports at e000 [size=32]

00:07.3 PCI bridge: VIA Technologies, Inc. VT82C586B ACPI (rev 10)
(prog-if 00 [Normal decode])
	!!! Invalid class 0604 for header type 00
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin ? routed to IRQ 9

00:09.0 Communication controller: Analog Devices SM56 PCI modem
	Subsystem: Analog Devices SM56 PCI modem
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR+
	Latency: 64 (250ns min, 63750ns max)
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at e7000000 (32-bit, prefetchable) [size=256]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA PME(D0+,D1-,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: ATI Technologies Inc 3D Rage IIC
AGP (rev 3a) (prog-if 00 [VGA])
	Subsystem: ATI Technologies Inc: Unknown device 0088
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (2000ns min), cache line size 08
	Region 0: Memory at e6000000 (32-bit, prefetchable) [size=16M]
	Region 1: I/O ports at c000 [size=256]
	Region 2: Memory at e5000000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at e4000000 [disabled] [size=128K]
	Capabilities: [5c] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
