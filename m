Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750871AbWCXP2S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750871AbWCXP2S (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 10:28:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750842AbWCXP2S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 10:28:18 -0500
Received: from odin2.bull.net ([192.90.70.84]:51592 "EHLO odin2.bull.net")
	by vger.kernel.org with ESMTP id S1750823AbWCXP2R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 10:28:17 -0500
From: "Serge Noiraud" <serge.noiraud@bull.net>
To: Ingo Molnar <mingo@elte.hu>, "linux-kernel" <linux-kernel@vger.kernel.org>,
       Thomas Gleixner <tglx@linutronix.de>
Subject: RT 2.6.16-rt6 : I can't boot any more
Date: Fri, 24 Mar 2006 16:28:09 +0100
User-Agent: KMail/1.7.1
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_KABJE3TPkVMaWeI"
Message-Id: <200603241628.10126.Serge.Noiraud@bull.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_KABJE3TPkVMaWeI
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

	I get some problem since 2.6.16. It worked with 2.6.15-rt21.

My machine is an HP workstation xw8200 ( IA32 ).
The console trace is in copy.
Is it a problem or a missconfiguration ?
Do you need my config file ?

Is the following a problem ?
TSC clocksource dbg: 3600447 khz, rating=300 mult=1164940 shift=22
    current value: 351834818184  current jiffies: 4294691830
Time: tsc clocksource has been installed.
hrtimers: Switched to high resolution mode CPU 1
Time: tsc clocksource has been installed.
hrtimers: Switched to high resolution mode CPU 1
hrtimers: Switched to high resolution mode CPU 0
check_periodic_interval: Long interval! 222791935 ns.
        Something may be blocking interrupts.

-- 
Serge Noiraud

--Boundary-00=_KABJE3TPkVMaWeI
Content-Type: text/plain;
  charset="iso-8859-15";
  name="HPworkstationXW8200.2.6.16-rt6.2.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="HPworkstationXW8200.2.6.16-rt6.2.txt"


Loading 2.6.16rt6..............................................
BIOS data check successful
Linux version 2.6.16-rt6 (root@XXXXXXXXXXXXXXXXXXXX.fr) (gcc version 3.4.1 (Mandrakelinux 10.1 3.4.1-4mdk)) #1 SMP PREEMPT Thu Mar 23 19:03:27 CET 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009ec00 (usable)
 BIOS-e820: 000000000009ec00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e8000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000007fff5000 (usable)
 BIOS-e820: 000000007fff5000 - 0000000080000000 (reserved)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
1151MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000f9bf0
On node 0 totalpages: 524277
  DMA zone: 4096 pages, LIFO batch:0
  DMA32 zone: 0 pages, LIFO batch:0
  Normal zone: 225280 pages, LIFO batch:31
  HighMem zone: 294901 pages, LIFO batch:31
DMI 2.3 present.
ACPI: RSDP (v002 COMPAQ                                ) @ 0x000e8a10
ACPI: XSDT (v001 COMPAQ CPQ0063  0x20050602  0x00000000) @ 0x7fff50ec
ACPI: FADT (v003 COMPAQ TUMWATER 0x00000001  0x00000000) @ 0x7fff52ac
ACPI: SSDT (v001 COMPAQ  PROJECT 0x00000001 MSFT 0x0100000e) @ 0x7fff6592
ACPI: MADT (v001 COMPAQ TUMWATER 0x00000001  0x00000000) @ 0x7fff53b8
ACPI: ASF! (v016 COMPAQ TUMWATER 0x00000001  0x00000000) @ 0x7fff5454
ACPI: MCFG (v001 COMPAQ TUMWATER 0x00000001  0x00000000) @ 0x7fff54be
ACPI: DSDT (v001 COMPAQ     DSDT 0x00000001 MSFT 0x0100000e) @ 0x00000000
ACPI: PM-Timer IO Port: 0xf808
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:4 APIC version 20
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x06] enabled)
Processor #6 15:4 APIC version 20
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x01] disabled)
ACPI: LAPIC (acpi_id[0x04] lapic_id[0x07] disabled)
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 1, version 32, address 0xfec00000, GSI 0-23
ACPI: IOAPIC (id[0x02] address[0xfec81000] gsi_base[24])
IOAPIC[1]: apic_id 2, version 32, address 0xfec81000, GSI 24-47
ACPI: IOAPIC (id[0x03] address[0xfec81400] gsi_base[48])
IOAPIC[2]: apic_id 3, version 32, address 0xfec81400, GSI 48-71
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 3 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 88000000 (gap: 80000000:7ec00000)
Detected 3600.447 MHz processor.
Real-Time Preemption Support (C) 2004-2006 Ingo Molnar
Built 1 zonelists
Kernel command line: BOOT_IMAGE=2.6.16rt6 ro root=806 nousb nofirewire nmi_watchdog=1 console=ttyS0 console=tty1 resume=/dev/sda5
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
mapped IOAPIC to ffffb000 (fec81000)
mapped IOAPIC to ffffa000 (fec81400)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
WARNING: experimental RCU implementation.
PID hash table entries: 4096 (order: 12, 65536 bytes)
Event source pit installed with caps set: 01
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 2069948k/2097108k available (3519k kernel code, 26768k reserved, 981k data, 520k init, 1179604k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 7203.36 BogoMIPS (lpj=3601680)
Security Framework v1.0.0 initialized
Mount-cache hash table entries: 512
CPU: After generic identify, caps: bfebfbff 20100000 00000000 00000000 0000659d 00000000 00000000
CPU: After vendor identify, caps: bfebfbff 20100000 00000000 00000000 0000659d 00000000 00000000
monitor/mwait feature present.
using mwait in idle threads.
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU: Hyper-Threading is disabled
CPU: After all inits, caps: bfebfbff 20100000 00000000 00000180 0000659d 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (24) available
Checking 'hlt' instruction... OK.
CPU0: Intel(R) Xeon(TM) CPU 3.60GHz stepping 01
Booting processor 1/6 eip 2000
Initializing CPU#1
Calibrating delay using timer specific routine.. 7199.31 BogoMIPS (lpj=3599655)
CPU: After generic identify, caps: bfebfbff 20100000 00000000 00000000 0000659d 00000000 00000000
CPU: After vendor identify, caps: bfebfbff 20100000 00000000 00000000 0000659d 00000000 00000000
monitor/mwait feature present.
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU: Hyper-Threading is disabled
CPU: After all inits, caps: bfebfbff 20100000 00000000 00000180 0000659d 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel P4/Xeon Extended MCE MSRs (24) available
CPU1: Intel(R) Xeon(TM) CPU 3.60GHz stepping 01
Total of 2 processors activated (14402.67 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
Event source lapic installed with caps set: 0e
checking TSC synchronization across 2 CPUs: passed.
Event source lapic installed with caps set: 0e
Brought up 2 CPUs
checking if image is initramfs...it isn't (no cpio magic); looks like an initrd
Freeing initrd memory: 54k freed
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.20 entry at 0xeb11a, last bus=64
PCI: Using MMCONFIG
ACPI: Subsystem revision 20060127
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Interrupt Link [LNKA] (IRQs *3 4 5 6 7 10 11 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 *5 6 7 10 11 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 *10 11 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 10 *11 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs *3 4 5 6 7 10 11 14 15)
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
PCI quirk: region f800-f87f claimed by ICH4 ACPI/GPIO/TCO
PCI quirk: region fa00-fa3f claimed by ICH4 GPIO
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
PCI: PXH quirk detected, disabling MSI for SHPC device
PCI: PXH quirk detected, disabling MSI for SHPC device
Boot video device is 0000:40:00.0
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.XPA_._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.XPB_._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB_._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.XPA1.PXA_._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.XPA1.PXB_._PRT]
Linux Plug and Play Support v0.97 (c) Adam Belay
SCSI subsystem initialized
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
PCI: Bridge: 0000:00:02.0
  IO window: d000-dfff
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:01:00.0
  IO window: 4000-4fff
  MEM window: fa000000-fa4fffff
  PREFETCH window: 88000000-882fffff
PCI: Bridge: 0000:01:00.2
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:03.0
  IO window: 4000-4fff
  MEM window: fa000000-fa5fffff
  PREFETCH window: 88000000-882fffff
PCI: Failed to allocate mem resource #6:20000@f8000000 for 0000:40:00.0
PCI: Bridge: 0000:00:04.0
  IO window: disabled.
  MEM window: f8000000-f9ffffff
  PREFETCH window: f0000000-f7ffffff
PCI: Bridge: 0000:00:1e.0
  IO window: 3000-3fff
  MEM window: fa600000-fa6fffff
  PREFETCH window: 88300000-883fffff
ACPI: PCI Interrupt 0000:00:02.0[A] -> GSI 16 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:00:02.0 to 64
ACPI: PCI Interrupt 0000:00:03.0[A] -> GSI 16 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:00:03.0 to 64
PCI: Setting latency timer of device 0000:01:00.0 to 64
PCI: Setting latency timer of device 0000:01:00.2 to 64
ACPI: PCI Interrupt 0000:00:04.0[A] -> GSI 16 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:00:04.0 to 64
PCI: Setting latency timer of device 0000:00:1e.0 to 64
register_clocksource: Registering pit
register_clocksource: Registering tsc
Initializing RT-Tester: OK
No per-cpu room for modules.
register_clocksource: Registering jiffies
highmem bounce pool size: 64 pages
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
SGI XFS with ACLs, no debug enabled
SGI XFS Quota Management subsystem
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
ACPI: PCI Interrupt 0000:00:02.0[A] -> GSI 16 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:00:02.0 to 64
Allocate Port Service[0000:00:02.0:pcie00]
Allocate Port Service[0000:00:02.0:pcie01]
ACPI: PCI Interrupt 0000:00:03.0[A] -> GSI 16 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:00:03.0 to 64
Allocate Port Service[0000:00:03.0:pcie00]
Allocate Port Service[0000:00:03.0:pcie01]
ACPI: PCI Interrupt 0000:00:04.0[A] -> GSI 16 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:00:04.0 to 64
Allocate Port Service[0000:00:04.0:pcie00]
Allocate Port Service[0000:00:04.0:pcie01]
vga16fb: initializing
vga16fb: mapped to 0xc00a0000
Console: switching to colour frame buffer device 80x30
fb0: VGA16 VGA frame buffer device
Real Time Clock Driver v1.12ac
Linux agpgart interface v0.101 (c) Dave Jones
PNP: No PS/2 controller found. Probing ports directly.
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 32000K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH5: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 177
ICH5: chipset revision 2
ICH5: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x54e0-0x54e7, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0x54e8-0x54ef, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
Probing IDE interface ide1...
hdc: PHILIPS DVD8631, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
Probing IDE interface ide0...
hdc: ATAPI 40X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(44)
Uniform CD-ROM driver Revision: 3.20
ide-floppy driver 0.99.newide
megaraid cmm: 2.20.2.6 (Release Date: Mon Mar 7 00:01:03 EST 2005)
megaraid: 2.20.4.7 (Release Date: Mon Nov 14 12:27:22 EST 2005)
megasas: 00.00.02.04 Fri Feb 03 14:31:44 PST 2006
st: Version 20050830, fixed bufsize 32768, s/g segs 256
osst :I: Tape driver with OnStream support version 0.99.3
osst :I: $Id: osst.c,v 1.73 2005/01/01 21:13:34 wriede Exp $
SCSI Media Changer driver v0.25 
Fusion MPT base driver 3.03.07
Copyright (c) 1999-2005 LSI Logic Corporation
Fusion MPT SPI Host driver 3.03.07
ACPI: PCI Interrupt 0000:02:05.0[A] -> GSI 30 (level, low) -> IRQ 185
mptbase: Initiating ioc0 bringup
ioc0: 53C1030: Capabilities={Initiator}
scsi0 : ioc0: LSI53C1030, FwRev=01030800h, Ports=1, MaxQ=222, IRQ=185
  Vendor: FUJITSU   Model: MAT3073NP         Rev: HPF5
  Type:   Direct-Access                      ANSI SCSI revision: 03
SCSI device sda: 143374738 512-byte hdwr sectors (73408 MB)
sda: Write Protect is off
sda: Mode Sense: cf 00 10 08
SCSI device sda: drive cache: write back w/ FUA
SCSI device sda: 143374738 512-byte hdwr sectors (73408 MB)
sda: Write Protect is off
sda: Mode Sense: cf 00 10 08
SCSI device sda: drive cache: write back w/ FUA
 sda: sda1 sda2 < sda5 sda6 sda7 sda8 >
sd 0:0:0:0: Attached scsi disk sda
sd 0:0:0:0: Attached scsi generic sg0 type 0
ACPI: PCI Interrupt 0000:02:05.1[B] -> GSI 31 (level, low) -> IRQ 193
mptbase: Initiating ioc1 bringup
ioc1: 53C1030: Capabilities={Initiator}
scsi1 : ioc1: LSI53C1030, FwRev=01030800h, Ports=1, MaxQ=222, IRQ=193
Fusion MPT FC Host driver 3.03.07
Fusion MPT SAS Host driver 3.03.07
Fusion MPT misc device (ioctl) driver 3.03.07
mptctl: Registered with Fusion MPT base driver
mptctl: /dev/mptctl @ (major,minor=10,220)
Fusion MPT LAN driver 3.03.07
mptlan: ioc0: PortNum=0, ProtocolFlags=08h (Itlb)
mptlan: ioc0: Hmmm... LAN protocol seems to be disabled on this adapter port!
mptlan: ioc1: PortNum=0, ProtocolFlags=08h (Itlb)
mptlan: ioc1: Hmmm... LAN protocol seems to be disabled on this adapter port!
mice: PS/2 mouse device common for all mice
register_clocksource: Registering acpi_pm
NET: Registered protocol family 2
input: AT Translated Set 2 keyboard as /class/input/input0
IP route cache hash table entries: 131072 (order: 7, 524288 bytes)
TCP established hash table entries: 32768 (order: 9, 2490368 bytes)
input: ImPS/2 Generic Wheel Mouse as /class/input/input1
TCP bind hash table entries: 32768 (order: 9, 2359296 bytes)
TCP: Hash tables configured (established 32768 bind 32768)
TCP reno registered
TCP bic registered
NET: Registered protocol family 1
Testing NMI watchdog ... OK.
Using IPI Shortcut mode
RAMDISK: Compressed image found at block 0
TSC clocksource dbg: 3600447 khz, rating=300 mult=1164940 shift=22
	current value: 351834818184  current jiffies: 4294691830
Time: tsc clocksource has been installed.
hrtimers: Switched to high resolution mode CPU 1
hrtimers: Switched to high resolution mode CPU 0
check_periodic_interval: Long interval! 222791935 ns.
		Something may be blocking interrupts.
VFS: Mounted root (ext2 filesystem).
BUG: scheduling with  irqs disabled: swapper/0x00010001/0
BUG: Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
c0118b81
*pde = 00000000
Oops: 0002 [#1]
PREEMPT SMP 
Modules linked in:
CPU:    0
EIP:    0060:[<c0118b81>]    Not tainted VLI
EFLAGS: 00010046   (2.6.16-rt6 #1) 
EIP is at enqueue_task+0x41/0xa0
eax: c207fae0   ebx: c21d3030   ecx: 00000000   edx: c21d3054
esi: c207f664   edi: c21d3030   ebp: f707bd90   esp: f707bd7c
ds: 007b   es: 007b   ss: 0068   preempt: 00000003
Process udevstart (pid: 915, threadinfo=f707a000 task=c22530f0 stack_left=7496 worst_left=-1)
Stack: <0>c21d3030 f707bd90 c046ee3a 00000001 c05ab3a0 f707bdec c0119b7e c21d3030 
       c207f664 00000000 00000002 f707bdbc c01113e0 00000002 00000002 c225366c 
       c207f1a0 00000002 00000000 c207f1a0 00000004 00000000 00000000 00000000 
Call Trace:
 [<c010455a>] show_stack_log_lvl+0xba/0xf0 (32)
 [<c01047ce>] show_registers+0x1de/0x250 (68)
 [<c01049fd>] die+0x10d/0x1a0 (68)
 [<c01174c2>] do_page_fault+0x3a2/0x5b0 (96)
 [<c0104143>] error_code+0x4f/0x54 (80)
 [<c0119b7e>] try_to_wake_up+0x2be/0x4e0 (92)
 [<c0119e4c>] wake_up_process_mutex+0x2c/0x40 (28)
 [<c0140925>] wakeup_next_waiter+0x115/0x1e0 (48)
 [<c046defc>] rt_lock_slowunlock+0x6c/0x90 (28)
 [<c046e790>] rt_unlock+0x10/0x20 (12)
 [<c0148ea9>] get_check_value+0x39/0x60 (20)
 [<c01495a9>] get_monotonic_clock_ts+0x19/0x170 (72)
 [<c01207ac>] copy_process+0x35c/0x10d0 (84)
 [<c012161f>] do_fork+0x6f/0x1c0 (132)
 [<c0101f07>] sys_fork+0x37/0x40 (32)
 [<c010354a>] syscall_call+0x7/0xb (-8116)
---------------------------
| preempt count: 00000003 ]
| 3-level deep critical section nesting:
----------------------------------------
.. [<c046ebf7>] .... _raw_spin_lock_irqsave+0x27/0x70
.....[<c046deab>] ..   ( <= rt_lock_slowunlock+0x1b/0x90)
.. [<c046ee3a>] .... _raw_spin_lock+0x1a/0x30
.....[<c0119916>] ..   ( <= try_to_wake_up+0x56/0x4e0)
.. [<c046ebf7>] .... _raw_spin_lock_irqsave+0x27/0x70
.....[<c0104939>] ..   ( <= die+0x49/0x1a0)

------------------------------
| showing all locks held by: |  (udevstart/915 [c22530f0, 125]):
------------------------------

Code: 08 75 49 8b 83 80 00 00 00 85 c0 75 0b a1 c0 a2 55 c0 89 83 80 00 00 00 8b 43 18 8d 53 24 8d 44 c6 1c 89 43 24 8b 48 04 89 50 04 <89> 11 89 4a 04 8b 43 18 ff 46 04 0f ab 46 08 89 73 2c 8b 16 83 
 <6>note: udevstart[915] exited with preempt_count 2
BUG: scheduling while atomic: udevstart/0x00000002/915
caller is do_exit+0x2e2/0x560
 [<c0104496>] show_trace+0x26/0x30 (20)
 [<c01045e3>] dump_stack+0x23/0x30 (20)
 [<c046ca42>] __schedule+0x712/0x9b0 (96)
 [<c0125de2>] do_exit+0x2e2/0x560 (44)
 [<c0104a8d>] die+0x19d/0x1a0 (68)
 [<c01174c2>] do_page_fault+0x3a2/0x5b0 (96)
 [<c0104143>] error_code+0x4f/0x54 (80)
 [<c0119b7e>] try_to_wake_up+0x2be/0x4e0 (92)
 [<c0119e4c>] wake_up_process_mutex+0x2c/0x40 (28)
 [<c0140925>] wakeup_next_waiter+0x115/0x1e0 (48)
 [<c046defc>] rt_lock_slowunlock+0x6c/0x90 (28)
 [<c046e790>] rt_unlock+0x10/0x20 (12)
 [<c0148ea9>] get_check_value+0x39/0x60 (20)
 [<c01495a9>] get_monotonic_clock_ts+0x19/0x170 (72)
 [<c01207ac>] copy_process+0x35c/0x10d0 (84)
 [<c012161f>] do_fork+0x6f/0x1c0 (132)
 [<c0101f07>] sys_fork+0x37/0x40 (32)
 [<c010354a>] syscall_call+0x7/0xb (-8116)
---------------------------
| preempt count: 00000002 ]
| 2-level deep critical section nesting:
----------------------------------------
.. [<c046ebf7>] .... _raw_spin_lock_irqsave+0x27/0x70
.....[<c046deab>] ..   ( <= rt_lock_slowunlock+0x1b/0x90)
.. [<c046ee3a>] .... _raw_spin_lock+0x1a/0x30
.....[<c0119916>] ..   ( <= try_to_wake_up+0x56/0x4e0)

------------------------------
| showing all locks held by: |  (udevstart/915 [c22530f0, 125]):
------------------------------

caller is rt_lock_slowlock+0x95/0x260
 [<c0104496>] show_trace+0x26/0x30 (20)
 [<c01045e3>] dump_stack+0x23/0x30 (20)
 [<c046cda6>] schedule+0xc6/0x140 (36)
 [<c046dcc5>] rt_lock_slowlock+0x95/0x260 (132)
 [<c046e773>] __lock_text_start+0x13/0x20 (16)
 [<c0148e93>] get_check_value+0x23/0x60 (20)
 [<c01493fc>] __get_monotonic_clock+0x9c/0xe0 (60)
 [<c0149473>] get_monotonic_clock+0x33/0x70 (32)
 [<c0148d62>] clockevents_set_next_event+0x32/0xd0 (48)
 [<c013d322>] hrtimer_interrupt+0x1a2/0x260 (84)
 [<c0148940>] handle_nextevent_update_profile+0x10/0x30 (12)
 [<c0112435>] smp_apic_timer_interrupt+0x85/0x90 (24)
 [<c010408f>] apic_timer_interrupt+0x27/0x2c (72)
 [<c0101098>] cpu_idle+0x78/0x120 (40)
 [<c0110ac8>] start_secondary+0x138/0x390 (40)
 [<00000000>] stext+0x3feffd64/0x4 (-4)
 [<c21d9fb4>] 0xc21d9fb4 (1038245964)
---------------------------
| preempt count: 00010001 ]
| 1-level deep critical section nesting:
----------------------------------------
.. [<c01010fb>] .... cpu_idle+0xdb/0x120
.....[<c0110ac8>] ..   ( <= start_secondary+0x138/0x390)

------------------------------
| showing all locks held by: |  (swapper/0 [c21d3030, 140]):
------------------------------

BUG: scheduling while atomic: swapper/0x00010001/0
caller is schedule+0x45/0x140
 [<c0104496>] show_trace+0x26/0x30 (20)
 [<c01045e3>] dump_stack+0x23/0x30 (20)
 [<c046ca42>] __schedule+0x712/0x9b0 (96)
 [<c046cd25>] schedule+0x45/0x140 (36)
 [<c046dcc5>] rt_lock_slowlock+0x95/0x260 (132)
 [<c046e773>] __lock_text_start+0x13/0x20 (16)
 [<c0148e93>] get_check_value+0x23/0x60 (20)
 [<c01493fc>] __get_monotonic_clock+0x9c/0xe0 (60)
 [<c0149473>] get_monotonic_clock+0x33/0x70 (32)
 [<c0148d62>] clockevents_set_next_event+0x32/0xd0 (48)
 [<c013d322>] hrtimer_interrupt+0x1a2/0x260 (84)
 [<c0148940>] handle_nextevent_update_profile+0x10/0x30 (12)
 [<c0112435>] smp_apic_timer_interrupt+0x85/0x90 (24)
 [<c010408f>] apic_timer_interrupt+0x27/0x2c (72)
 [<c0101098>] cpu_idle+0x78/0x120 (40)
 [<c0110ac8>] start_secondary+0x138/0x390 (40)
 [<00000000>] stext+0x3feffd64/0x4 (-4)
 [<c21d9fb4>] 0xc21d9fb4 (1038245964)
---------------------------
| preempt count: 00010001 ]
| 1-level deep critical section nesting:
----------------------------------------
.. [<c01010fb>] .... cpu_idle+0xdb/0x120
.....[<c0110ac8>] ..   ( <= start_secondary+0x138/0x390)

------------------------------
| showing all locks held by: |  (swapper/0 [c21d3030, 140]):
------------------------------

BUG: scheduling from the idle thread!
 [<c0104496>] show_trace+0x26/0x30 (20)
 [<c01045e3>] dump_stack+0x23/0x30 (20)
 [<c046c978>] __schedule+0x648/0x9b0 (96)
 [<c046cd25>] schedule+0x45/0x140 (36)
 [<c046dcc5>] rt_lock_slowlock+0x95/0x260 (132)
 [<c046e773>] __lock_text_start+0x13/0x20 (16)
 [<c0148e93>] get_check_value+0x23/0x60 (20)
 [<c01493fc>] __get_monotonic_clock+0x9c/0xe0 (60)
 [<c0149473>] get_monotonic_clock+0x33/0x70 (32)
 [<c0148d62>] clockevents_set_next_event+0x32/0xd0 (48)
 [<c013d322>] hrtimer_interrupt+0x1a2/0x260 (84)
 [<c0148940>] handle_nextevent_update_profile+0x10/0x30 (12)
 [<c0112435>] smp_apic_timer_interrupt+0x85/0x90 (24)
 [<c010408f>] apic_timer_interrupt+0x27/0x2c (72)
 [<c0101098>] cpu_idle+0x78/0x120 (40)
 [<c0110ac8>] start_secondary+0x138/0x390 (40)
 [<00000000>] stext+0x3feffd64/0x4 (-4)
 [<c21d9fb4>] 0xc21d9fb4 (1038245964)
---------------------------
| preempt count: 00010002 ]
| 2-level deep critical section nesting:
----------------------------------------
.. [<c01010fb>] .... cpu_idle+0xdb/0x120
.....[<c0110ac8>] ..   ( <= start_secondary+0x138/0x390)
.. [<c046c37e>] .... __schedule+0x4e/0x9b0
.....[<c046cd25>] ..   ( <= schedule+0x45/0x140)

------------------------------
| showing all locks held by: |  (swapper/0 [c21d3030, 140]):
------------------------------

NMI watchdog detected lockup on CPU#1 (5000/5000)

Pid: 0, comm:              swapper
EIP: 0060:[<c046ec67>] CPU: 1
EIP is at _raw_spin_lock_irq+0x27/0x40
 EFLAGS: 00000086    Not tainted  (2.6.16-rt6 #1)
EAX: 00000097 EBX: c207f1a0 ECX: c046ec60 EDX: 00000003
ESI: c207f1a0 EDI: 00000000 EBP: c21d9cf0 DS: 007b ES: 007b
CR0: 8005003b CR2: b7f12ffc CR3: 005ea000 CR4: 000006d0
 [<c0104496>] show_trace+0x26/0x30 (20)
 [<c0101511>] show_regs+0x171/0x1a0 (44)
 [<c0112e76>] nmi_watchdog_tick+0x1f6/0x320 (44)
 [<c010572a>] default_do_nmi+0x7a/0x180 (96)
 [<c0105898>] do_nmi+0x58/0x60 (24)
 [<c01041f2>] nmi_stack_correct+0x1d/0x22 (68)
 [<c046c42f>] __schedule+0xff/0x9b0 (96)
 [<c046cd25>] schedule+0x45/0x140 (36)
 [<c046dcc5>] rt_lock_slowlock+0x95/0x260 (132)
 [<c046e773>] __lock_text_start+0x13/0x20 (16)
 [<c0148e93>] get_check_value+0x23/0x60 (20)
 [<c01493fc>] __get_monotonic_clock+0x9c/0xe0 (60)
 [<c0149473>] get_monotonic_clock+0x33/0x70 (32)
 [<c0148d62>] clockevents_set_next_event+0x32/0xd0 (48)
 [<c013d322>] hrtimer_interrupt+0x1a2/0x260 (84)
 [<c0148940>] handle_nextevent_update_profile+0x10/0x30 (12)
 [<c0112435>] smp_apic_timer_interrupt+0x85/0x90 (24)
 [<c010408f>] apic_timer_interrupt+0x27/0x2c (72)
 [<c0101098>] cpu_idle+0x78/0x120 (40)
 [<c0110ac8>] start_secondary+0x138/0x390 (40)
 [<00000000>] stext+0x3feffd64/0x4 (-4)
 [<c21d9fb4>] 0xc21d9fb4 (1038245964)
---------------------------
| preempt count: 00010004 ]
| 4-level deep critical section nesting:
----------------------------------------
.. [<c01010fb>] .... cpu_idle+0xdb/0x120
.....[<c0110ac8>] ..   ( <= start_secondary+0x138/0x390)
.. [<c046c37e>] .... __schedule+0x4e/0x9b0
.....[<c046cd25>] ..   ( <= schedule+0x45/0x140)
.. [<c046ec60>] .... _raw_spin_lock_irq+0x20/0x40
.....[<c046c42f>] ..   ( <= __schedule+0xff/0x9b0)
.. [<c046ee3a>] .... _raw_spin_lock+0x1a/0x30
.....[<c0112e41>] ..   ( <= nmi_watchdog_tick+0x1c1/0x320)

------------------------------
| showing all locks held by: |  (swapper/0 [c21d3030, 140]):
------------------------------

NMI watchdog detected lockup on CPU#0 (0/5000)

Pid: 912, comm:              linuxrc
EIP: 0060:[<c046ec12>] CPU: 0
EIP is at _raw_spin_lock_irqsave+0x42/0x70
 EFLAGS: 00000086    Not tainted  (2.6.16-rt6 #1)
EAX: 00000093 EBX: 00000002 ECX: c046ebf7 EDX: 00000002
ESI: c055a620 EDI: f7057dac EBP: f7057cdc DS: 007b ES: 007b
CR0: 8005003b CR2: 00000000 CR3: 37070000 CR4: 000006d0
 [<c0104496>] show_trace+0x26/0x30 (20)
 [<c0101511>] show_regs+0x171/0x1a0 (44)
 [<c0112e76>] nmi_watchdog_tick+0x1f6/0x320 (44)
 [<c010572a>] default_do_nmi+0x7a/0x180 (96)
 [<c0105898>] do_nmi+0x58/0x60 (24)
 [<c01041f2>] nmi_stack_correct+0x1d/0x22 (72)
 [<c046dc5c>] rt_lock_slowlock+0x2c/0x260 (132)
 [<c046e773>] __lock_text_start+0x13/0x20 (16)
 [<c0148e93>] get_check_value+0x23/0x60 (20)
 [<c01493fc>] __get_monotonic_clock+0x9c/0xe0 (60)
 [<c0149473>] get_monotonic_clock+0x33/0x70 (32)
 [<c013d1d6>] hrtimer_interrupt+0x56/0x260 (84)
 [<c0148940>] handle_nextevent_update_profile+0x10/0x30 (12)
 [<c0112435>] smp_apic_timer_interrupt+0x85/0x90 (24)
 [<c010408f>] apic_timer_interrupt+0x27/0x2c (64)
 [<c046c7be>] __schedule+0x48e/0x9b0 (96)
 [<c046cd25>] schedule+0x45/0x140 (36)
 [<c0126fdf>] do_wait+0x31f/0x430 (124)
 [<c01271c1>] sys_wait4+0x41/0x50 (28)
 [<c01034c4>] sysenter_past_esp+0x61/0xa1 (-8116)
---------------------------
| preempt count: 00010003 ]
| 3-level deep critical section nesting:
----------------------------------------
.. [<c046c37e>] .... __schedule+0x4e/0x9b0
.....[<c046cd25>] ..   ( <= schedule+0x45/0x140)
.. [<c046ebf7>] .... _raw_spin_lock_irqsave+0x27/0x70
.....[<c046dc5c>] ..   ( <= rt_lock_slowlock+0x2c/0x260)
.. [<c046ee3a>] .... _raw_spin_lock+0x1a/0x30
.....[<c0112e41>] ..   ( <= nmi_watchdog_tick+0x1c1/0x320)

------------------------------
| showing all locks held by: |  (linuxrc/912 [f7c6d830, 115]):
------------------------------


--Boundary-00=_KABJE3TPkVMaWeI--
