Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030331AbWARPKN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030331AbWARPKN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 10:10:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030336AbWARPKM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 10:10:12 -0500
Received: from xproxy.gmail.com ([66.249.82.201]:65137 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030331AbWARPKK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 10:10:10 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=oNgUfuH65ULLVBWI11PCDe6rX4wuMiG8OuP/f0y4kXu/EUBBDKhp5r/BqFCq4uv0cfW4f3rUf2VY36rjLyQ+Ai+juz2MVz/yVbo8G6Fpi08RY4Zvq4MMntjdUav7CG9LmD9a2e0BtkNUkc26d2v2jhNlNs4Ucf1toMG/rvwqkLU=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: 2.6.16-rc1-mm1: Oops and BUG()
Date: Wed, 18 Jan 2006 16:10:16 +0100
User-Agent: KMail/1.9
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601181610.16336.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just got an Oops and BUG() with 2.6.16-rc1-mm1.

Full dmesg (including Oops etc) below.

Let me know if there's anything else you need or something you want me to test.


Linux version 2.6.16-rc1-mm1 (juhl@dragon) (gcc version 3.4.5) #1 SMP PREEMPT Wed Jan 18 15:22:43 CET 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e8000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000007ffb0000 (usable)
 BIOS-e820: 000000007ffb0000 - 000000007ffc0000 (ACPI data)
 BIOS-e820: 000000007ffc0000 - 000000007fff0000 (ACPI NVS)
 BIOS-e820: 000000007fff0000 - 0000000080000000 (reserved)
 BIOS-e820: 00000000ff7c0000 - 0000000100000000 (reserved)
1151MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000ff780
On node 0 totalpages: 524208
  DMA zone: 4096 pages, LIFO batch:0
  DMA32 zone: 0 pages, LIFO batch:0
  Normal zone: 225280 pages, LIFO batch:31
  HighMem zone: 294832 pages, LIFO batch:31
DMI 2.3 present.
ACPI: RSDP (v000 ACPIAM                                ) @ 0x000f9bb0
ACPI: RSDT (v001 A M I  OEMRSDT  0x12000506 MSFT 0x00000097) @ 0x7ffb0000
ACPI: FADT (v002 A M I  OEMFACP  0x12000506 MSFT 0x00000097) @ 0x7ffb0200
ACPI: MADT (v001 A M I  OEMAPIC  0x12000506 MSFT 0x00000097) @ 0x7ffb0390
ACPI: OEMB (v001 A M I  AMI_OEM  0x12000506 MSFT 0x00000097) @ 0x7ffc0040
ACPI: DSDT (v001  939M2 939M2150 0x00000150 INTL 0x02002026) @ 0x00000000
ACPI: PM-Timer IO Port: 0x808
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:3 APIC version 16
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1 15:3 APIC version 16
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, GSI 0-23
ACPI: IOAPIC (id[0x03] address[0xfec10000] gsi_base[24])
IOAPIC[1]: apic_id 3, version 17, address 0xfec10000, GSI 24-39
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 2 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 88000000 (gap: 80000000:7f7c0000)
Detected 2200.159 MHz processor.
Built 1 zonelists
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
mapped IOAPIC to ffffb000 (fec10000)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
Kernel command line: auto BOOT_IMAGE=2.6.16-rc1-mm1 ro root=801
CPU 0 irqstacks, hard=c041b000 soft=c0419000
PID hash table entries: 4096 (order: 12, 65536 bytes)
Console: colour dummy device 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 2073816k/2096832k available (2072k kernel code, 21884k reserved, 860k data, 212k init, 1179328k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 4401.75 BogoMIPS (lpj=2200875)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 178bfbff e3d3fbff 00000000 00000000 00000001 00000000 00000003
CPU: After vendor identify, caps: 178bfbff e3d3fbff 00000000 00000000 00000001 00000000 00000003
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 0(2) -> Core 0
CPU: After all inits, caps: 178bfbf7 e3d3fbff 00000000 00000010 00000001 00000000 00000003
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
mtrr: v2.0 (20020519)
Checking 'hlt' instruction... OK.
CPU0: AMD Athlon(tm) 64 X2 Dual Core Processor 4400+ stepping 02
Booting processor 1/1 eip 2000
CPU 1 irqstacks, hard=c041c000 soft=c041a000
Initializing CPU#1
Calibrating delay using timer specific routine.. 4399.52 BogoMIPS (lpj=2199764)
CPU: After generic identify, caps: 178bfbff e3d3fbff 00000000 00000000 00000001 00000000 00000003
CPU: After vendor identify, caps: 178bfbff e3d3fbff 00000000 00000000 00000001 00000000 00000003
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 1(2) -> Core 1
CPU: After all inits, caps: 178bfbf7 e3d3fbff 00000000 00000010 00000001 00000000 00000003
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: AMD Athlon(tm) 64 X2 Dual Core Processor 4400+ stepping 02
Total of 2 processors activated (8801.27 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
checking TSC synchronization across 2 CPUs: 
CPU#0 had 0 usecs TSC skew, fixed it up.
CPU#1 had 0 usecs TSC skew, fixed it up.
Brought up 2 CPUs
migration_cost=405
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 3.00 entry at 0xf0031, last bus=4
PCI: Using configuration type 1
ACPI: Subsystem revision 20051216
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI quirk: region 0800-083f claimed by ali7101 ACPI
Boot video device is 0000:03:00.0
PCI: Transparent bridge - 0000:00:06.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P4._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HTT_._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEB1._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEB2._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 *10 11 12 14 15), disabled.
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 *10 11 12 14 15), disabled.
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs *3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 10 11 12 14 15) *9
ACPI: PCI Interrupt Link [LNKP] (IRQs 3 4 *5 6 7 10 11 12 14 15)
SCSI subsystem initialized
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
PCI: Bridge: 0000:00:01.0
  IO window: disabled.
  MEM window: ff200000-ff2fffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:02.0
  IO window: disabled.
  MEM window: ff300000-ff3fffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:05.0
  IO window: disabled.
  MEM window: ff400000-ff4fffff
  PREFETCH window: c7f00000-d7efffff
PCI: Bridge: 0000:00:06.0
  IO window: d000-dfff
  MEM window: ff500000-ff5fffff
  PREFETCH window: 88000000-880fffff
ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 29 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:01.0 to 64
ACPI: PCI Interrupt 0000:00:02.0[A] -> GSI 34 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:00:02.0 to 64
PCI: Setting latency timer of device 0000:00:05.0 to 64
PCI: Setting latency timer of device 0000:00:06.0 to 64
Machine check exception polling timer started.
apm: BIOS version 1.2 Flags 0x02 (Driver version 1.16ac)
apm: disabled - APM is not SMP safe.
highmem bounce pool size: 64 pages
io scheduler noop registered
io scheduler anticipatory registered
vesafb: framebuffer at 0xc8000000, mapped to 0xf8880000, using 3072k, total 16384k
vesafb: mode is 1024x768x16, linelength=2048, pages=9
vesafb: protected mode interface info at c000:7880
vesafb: scrolling: redraw
vesafb: Truecolor: size=0:5:6:5, shift=0:11:5:0
Console: switching to colour frame buffer device 128x48
fb0: VESA VGA frame buffer device
Real Time Clock Driver v1.12ac
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 2 ports, IRQ sharing disabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
via-rhine.c:v1.10-LK1.2.0-2.6 June-10-2004 Written by Donald Becker
ACPI: PCI Interrupt 0000:04:07.0[A] -> GSI 22 (level, low) -> IRQ 18
PCI: Via IRQ fixup for 0000:04:07.0, from 11 to 2
eth0: VIA Rhine II at 0xff5fec00, 00:50:ba:f2:a3:1d, IRQ 18.
eth0: MII PHY found at address 8, status 0x782d advertising 01e1 Link 45e1.
ACPI: PCI Interrupt 0000:04:06.0[A] -> GSI 21 (level, low) -> IRQ 19
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 7.0
        <Adaptec 29160N Ultra160 SCSI adapter>
        aic7892: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs

  Vendor: PIONEER   Model: DVD-ROM DVD-305   Rev: 1.03
  Type:   CD-ROM                             ANSI SCSI revision: 02
 target0:0:4: Beginning Domain Validation
 target0:0:4: FAST-20 SCSI 20.0 MB/s ST (50 ns, offset 16)
 target0:0:4: Domain Validation skipping write tests
 target0:0:4: Ending Domain Validation
  Vendor: PLEXTOR   Model: CD-R   PX-W1210S  Rev: 1.01
  Type:   CD-ROM                             ANSI SCSI revision: 02
 target0:0:5: Beginning Domain Validation
 target0:0:5: FAST-20 SCSI 20.0 MB/s ST (50 ns, offset 16)
 target0:0:5: Domain Validation skipping write tests
 target0:0:5: Ending Domain Validation
  Vendor: IBM       Model: DDYS-T36950N      Rev: S96H
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi0:A:6:0: Tagged Queuing enabled.  Depth 200
 target0:0:6: Beginning Domain Validation
 target0:0:6: wide asynchronous
 target0:0:6: FAST-80 WIDE SCSI 160.0 MB/s DT (12.5 ns, offset 63)
 target0:0:6: Ending Domain Validation
SCSI device sda: 71687340 512-byte hdwr sectors (36704 MB)
sda: Write Protect is off
sda: Mode Sense: cb 00 00 08
SCSI device sda: drive cache: write back
SCSI device sda: 71687340 512-byte hdwr sectors (36704 MB)
sda: Write Protect is off
sda: Mode Sense: cb 00 00 08
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3 sda4
sd 0:0:6:0: Attached scsi disk sda
sr0: scsi3-mmc drive: 16x/40x cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
sr 0:0:4:0: Attached scsi CD-ROM sr0
sr1: scsi3-mmc drive: 32x/32x writer cd/rw xa/form2 cdda tray
sr 0:0:5:0: Attached scsi CD-ROM sr1
sr 0:0:4:0: Attached scsi generic sg0 type 5
sr 0:0:5:0: Attached scsi generic sg1 type 5
sd 0:0:6:0: Attached scsi generic sg2 type 0
mice: PS/2 mouse device common for all mice
MC: drivers/edac/edac_mc.c version edac_mc  Ver: 2.0.0 Jan 18 2006
NET: Registered protocol family 2
input: AT Translated Set 2 keyboard as /class/input/input0
IP route cache hash table entries: 131072 (order: 7, 524288 bytes)
TCP established hash table entries: 131072 (order: 9, 3145728 bytes)
TCP bind hash table entries: 65536 (order: 8, 1572864 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
Starting balanced_irq
Using IPI Shortcut mode
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
kjournald starting.  Commit interval 5 seconds
Freeing unused kernel memory: 212k freed
Write protecting the kernel read-only data: 330k
Time: tsc clocksource has been installed.
Time: acpi_pm clocksource has been installed.
input: ImExPS/2 Generic Explorer Mouse as /class/input/input1
Adding 763076k swap on /dev/sda3.  Priority:-1 extents:1 across:763076k
EXT3 FS on sda1, internal journal
Linux agpgart interface v0.101 (c) Dave Jones
ReiserFS: sda2: found reiserfs format "3.6" with standard journal
ReiserFS: sda2: using ordered data mode
ReiserFS: sda2: journal params: device sda2, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: sda2: checking transaction log (sda2)
ReiserFS: sda2: Using r5 hash to sort names
ReiserFS: sda4: found reiserfs format "3.6" with standard journal
ReiserFS: sda4: using ordered data mode
ReiserFS: sda4: journal params: device sda4, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: sda4: checking transaction log (sda4)
ReiserFS: sda4: Using r5 hash to sort names
eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
ACPI: PCI Interrupt 0000:04:05.0[A] -> GSI 20 (level, low) -> IRQ 20
usbcore: registered new driver usbfs
usbcore: registered new driver hub
USB Universal Host Controller Interface driver v3.0
Unable to handle kernel paging request at virtual address f4fe4000
 printing eip:
c01a0160
*pde = 004c0067
Oops: 0000 [#1]
PREEMPT SMP DEBUG_PAGEALLOC
last sysfs file: /class/vc/vcs2/dev
Modules linked in: snd_seq_oss snd_seq_midi_event snd_seq snd_pcm_oss snd_mixer_oss uhci_hcd usbcore snd_emu10k1 snd_rawmidi snd_ac97_codec snd_ac97_bus snd_pcm snd_seq_device snd_timer snd_page_alloc snd_util_mem snd_hwdep snd agpgart
CPU:    0
EIP:    0060:[<c01a0160>]    Not tainted VLI
EFLAGS: 00010216   (2.6.16-rc1-mm1) 
EIP is at reiserfs_cache_bitmap_metadata+0x50/0x80
eax: 08000000   ebx: f4fe3ffc   ecx: f8b99184   edx: 00000020
esi: 00000008   edi: 00000001   ebp: f7fe1b98   esp: f7fe1b8c
ds: 007b   es: 007b   ss: 0068
Process cat (pid: 2487, threadinfo=f7fe1000 task=f4fb6aa0)
Stack: <0>f4ef3f68 f7070bf8 00001000 f7fe1bbc c01a021b f7070bf8 f4ef3914 c01ba4cc 
       f8b99184 001dbc49 00308800 f56df000 f7fe1c00 c019e525 c01ba6e0 04040404 
       04040404 04040404 00000800 f8b99184 f7070bf8 f7fe1c3c 00000061 f7fe1ebc 
Call Trace:
 <c0103e01> show_stack_log_lvl+0xa1/0xe0   <c0103fc6> show_registers+0x156/0x1d0
 <c01041ee> die+0x11e/0x1b0   <c01176b9> do_page_fault+0x389/0x548
 <c0103a3b> error_code+0x4f/0x54   <c01a021b> reiserfs_read_bitmap_block+0x8b/0xc0
 <c019e525> scan_bitmap_block+0x55/0x2d0   <c019e9a6> scan_bitmap+0xe6/0x210
 <c019fcad> reiserfs_allocate_blocknrs+0x18d/0x4d0   <c01ab861> reiserfs_allocate_blocks_for_region+0x201/0x14d0
 <c01ae2df> reiserfs_file_write+0x74f/0x790   <c016511a> vfs_write+0x8a/0x160
 <c016529d> sys_write+0x3d/0x70   <c0102f39> syscall_call+0x7/0xb
Code: 66 89 01 4f 83 c3 04 85 ff 7f e3 66 83 39 00 74 36 5b 5e 5f c9 c3 40 8d 74 26 00 74 e6 8d 34 fd 00 00 00 00 ba 20 00 00 00 89 f6 <0f> a3 13 19 c0 85 c0 75 0a 66 ff 41 02 8d 04 16 66 89 01 4a 79 
 Badness in do_exit at kernel/exit.c:799
 <c0103d5d> show_trace+0xd/0x10   <c0103e67> dump_stack+0x17/0x20
 <c0123cd0> do_exit+0x460/0x470   <c0104275> die+0x1a5/0x1b0
 <c01176b9> do_page_fault+0x389/0x548   <c0103a3b> error_code+0x4f/0x54
 <c01a021b> reiserfs_read_bitmap_block+0x8b/0xc0   <c019e525> scan_bitmap_block+0x55/0x2d0
 <c019e9a6> scan_bitmap+0xe6/0x210   <c019fcad> reiserfs_allocate_blocknrs+0x18d/0x4d0
 <c01ab861> reiserfs_allocate_blocks_for_region+0x201/0x14d0   <c01ae2df> reiserfs_file_write+0x74f/0x790
 <c016511a> vfs_write+0x8a/0x160   <c016529d> sys_write+0x3d/0x70
 <c0102f39> syscall_call+0x7/0xb  
Assertion failure in journal_start() at fs/jbd/transaction.c:270: "handle->h_transaction->t_journal == journal"
------------[ cut here ]------------
kernel BUG at fs/jbd/transaction.c:270!
invalid opcode: 0000 [#2]
PREEMPT SMP DEBUG_PAGEALLOC
last sysfs file: /class/vc/vcs2/dev
Modules linked in: snd_seq_oss snd_seq_midi_event snd_seq snd_pcm_oss snd_mixer_oss uhci_hcd usbcore snd_emu10k1 snd_rawmidi snd_ac97_codec snd_ac97_bus snd_pcm snd_seq_device snd_timer snd_page_alloc snd_util_mem snd_hwdep snd agpgart
CPU:    0
EIP:    0060:[<c01d675f>]    Not tainted VLI
EFLAGS: 00010282   (2.6.16-rc1-mm1) 
EIP is at journal_start+0x5f/0xc0
eax: 00000073   ebx: f7fe1ebc   ecx: c03605e4   edx: 00000001
esi: f7ceddf8   edi: f7fe1000   ebp: f7fe1970   esp: f7fe1950
ds: 007b   es: 007b   ss: 0068
Process cat (pid: 2487, threadinfo=f7fe1000 task=f4fb6aa0)
Stack: <0>c03263b4 c030b982 c0320ddb 0000010e c0328194 f70bae04 f70bae04 f7fe19e8 
       f7fe1984 c01d1548 f70bae04 f70bae04 f7fe19e8 f7fe1994 c01c9a91 f70bae04 
       f70bae04 f7fe19a4 c01c9b3c c01c9b10 f70bae04 f7fe19b4 c017fe21 f70bae04 
Call Trace:
 <c0103e01> show_stack_log_lvl+0xa1/0xe0   <c0103fc6> show_registers+0x156/0x1d0
 <c01041ee> die+0x11e/0x1b0   <c01042ff> do_trap+0x7f/0xc0
 <c0104613> do_invalid_op+0xa3/0xb0   <c0103a3b> error_code+0x4f/0x54
 <c01d1548> ext3_journal_start_sb+0x48/0x50   <c01c9a91> start_transaction+0x21/0x50
 <c01c9b3c> ext3_delete_inode+0x2c/0x100   <c017fe21> generic_delete_inode+0x61/0xd0
 <c017ffdf> generic_drop_inode+0xf/0x20   <c0180046> iput+0x56/0x80
 <c017cb9a> dentry_iput+0x5a/0xb0   <c017ce81> dput_recursive+0x101/0x230
 <c017cfbe> dput+0xe/0x10   <c0165f2d> __fput+0x13d/0x1b0
 <c0165ddb> fput+0x3b/0x50   <c016462c> filp_close+0x3c/0x80
 <c0122e28> close_files+0x58/0x70   <c0122ec7> put_files_struct+0x47/0x80
 <c01239af> do_exit+0x13f/0x470   <c0104275> die+0x1a5/0x1b0
 <c01176b9> do_page_fault+0x389/0x548   <c0103a3b> error_code+0x4f/0x54
 <c01a021b> reiserfs_read_bitmap_block+0x8b/0xc0   <c019e525> scan_bitmap_block+0x55/0x2d0
 <c019e9a6> scan_bitmap+0xe6/0x210   <c019fcad> reiserfs_allocate_blocknrs+0x18d/0x4d0
 <c01ab861> reiserfs_allocate_blocks_for_region+0x201/0x14d0   <c01ae2df> reiserfs_file_write+0x74f/0x790
 <c016511a> vfs_write+0x8a/0x160   <c016529d> sys_write+0x3d/0x70
 <c0102f39> syscall_call+0x7/0xb  
Code: 44 24 10 94 81 32 c0 c7 44 24 0c 0e 01 00 00 c7 44 24 08 db 0d 32 c0 c7 44 24 04 82 b9 30 c0 c7 04 24 b4 63 32 c0 e8 81 ad f4 ff <0f> 0b 0e 01 db 0d 32 c0 ff 43 08 89 d8 8b 5d f4 8b 75 f8 8b 7d 
 Badness in do_exit at kernel/exit.c:799
 <c0103d5d> show_trace+0xd/0x10   <c0103e67> dump_stack+0x17/0x20
 <c0123cd0> do_exit+0x460/0x470   <c0104275> die+0x1a5/0x1b0
 <c01042ff> do_trap+0x7f/0xc0   <c0104613> do_invalid_op+0xa3/0xb0
 <c0103a3b> error_code+0x4f/0x54   <c01d1548> ext3_journal_start_sb+0x48/0x50
 <c01c9a91> start_transaction+0x21/0x50   <c01c9b3c> ext3_delete_inode+0x2c/0x100
 <c017fe21> generic_delete_inode+0x61/0xd0   <c017ffdf> generic_drop_inode+0xf/0x20
 <c0180046> iput+0x56/0x80   <c017cb9a> dentry_iput+0x5a/0xb0
 <c017ce81> dput_recursive+0x101/0x230   <c017cfbe> dput+0xe/0x10
 <c0165f2d> __fput+0x13d/0x1b0   <c0165ddb> fput+0x3b/0x50
 <c016462c> filp_close+0x3c/0x80   <c0122e28> close_files+0x58/0x70
 <c0122ec7> put_files_struct+0x47/0x80   <c01239af> do_exit+0x13f/0x470
 <c0104275> die+0x1a5/0x1b0   <c01176b9> do_page_fault+0x389/0x548
 <c0103a3b> error_code+0x4f/0x54   <c01a021b> reiserfs_read_bitmap_block+0x8b/0xc0
 <c019e525> scan_bitmap_block+0x55/0x2d0   <c019e9a6> scan_bitmap+0xe6/0x210
 <c019fcad> reiserfs_allocate_blocknrs+0x18d/0x4d0   <c01ab861> reiserfs_allocate_blocks_for_region+0x201/0x14d0
 <c01ae2df> reiserfs_file_write+0x74f/0x790   <c016511a> vfs_write+0x8a/0x160
 <c016529d> sys_write+0x3d/0x70   <c0102f39> syscall_call+0x7/0xb
Fixing recursive fault but reboot is needed!



-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html

