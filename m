Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932463AbWBPQoY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932463AbWBPQoY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 11:44:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932486AbWBPQoY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 11:44:24 -0500
Received: from 83-64-96-243.bad-voeslau.xdsl-line.inode.at ([83.64.96.243]:2785
	"EHLO mognix.dark-green.com") by vger.kernel.org with ESMTP
	id S932463AbWBPQoW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 11:44:22 -0500
Message-ID: <43F4ABE4.4040007@ed-soft.at>
Date: Thu, 16 Feb 2006 17:44:20 +0100
From: Edgar Hucek <hostmaster@ed-soft.at>
User-Agent: Mail/News 1.5 (X11/20060206)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: ACPI Troubles with 2.6.16-rc3
X-Enigmail-Version: 0.93.1.0
Content-Type: multipart/mixed;
 boundary="------------090400080002060904070900"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090400080002060904070900
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi.

I have ACPI troubles :

CPU: After all inits, caps: bfe9fbff 00100000 00000000 00000140 0000c1a9
00000000 00000000
Checking 'hlt' instruction... OK.
iounmap: bad address dfefd000
 [<c0253684>] acpi_tb_get_table_header+0x67/0x92
 [<c042a630>] unknown_bootoption+0x0/0x260
 [<c02536c2>] acpi_tb_get_table+0x13/0x55  [<c02538b2>]
acpi_tb_get_table_rsdt+0x1f/0x99
 [<c024e239>] acpi_ns_root_initialize+0x28a/0x299
 [<c0253971>] acpi_load_tables+0x45/0xa9
 [<c0443d56>] acpi_early_init+0x46/0xf6
 [<c042a56d>] start_kernel+0x2fd/0x3c0
 [<c042a630>] unknown_bootoption+0x0/0x260
iounmap: bad address dfefd000
 [<c0253f2a>] acpi_tb_delete_single_table+0x30/0x33
 [<c0252f37>] acpi_tb_convert_to_xsdt+0x8d/0xa3
 [<c042a630>] unknown_bootoption+0x0/0x260
 [<c0253900>] acpi_tb_get_table_rsdt+0x6d/0x99
 [<c024e239>] acpi_ns_root_initialize+0x28a/0x299
 [<c0253971>] acpi_load_tables+0x45/0xa9
 [<c0443d56>] acpi_early_init+0x46/0xf6
 [<c042a56d>] start_kernel+0x2fd/0x3c0
 [<c042a630>] unknown_bootoption+0x0/0x260
iounmap: bad address dfefb000
 [<c0253684>] acpi_tb_get_table_header+0x67/0x92
 [<c0253b4e>] acpi_tb_get_required_tables+0x4b/0x1f1
 [<c042a630>] unknown_bootoption+0x0/0x260
 [<c0253db5>] acpi_tb_init_table_descriptor+0x3a/0x107
 [<c0253911>] acpi_tb_get_table_rsdt+0x7e/0x99
 [<c042a630>] unknown_bootoption+0x0/0x260
 [<c0253986>] acpi_load_tables+0x5a/0xa9
 [<c0443d56>] acpi_early_init+0x46/0xf6
 [<c042a56d>] start_kernel+0x2fd/0x3c0

Ataches is the full dmesg output.

The machine is an Apple Intel iMac 17" Dual Core booted with
elilo.

Any ideas ?

thx

Edgar Hucek

--------------090400080002060904070900
Content-Type: text/plain;
 name="imac_dmesg.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="imac_dmesg.txt"

Linux version 2.6.16-rc3 (root@t43) (gcc version 4.0.2 (Gentoo 4.0.2-r3, pie-8.7.8)) #135 SMP Thu Feb 16 14:03:20 CET 2006
EFI: EFI v0.00 by Apple 
 ACPI=0x1fefd000 <6> ACPI 2.0=0x1fefd014 <6> SMBIOS=0x1fec9000 
510MB LOWMEM available.
On node 0 totalpages: 130800
  DMA zone: 4096 pages, LIFO batch:0
  DMA32 zone: 0 pages, LIFO batch:0
  Normal zone: 126704 pages, LIFO batch:31
  HighMem zone: 0 pages, LIFO batch:0
DMI not present or invalid.
ACPI: RSDP (v002 APPLE                                 ) @ 0x1fefd014
ACPI: XSDT (v001 APPLE   Apple00 0x00000039      0x01000013) @ 0x1fefd120
ACPI: FADT (v003 APPLE   Apple00 0x00000039 Loki 0x0000005f) @ 0x1fefb000
ACPI: HPET (v001 APPLE   Apple00 0x00000001 Loki 0x0000005f) @ 0x1fefa000
ACPI: MADT (v001 APPLE   Apple00 0x00000001 Loki 0x0000005f) @ 0x1fef9000
ACPI: MCFG (v001 APPLE   Apple00 0x00000001 Loki 0x0000005f) @ 0x1fef8000
ACPI: ASF! (v032 APPLE   Apple00 0x00000001 Loki 0x0000005f) @ 0x1fef7000
ACPI: SBST (v001 APPLE   Apple00 0x00000001 Loki 0x0000005f) @ 0x1fef6000
ACPI: ECDT (v001 APPLE   Apple00 0x00000001 Loki 0x0000005f) @ 0x1fef5000
ACPI: SSDT (v001 APPLE   SataPri 0x00001000 INTL 0x20050309) @ 0x1fec6000
ACPI: SSDT (v001 APPLE   SataSec 0x00001000 INTL 0x20050309) @ 0x1fec5000
ACPI: SSDT (v001 APPLE     CpuPm 0x00003000 INTL 0x20050309) @ 0x1fef0000
ACPI: DSDT (v001 APPLE      iMac 0x00040001 INTL 0x20050309) @ 0x00000000
ACPI: PM-Timer IO Port: 0x408
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 6:14 APIC version 20
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Processor #1 6:14 APIC version 20
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 1 already used, trying 2
IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
ACPI: HPET id: 0x8086a201 base: 0xfed00000
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 10100000 (gap: 10000000:00400000)
Built 1 zonelists
Kernel command line: BOOT_IMAGE=dev000:/vmlinuz  video=vesafb:1440x900-32@70 init=/linuxrc root=/dev/ram0 acpi=force pci=routeirq irqpoll
Misrouted IRQ fixup and polling support enabled
This may significantly impact system performance
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
PID hash table entries: 2048 (order: 11, 32768 bytes)
Console: colour dummy device 80x25
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 509572k/523200k available (2495k kernel code, 10328k reserved, 734k data, 248k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Oops: efitime: can't read time status: 0x80000007
Using HPET for base-timer
Using HPET for gettimeofday
Detected 1833.314 MHz processor.
Using hpet for high-res timesource
Calibrating delay using timer specific routine.. 3677.67 BogoMIPS (lpj=7355347)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: bfe9fbff 00100000 00000000 00000000 0000c1a9 00000000 00000000
CPU: After vendor identify, caps: bfe9fbff 00100000 00000000 00000000 0000c1a9 00000000 00000000
monitor/mwait feature present.
using mwait in idle threads.
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 2048K
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 0
CPU: After all inits, caps: bfe9fbff 00100000 00000000 00000140 0000c1a9 00000000 00000000
Checking 'hlt' instruction... OK.
iounmap: bad address dfefd000
 [<c0253684>] acpi_tb_get_table_header+0x67/0x92
 [<c042a630>] unknown_bootoption+0x0/0x260
 [<c02536c2>] acpi_tb_get_table+0x13/0x55
 [<c02538b2>] acpi_tb_get_table_rsdt+0x1f/0x99
 [<c024e239>] acpi_ns_root_initialize+0x28a/0x299
 [<c0253971>] acpi_load_tables+0x45/0xa9
 [<c0443d56>] acpi_early_init+0x46/0xf6
 [<c042a56d>] start_kernel+0x2fd/0x3c0
 [<c042a630>] unknown_bootoption+0x0/0x260
iounmap: bad address dfefd000
 [<c0253f2a>] acpi_tb_delete_single_table+0x30/0x33
 [<c0252f37>] acpi_tb_convert_to_xsdt+0x8d/0xa3
 [<c042a630>] unknown_bootoption+0x0/0x260
 [<c0253900>] acpi_tb_get_table_rsdt+0x6d/0x99
 [<c024e239>] acpi_ns_root_initialize+0x28a/0x299
 [<c0253971>] acpi_load_tables+0x45/0xa9
 [<c0443d56>] acpi_early_init+0x46/0xf6
 [<c042a56d>] start_kernel+0x2fd/0x3c0
 [<c042a630>] unknown_bootoption+0x0/0x260
iounmap: bad address dfefb000
 [<c0253684>] acpi_tb_get_table_header+0x67/0x92
 [<c0253b4e>] acpi_tb_get_required_tables+0x4b/0x1f1
 [<c042a630>] unknown_bootoption+0x0/0x260
 [<c0253db5>] acpi_tb_init_table_descriptor+0x3a/0x107
 [<c0253911>] acpi_tb_get_table_rsdt+0x7e/0x99
 [<c042a630>] unknown_bootoption+0x0/0x260
 [<c0253986>] acpi_load_tables+0x5a/0xa9
 [<c0443d56>] acpi_early_init+0x46/0xf6
 [<c042a56d>] start_kernel+0x2fd/0x3c0
 [<c042a630>] unknown_bootoption+0x0/0x260
iounmap: bad address dfefa000
 [<c0253684>] acpi_tb_get_table_header+0x67/0x92
 [<c0253b4e>] acpi_tb_get_required_tables+0x4b/0x1f1
 [<c042a630>] unknown_bootoption+0x0/0x260
 [<c0253986>] acpi_load_tables+0x5a/0xa9
 [<c0443d56>] acpi_early_init+0x46/0xf6
 [<c042a56d>] start_kernel+0x2fd/0x3c0
 [<c042a630>] unknown_bootoption+0x0/0x260
iounmap: bad address dfef9000
 [<c0253684>] acpi_tb_get_table_header+0x67/0x92
 [<c0253b4e>] acpi_tb_get_required_tables+0x4b/0x1f1
 [<c042a630>] unknown_bootoption+0x0/0x260
 [<c0253986>] acpi_load_tables+0x5a/0xa9
 [<c0443d56>] acpi_early_init+0x46/0xf6
 [<c042a56d>] start_kernel+0x2fd/0x3c0
 [<c042a630>] unknown_bootoption+0x0/0x260
iounmap: bad address dfef8000
 [<c0253684>] acpi_tb_get_table_header+0x67/0x92
 [<c0253b4e>] acpi_tb_get_required_tables+0x4b/0x1f1
 [<c042a630>] unknown_bootoption+0x0/0x260
 [<c0253986>] acpi_load_tables+0x5a/0xa9
 [<c0443d56>] acpi_early_init+0x46/0xf6
 [<c042a56d>] start_kernel+0x2fd/0x3c0
 [<c042a630>] unknown_bootoption+0x0/0x260
iounmap: bad address dfef7000
 [<c0253684>] acpi_tb_get_table_header+0x67/0x92
 [<c0253b4e>] acpi_tb_get_required_tables+0x4b/0x1f1
 [<c042a630>] unknown_bootoption+0x0/0x260
 [<c0253986>] acpi_load_tables+0x5a/0xa9
 [<c0443d56>] acpi_early_init+0x46/0xf6
 [<c042a56d>] start_kernel+0x2fd/0x3c0
 [<c042a630>] unknown_bootoption+0x0/0x260
iounmap: bad address dfef6000
 [<c0253684>] acpi_tb_get_table_header+0x67/0x92
 [<c0253b4e>] acpi_tb_get_required_tables+0x4b/0x1f1
 [<c042a630>] unknown_bootoption+0x0/0x260
 [<c0253986>] acpi_load_tables+0x5a/0xa9
 [<c0443d56>] acpi_early_init+0x46/0xf6
 [<c042a56d>] start_kernel+0x2fd/0x3c0
 [<c042a630>] unknown_bootoption+0x0/0x260
iounmap: bad address dfef5000
 [<c0253684>] acpi_tb_get_table_header+0x67/0x92
 [<c0253b4e>] acpi_tb_get_required_tables+0x4b/0x1f1
 [<c042a630>] unknown_bootoption+0x0/0x260
 [<c0253986>] acpi_load_tables+0x5a/0xa9
 [<c0443d56>] acpi_early_init+0x46/0xf6
 [<c042a56d>] start_kernel+0x2fd/0x3c0
 [<c042a630>] unknown_bootoption+0x0/0x260
iounmap: bad address dfefb000
 [<c0253f2a>] acpi_tb_delete_single_table+0x30/0x33
 [<c02533b7>] acpi_tb_convert_table_fadt+0x2df/0x2fc
 [<c0253c14>] acpi_tb_get_required_tables+0x111/0x1f1
 [<c042a630>] unknown_bootoption+0x0/0x260
 [<c0253986>] acpi_load_tables+0x5a/0xa9
 [<c0443d56>] acpi_early_init+0x46/0xf6
 [<c042a56d>] start_kernel+0x2fd/0x3c0
 [<c042a630>] unknown_bootoption+0x0/0x260
iounmap: bad address dfef1000
 [<c0253684>] acpi_tb_get_table_header+0x67/0x92
 [<c0253a83>] acpi_tb_get_secondary_table+0x1b/0x9b
 [<c0253cbb>] acpi_tb_get_required_tables+0x1b8/0x1f1
 [<c042a630>] unknown_bootoption+0x0/0x260
 [<c0253986>] acpi_load_tables+0x5a/0xa9
 [<c0443d56>] acpi_early_init+0x46/0xf6
 [<c042a56d>] start_kernel+0x2fd/0x3c0
 [<c042a630>] unknown_bootoption+0x0/0x260
iounmap: bad address dfefd000
 [<c0253f2a>] acpi_tb_delete_single_table+0x30/0x33
 [<c0253f63>] acpi_tb_uninstall_table+0x36/0x46
 [<c0253fe4>] acpi_tb_delete_tables_by_type+0x71/0x88
 [<c0253ce6>] acpi_tb_get_required_tables+0x1e3/0x1f1
 [<c042a630>] unknown_bootoption+0x0/0x260
 [<c0253986>] acpi_load_tables+0x5a/0xa9
 [<c0443d56>] acpi_early_init+0x46/0xf6
 [<c042a56d>] start_kernel+0x2fd/0x3c0
 [<c042a630>] unknown_bootoption+0x0/0x260
CPU0: Intel Genuine Intel(R) CPU            1400  @ 1.83GHz stepping 08
Booting processor 1/1 eip 2000
Initializing CPU#1
Calibrating delay using timer specific routine.. 3666.68 BogoMIPS (lpj=7333368)
CPU: After generic identify, caps: bfe9fbff 00100000 00000000 00000000 0000c1a9 00000000 00000000
CPU: After vendor identify, caps: bfe9fbff 00100000 00000000 00000000 0000c1a9 00000000 00000000
monitor/mwait feature present.
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 2048K
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 1
CPU: After all inits, caps: bfe9fbff 00100000 00000000 00000140 0000c1a9 00000000 00000000
CPU1: Intel Genuine Intel(R) CPU            1400  @ 1.83GHz stepping 08
Total of 2 processors activated (7344.35 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
checking TSC synchronization across 2 CPUs: passed.
Brought up 2 CPUs
migration_cost=8000
checking if image is initramfs...it isn't (no cpio magic); looks like an initrd
Freeing initrd memory: 1848k freed
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using configuration type 1
ACPI: Subsystem revision 20060127
iounmap: bad address dfefd000
 [<c0253684>] acpi_tb_get_table_header+0x67/0x92
 [<c02536c2>] acpi_tb_get_table+0x13/0x55
 [<c02544a0>] acpi_get_firmware_table+0xd7/0x282
 [<c024cf21>] acpi_hw_enable_runtime_gpe_block+0x28/0x3e
 [<c044442c>] acpi_ec_ecdt_probe+0xd2/0x31f
 [<c0443e5e>] acpi_init+0x58/0x1d7
 [<c04429c4>] fbmem_init+0x64/0xb0
 [<c0100436>] init+0x136/0x3a0
 [<c0100300>] init+0x0/0x3a0
 [<c0100f15>] kernel_thread_helper+0x5/0x10
iounmap: bad address dfefb000
 [<c0253684>] acpi_tb_get_table_header+0x67/0x92
 [<c0254588>] acpi_get_firmware_table+0x1bf/0x282
 [<c044442c>] acpi_ec_ecdt_probe+0xd2/0x31f
 [<c0443e5e>] acpi_init+0x58/0x1d7
 [<c04429c4>] fbmem_init+0x64/0xb0
 [<c0100436>] init+0x136/0x3a0
 [<c0100300>] init+0x0/0x3a0
 [<c0100f15>] kernel_thread_helper+0x5/0x10
iounmap: bad address dfefa000
 [<c0253684>] acpi_tb_get_table_header+0x67/0x92
 [<c0254588>] acpi_get_firmware_table+0x1bf/0x282
 [<c044442c>] acpi_ec_ecdt_probe+0xd2/0x31f
 [<c0443e5e>] acpi_init+0x58/0x1d7
 [<c04429c4>] fbmem_init+0x64/0xb0
 [<c0100436>] init+0x136/0x3a0
 [<c0100300>] init+0x0/0x3a0
 [<c0100f15>] kernel_thread_helper+0x5/0x10
iounmap: bad address dfef9000
 [<c0253684>] acpi_tb_get_table_header+0x67/0x92
 [<c0254588>] acpi_get_firmware_table+0x1bf/0x282
 [<c044442c>] acpi_ec_ecdt_probe+0xd2/0x31f
 [<c0443e5e>] acpi_init+0x58/0x1d7
 [<c04429c4>] fbmem_init+0x64/0xb0
 [<c0100436>] init+0x136/0x3a0
 [<c0100300>] init+0x0/0x3a0
 [<c0100f15>] kernel_thread_helper+0x5/0x10
iounmap: bad address dfef8000
 [<c0253684>] acpi_tb_get_table_header+0x67/0x92
 [<c0254588>] acpi_get_firmware_table+0x1bf/0x282
 [<c044442c>] acpi_ec_ecdt_probe+0xd2/0x31f
 [<c0443e5e>] acpi_init+0x58/0x1d7
 [<c04429c4>] fbmem_init+0x64/0xb0
 [<c0100436>] init+0x136/0x3a0
 [<c0100300>] init+0x0/0x3a0
 [<c0100f15>] kernel_thread_helper+0x5/0x10
iounmap: bad address dfef7000
 [<c0253684>] acpi_tb_get_table_header+0x67/0x92
 [<c0254588>] acpi_get_firmware_table+0x1bf/0x282
 [<c044442c>] acpi_ec_ecdt_probe+0xd2/0x31f
 [<c0443e5e>] acpi_init+0x58/0x1d7
 [<c04429c4>] fbmem_init+0x64/0xb0
 [<c0100436>] init+0x136/0x3a0
 [<c0100300>] init+0x0/0x3a0
 [<c0100f15>] kernel_thread_helper+0x5/0x10
iounmap: bad address dfef6000
 [<c0253684>] acpi_tb_get_table_header+0x67/0x92
 [<c0254588>] acpi_get_firmware_table+0x1bf/0x282
 [<c044442c>] acpi_ec_ecdt_probe+0xd2/0x31f
 [<c0443e5e>] acpi_init+0x58/0x1d7
 [<c04429c4>] fbmem_init+0x64/0xb0
 [<c0100436>] init+0x136/0x3a0
 [<c0100300>] init+0x0/0x3a0
 [<c0100f15>] kernel_thread_helper+0x5/0x10
iounmap: bad address dfef5000
 [<c0253684>] acpi_tb_get_table_header+0x67/0x92
 [<c0254588>] acpi_get_firmware_table+0x1bf/0x282
 [<c044442c>] acpi_ec_ecdt_probe+0xd2/0x31f
 [<c0443e5e>] acpi_init+0x58/0x1d7
 [<c04429c4>] fbmem_init+0x64/0xb0
 [<c0100436>] init+0x136/0x3a0
 [<c0100300>] init+0x0/0x3a0
 [<c0100f15>] kernel_thread_helper+0x5/0x10
iounmap: bad address dfefd000
 [<c0254617>] acpi_get_firmware_table+0x24e/0x282
 [<c044442c>] acpi_ec_ecdt_probe+0xd2/0x31f
 [<c0443e5e>] acpi_init+0x58/0x1d7
 [<c04429c4>] fbmem_init+0x64/0xb0
 [<c0100436>] init+0x136/0x3a0
 [<c0100300>] init+0x0/0x3a0
 [<c0100f15>] kernel_thread_helper+0x5/0x10
ACPI: Found ECDT
ACPI: Could not use ECDT
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEGP._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP01._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP02._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIB._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 10 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 7 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 7 10 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKE] (IRQs 1 3 4 5 6 7 10 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 1 3 4 5 6 7 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 1 3 4 5 6 7 10 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 11 12 14 15) *0, disabled.
ACPI: Embedded Controller [EC] (gpe 23) interrupt mode.
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: Routing PCI interrupts for all devices because "pci=routeirq" specified
ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 16 (level, low) -> IRQ 16
ACPI: PCI Interrupt 0000:00:07.0[A] -> GSI 16 (level, low) -> IRQ 16
ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 22 (level, low) -> IRQ 17
ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 17 (level, low) -> IRQ 18
ACPI: PCI Interrupt 0000:00:1c.1[B] -> GSI 16 (level, low) -> IRQ 16
ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 23 (level, low) -> IRQ 19
ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 20
ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 21
ACPI: PCI Interrupt 0000:00:1d.3[D] -> GSI 16 (level, low) -> IRQ 16
ACPI: PCI Interrupt 0000:00:1d.7[A] -> GSI 23 (level, low) -> IRQ 19
ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 21
ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 20
ACPI: PCI Interrupt 0000:00:1f.3[B] -> GSI 19 (level, low) -> IRQ 20
ACPI: PCI Interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 16
ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 16 (level, low) -> IRQ 16
ACPI: PCI Interrupt 0000:03:00.0[A] -> GSI 17 (level, low) -> IRQ 18
ACPI: PCI Interrupt 0000:04:03.0[A] -> GSI 19 (level, low) -> IRQ 20
PCI: Bridge: 0000:00:01.0
  IO window: 2000-2fff
  MEM window: 88300000-883fffff
  PREFETCH window: 80000000-87ffffff
PCI: Bridge: 0000:00:1c.0
  IO window: 1000-1fff
  MEM window: 88200000-882fffff
  PREFETCH window: 1ff00000-1fffffff
PCI: Bridge: 0000:00:1c.1
  IO window: disabled.
  MEM window: 88100000-881fffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:1e.0
  IO window: disabled.
  MEM window: 88000000-880fffff
  PREFETCH window: disabled.
ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:01.0 to 64
ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 17 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:1c.0 to 64
ACPI: PCI Interrupt 0000:00:1c.1[B] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1c.1 to 64
PCI: Setting latency timer of device 0000:00:1e.0 to 64
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:01.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:01.0:pcie00]
ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 17 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:1c.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:1c.0:pcie00]
Allocate Port Service[0000:00:1c.0:pcie02]
ACPI: PCI Interrupt 0000:00:1c.1[B] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1c.1 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:1c.1:pcie00]
Allocate Port Service[0000:00:1c.1:pcie02]
vesafb: framebuffer at 0x80000320, mapped to 0xe0900320, using 10350k, total 65536k
vesafb: mode is 1472x900x32, linelength=5888, pages=1
vesafb: scrolling: redraw
vesafb: Truecolor: size=8:8:8:8, shift=24:16:8:0
Console: switching to colour frame buffer device 184x112
fb0: VESA VGA frame buffer device
ACPI: AC Adapter [ADP1] (on-line)
ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [PWRB]
ACPI Error (evgpe-0688): No handler or method for GPE[1D], disabling event<6>ACPI: Video Device [GFX0] (multi-head: yes  rom: no  post: no)
Using specific hotkey driver
 [20060127]
ACPI: CPU0 (power states: C1[C1] C2[C2])
ACPI: Processor [CPU0] (supports 8 throttling states)
ACPI: CPU1 (power states: C1[C1] C2[C2])
ACPI: Processor [CPU1] (supports 8 throttling states)
Real Time Clock Driver v1.12ac
i8042.c: No controller found.
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
loop: loaded (max 8 devices)
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH7: IDE controller at PCI slot 0000:00:1f.1
ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 21
ICH7: chipset revision 2
ICH7: 100% native mode on irq 21
    ide0: BM-DMA at 0x30c0-0x30c7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x30c8-0x30cf, BIOS settings: hdc:pio, hdd:pio
Probing IDE interface ide0...
hda: MATSHITADVD-R UJ-846, ATAPI CD/DVD-ROM drive
ide0 at 0x30e8-0x30ef,0x30fe on irq 21
Probing IDE interface ide1...
Probing IDE interface ide1...
hda: ATAPI 24X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache
Uniform CD-ROM driver Revision: 3.20
hda: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
hda: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
hda: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
hda: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
hda: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
hda: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
hda: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
hda: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
hda: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
hda: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
hda: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
libata version 1.20 loaded.
ahci 0000:00:1f.2: version 1.2
PCI: Enabling device 0000:00:1f.2 (0005 -> 0007)
ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 20
irq 21: nobody cared (try booting with the "irqpoll" option)
 [<c013d754>] __report_bad_irq+0x24/0x90
 [<c0240b3f>] acpi_irq+0xc/0x16
 [<c013d853>] note_interrupt+0x93/0x250
 [<c0240b33>] acpi_irq+0x0/0x16
 [<c013d19d>] __do_IRQ+0xed/0x100
 [<c01055c9>] do_IRQ+0x19/0x30
 [<c010390a>] common_interrupt+0x1a/0x20
 [<c025f4d2>] acpi_processor_idle+0x15a/0x330
 [<c025007b>] acpi_get_parent+0x4a/0x6d
 [<c042a630>] unknown_bootoption+0x0/0x260
 [<c0101d29>] cpu_idle+0x69/0x80
 [<c042a572>] start_kernel+0x302/0x3c0
 [<c042a630>] unknown_bootoption+0x0/0x260
handlers:
[<c028a050>] (ide_intr+0x0/0x210)
Disabling IRQ #21
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ahci 0000:00:1f.2: AHCI 0001.0100 32 slots 4 ports 1.5 Gbps 0x4 impl SATA mode
ahci 0000:00:1f.2: flags: 64bit ncq ilck stag pm led clo pio slum part 
ata1: SATA max UDMA/133 cmd 0xE081A100 ctl 0x0 bmdma 0x0 irq 20
ata2: SATA max UDMA/133 cmd 0xE081A180 ctl 0x0 bmdma 0x0 irq 20
ata3: SATA max UDMA/133 cmd 0xE081A200 ctl 0x0 bmdma 0x0 irq 20
ata4: SATA max UDMA/133 cmd 0xE081A280 ctl 0x0 bmdma 0x0 irq 20
ata1: SATA link down (SStatus 0)
scsi0 : ahci
ata2: SATA link down (SStatus 0)
scsi1 : ahci
ata3: SATA link up 1.5 Gbps (SStatus 113)
ata3: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4003 85:3469 86:3c01 87:4003 88:007f
ata3: dev 0 ATA-6, max UDMA/133, 312581808 sectors: LBA48
ata3: dev 0 configured for UDMA/133
scsi2 : ahci
ata4: SATA link down (SStatus 0)
scsi3 : ahci
  Vendor: ATA       Model: ST3160023AS       Rev: 3.42
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
 sda: sda1 sda2
sd 2:0:0:0: Attached scsi disk sda
sd 2:0:0:0: Attached scsi generic sg0 type 0
SCSI Media Changer driver v0.25 
usbmon: debugfs is not available
PCI: Enabling device 0000:00:1d.7 (0000 -> 0002)
ACPI: PCI Interrupt 0000:00:1d.7[A] -> GSI 23 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: debug port 1
PCI: cache line size of 32 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:1d.7: irq 19, io mem 0x88405400
ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 8 ports detected
ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
USB Universal Host Controller Interface driver v2.3
ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 23 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.0: irq 19, io base 0x000030a0
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 20
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.1: irq 20, io base 0x00003080
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 21
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: UHCI Host Controller
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1d.2: irq 21, io base 0x00003060
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.3[D] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1d.3 to 64
uhci_hcd 0000:00:1d.3: UHCI Host Controller
uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 5
uhci_hcd 0000:00:1d.3: irq 16, io base 0x00003040
usb 1-4: new high speed USB device using ehci_hcd and address 4
usb usb5: configuration #1 chosen from 1 choice
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
usb 1-4: configuration #1 chosen from 1 choice
Initializing USB Mass Storage driver...
usb 1-5: new high speed USB device using ehci_hcd and address 5
usb 1-5: configuration #1 chosen from 1 choice
usb 2-1: new full speed USB device using uhci_hcd and address 2
usb 2-1: configuration #1 chosen from 1 choice
hub 2-1:1.0: USB hub found
hub 2-1:1.0: 3 ports detected
usb 3-1: new full speed USB device using uhci_hcd and address 2
usb 3-1: configuration #1 chosen from 1 choice
usb 5-1: new full speed USB device using uhci_hcd and address 2
usb 5-1: configuration #1 chosen from 1 choice
usb 5-2: new full speed USB device using uhci_hcd and address 3
usb 5-2: configuration #1 chosen from 1 choice
scsi4 : SCSI emulation for USB Mass Storage devices
usb-storage: device found at 5
usb-storage: waiting for device to settle before scanning
usb 2-1.2: new low speed USB device using uhci_hcd and address 3
usb 2-1.2: configuration #1 chosen from 1 choice
usb 2-1.3: new full speed USB device using uhci_hcd and address 4
usb 2-1.3: configuration #1 chosen from 1 choice
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
usbcore: registered new driver libusual
input: USB HIDBP Keyboard 05ac:1000 as /class/input/input0
input: Mitsumi Electric Apple Extended USB Keyboard as /class/input/input1
usbcore: registered new driver usbkbd
drivers/usb/input/usbkbd.c: :USB HID Boot Protocol keyboard driver
input: USB HIDBP Mouse 05ac:1000 as /class/input/input2
input: Mitsumi Electric Apple Optical USB Mouse as /class/input/input3
usbcore: registered new driver usbmouse
drivers/usb/input/usbmouse.c: v1.6:USB HID Boot Protocol mouse driver
usbcore: registered new driver yealink
drivers/usb/input/yealink.c: Yealink phone driver:yld-20051230
pegasus: v0.6.13 (2005/11/13), Pegasus/Pegasus II USB Ethernet driver
pegasus 3-1:1.0: eth0, USB 10/100 Fast Ethernet, 00:e0:98:7e:02:d1
usbcore: registered new driver pegasus
mice: PS/2 mouse device common for all mice
NET: Registered protocol family 2
IP route cache hash table entries: 4096 (order: 2, 16384 bytes)
TCP established hash table entries: 16384 (order: 5, 131072 bytes)
TCP bind hash table entries: 16384 (order: 5, 131072 bytes)
TCP: Hash tables configured (established 16384 bind 16384)
TCP reno registered
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
Starting balanced_irq
Using IPI Shortcut mode
RAMDISK: Compressed image found at block 0
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 248k freed
  Vendor: Maxtor    Model: 6Y160P0           Rev: YAR4
  Type:   Direct-Access                      ANSI SCSI revision: 02
SCSI device sdb: 320173056 512-byte hdwr sectors (163929 MB)
sdb: Write Protect is off
sdb: Mode Sense: 53 00 00 08
sdb: assuming drive cache: write through
SCSI device sdb: 320173056 512-byte hdwr sectors (163929 MB)
sdb: Write Protect is off
sdb: Mode Sense: 53 00 00 08
sdb: assuming drive cache: write through
 sdb: sdb1 sdb2 sdb3
sd 4:0:0:0: Attached scsi disk sdb
sd 4:0:0:0: Attached scsi generic sg1 type 0
usb-storage: device scan complete
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
Adding 1959920k swap on /dev/sdb2.  Priority:-1 extents:1 across:1959920k
EXT3-fs warning: checktime reached, running e2fsck is recommended
EXT3 FS on sdb3, internal journal
eth0: set allmulti
eth0: set allmulti
eth0: set allmulti
eth0: set allmulti

--------------090400080002060904070900--
