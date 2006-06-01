Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750859AbWFASL6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750859AbWFASL6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 14:11:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750878AbWFASL6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 14:11:58 -0400
Received: from dspnet.fr.eu.org ([213.186.44.138]:9988 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S1750858AbWFASL5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 14:11:57 -0400
Date: Thu, 1 Jun 2006 20:11:55 +0200
From: Olivier Galibert <galibert@pobox.com>
To: "Hack inc." <linux-kernel@vger.kernel.org>
Subject: [aacraid] Is that a linux issue or flaky hardware?
Message-ID: <20060601181155.GA95280@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	"Hack inc." <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="gKMricLos+KVdGMg"
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I have a new dual-EMT64 server with an aacraid skyhawk (asr-2020s
pci-x zcr) in it and the drives supposedly in raid1.  The aacraid dies
shortly after I start using it, with both an up-to-date FC5 kernel and
a gentoo installcd 2006.0.

Are there known issues with that hardware under linux, or is that an
hardware issue?

The attached messages file shows the life and death of the scsi system
under a livecd when formatting sda1 and copying a bunch of files
through nfs.

  OG.

--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=messages

Jun  2 01:01:05 livecd syslog-ng[7457]: syslog-ng version 1.6.8 starting
Jun  2 01:01:05 livecd syslog-ng[7457]: Changing permissions on special file /dev/tty12
Jun  2 01:01:05 livecd Bootdata ok (command line is root=/dev/ram0 init=/linuxrc dokeymap looptype=squashfs loop=/image.squashfs cdroot initrd=gentoo.igz vga=791 splash=silent,theme:livecd-2006.0 CONSOLE=/dev/tty1 quiet BOOT_IMAGE=gentoo )
Jun  2 01:01:05 livecd Linux version 2.6.15-gentoo-r5 (root@poseidon) (gcc version 3.4.4 (Gentoo 3.4.4-r1, ssp-3.4.4-1.0, pie-8.7.8)) #1 SMP Wed Feb 22 17:51:15 UTC 2006
Jun  2 01:01:05 livecd BIOS-provided physical RAM map:
Jun  2 01:01:05 livecd BIOS-e820: 0000000000000000 - 000000000009a400 (usable)
Jun  2 01:01:05 livecd BIOS-e820: 000000000009a400 - 00000000000a0000 (reserved)
Jun  2 01:01:05 livecd BIOS-e820: 00000000000ce000 - 00000000000d0000 (reserved)
Jun  2 01:01:05 livecd BIOS-e820: 00000000000e4000 - 0000000000100000 (reserved)
Jun  2 01:01:05 livecd BIOS-e820: 0000000000100000 - 00000000bff70000 (usable)
Jun  2 01:01:05 livecd BIOS-e820: 00000000bff70000 - 00000000bff78000 (ACPI data)
Jun  2 01:01:05 livecd BIOS-e820: 00000000bff78000 - 00000000bff80000 (ACPI NVS)
Jun  2 01:01:05 livecd BIOS-e820: 00000000bff80000 - 00000000c0000000 (reserved)
Jun  2 01:01:05 livecd BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
Jun  2 01:01:05 livecd BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
Jun  2 01:01:05 livecd BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
Jun  2 01:01:05 livecd BIOS-e820: 00000000ff800000 - 00000000ffc00000 (reserved)
Jun  2 01:01:05 livecd BIOS-e820: 00000000fffffc00 - 0000000100000000 (reserved)
Jun  2 01:01:05 livecd BIOS-e820: 0000000100000000 - 0000000240000000 (usable)
Jun  2 01:01:05 livecd ACPI: RSDP (v000 PTLTD                                 ) @ 0x00000000000f6910
Jun  2 01:01:05 livecd ACPI: RSDT (v001 PTLTD    RSDT   0x06040000  LTP 0x00000000) @ 0x00000000bff73156
Jun  2 01:01:05 livecd ACPI: FADT (v001 INTEL  LINDHRST 0x06040000 PTL  0x00000003) @ 0x00000000bff77e38
Jun  2 01:01:05 livecd ACPI: MADT (v001 PTLTD  	 APIC   0x06040000  LTP 0x00000000) @ 0x00000000bff77eac
Jun  2 01:01:05 livecd ACPI: BOOT (v001 PTLTD  $SBFTBL$ 0x06040000  LTP 0x00000001) @ 0x00000000bff77f48
Jun  2 01:01:05 livecd ACPI: SPCR (v001 PTLTD  $UCRTBL$ 0x06040000 PTL  0x00000001) @ 0x00000000bff77f70
Jun  2 01:01:05 livecd ACPI: MCFG (v001 PTLTD  	 MCFG   0x06040000  LTP 0x00000000) @ 0x00000000bff77fc0
Jun  2 01:01:05 livecd ACPI: SSDT (v001  PmRef    CpuPm 0x00003000 INTL 0x20030224) @ 0x00000000bff73192
Jun  2 01:01:05 livecd ACPI: DSDT (v001  Intel LINDHRST 0x06040000 MSFT 0x0100000e) @ 0x0000000000000000
Jun  2 01:01:05 livecd On node 0 totalpages: 2063682
Jun  2 01:01:05 livecd DMA zone: 2970 pages, LIFO batch:0
Jun  2 01:01:05 livecd DMA32 zone: 767912 pages, LIFO batch:31
Jun  2 01:01:05 livecd Normal zone: 1292800 pages, LIFO batch:31
Jun  2 01:01:05 livecd HighMem zone: 0 pages, LIFO batch:0
Jun  2 01:01:05 livecd ACPI: PM-Timer IO Port: 0x1008
Jun  2 01:01:05 livecd ACPI: Local APIC address 0xfee00000
Jun  2 01:01:05 livecd ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Jun  2 01:01:05 livecd Processor #0 15:4 APIC version 20
Jun  2 01:01:05 livecd ACPI: LAPIC (acpi_id[0x01] lapic_id[0x06] enabled)
Jun  2 01:01:05 livecd Processor #6 15:4 APIC version 20
Jun  2 01:01:05 livecd ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Jun  2 01:01:05 livecd Processor #1 15:4 APIC version 20
Jun  2 01:01:05 livecd ACPI: LAPIC (acpi_id[0x03] lapic_id[0x07] enabled)
Jun  2 01:01:05 livecd Processor #7 15:4 APIC version 20
Jun  2 01:01:05 livecd ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
Jun  2 01:01:05 livecd ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
Jun  2 01:01:05 livecd ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
Jun  2 01:01:05 livecd ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
Jun  2 01:01:05 livecd ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
Jun  2 01:01:05 livecd IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
Jun  2 01:01:05 livecd ACPI: IOAPIC (id[0x03] address[0xfec80000] gsi_base[24])
Jun  2 01:01:05 livecd IOAPIC[1]: apic_id 3, version 32, address 0xfec80000, GSI 24-47
Jun  2 01:01:05 livecd ACPI: IOAPIC (id[0x04] address[0xfec80400] gsi_base[48])
Jun  2 01:01:05 livecd IOAPIC[2]: apic_id 4, version 32, address 0xfec80400, GSI 48-71
Jun  2 01:01:05 livecd ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 high edge)
Jun  2 01:01:05 livecd ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
Jun  2 01:01:05 livecd ACPI: IRQ0 used by override.
Jun  2 01:01:05 livecd ACPI: IRQ2 used by override.
Jun  2 01:01:05 livecd ACPI: IRQ9 used by override.
Jun  2 01:01:05 livecd Setting APIC routing to flat
Jun  2 01:01:05 livecd Using ACPI (MADT) for SMP configuration information
Jun  2 01:01:05 livecd Allocating PCI resources starting at c2000000 (gap: c0000000:20000000)
Jun  2 01:01:05 livecd Checking aperture...
Jun  2 01:01:05 livecd Built 1 zonelists
Jun  2 01:01:05 livecd Kernel command line: root=/dev/ram0 init=/linuxrc dokeymap looptype=squashfs loop=/image.squashfs cdroot initrd=gentoo.igz vga=791 splash=silent,theme:livecd-2006.0 CONSOLE=/dev/tty1 quiet BOOT_IMAGE=gentoo 
Jun  2 01:01:05 livecd Initializing CPU#0
Jun  2 01:01:05 livecd PID hash table entries: 4096 (order: 12, 131072 bytes)
Jun  2 01:01:05 livecd time.c: Using 3.579545 MHz PM timer.
Jun  2 01:01:05 livecd time.c: Detected 3400.298 MHz processor.
Jun  2 01:01:05 livecd Speakup v-2.00 CVS: Wed Dec 21 14:36:03 EST 2005 : initialized
Jun  2 01:01:05 livecd Console: colour dummy device 80x25
Jun  2 01:01:05 livecd Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes)
Jun  2 01:01:05 livecd Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes)
Jun  2 01:01:05 livecd Placing software IO TLB between 0x9a75000 - 0xda75000
Jun  2 01:01:05 livecd Memory: 8171824k/9437184k available (2524k kernel code, 215492k reserved, 724k data, 168k init)
Jun  2 01:01:05 livecd Calibrating delay using timer specific routine.. 6806.67 BogoMIPS (lpj=3403338)
Jun  2 01:01:05 livecd Mount-cache hash table entries: 256
Jun  2 01:01:05 livecd CPU: Trace cache: 12K uops, L1 D cache: 16K
Jun  2 01:01:05 livecd CPU: L2 cache: 2048K
Jun  2 01:01:05 livecd using mwait in idle threads.
Jun  2 01:01:05 livecd CPU: Physical Processor ID: 0
Jun  2 01:01:05 livecd mtrr: v2.0 (20020519)
Jun  2 01:01:05 livecd Using local APIC timer interrupts.
Jun  2 01:01:05 livecd Detected 12.501 MHz APIC timer.
Jun  2 01:01:05 livecd Booting processor 1/4 APIC 0x6
Jun  2 01:01:05 livecd Initializing CPU#1
Jun  2 01:01:05 livecd Calibrating delay using timer specific routine.. 6799.41 BogoMIPS (lpj=3399708)
Jun  2 01:01:05 livecd CPU: Trace cache: 12K uops, L1 D cache: 16K
Jun  2 01:01:05 livecd CPU: L2 cache: 2048K
Jun  2 01:01:05 livecd CPU: Physical Processor ID: 3
Jun  2 01:01:05 livecd Intel(R) Xeon(TM) CPU 3.40GHz stepping 03
Jun  2 01:01:05 livecd APIC error on CPU1: 00(40)
Jun  2 01:01:05 livecd CPU 1: Syncing TSC to CPU 0.
Jun  2 01:01:05 livecd CPU 1: synchronized TSC with CPU 0 (last diff 4 cycles, maxerr 1360 cycles)
Jun  2 01:01:05 livecd Booting processor 2/4 APIC 0x1
Jun  2 01:01:05 livecd Initializing CPU#2
Jun  2 01:01:05 livecd Calibrating delay using timer specific routine.. 6799.21 BogoMIPS (lpj=3399605)
Jun  2 01:01:05 livecd CPU: Trace cache: 12K uops, L1 D cache: 16K
Jun  2 01:01:05 livecd CPU: L2 cache: 2048K
Jun  2 01:01:05 livecd CPU: Physical Processor ID: 0
Jun  2 01:01:05 livecd Intel(R) Xeon(TM) CPU 3.40GHz stepping 03
Jun  2 01:01:05 livecd APIC error on CPU2: 00(40)
Jun  2 01:01:05 livecd CPU 2: Syncing TSC to CPU 0.
Jun  2 01:01:05 livecd CPU 2: synchronized TSC with CPU 0 (last diff 0 cycles, maxerr 952 cycles)
Jun  2 01:01:05 livecd Booting processor 3/4 APIC 0x7
Jun  2 01:01:05 livecd Initializing CPU#3
Jun  2 01:01:05 livecd Calibrating delay using timer specific routine.. 6895.13 BogoMIPS (lpj=3447567)
Jun  2 01:01:05 livecd CPU: Trace cache: 12K uops, L1 D cache: 16K
Jun  2 01:01:05 livecd CPU: L2 cache: 2048K
Jun  2 01:01:05 livecd CPU: Physical Processor ID: 3
Jun  2 01:01:05 livecd Intel(R) Xeon(TM) CPU 3.40GHz stepping 03
Jun  2 01:01:05 livecd APIC error on CPU3: 00(40)
Jun  2 01:01:05 livecd CPU 3: Syncing TSC to CPU 0.
Jun  2 01:01:05 livecd CPU 3: synchronized TSC with CPU 0 (last diff 39 cycles, maxerr 1309 cycles)
Jun  2 01:01:05 livecd Brought up 4 CPUs
Jun  2 01:01:05 livecd time.c: Using PIT/TSC based timekeeping.
Jun  2 01:01:05 livecd testing NMI watchdog ... OK.
Jun  2 01:01:05 livecd checking if image is initramfs... it is
Jun  2 01:01:05 livecd NET: Registered protocol family 16
Jun  2 01:01:05 livecd ACPI: bus type pci registered
Jun  2 01:01:05 livecd PCI: Using configuration type 1
Jun  2 01:01:05 livecd PCI: Using MMCONFIG at e0000000
Jun  2 01:01:05 livecd ACPI: Subsystem revision 20050902
Jun  2 01:01:05 livecd ACPI: Interpreter enabled
Jun  2 01:01:05 livecd ACPI: Using IOAPIC for interrupt routing
Jun  2 01:01:05 livecd ACPI: PCI Root Bridge [PCI0] (0000:00)
Jun  2 01:01:05 livecd PCI: Probing PCI hardware (bus 00)
Jun  2 01:01:05 livecd PCI quirk: region 1000-107f claimed by ICH4 ACPI/GPIO/TCO
Jun  2 01:01:05 livecd PCI quirk: region 1180-11bf claimed by ICH4 GPIO
Jun  2 01:01:05 livecd PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
Jun  2 01:01:05 livecd PCI: PXH quirk detected, disabling MSI for SHPC device
Jun  2 01:01:05 livecd PCI: PXH quirk detected, disabling MSI for SHPC device
Jun  2 01:01:05 livecd Boot video device is 0000:06:01.0
Jun  2 01:01:05 livecd PCI: Transparent bridge - 0000:00:1e.0
Jun  2 01:01:05 livecd ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
Jun  2 01:01:05 livecd ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX0.PXH0._PRT]
Jun  2 01:01:05 livecd ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX0.PXH1._PRT]
Jun  2 01:01:05 livecd ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEY0._PRT]
Jun  2 01:01:05 livecd ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEZ0._PRT]
Jun  2 01:01:05 livecd ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIB._PRT]
Jun  2 01:01:05 livecd ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 *5 6 7 10 11 14 15)
Jun  2 01:01:05 livecd ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *10 11 14 15)
Jun  2 01:01:05 livecd ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 *7 10 11 14 15)
Jun  2 01:01:05 livecd ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 10 *11 14 15)
Jun  2 01:01:05 livecd ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 11 14 15) *0, disabled.
Jun  2 01:01:05 livecd ACPI: PCI Interrupt Link [LNKF] (IRQs 4 5 6 7 10 11 14 15) *0, disabled.
Jun  2 01:01:05 livecd ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 11 14 15) *0, disabled.
Jun  2 01:01:05 livecd ACPI: PCI Interrupt Link [LNKH] (IRQs 4 5 6 7 *10 11 14 15)
Jun  2 01:01:05 livecd ACPI: Device [PRT] status [0000000c]: functional but not present; setting present
Jun  2 01:01:05 livecd Linux Plug and Play Support v0.97 (c) Adam Belay
Jun  2 01:01:05 livecd pnp: PnP ACPI init
Jun  2 01:01:05 livecd pnp: PnP ACPI: found 12 devices
Jun  2 01:01:05 livecd SCSI subsystem initialized
Jun  2 01:01:05 livecd PCI: Using ACPI for IRQ routing
Jun  2 01:01:05 livecd PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
Jun  2 01:01:05 livecd PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
Jun  2 01:01:05 livecd PCI: Bridge: 0000:01:00.0
Jun  2 01:01:05 livecd IO window: disabled.
Jun  2 01:01:05 livecd MEM window: d4200000-d5ffffff
Jun  2 01:01:05 livecd PREFETCH window: dc000000-dfffffff
Jun  2 01:01:05 livecd PCI: Bridge: 0000:01:00.2
Jun  2 01:01:05 livecd IO window: 2000-2fff
Jun  2 01:01:05 livecd MEM window: d6000000-d60fffff
Jun  2 01:01:05 livecd PREFETCH window: disabled.
Jun  2 01:01:05 livecd PCI: Bridge: 0000:00:02.0
Jun  2 01:01:05 livecd IO window: 2000-2fff
Jun  2 01:01:05 livecd MEM window: d4100000-d60fffff
Jun  2 01:01:05 livecd PREFETCH window: dc000000-dfffffff
Jun  2 01:01:05 livecd PCI: Bridge: 0000:00:04.0
Jun  2 01:01:05 livecd IO window: disabled.
Jun  2 01:01:05 livecd MEM window: disabled.
Jun  2 01:01:05 livecd PREFETCH window: disabled.
Jun  2 01:01:05 livecd PCI: Bridge: 0000:00:06.0
Jun  2 01:01:05 livecd IO window: disabled.
Jun  2 01:01:05 livecd MEM window: disabled.
Jun  2 01:01:05 livecd PREFETCH window: disabled.
Jun  2 01:01:05 livecd PCI: Bridge: 0000:00:1e.0
Jun  2 01:01:05 livecd IO window: 3000-3fff
Jun  2 01:01:05 livecd MEM window: d6100000-d7ffffff
Jun  2 01:01:05 livecd PREFETCH window: c2000000-c20fffff
Jun  2 01:01:05 livecd GSI 16 sharing vector 0xA9 and IRQ 16
Jun  2 01:01:05 livecd ACPI: PCI Interrupt 0000:00:02.0[A] -> GSI 16 (level, low) -> IRQ 16
Jun  2 01:01:05 livecd PCI: Setting latency timer of device 0000:00:02.0 to 64
Jun  2 01:01:05 livecd PCI: Setting latency timer of device 0000:01:00.0 to 64
Jun  2 01:01:05 livecd PCI: Setting latency timer of device 0000:01:00.2 to 64
Jun  2 01:01:05 livecd ACPI: PCI Interrupt 0000:00:04.0[A] -> GSI 16 (level, low) -> IRQ 16
Jun  2 01:01:05 livecd PCI: Setting latency timer of device 0000:00:04.0 to 64
Jun  2 01:01:05 livecd ACPI: PCI Interrupt 0000:00:06.0[A] -> GSI 16 (level, low) -> IRQ 16
Jun  2 01:01:05 livecd PCI: Setting latency timer of device 0000:00:06.0 to 64
Jun  2 01:01:05 livecd PCI: Setting latency timer of device 0000:00:1e.0 to 64
Jun  2 01:01:05 livecd Simple Boot Flag at 0x39 set to 0x1
Jun  2 01:01:05 livecd IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 13:02:28 ak Exp $
Jun  2 01:01:05 livecd Squashfs 2.2 (released 2005/07/03) (C) 2002-2005 Phillip Lougher
Jun  2 01:01:05 livecd SGI XFS with ACLs, security attributes, realtime, large block/inode numbers, no debug enabled
Jun  2 01:01:05 livecd SGI XFS Quota Management subsystem
Jun  2 01:01:05 livecd Initializing Cryptographic API
Jun  2 01:01:05 livecd io scheduler noop registered
Jun  2 01:01:05 livecd io scheduler deadline registered
Jun  2 01:01:05 livecd ACPI: PCI Interrupt 0000:00:02.0[A] -> GSI 16 (level, low) -> IRQ 16
Jun  2 01:01:05 livecd PCI: Setting latency timer of device 0000:00:02.0 to 64
Jun  2 01:01:05 livecd Allocate Port Service[pcie00]
Jun  2 01:01:05 livecd Allocate Port Service[pcie01]
Jun  2 01:01:05 livecd ACPI: PCI Interrupt 0000:00:04.0[A] -> GSI 16 (level, low) -> IRQ 16
Jun  2 01:01:05 livecd PCI: Setting latency timer of device 0000:00:04.0 to 64
Jun  2 01:01:05 livecd Allocate Port Service[pcie00]
Jun  2 01:01:05 livecd Allocate Port Service[pcie01]
Jun  2 01:01:05 livecd ACPI: PCI Interrupt 0000:00:06.0[A] -> GSI 16 (level, low) -> IRQ 16
Jun  2 01:01:05 livecd PCI: Setting latency timer of device 0000:00:06.0 to 64
Jun  2 01:01:05 livecd Allocate Port Service[pcie00]
Jun  2 01:01:05 livecd Allocate Port Service[pcie01]
Jun  2 01:01:05 livecd Real Time Clock Driver v1.12
Jun  2 01:01:05 livecd initialized device: /dev/synth, node ( MAJOR 10, MINOR 25 )
Jun  2 01:01:05 livecd Linux agpgart interface v0.101 (c) Dave Jones
Jun  2 01:01:05 livecd vesafb: framebuffer at 0xd7000000, mapped to 0xffffc20010100000, using 3072k, total 8128k
Jun  2 01:01:05 livecd vesafb: mode is 1024x768x16, linelength=2048, pages=4
Jun  2 01:01:05 livecd vesafb: scrolling: redraw
Jun  2 01:01:05 livecd vesafb: Truecolor: size=0:5:6:5, shift=0:11:5:0
Jun  2 01:01:05 livecd vesafb: Mode is not VGA compatible
Jun  2 01:01:05 livecd Console: switching to colour frame buffer device 128x48
Jun  2 01:01:05 livecd fb0: VESA VGA frame buffer device
Jun  2 01:01:05 livecd PNP: PS/2 Controller [PNP0303:KBC0,PNP0f13:MSE0] at 0x60,0x64 irq 1,12
Jun  2 01:01:05 livecd serio: i8042 AUX port at 0x60,0x64 irq 12
Jun  2 01:01:05 livecd serio: i8042 KBD port at 0x60,0x64 irq 1
Jun  2 01:01:05 livecd Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
Jun  2 01:01:05 livecd serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Jun  2 01:01:05 livecd serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Jun  2 01:01:05 livecd serial8250: ttyS0 at I/O 0x3f8 (irq = 0) is a 16550A
Jun  2 01:01:05 livecd serial8250: ttyS1 at I/O 0x2f8 (irq = 0) is a 16550A
Jun  2 01:01:05 livecd 00:09: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Jun  2 01:01:05 livecd 00:0a: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Jun  2 01:01:05 livecd mice: PS/2 mouse device common for all mice
Jun  2 01:01:05 livecd RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
Jun  2 01:01:05 livecd loop: loaded (max 8 devices)
Jun  2 01:01:05 livecd Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
Jun  2 01:01:05 livecd ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Jun  2 01:01:05 livecd ICH5: IDE controller at PCI slot 0000:00:1f.1
Jun  2 01:01:05 livecd GSI 17 sharing vector 0xB1 and IRQ 17
Jun  2 01:01:05 livecd ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 17
Jun  2 01:01:05 livecd ICH5: chipset revision 2
Jun  2 01:01:05 livecd ICH5: not 100% native mode: will probe irqs later
Jun  2 01:01:05 livecd ide0: BM-DMA at 0x14a0-0x14a7, BIOS settings: hda:pio, hdb:pio
Jun  2 01:01:05 livecd ide1: BM-DMA at 0x14a8-0x14af, BIOS settings: hdc:pio, hdd:DMA
Jun  2 01:01:05 livecd Probing IDE interface ide0...
Jun  2 01:01:05 livecd input: AT Translated Set 2 keyboard as /class/input/input0
Jun  2 01:01:05 livecd Synaptics Touchpad, model: 1, fw: 5.9, id: 0x2c6eb1, caps: 0xa84793/0x554755
Jun  2 01:01:05 livecd serio: Synaptics pass-through port at isa0060/serio1/input0
Jun  2 01:01:05 livecd input: SynPS/2 Synaptics TouchPad as /class/input/input1
Jun  2 01:01:05 livecd Probing IDE interface ide1...
Jun  2 01:01:05 livecd hdd: MATSHITADVD-ROM SR-8178, ATAPI CD/DVD-ROM drive
Jun  2 01:01:05 livecd ide1 at 0x170-0x177,0x376 on irq 15
Jun  2 01:01:05 livecd Probing IDE interface ide0...
Jun  2 01:01:05 livecd hdd: ATAPI 24X DVD-ROM drive, 256kB Cache, UDMA(33)
Jun  2 01:01:05 livecd Uniform CD-ROM driver Revision: 3.20
Jun  2 01:01:05 livecd NET: Registered protocol family 2
Jun  2 01:01:05 livecd IP route cache hash table entries: 262144 (order: 9, 2097152 bytes)
Jun  2 01:01:05 livecd TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
Jun  2 01:01:05 livecd TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
Jun  2 01:01:05 livecd TCP: Hash tables configured (established 262144 bind 65536)
Jun  2 01:01:05 livecd TCP reno registered
Jun  2 01:01:05 livecd TCP bic registered
Jun  2 01:01:05 livecd NET: Registered protocol family 1
Jun  2 01:01:05 livecd NET: Registered protocol family 17
Jun  2 01:01:05 livecd Freeing unused kernel memory: 168k freed
Jun  2 01:01:05 livecd usbcore: registered new driver usbfs
Jun  2 01:01:05 livecd usbcore: registered new driver hub
Jun  2 01:01:05 livecd GSI 18 sharing vector 0xB9 and IRQ 18
Jun  2 01:01:05 livecd ACPI: PCI Interrupt 0000:00:1d.7[D] -> GSI 23 (level, low) -> IRQ 18
Jun  2 01:01:05 livecd PCI: Setting latency timer of device 0000:00:1d.7 to 64
Jun  2 01:01:05 livecd ehci_hcd 0000:00:1d.7: EHCI Host Controller
Jun  2 01:01:05 livecd ehci_hcd 0000:00:1d.7: debug port 1
Jun  2 01:01:05 livecd PCI: cache line size of 128 is not supported by device 0000:00:1d.7
Jun  2 01:01:05 livecd ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
Jun  2 01:01:05 livecd ehci_hcd 0000:00:1d.7: irq 18, io mem 0xd4001000
Jun  2 01:01:05 livecd ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
Jun  2 01:01:05 livecd hub 1-0:1.0: USB hub found
Jun  2 01:01:05 livecd hub 1-0:1.0: 8 ports detected
Jun  2 01:01:05 livecd usbcore: registered new driver hiddev
Jun  2 01:01:05 livecd usbcore: registered new driver usbhid
Jun  2 01:01:05 livecd drivers/usb/input/hid-core.c: v2.6:USB HID core driver
Jun  2 01:01:05 livecd Initializing USB Mass Storage driver...
Jun  2 01:01:05 livecd usbcore: registered new driver usb-storage
Jun  2 01:01:05 livecd USB Mass Storage support registered.
Jun  2 01:01:05 livecd USB Universal Host Controller Interface driver v2.3
Jun  2 01:01:05 livecd ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 16 (level, low) -> IRQ 16
Jun  2 01:01:05 livecd PCI: Setting latency timer of device 0000:00:1d.0 to 64
Jun  2 01:01:05 livecd uhci_hcd 0000:00:1d.0: UHCI Host Controller
Jun  2 01:01:05 livecd uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
Jun  2 01:01:05 livecd uhci_hcd 0000:00:1d.0: irq 16, io base 0x00001400
Jun  2 01:01:05 livecd hub 2-0:1.0: USB hub found
Jun  2 01:01:05 livecd hub 2-0:1.0: 2 ports detected
Jun  2 01:01:05 livecd GSI 19 sharing vector 0xC1 and IRQ 19
Jun  2 01:01:05 livecd ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 19
Jun  2 01:01:05 livecd PCI: Setting latency timer of device 0000:00:1d.1 to 64
Jun  2 01:01:05 livecd uhci_hcd 0000:00:1d.1: UHCI Host Controller
Jun  2 01:01:05 livecd uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
Jun  2 01:01:05 livecd uhci_hcd 0000:00:1d.1: irq 19, io base 0x00001420
Jun  2 01:01:05 livecd hub 3-0:1.0: USB hub found
Jun  2 01:01:05 livecd hub 3-0:1.0: 2 ports detected
Jun  2 01:01:05 livecd ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 17
Jun  2 01:01:05 livecd PCI: Setting latency timer of device 0000:00:1d.2 to 64
Jun  2 01:01:05 livecd uhci_hcd 0000:00:1d.2: UHCI Host Controller
Jun  2 01:01:05 livecd uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
Jun  2 01:01:05 livecd uhci_hcd 0000:00:1d.2: irq 17, io base 0x00001440
Jun  2 01:01:05 livecd hub 4-0:1.0: USB hub found
Jun  2 01:01:05 livecd hub 4-0:1.0: 2 ports detected
Jun  2 01:01:05 livecd ACPI: PCI Interrupt 0000:00:1d.3[A] -> GSI 16 (level, low) -> IRQ 16
Jun  2 01:01:05 livecd PCI: Setting latency timer of device 0000:00:1d.3 to 64
Jun  2 01:01:05 livecd uhci_hcd 0000:00:1d.3: UHCI Host Controller
Jun  2 01:01:05 livecd uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 5
Jun  2 01:01:05 livecd uhci_hcd 0000:00:1d.3: irq 16, io base 0x00001460
Jun  2 01:01:05 livecd hub 5-0:1.0: USB hub found
Jun  2 01:01:05 livecd hub 5-0:1.0: 2 ports detected
Jun  2 01:01:05 livecd ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
Jun  2 01:01:05 livecd sl811: driver sl811-hcd, 19 May 2005
Jun  2 01:01:05 livecd ieee1394: Initialized config rom entry `ip1394'
Jun  2 01:01:05 livecd sbp2: $Rev: 1306 $ Ben Collins <bcollins@debian.org>
Jun  2 01:01:05 livecd ieee1394: sbp2: Driver forced to serialize I/O (serialize_io=1)
Jun  2 01:01:05 livecd ieee1394: sbp2: Try serialize_io=0 for better performance
Jun  2 01:01:05 livecd libata version 1.20 loaded.
Jun  2 01:01:05 livecd device-mapper: 4.4.0-ioctl (2005-01-12) initialised: dm-devel@redhat.com
Jun  2 01:01:05 livecd ReiserFS: hdd: warning: sh-2021: reiserfs_fill_super: can not find reiserfs on hdd
Jun  2 01:01:05 livecd VFS: Can't find ext3 filesystem on dev hdd.
Jun  2 01:01:05 livecd VFS: Can't find an ext2 filesystem on dev hdd.
Jun  2 01:01:05 livecd SQUASHFS error: Can't find a SQUASHFS superblock on hdd
Jun  2 01:01:05 livecd FAT: bogus number of reserved sectors
Jun  2 01:01:05 livecd VFS: Can't find a valid FAT filesystem on dev hdd.
Jun  2 01:01:05 livecd ISO 9660 Extensions: Microsoft Joliet Level 3
Jun  2 01:01:05 livecd ISO 9660 Extensions: RRIP_1991A
Jun  2 01:01:15 livecd Intel(R) PRO/1000 Network Driver - version 6.1.16-k2
Jun  2 01:01:15 livecd Copyright (c) 1999-2005 Intel Corporation.
Jun  2 01:01:15 livecd GSI 20 sharing vector 0xC9 and IRQ 20
Jun  2 01:01:15 livecd ACPI: PCI Interrupt 0000:03:02.0[A] -> GSI 54 (level, low) -> IRQ 20
Jun  2 01:01:15 livecd e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
Jun  2 01:01:15 livecd GSI 21 sharing vector 0xD1 and IRQ 21
Jun  2 01:01:15 livecd ACPI: PCI Interrupt 0000:03:02.1[B] -> GSI 55 (level, low) -> IRQ 21
Jun  2 01:01:15 livecd e1000: eth1: e1000_probe: Intel(R) PRO/1000 Network Connection
Jun  2 01:01:16 livecd ACPI: PCI interrupt for device 0000:03:02.1 disabled
Jun  2 01:01:16 livecd ACPI: PCI interrupt for device 0000:03:02.0 disabled
Jun  2 01:01:16 livecd rc-scripts: eth1 does not exist
Jun  2 01:01:16 livecd rc-scripts: eth0 does not exist
Jun  2 01:01:17 livecd Intel(R) PRO/1000 Network Driver - version 6.1.16-k2
Jun  2 01:01:17 livecd Copyright (c) 1999-2005 Intel Corporation.
Jun  2 01:01:17 livecd ACPI: PCI Interrupt 0000:03:02.0[A] -> GSI 54 (level, low) -> IRQ 20
Jun  2 01:01:17 livecd e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
Jun  2 01:01:17 livecd ACPI: PCI Interrupt 0000:03:02.1[B] -> GSI 55 (level, low) -> IRQ 21
Jun  2 01:01:17 livecd e1000: eth1: e1000_probe: Intel(R) PRO/1000 Network Connection
Jun  2 01:01:17 livecd Adaptec aacraid driver (1.1-4 Feb 22 2006 17:53:59)
Jun  2 01:01:17 livecd GSI 22 sharing vector 0xD9 and IRQ 22
Jun  2 01:01:17 livecd ACPI: PCI Interrupt 0000:02:01.0[A] -> GSI 24 (level, low) -> IRQ 22
Jun  2 01:01:17 livecd AAC0: kernel 4.2-1[7373] 
Jun  2 01:01:17 livecd AAC0: monitor 4.2-1[7373]
Jun  2 01:01:17 livecd AAC0: bios 4.2-1[7373]
Jun  2 01:01:17 livecd AAC0: Non-DASD support enabled.
Jun  2 01:01:17 livecd AAC0: 64bit support enabled.
Jun  2 01:01:17 livecd AAC0: 64 Bit DAC enabled
Jun  2 01:01:17 livecd scsi0 : aacraid
Jun  2 01:01:17 livecd Vendor: Adaptec   Model: RAID1             Rev: V1.0
Jun  2 01:01:17 livecd Type:   Direct-Access                      ANSI SCSI revision: 02
Jun  2 01:01:17 livecd SCSI device sda: 143307008 512-byte hdwr sectors (73373 MB)
Jun  2 01:01:17 livecd sda: Write Protect is off
Jun  2 01:01:17 livecd sda: Mode Sense: 03 00 00 00
Jun  2 01:01:17 livecd sda: got wrong page
Jun  2 01:01:17 livecd sda: assuming drive cache: write through
Jun  2 01:01:17 livecd SCSI device sda: 143307008 512-byte hdwr sectors (73373 MB)
Jun  2 01:01:17 livecd sda: Write Protect is off
Jun  2 01:01:17 livecd sda: Mode Sense: 03 00 00 00
Jun  2 01:01:17 livecd sda: got wrong page
Jun  2 01:01:17 livecd sda: assuming drive cache: write through
Jun  2 01:01:17 livecd sda: sda1 sda2 sda3 sda4
Jun  2 01:01:17 livecd sd 0:0:0:0: Attached scsi removable disk sda
Jun  2 01:01:17 livecd Vendor: SEAGATE   Model: ST373207LC        Rev: 0003
Jun  2 01:01:17 livecd Type:   Direct-Access                      ANSI SCSI revision: 03
Jun  2 01:01:17 livecd SCSI device sdb: 143374744 512-byte hdwr sectors (73408 MB)
Jun  2 01:01:17 livecd SCSI device sdb: drive cache: write back
Jun  2 01:01:17 livecd SCSI device sdb: 143374744 512-byte hdwr sectors (73408 MB)
Jun  2 01:01:17 livecd SCSI device sdb: drive cache: write back
Jun  2 01:01:17 livecd sdb: unknown partition table
Jun  2 01:01:17 livecd sd 0:1:0:0: Attached scsi disk sdb
Jun  2 01:01:17 livecd scsi.agent[8663]: disk at /devices/pci0000:00/0000:00:02.0/0000:01:00.0/0000:02:01.0/host0/target0:0:0/0:0:0:0
Jun  2 01:01:17 livecd scsi.agent[8676]: disk at /devices/pci0000:00/0000:00:02.0/0000:01:00.0/0000:02:01.0/host0/target0:1:0/0:1:0:0
Jun  2 01:01:21 livecd rc-scripts: Not Loading APM Bios support ...
Jun  2 01:01:21 livecd rc-scripts: Not Loading ACPI support ...
Jun  2 01:01:26 livecd input: PC Speaker as /class/input/input2
Jun  2 01:01:26 livecd Floppy drive(s): fd0 is 1.44M
Jun  2 01:01:26 livecd FDC 0 is a National Semiconductor PC87306
Jun  2 01:01:28 livecd e1000: eth0: e1000_watchdog_task: NIC Link is Up 1000 Mbps Full Duplex
Jun  2 01:01:28 livecd dhcpcd[10256]: dhcpConfig: ioctl SIOCADDRT: File exists
Jun  2 01:01:30 livecd fbsplash: console 0 using theme 'default'
Jun  2 01:01:30 livecd fbsplash: switched splash state to 'on' on console 0
Jun  2 01:02:30 livecd NET: Registered protocol family 10
Jun  2 01:02:30 livecd lo: Disabled Privacy Extensions
Jun  2 01:02:30 livecd IPv6 over IPv4 tunneling driver
Jun  2 01:02:30 livecd sshd[10802]: Server listening on :: port 22.
Jun  2 01:02:30 livecd sshd[10802]: error: Bind to port 22 on 0.0.0.0 failed: Address already in use.
Jun  2 01:02:30 livecd net.agent[10795]: add event not handled
Jun  2 01:02:38 livecd passwd(pam_unix)[10806]: password changed for root
Jun  2 01:02:40 livecd eth0: no IPv6 routers present
Jun  2 01:07:43 livecd sshd[10807]: Accepted keyboard-interactive/pam for root from 192.44.78.23 port 37708 ssh2
Jun  2 01:07:43 livecd sshd[10810]: lastlog_filetype: Couldn't stat /var/log/lastlog: No such file or directory
Jun  2 01:07:43 livecd sshd[10810]: lastlog_openseek: /var/log/lastlog is not a file or directory!
Jun  2 01:07:43 livecd sshd[10810]: lastlog_filetype: Couldn't stat /var/log/lastlog: No such file or directory
Jun  2 01:07:43 livecd sshd[10810]: lastlog_openseek: /var/log/lastlog is not a file or directory!
Jun  2 01:07:43 livecd sshd(pam_unix)[10810]: session opened for user root by root(uid=0)
Jun  2 01:27:44 livecd ReiserFS: sda1: found reiserfs format "3.6" with standard journal
Jun  2 01:27:44 livecd ReiserFS: sda1: using ordered data mode
Jun  2 01:27:45 livecd ReiserFS: sda1: journal params: device sda1, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
Jun  2 01:27:45 livecd ReiserFS: sda1: checking transaction log (sda1)
Jun  2 01:27:45 livecd ReiserFS: sda1: replayed 6 transactions in 0 seconds
Jun  2 01:27:45 livecd ReiserFS: sda1: Using r5 hash to sort names
Jun  2 01:27:45 livecd ReiserFS: sda1: Removing [2 20 0x0 SD]..done
Jun  2 01:27:45 livecd ReiserFS: sda1: There were 1 uncompleted unlinks/truncates. Completed
Jun  2 01:28:45 livecd ReiserFS: sda1: found reiserfs format "3.6" with standard journal
Jun  2 01:28:45 livecd ReiserFS: sda1: using ordered data mode
Jun  2 01:28:45 livecd ReiserFS: sda1: journal params: device sda1, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
Jun  2 01:28:45 livecd ReiserFS: sda1: checking transaction log (sda1)
Jun  2 01:28:45 livecd ReiserFS: sda1: Using r5 hash to sort names
Jun  2 01:28:45 livecd Losing some ticks... checking if CPU frequency changed.
Jun  2 01:28:45 livecd ReiserFS: sda1: warning: Created .reiserfs_priv on sda1 - reserved for xattr storage.
Jun  2 01:29:46 livecd portmap: server localhost not responding, timed out
Jun  2 01:29:46 livecd RPC: failed to contact portmap (errno -5).
Jun  2 01:30:21 livecd portmap: server localhost not responding, timed out
Jun  2 01:30:21 livecd RPC: failed to contact portmap (errno -5).
Jun  2 01:30:21 livecd lockd_up: makesock failed, error=-5
Jun  2 01:30:56 livecd portmap: server localhost not responding, timed out
Jun  2 01:30:56 livecd RPC: failed to contact portmap (errno -5).
Jun  2 01:32:11 livecd aacraid: Host adapter reset request. SCSI hang ?
Jun  2 01:32:11 livecd aacraid: Host adapter appears dead
Jun  2 01:32:12 livecd sd 0:0:0:0: scsi: Device offlined - not ready after error recovery
Jun  2 01:32:12 livecd sd 0:0:0:0: scsi: Device offlined - not ready after error recovery
Jun  2 01:32:12 livecd sd 0:0:0:0: scsi: Device offlined - not ready after error recovery
Jun  2 01:32:12 livecd sd 0:0:0:0: scsi: Device offlined - not ready after error recovery
Jun  2 01:32:12 livecd sd 0:0:0:0: scsi: Device offlined - not ready after error recovery
Jun  2 01:32:12 livecd sd 0:0:0:0: scsi: Device offlined - not ready after error recovery
Jun  2 01:32:12 livecd sd 0:0:0:0: scsi: Device offlined - not ready after error recovery
Jun  2 01:32:12 livecd sd 0:0:0:0: scsi: Device offlined - not ready after error recovery
Jun  2 01:32:12 livecd sd 0:0:0:0: scsi: Device offlined - not ready after error recovery
Jun  2 01:32:12 livecd sd 0:0:0:0: scsi: Device offlined - not ready after error recovery
Jun  2 01:32:12 livecd sd 0:0:0:0: scsi: Device offlined - not ready after error recovery
Jun  2 01:32:12 livecd sd 0:0:0:0: scsi: Device offlined - not ready after error recovery
Jun  2 01:32:12 livecd sd 0:0:0:0: scsi: Device offlined - not ready after error recovery
Jun  2 01:32:12 livecd sd 0:0:0:0: scsi: Device offlined - not ready after error recovery
Jun  2 01:32:12 livecd sd 0:0:0:0: scsi: Device offlined - not ready after error recovery
Jun  2 01:32:12 livecd sd 0:0:0:0: scsi: Device offlined - not ready after error recovery
Jun  2 01:32:12 livecd sd 0:0:0:0: scsi: Device offlined - not ready after error recovery
Jun  2 01:32:12 livecd sd 0:0:0:0: scsi: Device offlined - not ready after error recovery
Jun  2 01:32:12 livecd sd 0:0:0:0: scsi: Device offlined - not ready after error recovery
Jun  2 01:32:12 livecd sd 0:0:0:0: scsi: Device offlined - not ready after error recovery
Jun  2 01:32:12 livecd sd 0:0:0:0: scsi: Device offlined - not ready after error recovery
Jun  2 01:32:12 livecd sd 0:0:0:0: scsi: Device offlined - not ready after error recovery
Jun  2 01:32:12 livecd sd 0:0:0:0: scsi: Device offlined - not ready after error recovery
Jun  2 01:32:12 livecd sd 0:0:0:0: scsi: Device offlined - not ready after error recovery
Jun  2 01:32:12 livecd sd 0:0:0:0: scsi: Device offlined - not ready after error recovery
Jun  2 01:32:12 livecd sd 0:0:0:0: scsi: Device offlined - not ready after error recovery
Jun  2 01:32:12 livecd sd 0:0:0:0: scsi: Device offlined - not ready after error recovery
Jun  2 01:32:12 livecd sd 0:0:0:0: scsi: Device offlined - not ready after error recovery
Jun  2 01:32:12 livecd sd 0:0:0:0: scsi: Device offlined - not ready after error recovery
Jun  2 01:32:12 livecd sd 0:0:0:0: scsi: Device offlined - not ready after error recovery
Jun  2 01:32:12 livecd sd 0:0:0:0: scsi: Device offlined - not ready after error recovery
Jun  2 01:32:12 livecd sd 0:0:0:0: scsi: Device offlined - not ready after error recovery
Jun  2 01:32:12 livecd sd 0:0:0:0: scsi: Device offlined - not ready after error recovery
Jun  2 01:32:12 livecd sd 0:0:0:0: scsi: Device offlined - not ready after error recovery
Jun  2 01:32:12 livecd sd 0:0:0:0: scsi: Device offlined - not ready after error recovery
Jun  2 01:32:12 livecd sd 0:0:0:0: scsi: Device offlined - not ready after error recovery
Jun  2 01:32:12 livecd sd 0:0:0:0: scsi: Device offlined - not ready after error recovery
Jun  2 01:32:12 livecd sd 0:0:0:0: scsi: Device offlined - not ready after error recovery
Jun  2 01:32:12 livecd sd 0:0:0:0: scsi: Device offlined - not ready after error recovery
Jun  2 01:32:12 livecd sd 0:0:0:0: scsi: Device offlined - not ready after error recovery
Jun  2 01:32:12 livecd sd 0:0:0:0: scsi: Device offlined - not ready after error recovery
Jun  2 01:32:12 livecd sd 0:0:0:0: scsi: Device offlined - not ready after error recovery
Jun  2 01:32:12 livecd sd 0:0:0:0: scsi: Device offlined - not ready after error recovery
Jun  2 01:32:12 livecd sd 0:0:0:0: scsi: Device offlined - not ready after error recovery
Jun  2 01:32:12 livecd sd 0:0:0:0: scsi: Device offlined - not ready after error recovery
Jun  2 01:32:12 livecd sd 0:0:0:0: scsi: Device offlined - not ready after error recovery
Jun  2 01:32:12 livecd sd 0:0:0:0: scsi: Device offlined - not ready after error recovery
Jun  2 01:32:12 livecd sd 0:0:0:0: scsi: Device offlined - not ready after error recovery
Jun  2 01:32:12 livecd sd 0:0:0:0: scsi: Device offlined - not ready after error recovery
Jun  2 01:32:12 livecd sd 0:0:0:0: scsi: Device offlined - not ready after error recovery
Jun  2 01:32:12 livecd sd 0:0:0:0: scsi: Device offlined - not ready after error recovery
Jun  2 01:32:12 livecd sd 0:0:0:0: scsi: Device offlined - not ready after error recovery
Jun  2 01:32:12 livecd sd 0:0:0:0: scsi: Device offlined - not ready after error recovery
Jun  2 01:32:12 livecd sd 0:0:0:0: scsi: Device offlined - not ready after error recovery
Jun  2 01:32:12 livecd sd 0:0:0:0: scsi: Device offlined - not ready after error recovery
Jun  2 01:32:12 livecd sd 0:0:0:0: scsi: Device offlined - not ready after error recovery
Jun  2 01:32:12 livecd sd 0:0:0:0: scsi: Device offlined - not ready after error recovery
Jun  2 01:32:12 livecd sd 0:0:0:0: scsi: Device offlined - not ready after error recovery
Jun  2 01:32:12 livecd sd 0:0:0:0: scsi: Device offlined - not ready after error recovery
Jun  2 01:32:12 livecd sd 0:0:0:0: scsi: Device offlined - not ready after error recovery
Jun  2 01:32:12 livecd sd 0:0:0:0: scsi: Device offlined - not ready after error recovery
Jun  2 01:32:12 livecd sd 0:0:0:0: scsi: Device offlined - not ready after error recovery
Jun  2 01:32:12 livecd sd 0:0:0:0: scsi: Device offlined - not ready after error recovery
Jun  2 01:32:12 livecd sd 0:0:0:0: scsi: Device offlined - not ready after error recovery
Jun  2 01:32:12 livecd sd 0:0:0:0: scsi: Device offlined - not ready after error recovery
Jun  2 01:32:12 livecd sd 0:0:0:0: scsi: Device offlined - not ready after error recovery
Jun  2 01:32:12 livecd sd 0:0:0:0: scsi: Device offlined - not ready after error recovery
Jun  2 01:32:12 livecd sd 0:0:0:0: scsi: Device offlined - not ready after error recovery
Jun  2 01:32:12 livecd sd 0:0:0:0: scsi: Device offlined - not ready after error recovery
Jun  2 01:32:12 livecd sd 0:0:0:0: scsi: Device offlined - not ready after error recovery
Jun  2 01:32:12 livecd sd 0:0:0:0: scsi: Device offlined - not ready after error recovery
Jun  2 01:32:12 livecd sd 0:0:0:0: scsi: Device offlined - not ready after error recovery
Jun  2 01:32:12 livecd sd 0:0:0:0: scsi: Device offlined - not ready after error recovery
Jun  2 01:32:12 livecd sd 0:0:0:0: scsi: Device offlined - not ready after error recovery
Jun  2 01:32:12 livecd sd 0:0:0:0: scsi: Device offlined - not ready after error recovery
Jun  2 01:32:12 livecd sd 0:0:0:0: scsi: Device offlined - not ready after error recovery
Jun  2 01:32:12 livecd sd 0:0:0:0: scsi: Device offlined - not ready after error recovery
Jun  2 01:32:12 livecd sd 0:0:0:0: scsi: Device offlined - not ready after error recovery
Jun  2 01:32:12 livecd sd 0:0:0:0: scsi: Device offlined - not ready after error recovery
Jun  2 01:32:12 livecd sd 0:0:0:0: scsi: Device offlined - not ready after error recovery
Jun  2 01:32:12 livecd sd 0:0:0:0: scsi: Device offlined - not ready after error recovery
Jun  2 01:32:12 livecd sd 0:0:0:0: scsi: Device offlined - not ready after error recovery
Jun  2 01:32:12 livecd sd 0:0:0:0: scsi: Device offlined - not ready after error recovery
Jun  2 01:32:12 livecd sd 0:0:0:0: scsi: Device offlined - not ready after error recovery
Jun  2 01:32:12 livecd sd 0:0:0:0: scsi: Device offlined - not ready after error recovery
Jun  2 01:32:12 livecd sd 0:0:0:0: scsi: Device offlined - not ready after error recovery
Jun  2 01:32:12 livecd sd 0:0:0:0: scsi: Device offlined - not ready after error recovery
Jun  2 01:32:12 livecd sd 0:0:0:0: scsi: Device offlined - not ready after error recovery
Jun  2 01:32:12 livecd sd 0:0:0:0: scsi: Device offlined - not ready after error recovery
Jun  2 01:32:12 livecd sd 0:0:0:0: scsi: Device offlined - not ready after error recovery
Jun  2 01:32:12 livecd sd 0:0:0:0: scsi: Device offlined - not ready after error recovery
Jun  2 01:32:12 livecd sd 0:0:0:0: scsi: Device offlined - not ready after error recovery
Jun  2 01:32:12 livecd sd 0:0:0:0: scsi: Device offlined - not ready after error recovery
Jun  2 01:32:12 livecd sd 0:0:0:0: scsi: Device offlined - not ready after error recovery
Jun  2 01:32:12 livecd sd 0:0:0:0: scsi: Device offlined - not ready after error recovery
Jun  2 01:32:12 livecd sd 0:0:0:0: scsi: Device offlined - not ready after error recovery
Jun  2 01:32:12 livecd sd 0:0:0:0: scsi: Device offlined - not ready after error recovery
Jun  2 01:32:12 livecd sd 0:0:0:0: scsi: Device offlined - not ready after error recovery
Jun  2 01:32:12 livecd sd 0:0:0:0: scsi: Device offlined - not ready after error recovery
Jun  2 01:32:12 livecd sd 0:0:0:0: scsi: Device offlined - not ready after error recovery
Jun  2 01:32:12 livecd sd 0:0:0:0: scsi: Device offlined - not ready after error recovery
Jun  2 01:32:12 livecd sd 0:0:0:0: scsi: Device offlined - not ready after error recovery
Jun  2 01:32:12 livecd sd 0:0:0:0: scsi: Device offlined - not ready after error recovery
Jun  2 01:32:12 livecd sd 0:0:0:0: scsi: Device offlined - not ready after error recovery
Jun  2 01:32:12 livecd sd 0:0:0:0: scsi: Device offlined - not ready after error recovery
Jun  2 01:32:12 livecd sd 0:0:0:0: scsi: Device offlined - not ready after error recovery
Jun  2 01:32:12 livecd sd 0:0:0:0: scsi: Device offlined - not ready after error recovery
Jun  2 01:32:12 livecd sd 0:0:0:0: scsi: Device offlined - not ready after error recovery
Jun  2 01:32:12 livecd sd 0:0:0:0: scsi: Device offlined - not ready after error recovery
Jun  2 01:32:12 livecd sd 0:0:0:0: SCSI error: return code = 0x6000000
Jun  2 01:32:12 livecd end_request: I/O error, dev sda, sector 294191
Jun  2 01:32:12 livecd sd 0:0:0:0: rejecting I/O to offline device
Jun  2 01:32:12 livecd sd 0:0:0:0: SCSI error: return code = 0x6000000
Jun  2 01:32:12 livecd end_request: I/O error, dev sda, sector 294255
Jun  2 01:32:12 livecd sd 0:0:0:0: rejecting I/O to offline device
Jun  2 01:32:12 livecd sd 0:0:0:0: SCSI error: return code = 0x6000000
Jun  2 01:32:12 livecd end_request: I/O error, dev sda, sector 294327
Jun  2 01:32:12 livecd sd 0:0:0:0: rejecting I/O to offline device
Jun  2 01:32:12 livecd sd 0:0:0:0: SCSI error: return code = 0x6000000
Jun  2 01:32:12 livecd end_request: I/O error, dev sda, sector 294439
Jun  2 01:32:12 livecd sd 0:0:0:0: SCSI error: return code = 0x6000000
Jun  2 01:32:12 livecd end_request: I/O error, dev sda, sector 294303
Jun  2 01:32:12 livecd sd 0:0:0:0: SCSI error: return code = 0x6000000
Jun  2 01:32:12 livecd end_request: I/O error, dev sda, sector 294447
Jun  2 01:32:12 livecd sd 0:0:0:0: SCSI error: return code = 0x6000000
Jun  2 01:32:12 livecd end_request: I/O error, dev sda, sector 294495
Jun  2 01:32:12 livecd sd 0:0:0:0: rejecting I/O to offline device
Jun  2 01:32:12 livecd sd 0:0:0:0: SCSI error: return code = 0x6000000
Jun  2 01:32:12 livecd end_request: I/O error, dev sda, sector 294703
Jun  2 01:32:12 livecd sd 0:0:0:0: SCSI error: return code = 0x6000000
Jun  2 01:32:12 livecd end_request: I/O error, dev sda, sector 294679
Jun  2 01:32:12 livecd sd 0:0:0:0: SCSI error: return code = 0x6000000
Jun  2 01:32:12 livecd end_request: I/O error, dev sda, sector 294711
Jun  2 01:32:12 livecd sd 0:0:0:0: SCSI error: return code = 0x6000000
Jun  2 01:32:12 livecd end_request: I/O error, dev sda, sector 294727
Jun  2 01:32:12 livecd sd 0:0:0:0: rejecting I/O to offline device
Jun  2 01:32:12 livecd sd 0:0:0:0: SCSI error: return code = 0x6000000
Jun  2 01:32:12 livecd end_request: I/O error, dev sda, sector 295047
Jun  2 01:32:12 livecd sd 0:0:0:0: SCSI error: return code = 0x6000000
Jun  2 01:32:12 livecd end_request: I/O error, dev sda, sector 295055
Jun  2 01:32:12 livecd sd 0:0:0:0: rejecting I/O to offline device
Jun  2 01:32:12 livecd sd 0:0:0:0: SCSI error: return code = 0x6000000
Jun  2 01:32:12 livecd end_request: I/O error, dev sda, sector 295095
Jun  2 01:32:12 livecd sd 0:0:0:0: rejecting I/O to offline device
Jun  2 01:32:12 livecd sd 0:0:0:0: SCSI error: return code = 0x6000000
Jun  2 01:32:12 livecd end_request: I/O error, dev sda, sector 295127
Jun  2 01:32:12 livecd sd 0:0:0:0: rejecting I/O to offline device
Jun  2 01:32:12 livecd sd 0:0:0:0: SCSI error: return code = 0x6000000
Jun  2 01:32:12 livecd end_request: I/O error, dev sda, sector 295151
Jun  2 01:32:12 livecd sd 0:0:0:0: SCSI error: return code = 0x6000000
Jun  2 01:32:12 livecd end_request: I/O error, dev sda, sector 295159
Jun  2 01:32:12 livecd sd 0:0:0:0: rejecting I/O to offline device
Jun  2 01:32:12 livecd sd 0:0:0:0: SCSI error: return code = 0x6000000
Jun  2 01:32:12 livecd end_request: I/O error, dev sda, sector 295199
Jun  2 01:32:12 livecd sd 0:0:0:0: rejecting I/O to offline device
Jun  2 01:32:12 livecd sd 0:0:0:0: SCSI error: return code = 0x6000000
Jun  2 01:32:12 livecd end_request: I/O error, dev sda, sector 295263
Jun  2 01:32:12 livecd sd 0:0:0:0: rejecting I/O to offline device
Jun  2 01:32:12 livecd sd 0:0:0:0: SCSI error: return code = 0x6000000
Jun  2 01:32:12 livecd end_request: I/O error, dev sda, sector 295287
Jun  2 01:32:12 livecd sd 0:0:0:0: SCSI error: return code = 0x6000000
Jun  2 01:32:12 livecd end_request: I/O error, dev sda, sector 295295
Jun  2 01:32:12 livecd sd 0:0:0:0: SCSI error: return code = 0x6000000
Jun  2 01:32:12 livecd end_request: I/O error, dev sda, sector 295319
Jun  2 01:32:12 livecd sd 0:0:0:0: rejecting I/O to offline device
Jun  2 01:32:12 livecd sd 0:0:0:0: SCSI error: return code = 0x6000000
Jun  2 01:32:12 livecd end_request: I/O error, dev sda, sector 295439
Jun  2 01:32:12 livecd sd 0:0:0:0: rejecting I/O to offline device
Jun  2 01:32:12 livecd sd 0:0:0:0: SCSI error: return code = 0x6000000
Jun  2 01:32:12 livecd end_request: I/O error, dev sda, sector 295695
Jun  2 01:32:12 livecd sd 0:0:0:0: SCSI error: return code = 0x6000000
Jun  2 01:32:12 livecd end_request: I/O error, dev sda, sector 295703
Jun  2 01:32:12 livecd sd 0:0:0:0: SCSI error: return code = 0x6000000
Jun  2 01:32:12 livecd end_request: I/O error, dev sda, sector 295743
Jun  2 01:32:12 livecd sd 0:0:0:0: rejecting I/O to offline device
Jun  2 01:32:12 livecd sd 0:0:0:0: SCSI error: return code = 0x6000000
Jun  2 01:32:12 livecd end_request: I/O error, dev sda, sector 296255
Jun  2 01:32:12 livecd sd 0:0:0:0: rejecting I/O to offline device
Jun  2 01:32:12 livecd sd 0:0:0:0: SCSI error: return code = 0x6000000
Jun  2 01:32:12 livecd end_request: I/O error, dev sda, sector 296743
Jun  2 01:32:12 livecd sd 0:0:0:0: SCSI error: return code = 0x6000000
Jun  2 01:32:12 livecd end_request: I/O error, dev sda, sector 296751
Jun  2 01:32:12 livecd sd 0:0:0:0: SCSI error: return code = 0x6000000
Jun  2 01:32:12 livecd end_request: I/O error, dev sda, sector 296815
Jun  2 01:32:12 livecd sd 0:0:0:0: rejecting I/O to offline device
Jun  2 01:32:12 livecd sd 0:0:0:0: SCSI error: return code = 0x6000000
Jun  2 01:32:12 livecd end_request: I/O error, dev sda, sector 296903
Jun  2 01:32:12 livecd sd 0:0:0:0: rejecting I/O to offline device
Jun  2 01:32:12 livecd sd 0:0:0:0: SCSI error: return code = 0x6000000
Jun  2 01:32:12 livecd end_request: I/O error, dev sda, sector 297047
Jun  2 01:32:12 livecd sd 0:0:0:0: SCSI error: return code = 0x6000000
Jun  2 01:32:12 livecd end_request: I/O error, dev sda, sector 297055
Jun  2 01:32:12 livecd sd 0:0:0:0: rejecting I/O to offline device
Jun  2 01:32:12 livecd sd 0:0:0:0: SCSI error: return code = 0x6000000
Jun  2 01:32:12 livecd end_request: I/O error, dev sda, sector 297079
Jun  2 01:32:12 livecd sd 0:0:0:0: rejecting I/O to offline device
Jun  2 01:32:12 livecd sd 0:0:0:0: SCSI error: return code = 0x6000000
Jun  2 01:32:12 livecd end_request: I/O error, dev sda, sector 297199
Jun  2 01:32:12 livecd sd 0:0:0:0: rejecting I/O to offline device
Jun  2 01:32:12 livecd sd 0:0:0:0: SCSI error: return code = 0x6000000
Jun  2 01:32:12 livecd end_request: I/O error, dev sda, sector 297247
Jun  2 01:32:12 livecd sd 0:0:0:0: SCSI error: return code = 0x6000000
Jun  2 01:32:12 livecd end_request: I/O error, dev sda, sector 297255
Jun  2 01:32:12 livecd sd 0:0:0:0: SCSI error: return code = 0x6000000
Jun  2 01:32:12 livecd end_request: I/O error, dev sda, sector 297271
Jun  2 01:32:12 livecd sd 0:0:0:0: rejecting I/O to offline device
Jun  2 01:32:12 livecd sd 0:0:0:0: SCSI error: return code = 0x6000000
Jun  2 01:32:12 livecd end_request: I/O error, dev sda, sector 297535
Jun  2 01:32:12 livecd sd 0:0:0:0: rejecting I/O to offline device
Jun  2 01:32:12 livecd sd 0:0:0:0: SCSI error: return code = 0x6000000
Jun  2 01:32:12 livecd end_request: I/O error, dev sda, sector 297695
Jun  2 01:32:12 livecd sd 0:0:0:0: SCSI error: return code = 0x6000000
Jun  2 01:32:12 livecd end_request: I/O error, dev sda, sector 297703
Jun  2 01:32:12 livecd sd 0:0:0:0: SCSI error: return code = 0x6000000
Jun  2 01:32:12 livecd end_request: I/O error, dev sda, sector 297791
Jun  2 01:32:12 livecd sd 0:0:0:0: rejecting I/O to offline device
Jun  2 01:32:12 livecd sd 0:0:0:0: SCSI error: return code = 0x6000000
Jun  2 01:32:12 livecd end_request: I/O error, dev sda, sector 297959
Jun  2 01:32:12 livecd sd 0:0:0:0: rejecting I/O to offline device
Jun  2 01:32:12 livecd sd 0:0:0:0: SCSI error: return code = 0x6000000
Jun  2 01:32:12 livecd end_request: I/O error, dev sda, sector 298007
Jun  2 01:32:12 livecd sd 0:0:0:0: SCSI error: return code = 0x6000000
Jun  2 01:32:12 livecd end_request: I/O error, dev sda, sector 298015
Jun  2 01:32:12 livecd sd 0:0:0:0: rejecting I/O to offline device
Jun  2 01:32:12 livecd sd 0:0:0:0: SCSI error: return code = 0x6000000
Jun  2 01:32:12 livecd end_request: I/O error, dev sda, sector 298079
Jun  2 01:32:12 livecd sd 0:0:0:0: rejecting I/O to offline device
Jun  2 01:32:12 livecd sd 0:0:0:0: SCSI error: return code = 0x6000000
Jun  2 01:32:12 livecd end_request: I/O error, dev sda, sector 298135
Jun  2 01:32:12 livecd sd 0:0:0:0: rejecting I/O to offline device
Jun  2 01:32:12 livecd sd 0:0:0:0: SCSI error: return code = 0x6000000
Jun  2 01:32:12 livecd end_request: I/O error, dev sda, sector 298159
Jun  2 01:32:12 livecd sd 0:0:0:0: SCSI error: return code = 0x6000000
Jun  2 01:32:12 livecd end_request: I/O error, dev sda, sector 298167
Jun  2 01:32:12 livecd sd 0:0:0:0: rejecting I/O to offline device
Jun  2 01:32:12 livecd sd 0:0:0:0: SCSI error: return code = 0x6000000
Jun  2 01:32:12 livecd end_request: I/O error, dev sda, sector 298223
Jun  2 01:32:12 livecd sd 0:0:0:0: rejecting I/O to offline device
Jun  2 01:32:12 livecd sd 0:0:0:0: SCSI error: return code = 0x6000000
Jun  2 01:32:12 livecd end_request: I/O error, dev sda, sector 298263
Jun  2 01:32:12 livecd sd 0:0:0:0: rejecting I/O to offline device
Jun  2 01:32:12 livecd sd 0:0:0:0: SCSI error: return code = 0x6000000
Jun  2 01:32:12 livecd end_request: I/O error, dev sda, sector 298295
Jun  2 01:32:12 livecd sd 0:0:0:0: SCSI error: return code = 0x6000000
Jun  2 01:32:12 livecd end_request: I/O error, dev sda, sector 298303
Jun  2 01:32:12 livecd sd 0:0:0:0: SCSI error: return code = 0x6000000
Jun  2 01:32:12 livecd end_request: I/O error, dev sda, sector 298319
Jun  2 01:32:12 livecd sd 0:0:0:0: rejecting I/O to offline device
Jun  2 01:32:12 livecd sd 0:0:0:0: SCSI error: return code = 0x6000000
Jun  2 01:32:12 livecd end_request: I/O error, dev sda, sector 298463
Jun  2 01:32:12 livecd sd 0:0:0:0: rejecting I/O to offline device
Jun  2 01:32:12 livecd sd 0:0:0:0: SCSI error: return code = 0x6000000
Jun  2 01:32:12 livecd end_request: I/O error, dev sda, sector 298623
Jun  2 01:32:12 livecd sd 0:0:0:0: SCSI error: return code = 0x6000000
Jun  2 01:32:12 livecd end_request: I/O error, dev sda, sector 298631
Jun  2 01:32:12 livecd sd 0:0:0:0: rejecting I/O to offline device
Jun  2 01:32:12 livecd sd 0:0:0:0: SCSI error: return code = 0x6000000
Jun  2 01:32:12 livecd end_request: I/O error, dev sda, sector 299143
Jun  2 01:32:12 livecd sd 0:0:0:0: rejecting I/O to offline device
Jun  2 01:32:12 livecd sd 0:0:0:0: SCSI error: return code = 0x6000000
Jun  2 01:32:12 livecd end_request: I/O error, dev sda, sector 299183
Jun  2 01:32:12 livecd sd 0:0:0:0: rejecting I/O to offline device
Jun  2 01:32:12 livecd sd 0:0:0:0: SCSI error: return code = 0x6000000
Jun  2 01:32:12 livecd end_request: I/O error, dev sda, sector 299687
Jun  2 01:32:12 livecd sd 0:0:0:0: SCSI error: return code = 0x6000000
Jun  2 01:32:12 livecd end_request: I/O error, dev sda, sector 299695
Jun  2 01:32:12 livecd sd 0:0:0:0: rejecting I/O to offline device
Jun  2 01:32:12 livecd sd 0:0:0:0: SCSI error: return code = 0x6000000
Jun  2 01:32:12 livecd end_request: I/O error, dev sda, sector 299879
Jun  2 01:32:12 livecd sd 0:0:0:0: rejecting I/O to offline device
Jun  2 01:32:12 livecd sd 0:0:0:0: SCSI error: return code = 0x6000000
Jun  2 01:32:12 livecd end_request: I/O error, dev sda, sector 300071
Jun  2 01:32:12 livecd sd 0:0:0:0: rejecting I/O to offline device
Jun  2 01:32:12 livecd sd 0:0:0:0: SCSI error: return code = 0x6000000
Jun  2 01:32:12 livecd end_request: I/O error, dev sda, sector 300095
Jun  2 01:32:12 livecd sd 0:0:0:0: SCSI error: return code = 0x6000000
Jun  2 01:32:12 livecd end_request: I/O error, dev sda, sector 300103
Jun  2 01:32:12 livecd sd 0:0:0:0: SCSI error: return code = 0x6000000
Jun  2 01:32:12 livecd end_request: I/O error, dev sda, sector 300151
Jun  2 01:32:12 livecd sd 0:0:0:0: rejecting I/O to offline device
Jun  2 01:32:12 livecd sd 0:0:0:0: SCSI error: return code = 0x6000000
Jun  2 01:32:12 livecd end_request: I/O error, dev sda, sector 300215
Jun  2 01:32:12 livecd sd 0:0:0:0: rejecting I/O to offline device
Jun  2 01:32:12 livecd sd 0:0:0:0: SCSI error: return code = 0x6000000
Jun  2 01:32:12 livecd end_request: I/O error, dev sda, sector 300295
Jun  2 01:32:12 livecd sd 0:0:0:0: SCSI error: return code = 0x6000000
Jun  2 01:32:12 livecd end_request: I/O error, dev sda, sector 300319
Jun  2 01:32:12 livecd sd 0:0:0:0: rejecting I/O to offline device
Jun  2 01:32:12 livecd sd 0:0:0:0: SCSI error: return code = 0x6000000
Jun  2 01:32:12 livecd end_request: I/O error, dev sda, sector 300351
Jun  2 01:32:12 livecd sd 0:0:0:0: rejecting I/O to offline device
Jun  2 01:32:12 livecd sd 0:0:0:0: SCSI error: return code = 0x6000000
Jun  2 01:32:12 livecd end_request: I/O error, dev sda, sector 300391
Jun  2 01:32:12 livecd sd 0:0:0:0: rejecting I/O to offline device
Jun  2 01:32:12 livecd sd 0:0:0:0: SCSI error: return code = 0x6000000
Jun  2 01:32:12 livecd end_request: I/O error, dev sda, sector 300535
Jun  2 01:32:12 livecd sd 0:0:0:0: SCSI error: return code = 0x6000000
Jun  2 01:32:12 livecd end_request: I/O error, dev sda, sector 300543
Jun  2 01:32:12 livecd sd 0:0:0:0: SCSI error: return code = 0x6000000
Jun  2 01:32:12 livecd end_request: I/O error, dev sda, sector 300591
Jun  2 01:32:12 livecd sd 0:0:0:0: rejecting I/O to offline device
Jun  2 01:32:12 livecd sd 0:0:0:0: SCSI error: return code = 0x6000000
Jun  2 01:32:12 livecd end_request: I/O error, dev sda, sector 300647
Jun  2 01:32:12 livecd sd 0:0:0:0: rejecting I/O to offline device
Jun  2 01:32:12 livecd sd 0:0:0:0: SCSI error: return code = 0x6000000
Jun  2 01:32:12 livecd end_request: I/O error, dev sda, sector 300695
Jun  2 01:32:12 livecd sd 0:0:0:0: SCSI error: return code = 0x6000000
Jun  2 01:32:12 livecd end_request: I/O error, dev sda, sector 300703
Jun  2 01:32:12 livecd sd 0:0:0:0: SCSI error: return code = 0x6000000
Jun  2 01:32:12 livecd end_request: I/O error, dev sda, sector 300791
Jun  2 01:32:12 livecd sd 0:0:0:0: rejecting I/O to offline device
Jun  2 01:32:12 livecd sd 0:0:0:0: SCSI error: return code = 0x6000000
Jun  2 01:32:12 livecd end_request: I/O error, dev sda, sector 300823
Jun  2 01:32:12 livecd sd 0:0:0:0: rejecting I/O to offline device
Jun  2 01:32:12 livecd sd 0:0:0:0: SCSI error: return code = 0x6000000
Jun  2 01:32:12 livecd end_request: I/O error, dev sda, sector 300895
Jun  2 01:32:12 livecd sd 0:0:0:0: SCSI error: return code = 0x6000000
Jun  2 01:32:12 livecd end_request: I/O error, dev sda, sector 300903
Jun  2 01:32:12 livecd sd 0:0:0:0: SCSI error: return code = 0x6000000
Jun  2 01:32:12 livecd end_request: I/O error, dev sda, sector 300943
Jun  2 01:32:12 livecd sd 0:0:0:0: rejecting I/O to offline device
Jun  2 01:32:12 livecd sd 0:0:0:0: SCSI error: return code = 0x6000000
Jun  2 01:32:12 livecd end_request: I/O error, dev sda, sector 301023
Jun  2 01:32:12 livecd sd 0:0:0:0: rejecting I/O to offline device
Jun  2 01:32:12 livecd sd 0:0:0:0: SCSI error: return code = 0x6000000
Jun  2 01:32:12 livecd end_request: I/O error, dev sda, sector 301055
Jun  2 01:32:12 livecd sd 0:0:0:0: SCSI error: return code = 0x6000000
Jun  2 01:32:12 livecd end_request: I/O error, dev sda, sector 301063
Jun  2 01:32:12 livecd sd 0:0:0:0: rejecting I/O to offline device
Jun  2 01:32:12 livecd sd 0:0:0:0: SCSI error: return code = 0x6000000
Jun  2 01:32:12 livecd end_request: I/O error, dev sda, sector 301103
Jun  2 01:32:12 livecd sd 0:0:0:0: rejecting I/O to offline device
Jun  2 01:32:12 livecd sd 0:0:0:0: SCSI error: return code = 0x6000000
Jun  2 01:32:12 livecd end_request: I/O error, dev sda, sector 301159
Jun  2 01:32:12 livecd sd 0:0:0:0: rejecting I/O to offline device
Jun  2 01:32:12 livecd sd 0:0:0:0: SCSI error: return code = 0x6000000
Jun  2 01:32:12 livecd end_request: I/O error, dev sda, sector 301295
Jun  2 01:32:12 livecd sd 0:0:0:0: SCSI error: return code = 0x6000000
Jun  2 01:32:12 livecd end_request: I/O error, dev sda, sector 301303
Jun  2 01:32:12 livecd sd 0:0:0:0: SCSI error: return code = 0x6000000
Jun  2 01:32:12 livecd end_request: I/O error, dev sda, sector 301407
Jun  2 01:32:12 livecd sd 0:0:0:0: rejecting I/O to offline device
Jun  2 01:32:12 livecd sd 0:0:0:0: SCSI error: return code = 0x6000000
Jun  2 01:32:12 livecd end_request: I/O error, dev sda, sector 301439
Jun  2 01:32:12 livecd sd 0:0:0:0: rejecting I/O to offline device
Jun  2 01:32:12 livecd sd 0:0:0:0: SCSI error: return code = 0x6000000
Jun  2 01:32:12 livecd end_request: I/O error, dev sda, sector 301551
Jun  2 01:32:12 livecd sd 0:0:0:0: SCSI error: return code = 0x6000000
Jun  2 01:32:12 livecd end_request: I/O error, dev sda, sector 301559
Jun  2 01:32:12 livecd sd 0:0:0:0: rejecting I/O to offline device
Jun  2 01:32:12 livecd sd 0:0:0:0: SCSI error: return code = 0x6000000
Jun  2 01:32:12 livecd end_request: I/O error, dev sda, sector 301719
Jun  2 01:32:12 livecd sd 0:0:0:0: rejecting I/O to offline device
Jun  2 01:32:12 livecd sd 0:0:0:0: SCSI error: return code = 0x6000000
Jun  2 01:32:12 livecd end_request: I/O error, dev sda, sector 301799
Jun  2 01:32:12 livecd sd 0:0:0:0: rejecting I/O to offline device
Jun  2 01:32:12 livecd sd 0:0:0:0: SCSI error: return code = 0x6000000
Jun  2 01:32:12 livecd end_request: I/O error, dev sda, sector 301863
Jun  2 01:32:12 livecd sd 0:0:0:0: SCSI error: return code = 0x6000000
Jun  2 01:32:12 livecd end_request: I/O error, dev sda, sector 301871
Jun  2 01:32:12 livecd sd 0:0:0:0: rejecting I/O to offline device
Jun  2 01:32:12 livecd sd 0:0:0:0: SCSI error: return code = 0x6000000
Jun  2 01:32:12 livecd end_request: I/O error, dev sda, sector 301991
Jun  2 01:32:12 livecd sd 0:0:0:0: rejecting I/O to offline device
Jun  2 01:32:12 livecd sd 0:0:0:0: SCSI error: return code = 0x6000000
Jun  2 01:32:12 livecd end_request: I/O error, dev sda, sector 302135
Jun  2 01:32:12 livecd sd 0:0:0:0: rejecting I/O to offline device
Jun  2 01:32:12 livecd sd 0:0:0:0: SCSI error: return code = 0x6000000
Jun  2 01:32:12 livecd end_request: I/O error, dev sda, sector 302399
Jun  2 01:32:12 livecd sd 0:0:0:0: SCSI error: return code = 0x6000000
Jun  2 01:32:12 livecd end_request: I/O error, dev sda, sector 302407
Jun  2 01:32:12 livecd sd 0:0:0:0: rejecting I/O to offline device
Jun  2 01:32:12 livecd sd 0:0:0:0: SCSI error: return code = 0x6000000
Jun  2 01:32:12 livecd end_request: I/O error, dev sda, sector 302799
Jun  2 01:32:12 livecd sd 0:0:0:0: rejecting I/O to offline device
Jun  2 01:32:12 livecd sd 0:0:0:0: SCSI error: return code = 0x6000000
Jun  2 01:32:12 livecd end_request: I/O error, dev sda, sector 302855
Jun  2 01:32:12 livecd sd 0:0:0:0: rejecting I/O to offline device
Jun  2 01:32:12 livecd sd 0:0:0:0: SCSI error: return code = 0x6000000
Jun  2 01:32:12 livecd end_request: I/O error, dev sda, sector 302999
Jun  2 01:32:12 livecd sd 0:0:0:0: SCSI error: return code = 0x6000000
Jun  2 01:32:12 livecd end_request: I/O error, dev sda, sector 303007
Jun  2 01:32:12 livecd sd 0:0:0:0: rejecting I/O to offline device
Jun  2 01:32:12 livecd sd 0:0:0:0: SCSI error: return code = 0x6000000
Jun  2 01:32:12 livecd end_request: I/O error, dev sda, sector 303271
Jun  2 01:32:12 livecd sd 0:0:0:0: rejecting I/O to offline device
Jun  2 01:32:12 livecd sd 0:0:0:0: SCSI error: return code = 0x6000000
Jun  2 01:32:12 livecd end_request: I/O error, dev sda, sector 303431
Jun  2 01:32:12 livecd sd 0:0:0:0: rejecting I/O to offline device
Jun  2 01:32:12 livecd sd 0:0:0:0: SCSI error: return code = 0x6000000
Jun  2 01:32:12 livecd end_request: I/O error, dev sda, sector 303511
Jun  2 01:32:12 livecd sd 0:0:0:0: SCSI error: return code = 0x6000000
Jun  2 01:32:12 livecd end_request: I/O error, dev sda, sector 303519
Jun  2 01:32:12 livecd sd 0:0:0:0: rejecting I/O to offline device
Jun  2 01:32:12 livecd sd 0:0:0:0: rejecting I/O to offline device
Jun  2 01:32:12 livecd Buffer I/O error on device sda1, logical block 60
Jun  2 01:32:12 livecd lost page write due to I/O error on sda1
Jun  2 01:32:12 livecd Buffer I/O error on device sda1, logical block 61
Jun  2 01:32:12 livecd lost page write due to I/O error on sda1
Jun  2 01:32:12 livecd Buffer I/O error on device sda1, logical block 62
Jun  2 01:32:12 livecd lost page write due to I/O error on sda1
Jun  2 01:32:12 livecd Buffer I/O error on device sda1, logical block 63
Jun  2 01:32:12 livecd lost page write due to I/O error on sda1
Jun  2 01:32:12 livecd Buffer I/O error on device sda1, logical block 64
Jun  2 01:32:12 livecd lost page write due to I/O error on sda1
Jun  2 01:32:12 livecd Buffer I/O error on device sda1, logical block 65
Jun  2 01:32:12 livecd lost page write due to I/O error on sda1
Jun  2 01:32:12 livecd Buffer I/O error on device sda1, logical block 66
Jun  2 01:32:12 livecd lost page write due to I/O error on sda1
Jun  2 01:32:12 livecd Buffer I/O error on device sda1, logical block 67
Jun  2 01:32:12 livecd lost page write due to I/O error on sda1
Jun  2 01:32:12 livecd Buffer I/O error on device sda1, logical block 68
Jun  2 01:32:12 livecd lost page write due to I/O error on sda1
Jun  2 01:32:12 livecd Buffer I/O error on device sda1, logical block 69
Jun  2 01:32:12 livecd lost page write due to I/O error on sda1
Jun  2 01:32:12 livecd sd 0:0:0:0: rejecting I/O to offline device
Jun  2 01:32:12 livecd sd 0:0:0:0: rejecting I/O to offline device
Jun  2 01:32:12 livecd REISERFS: abort (device sda1): Journal write error in flush_commit_list
Jun  2 01:32:12 livecd REISERFS: Aborting journal for filesystem on sda1

--gKMricLos+KVdGMg--
