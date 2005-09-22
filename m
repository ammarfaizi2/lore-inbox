Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750832AbVIVW3Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750832AbVIVW3Z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 18:29:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751137AbVIVW3Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 18:29:25 -0400
Received: from xproxy.gmail.com ([66.249.82.206]:14147 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750832AbVIVW3Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 18:29:24 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer;
        b=LzORD/JxRnzpSA1RruP3+1FsllgAdMdxOMExEsiaBK1l4QAjOwaiqFZeBzOvxhVFqDmM/Y5ykDxFsF6lHIv7rFrSuFUkneW9FJjLLpNKw3FfYVS5vle7xit8JjYGolrvWpO2BxQlIWo1pTcL27KIx4OiHVdKAdJan2Q4W+ZKdJM=
Subject: Re: 2.6.14-rc2-mm1 - ide problems ?
From: Badari Pulavarty <pbadari@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20050922125219.7ea04930.akpm@osdl.org>
References: <20050921222839.76c53ba1.akpm@osdl.org>
	 <64900000.1127415577@[10.10.2.4]>  <20050922125219.7ea04930.akpm@osdl.org>
Content-Type: multipart/mixed; boundary="=-ZUz06AAFjPfkb7aZW7Ad"
Date: Thu, 22 Sep 2005 15:28:53 -0700
Message-Id: <1127428133.17227.94.camel@dyn9047017102.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ZUz06AAFjPfkb7aZW7Ad
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Andrew,

My ide-based AMD64 machine doesn't boot 2.6.14-rc2-mm1.
Known issue ?

Thanks,
Badari



--=-ZUz06AAFjPfkb7aZW7Ad
Content-Disposition: attachment; filename=amd-log
Content-Type: text/plain; name=amd-log; charset=UTF-8
Content-Transfer-Encoding: 7bit

Bootdata ok (command line is root=/dev/hda2 vga=0x314 selinux=0 splash=silent console=tty0 console=ttyS0,38400 resume=/dev/hda1 profile=2)
Linux version 2.6.14-rc2-mm1 (root@elm3b29) (gcc version 3.3.3 (SuSE Linux)) #1 SMP Thu Sep 22 14:46:56 PDT 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
 BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000ca000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 00000000dfef0000 (usable)
 BIOS-e820: 00000000dfef0000 - 00000000dfeff000 (ACPI data)
 BIOS-e820: 00000000dfeff000 - 00000000dff00000 (ACPI NVS)
 BIOS-e820: 00000000dff00000 - 00000000e0000000 (usable)
 BIOS-e820: 00000000fec00000 - 00000000fec00400 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
 BIOS-e820: 0000000100000000 - 00000001e0000000 (usable)
Scanning NUMA topology in Northbridge 24
Number of nodes 4
Node 0 MemBase 0000000000000000 Limit 000000017fffffff
Node 1 MemBase 0000000180000000 Limit 000000019fffffff
Node 2 MemBase 00000001a0000000 Limit 00000001bfffffff
Node 3 MemBase 00000001c0000000 Limit 00000001dfffffff
Using node hash shift of 21
Bootmem setup node 0 0000000000000000-000000017fffffff
Bootmem setup node 1 0000000180000000-000000019fffffff
Bootmem setup node 2 00000001a0000000-00000001bfffffff
Bootmem setup node 3 00000001c0000000-00000001dfffffff
ACPI: PM-Timer IO Port: 0x8008
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 15:5 APIC version 16
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Processor #1 15:5 APIC version 16
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x02] enabled)
Processor #2 15:5 APIC version 16
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x03] enabled)
Processor #3 15:5 APIC version 16
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
ACPI: IOAPIC (id[0x04] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 4, version 17, address 0xfec00000, GSI 0-23
ACPI: IOAPIC (id[0x05] address[0xfa3e0000] gsi_base[24])
IOAPIC[1]: apic_id 5, version 17, address 0xfa3e0000, GSI 24-27
ACPI: IOAPIC (id[0x06] address[0xfa3e1000] gsi_base[28])
IOAPIC[2]: apic_id 6, version 17, address 0xfa3e1000, GSI 28-31
ACPI: IOAPIC (id[0x07] address[0xfa3e2000] gsi_base[32])
IOAPIC[3]: apic_id 7, version 17, address 0xfa3e2000, GSI 32-35
ACPI: IOAPIC (id[0x08] address[0xfa3e4000] gsi_base[36])
IOAPIC[4]: apic_id 8, version 17, address 0xfa3e4000, GSI 36-39
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 high edge)
Setting APIC routing to flat
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at e2000000 (gap: e0000000:1ec00000)
Checking aperture...
CPU 0: aperture @ 0 size 32 MB
No AGP bridge found
Your BIOS doesn't leave a aperture memory hole
Please enable the IOMMU option in the BIOS setup
This costs you 64 MB of RAM
Mapping aperture over 65536 KB of RAM @ 8000000
Built 4 zonelists
Initializing CPU#0
Kernel command line: root=/dev/hda2 vga=0x314 selinux=0 splash=silent console=tty0 console=ttyS0,38400 resume=/dev/hda1 profile=2
kernel profiling enabled (shift: 2)
PID hash table entries: 4096 (order: 12, 131072 bytes)
time.c: Using 3.579545 MHz PM timer.
time.c: Detected 1398.189 MHz processor.
Console: colour dummy device 80x25
Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes)
Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes)
Memory: 6110856k/7864320k available (3049k kernel code, 194612k reserved, 1612k data, 244k init)
Calibrating delay using timer specific routine.. 2801.62 BogoMIPS (lpj=5603254)
Security Framework v1.0.0 initialized
SELinux:  Disabled at boot.
Mount-cache hash table entries: 256
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 0(1) -> Node 0 -> Core 0
mtrr: v2.0 (20020519)
Using local APIC timer interrupts.
Detected 12.483 MHz APIC timer.
setup_APIC_timer
done
Booting processor 1/4 APIC 0x1
Initializing CPU#1
Calibrating delay using timer specific routine.. 2796.59 BogoMIPS (lpj=5593188)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 1(1) -> Node 1 -> Core 0
Opteron MP w/ 1MB stepping 00
setup_APIC_timer
done
CPU 1: Syncing TSC to CPU 0.
CPU 1: synchronized TSC with CPU 0 (last diff -1 cycles, maxerr 981 cycles)
Booting processor 2/4 APIC 0x2
Initializing CPU#2
Calibrating delay using timer specific routine.. 2796.59 BogoMIPS (lpj=5593185)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 2(1) -> Node 2 -> Core 0
Opteron MP w/ 1MB stepping 00
setup_APIC_timer
done
CPU 2: Syncing TSC to CPU 0.
CPU 2: synchronized TSC with CPU 0 (last diff -4 cycles, maxerr 976 cycles)
Booting processor 3/4 APIC 0x3
Initializing CPU#3
Calibrating delay using timer specific routine.. 2796.59 BogoMIPS (lpj=5593186)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 3(1) -> Node 3 -> Core 0
Opteron MP w/ 1MB stepping 00
setup_APIC_timer
done
CPU 3: Syncing TSC to CPU 0.
CPU 3: synchronized TSC with CPU 0 (last diff -2 cycles, maxerr 1606 cycles)
Brought up 4 CPUs
Disabling vsyscall due to use of PM timer
time.c: Using PM based timekeeping.
testing NMI watchdog ... OK.
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using configuration type 1
ACPI: Subsystem revision 20050902
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 *5 10 11)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 5 *10 11)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 5 10 *11)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 5 10 *11)
ACPI: PCI Root Bridge [PCI1] (0000:08)
PCI: Probing PCI hardware (bus 08)
SCSI subsystem initialized
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
PCI-DMA: Disabling AGP.
PCI-DMA: aperture base @ 8000000 size 65536 KB
PCI-DMA: Reserving 64MB of IOMMU area in the AGP aperture
PCI: Bridge: 0000:00:06.0
  IO window: 2000-2fff
  MEM window: fa000000-fa0fffff
  PREFETCH window: e2000000-e20fffff
PCI: Bridge: 0000:09:01.0
  IO window: disabled.
  MEM window: fa400000-faffffff
  PREFETCH window: fc000000-fdffffff
PCI: Bridge: 0000:08:01.0
  IO window: disabled.
  MEM window: fa400000-faffffff
  PREFETCH window: fc000000-fdffffff
PCI: Bridge: 0000:08:02.0
  IO window: 3000-3fff
  MEM window: fb000000-fb0fffff
  PREFETCH window: e2100000-e21fffff
PCI: Bridge: 0000:08:03.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:08:04.0
  IO window: 4000-4fff
  MEM window: fb100000-fb1fffff
  PREFETCH window: e2200000-e22fffff
ACPI: PCI Interrupt 0000:08:04.0[A] -> GSI 36 (level, low) -> IRQ 16
IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 13:02:28 ak Exp $
audit: initializing netlink socket (disabled)
audit(1127427646.392:1): initialized
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
JFS: nTxBlock = 8192, nTxLock = 65536
Initializing Cryptographic API
PCI: MSI quirk detected. pci_msi_quirk set.
PCI: MSI quirk detected. pci_msi_quirk set.
PCI: MSI quirk detected. pci_msi_quirk set.
PCI: MSI quirk detected. pci_msi_quirk set.
vesafb: framebuffer at 0xfc000000, mapped to 0xffffc20000600000, using 1875k, total 16384k
vesafb: mode is 800x600x16, linelength=1600, pages=16
vesafb: scrolling: redraw
vesafb: Truecolor: size=0:5:6:5, shift=0:11:5:0
mtrr: type mismatch for fc000000,1000000 old: write-back new: write-combining
mtrr: type mismatch for fc000000,800000 old: write-back new: write-combining
mtrr: type mismatch for fc000000,400000 old: write-back new: write-combining
mtrr: type mismatch for fc000000,200000 old: write-back new: write-combining
mtrr: type mismatch for fc000000,100000 old: write-back new: write-combining
mtrr: type mismatch for fc000000,80000 old: write-back new: write-combining
mtrr: type mismatch for fc000000,40000 old: write-back new: write-combining
mtrr: type mismatch for fc000000,20000 old: write-back new: write-combining
mtrr: type mismatch for fc000000,10000 old: write-back new: write-combining
mtrr: type mismatch for fc000000,8000 old: write-back new: write-combining
mtrr: type mismatch for fc000000,4000 old: write-back new: write-combining
mtrr: type mismatch for fc000000,2000 old: write-back new: write-combining
mtrr: type mismatch for fc000000,1000 old: write-back new: write-combining
vesafb: Mode is not VGA compatible
Console: switching to colour frame buffer device 100x37
fb0: VESA VGA frame buffer device
Real Time Clock Driver v1.12
Non-volatile memory driver v1.2
Linux agpgart interface v0.101 (c) Dave Jones
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
mice: PS/2 mouse device common for all mice
input: PC Speaker
io scheduler noop registered
input: AT Translated Set 2 keyboard on isa0060/serio0
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
RAMDISK driver initialized: 16 RAM disks of 128000K size 1024 blocksize
loop: loaded (max 8 devices)
tg3.c:v3.40 (September 15, 2005)
ACPI: PCI Interrupt 0000:19:02.0[A] -> GSI 38 (level, low) -> IRQ 17
input: PS/2 Generic Mouse on isa0060/serio1
eth0: Tigon3 [partno(3C996B-T) rev 0105 PHY(5701)] (PCI:66MHz:64-bit) 10/100/1000BaseT Ethernet 00:04:76:f0:f9:aa
eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[1] TSOcap[0]
eth0: dma_rwctrl[76ff000f]
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
AMD8111: IDE controller at PCI slot 0000:00:07.1
AMD8111: chipset revision 3
AMD8111: not 100% native mode: will probe irqs later
AMD8111: 0000:00:07.1 (rev 03) UDMA133 controller
    ide0: BM-DMA at 0x1020-0x1027, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1028-0x102f, BIOS settings: hdc:DMA, hdd:pio



--=-ZUz06AAFjPfkb7aZW7Ad--

