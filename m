Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262400AbTFJUXd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 16:23:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262312AbTFJUWw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 16:22:52 -0400
Received: from bigmama.rhoen.de ([62.80.125.185]:5569 "EHLO rhoen.de")
	by vger.kernel.org with ESMTP id S262318AbTFJUUP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 16:20:15 -0400
Date: Tue, 10 Jun 2003 22:29:47 +0200
To: linux-kernel@vger.kernel.org
Subject: oops while booting : 2.5.70-bk1[4,5] - Process swapper
Message-ID: <20030610202947.GA752@macbeth.rhoen.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="envbJBWh7q8WU6mo"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
From: boris mogwitz <boris@macbeth.rhoen.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--envbJBWh7q8WU6mo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello ...

Linux version 2.5.70-bk15 (root@macbeth) (gcc version 3.3 (Debian)) #9 SMP Tue Jun 10 15:25:41 CEST 2003
Video mode to be used for restore is f00
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000c000000 (usable)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
192MB LOWMEM available.
found SMP MP-table at 000f5620
hm, page 000f5000 reserved twice.
hm, page 000f6000 reserved twice.
hm, page 000f1000 reserved twice.
hm, page 000f2000 reserved twice.
On node 0 totalpages: 49152
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 45056 pages, LIFO batch:11
  HighMem zone: 0 pages, LIFO batch:1
Intel MultiProcessor Specification v1.1
    Virtual Wire compatibility mode.
OEM ID: OEM00000 Product ID: PROD00000000 APIC at: 0xFEE00000
Processor #0 6:3 APIC version 17
Processor #1 6:3 APIC version 17
I/O APIC #2 Version 17 at 0xFEC00000.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Processors: 2
Building zonelist for node : 0
Kernel command line: auto BOOT_IMAGE=Linux ro root=801 video=matroxfb:vesa:0x11A console=ttyS1,57600n8 console=tty0
Initializing CPU#0
PID hash table entries: 1024 (order 10: 8192 bytes)
Detected 233.923 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 459.77 BogoMIPS
Memory: 191236k/196608k available (1725k kernel code, 4712k reserved, 396k data, 340k init, 0k highmem)
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
-> /dev
-> /dev/console
-> /root
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Checking 'hlt' instruction... OK.
POSIX conforance testing by UNIFIX
CPU0: Intel Pentium II (Klamath) stepping 04
per-CPU timelice cutoff: 1465.81 usecs.
task migration cache decay timeout: 2 msecs.
enabledExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabing vector: 00000000
Booting processor 1/1 eip 2000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling ector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loo... 465.92 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
Intel machine check architecture supported.
Intel machine check reporting enabled n CPU#1.
CPU1: Intel Pentium II (Klamath) stepping 04
Total of 2 processors acivated (925.69 BogoMIPS).
ENABLING IO-APIC IRQs
Setting 2 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 2 ... ok.
..TIMER: vecto=0x31 pin1=2 pin2=0
testing the IO APIC.......................

................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ..
..... CPU clock speed is 233.0815 MHz.
..... host bus clock speed is 66.0804 MHz.
checking TSC synchronization across 2 CPUs: passed.
Starting migration thread for cpu 0
Bringing up 1
CPU 1 IS NOW UP!
Starting migration thread for cpu 1
CPUS done 2
mtrr: v2.0 (20020519)
mtrr: your CPUs had inconsistent fixed MTRR settings
mtrr: probably your BIOS does not setup all CPUs.
mtrr: corrected configuration.
Initializing RT netlink socket
PCI: PCI BIOS revision 2.10 entry at 0xfacd0, last bus=2
PCI: Using configuration type 1
BIO: pool of 256 setup, 14Kb (56 bytes/bio)
biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
Linux Plug and Play Support v0.96 (c) Adam Belay
pty: 256 Unix98 ptys configured
block request queues:
 4/128 requests per read queue
 4/128 requests per write queue
 enter congestion at 15
 exit congestion at 17
SCSI subsystem initialized
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
00000000
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<00000000>]    Not tainted
EFLAGS: 00010246
eax: 00000000   ebx: cbd93c00   ecx: 00000006   edx: cbd93dcc
esi: cbd93c00   edi: 0000102b   ebp: 00000d43   esp: cbf8be68
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 1, threadinfo=cbf8a000 task=c11ff8c0)
Stack: c0254888 cbd93c00 0000003f cbd93c00 c01c4f7b cbd93c00 0000003f c0307f00 
       c01c4fa7 cbd93c00 0000003f c02466e9 cbd93c00 00000000 00000004 cbf8bea8 
       02900007 85d788e0 c0307fc0 ffffffed cbd93c00 00000000 c01c6222 cbd93c00 
Call Trace: [<c0254888>]  [<c01c4f7b>]  [<c01c4fa7>]  [<c02466e9>]  [<c01c6222>]  [<c01c63bc>]  [<c01c63ff>]  [<c01ee395>]  [<c01ee41f>]  [<c01ee5d5>]  [<c01ed661>]  [<c032632c>]  [<c0326315>]  [<c0326e22>]  [<c0330cbb>]  [<c0330648>]  [<c031694b>]  [<c012f27f>]  [<c01050d8>]  [<c0105080>]  [<c0107229>] 
Code:  Bad EIP value.
 <0>Kernel panic: Attempted to kill init!

ksymoops: 
---------

ksymoops 2.4.8 on i686 2.5.70-bk13.  Options used
     -v /usr/src/linux/vmlinux (specified)
     -K (specified)
     -L (specified)
     -o /lib/modules/2.5.70-bk15/ (specified)
     -m /usr/src/linux/System.map (specified)

No modules in ksyms, skipping objects
Unable to handle kernel NULL pointer dereference at virtual address 00000000
00000000
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<00000000>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00000000   ebx: cbd93c00   ecx: 00000006   edx: cbd93dcc
esi: cbd93c00   edi: 0000102b   ebp: 00000d43   esp: cbf8be68
ds: 007b   es: 007b   ss: 0068
Stack: c0254888 cbd93c00 0000003f cbd93c00 c01c4f7b cbd93c00 0000003f c0307f00 
       c01c4fa7 cbd93c00 0000003f c02466e9 cbd93c00 00000000 00000004 cbf8bea8 
       02900007 85d788e0 c0307fc0 ffffffed cbd93c00 00000000 c01c6222 cbd93c00 
Call Trace: [<c0254888>]  [<c01c4f7b>]  [<c01c4fa7>]  [<c02466e9>]  [<c01c6222>]  [<c01c63bc>]  [<c01c63ff>]  [<c01ee395>]  [<c01ee41f>]  [<c01ee5d5>]  [<c01ed661>]  [<c032632c>]  [<c0326315>]  [<c0326e22>]  [<c0330cbb>]  [<c0330648>]  [<c031694b>]  [<c012f27f>]  [<c01050d8>]  [<c0105080>]  [<c0107229>] 
Code:  Bad EIP value.


>>EIP; 00000000 Before first symbol

>>ebx; cbd93c00 <_end+b9fe068/3fc68468>
>>edx; cbd93dcc <_end+b9fe234/3fc68468>
>>esi; cbd93c00 <_end+b9fe068/3fc68468>
>>esp; cbf8be68 <_end+bbf62d0/3fc68468>

Trace; c0254888 <pcibios_enable_device+28/30>
Trace; c01c4f7b <pci_enable_device_bars+2b/40>
Trace; c01c4fa7 <pci_enable_device+17/20>
Trace; c02466e9 <matroxfb_probe+d9/2d0>
Trace; c01c6222 <pci_device_probe_static+52/70>
Trace; c01c63bc <__pci_device_probe+3c/50>
Trace; c01c63ff <pci_device_probe+2f/50>
Trace; c01ee395 <bus_match+45/80>
Trace; c01ee41f <device_attach+4f/90>
Trace; c01ee5d5 <bus_add_device+65/b0>
Trace; c01ed661 <device_add+d1/100>
Trace; c032632c <pci_bus_add_devices+ac/e0>
Trace; c0326315 <pci_bus_add_devices+95/e0>
Trace; c0326e22 <pci_scan_bus_parented+42/50>
Trace; c0330cbb <pcibios_scan_root+6b/80>
Trace; c0330648 <pci_legacy_init+38/60>
Trace; c031694b <do_initcalls+2b/a0>
Trace; c012f27f <init_workqueues+f/24>
Trace; c01050d8 <init+58/200>
Trace; c0105080 <init+0/200>
Trace; c0107229 <kernel_thread_helper+5/c>

 <0>Kernel panic: Attempted to kill init!


I use a plain kernel form ftp.xx.kernel.org with the
aic79xx-linux-2.5-20030603-tar.gz package from:
http://people.FreeBSD.org/~gibbs/linux/SRC/

-> (http://marc.theaimsgroup.com/?l=linux-kernel&m=105346338023590&w=2)

              mfg
                        boris

--envbJBWh7q8WU6mo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=lspci-v

00:00.0 Host bridge: Intel Corp. 440LX/EX - 82443LX/EX Host bridge (rev 03)
	Flags: bus master, medium devsel, latency 64
	Memory at e0000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [a0] AGP version 1.0

00:01.0 PCI bridge: Intel Corp. 440LX/EX - 82443LX/EX AGP bridge (rev 03) (prog-if 00 [Normal decode])
	Flags: bus master, 66Mhz, medium devsel, latency 64
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	I/O behind bridge: 0000b000-0000bfff

00:07.0 ISA bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 01)
	Flags: bus master, medium devsel, latency 0

00:07.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01) (prog-if 80 [Master])
	Flags: bus master, medium devsel, latency 64
	I/O ports at f000 [size=16]

00:07.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 01) (prog-if 00 [UHCI])
	Flags: bus master, medium devsel, latency 64, IRQ 19
	I/O ports at d400 [size=32]

00:07.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 01)
	Flags: medium devsel, IRQ 9

00:08.0 Ethernet controller: 3Com Corporation 3c905C-TX/TX-M [Tornado] (rev 30)
	Subsystem: 3Com Corporation 3C905C-TX Fast Etherlink for PC Management NIC
	Flags: bus master, medium devsel, latency 64, IRQ 16
	I/O ports at d000 [size=128]
	Memory at ec002000 (32-bit, non-prefetchable) [size=128]
	Expansion ROM at ea000000 [disabled] [size=128K]
	Capabilities: [dc] Power Management version 2

00:09.0 PCI bridge: Hint Corp HB1-SE33 PCI-PCI Bridge (rev 13) (prog-if 00 [Normal decode])
	Flags: bus master, medium devsel, latency 64
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=64
	I/O behind bridge: 0000c000-0000cfff
	Memory behind bridge: e4000000-e7ffffff
	Prefetchable memory behind bridge: 00000000e8000000-00000000e9f00000
	Capabilities: [80] Power Management version 2
	Capabilities: [90] #06 [0000]
	Capabilities: [a0] Vital Product Data

00:0a.0 Multimedia audio controller: Ensoniq ES1370 [AudioPCI] (rev 01)
	Subsystem: Unknown device 4942:4c4c
	Flags: bus master, slow devsel, latency 64, IRQ 18
	I/O ports at d800 [size=64]

00:0b.0 Multimedia controller: Philips Semiconductors SAA7146 (rev 01)
	Subsystem: Technotrend Systemtechnik GmbH: Unknown device 0003
	Flags: bus master, medium devsel, latency 64, IRQ 19
	Memory at ec000000 (32-bit, non-prefetchable) [size=512]

00:0c.0 SCSI storage controller: Adaptec AIC-7880U
	Flags: bus master, medium devsel, latency 64, IRQ 16
	I/O ports at dc00 [disabled] [size=256]
	Memory at ec001000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at eb000000 [disabled] [size=64K]

02:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP (rev 85) (prog-if 00 [VGA])
	Subsystem: Matrox Graphics, Inc.: Unknown device 0d43
	Flags: bus master, medium devsel, latency 64, IRQ 17
	Memory at e8000000 (32-bit, prefetchable) [size=32M]
	Memory at e4000000 (32-bit, non-prefetchable) [size=16K]
	Memory at e5000000 (32-bit, non-prefetchable) [size=8M]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [dc] Power Management version 2
	Capabilities: [f0] AGP version 2.0


--envbJBWh7q8WU6mo--

