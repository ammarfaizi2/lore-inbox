Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261186AbUKWCZk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261186AbUKWCZk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 21:25:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262497AbUKWCYn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 21:24:43 -0500
Received: from CPE-203-51-35-114.nsw.bigpond.net.au ([203.51.35.114]:30446
	"EHLO e4.eyal.emu.id.au") by vger.kernel.org with ESMTP
	id S261162AbUKVWoq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 17:44:46 -0500
Message-ID: <41A26BD4.8000509@eyal.emu.id.au>
Date: Tue, 23 Nov 2004 09:44:36 +1100
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
User-Agent: Mozilla Thunderbird 0.8 (X11/20040926)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-rc2-mm3 - oops on boot
References: <20041121223929.40e038b2.akpm@osdl.org>
In-Reply-To: <20041121223929.40e038b2.akpm@osdl.org>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------070904010004050402020101"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070904010004050402020101
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.10-rc2/2.6.10-rc2-mm3/

It is unusual for -mm kernels to give me trouble, but this one does.

Captured boot messages attached.

-- 
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>

--------------070904010004050402020101
Content-Type: text/plain;
 name="mm3-oops.cap"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mm3-oops.cap"

Linux version 2.6.10-rc2-mm3 (root@e7) (gcc version 3.3.4 (Debian 1:3.3.4-13)) #1 SMP Tue Nov 23 01:20:59 EST 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003fff0000 (usable)
 BIOS-e820: 000000003fff0000 - 000000003fff3000 (ACPI NVS)
 BIOS-e820: 000000003fff3000 - 0000000040000000 (ACPI data)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
127MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000f5200
DMI 2.3 present.
ACPI: PM-Timer IO Port: 0x1008
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 15:2 APIC version 20
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] disabled)
ACPI: LAPIC_NMI (acpi_id[0x00] dfl dfl lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] dfl dfl lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Built 1 zonelists
Initializing CPU#0
Kernel command line: BOOT_IMAGE=2.6.10-rc2-mm3 ro root=306 console=ttyS0,38400 console=tty0
CPU 0 irqstacks, hard=c041c000 soft=c0414000
PID hash table entries: 4096 (order: 12, 65536 bytes)
Detected 3015.669 MHz processor.
Using pmtmr for high-res timesource
Console: colour VGA+ 80x50
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 1035128k/1048512k available (1800k kernel code, 12776k reserved, 1035k data, 292k init, 131008k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Security Framework v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Hyper-Threading is disabled
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU0: Thermal monitoring enabled
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
CPU0: Intel(R) Pentium(R) 4 CPU 3.00GHz stepping 09
per-CPU timeslice cutoff: 1462.69 usecs.
task migration cache decay timeout: 2 msecs.
Total of 1 processors activated (5980.16 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 pin1=2 pin2=-1
Brought up 1 CPUs
NET: Registered protocol family 16
EISA bus registered
PCI: PCI BIOS revision 2.10 entry at 0xfb500, last bus=3
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20041105
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK0] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 15 devices
PnPBIOS: Disabled by ACPI
PCI: Using ACPI for IRQ routing
** PCI interrupts are no longer routed automatically.  If this
** causes a device to stop working, it is probably because the
** driver failed to call pci_enable_device().  As a temporary
** workaround, the "pci=routeirq" argument restores the old
** behavior.  If this argument makes the device work again,
** please email the output of "lspci" to bjorn.helgaas@hp.com
** so I can fix the driver.
Machine check exception polling timer started.
highmem bounce pool size: 64 pages
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
devfs: 2004-01-31 Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
SELinux:  Registering netfilter hooks
Initializing Cryptographic API
vesafb: probe of vesafb0 failed with error -6
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
ACPI: PS/2 Keyboard Controller [PS2K] at I/O 0x60, 0x64, irq 1
ACPI: PS/2 Mouse Controller [PS2M] at irq 12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 14 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH5: IDE controller at PCI slot 0000:00:1f.1
ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 18
ICH5: chipset revision 2
ICH5: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
hda: WDC WD1200BB-00DWA0, ATA DISK drive
elevator: using anticipatory as default io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: ATAPI DVD RW 8XMax, ATAPI CD/DVD-ROM drive
hdd: Pioneer DVD-ROM ATAPIModel DVD-115 0122, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 1024KiB
hda: 234441648 sectors (120034 MB) w/2048KiB Cache, CHS=16383/255/63, UDMA(100)
 /dev/ide/host0/bus0/target0/lun0: p2 p3 p4 < p5 p6 p7 >
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard on isa0060/serio0
EISA: Probing bus 0 at eisa0
Cannot allocate resource for EISA slot 1
EISA: Detected 0 cards.
perfctr: driver 2.7.6, cpu type Intel P4 at 3015669 kHz
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 64Kbytes
TCP: Hash tables configured (established 131072 bind 43690)
ACPI: (supports S0 S1 S4 S5)
ACPI wakeup devices: 
SLPB PCI0 CSAD HUB0 USB0 USB1 USB2 USB3 USBE 
VFS: Mounted root (ext2 filesystem) readonly.
Unable to handle kernel NULL pointer dereference at virtual address 00000004
 printing eip:
c015c0c6
*pde = 00000000
Oops: 0000 [#1]
PREEMPT SMP 
Modules linked in:
CPU:    0
EIP:    0060:[<c015c0c6>]    Not tainted VLI
EFLAGS: 00010282   (2.6.10-rc2-mm3) 
EIP is at invalidate_bdev+0x10/0x29
eax: 00000000   ebx: 00000000   ecx: 00000000   edx: f7ca4320
esi: 00000002   edi: 00000006   ebp: f7cb3400   esp: c194bef8
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 1, threadinfo=c194b000 task=c194aa80)
Stack: 00000000 00000004 c0187aa3 00000000 00000000 00000005 00000006 00000006 
       00000000 00000000 00000000 f7cb3400 c1931f80 00000000 c0176377 f7cb3400 
       ffffffff c02cc149 00000000 ffffffff c194bf60 c02cc149 00000000 c0176498 
Call Trace:
 [<c0187aa3>] vfs_quota_off+0xc0/0x219
 [<c0176377>] do_umount+0x19e/0x235
 [<c0176498>] sys_umount+0x8a/0x8e
 [<c03c72b0>] umount_devfs+0x17/0x1b
 [<c03c71bd>] prepare_namespace+0x2e/0xd7
 [<c012e2fc>] flush_workqueue+0x77/0x95
 [<c0100454>] init+0x14e/0x18d
 [<c0100306>] init+0x0/0x18d
 [<c010128d>] kernel_thread_helper+0x5/0xb
Code: 5e 5f 5d c3 89 5c 24 1c f0 ff 43 0c eb d5 0f 0b b2 01 7f 6d 2d c0 e9 4b ff ff ff 83 ec 08 89 5c 24 04 8b 5c 24 0c e8 f5 0f 00 00 <8b> 43 04 8b 5c 24 04 8b 80 b4 00 00 00 89 44 24 0c 83 c4 08 e9 
 <0>Kernel panic - not syncing: Attempted to kill init!
 
--------------070904010004050402020101--
