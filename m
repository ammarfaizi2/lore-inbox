Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262696AbVCJCAM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262696AbVCJCAM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 21:00:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262657AbVCJB73
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 20:59:29 -0500
Received: from rproxy.gmail.com ([64.233.170.202]:2027 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262607AbVCJBQn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 20:16:43 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=GJMvDZfFws3L+Ngto5n2tKCUlou78w2YyKEph8TBdIncAItY7wWYdDOcYAh6tp2ZcdTv6WHQlfmQ1SELi0adrUQV9/io/ZeMdlhutpedk07Gfn0MEkgn0MpsWpU03LNJa+CsGnj2xIZq09T7VYmRaSZ7qjXn6reUAneQeaxHCDg=
Message-ID: <9e473391050309171643733a12@mail.gmail.com>
Date: Wed, 9 Mar 2005 20:16:35 -0500
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Jens Axboe <axboe@suse.de>
Subject: Re: current linus bk, error mounting root
Cc: Jeff Garzik <jgarzik@pobox.com>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20050309210926.GZ28855@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_264_13967463.1110417395127"
References: <9e47339105030909031486744f@mail.gmail.com>
	 <422F2F7C.3010605@pobox.com>
	 <9e4733910503091023474eb377@mail.gmail.com>
	 <422F5D0E.7020004@pobox.com>
	 <9e473391050309125118f2e979@mail.gmail.com>
	 <20050309210926.GZ28855@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_264_13967463.1110417395127
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wed, 9 Mar 2005 22:09:26 +0100, Jens Axboe <axboe@suse.de> wrote:
> probably not worth the bother, looks like barrier problems. get the
> serial console running instead and send the full output, I'll take a
> look in the morning.

serial console boot output attached.


> 
> --
> Jens Axboe
> 
> 


-- 
Jon Smirl
jonsmirl@gmail.com

------=_Part_264_13967463.1110417395127
Content-Type: text/plain; name="dmesg-2.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="dmesg-2.txt"

Linux version 2.6.11-bk5 (jonsmirl@jonsmirl.smirl.net) (gcc version 3.4.2 2=
0041017 (Red Hat 3.4.2-6.fc3)) #3 SMP Wed Mar 9 18:36:46 EST 2005

BIOS-provided physical RAM map:

 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)

 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)

 BIOS-e820: 0000000000100000 - 000000003ff74000 (usable)

 BIOS-e820: 000000003ff74000 - 000000003ff76000 (ACPI NVS)

 BIOS-e820: 000000003ff76000 - 000000003ff97000 (ACPI data)

 BIOS-e820: 000000003ff97000 - 0000000040000000 (reserved)

 BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)

 BIOS-e820: 00000000fecf0000 - 00000000fecf1000 (reserved)

 BIOS-e820: 00000000fed20000 - 00000000fed90000 (reserved)

 BIOS-e820: 00000000fee00000 - 00000000fee10000 (reserved)

 BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)

127MB HIGHMEM available.

896MB LOWMEM available.

found SMP MP-table at 000fe710

DMI 2.3 present.

ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)

Processor #0 15:2 APIC version 20

ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)

Processor #1 15:2 APIC version 20

ACPI: LAPIC (acpi_id[0x03] lapic_id[0x01] disabled)

ACPI: LAPIC (acpi_id[0x04] lapic_id[0x03] disabled)

ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])

IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23

ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)

ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)

Enabling APIC mode:  Flat.  Using 1 I/O APICs

Using ACPI (MADT) for SMP configuration information

Allocating PCI resources starting at 40000000 (gap: 40000000:bec00000)

Built 1 zonelists

Kernel command line: ro root=3DLABEL=3D/ console=3DttyS0

Initializing CPU#0

CPU 0 irqstacks, hard=3Dc03b3000 soft=3Dc03b1000

PID hash table entries: 4096 (order: 12, 65536 bytes)

Detected 2793.222 MHz processor.

Using tsc for high-res timesource

Console: colour VGA+ 80x25

Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)

Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)

Memory: 1034896k/1048016k available (1576k kernel code, 12396k reserved, 96=
3k data, 188k init, 130512k highmem)

Checking if this processor honours the WP bit even in supervisor mode... Ok=
.

Security Framework v1.0.0 initialized

Mount-cache hash table entries: 512 (order: 0, 4096 bytes)

CPU: Trace cache: 12K uops, L1 D cache: 8K

CPU: L2 cache: 512K

CPU: Physical Processor ID: 0

Intel machine check architecture supported.

Intel machine check reporting enabled on CPU#0.

CPU0: Intel P4/Xeon Extended MCE MSRs (12) available

CPU0: Thermal monitoring enabled

Enabling fast FPU save and restore... done.

Enabling unmasked SIMD FPU exception support... done.

Checking 'hlt' instruction... OK.

CPU0: Intel(R) Pentium(R) 4 CPU 2.80GHz stepping 09

per-CPU timeslice cutoff: 1462.56 usecs.

task migration cache decay timeout: 2 msecs.

Booting processor 1/1 eip 3000

CPU 1 irqstacks, hard=3Dc03b4000 soft=3Dc03b2000

Initializing CPU#1

CPU: Trace cache: 12K uops, L1 D cache: 8K

CPU: L2 cache: 512K

CPU: Physical Processor ID: 0

Intel machine check architecture supported.

Intel machine check reporting enabled on CPU#1.

CPU1: Intel P4/Xeon Extended MCE MSRs (12) available

CPU1: Thermal monitoring enabled

CPU1: Intel(R) Pentium(R) 4 CPU 2.80GHz stepping 09

Total of 2 processors activated (11091.96 BogoMIPS).

ENABLING IO-APIC IRQs

..TIMER: vector=3D0x31 pin1=3D2 pin2=3D-1

checking TSC synchronization across 2 CPUs: passed.

Brought up 2 CPUs

checking if image is initramfs... it is

Freeing initrd memory: 318k freed

NET: Registered protocol family 16

PCI: PCI BIOS revision 2.10 entry at 0xfba5e, last bus=3D2

PCI: Using configuration type 1

mtrr: v2.0 (20020519)

ACPI: Subsystem revision 20050211

ACPI: Interpreter enabled

ACPI: Using IOAPIC for interrupt routing

ACPI: PCI Root Bridge [PCI0] (00:00)

PCI: Probing PCI hardware (bus 00)

PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1

PCI: Transparent bridge - 0000:00:1e.0

ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 15)

ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 *10 11 12 15)

ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 *9 10 11 12 15)

ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 *10 11 12 15)

ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 11 12 15) *0, disabled=
.

ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 *5 6 7 9 10 11 12 15)

ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 9 *10 11 12 15)

ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 *5 6 7 9 10 11 12 15)

SCSI subsystem initialized

PCI: Using ACPI for IRQ routing

PCI: If a device doesn't work, try "pci=3Drouteirq".  If it helps, post a r=
eport

Simple Boot Flag value 0x87 read from CMOS RAM was invalid

Simple Boot Flag at 0x7a set to 0x1

Machine check exception polling timer started.

audit: initializing netlink socket (disabled)

audit(1110395018.538:0): initialized

highmem bounce pool size: 64 pages

Initializing Cryptographic API

ACPI: PS/2 Keyboard Controller [KBD] at I/O 0x60, 0x64, irq 1

ACPI: PS/2 Mouse Controller [MOU] at irq 12

serio: i8042 AUX port at 0x60,0x64 irq 12

serio: i8042 KBD port at 0x60,0x64 irq 1

Serial: 8250/16550 driver $Revision: 1.90 $ 6 ports, IRQ sharing disabled

ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A

ttyS1 at I/O 0x2f8 (irq =3D 3) is a 16550A

ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A

ttyS1 at I/O 0x2f8 (irq =3D 3) is a 16550A

io scheduler noop registered

io scheduler anticipatory registered

io scheduler deadline registered

io scheduler cfq registered

RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize

loop: loaded (max 8 devices)

Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2

ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx

ICH5: IDE controller at PCI slot 0000:00:1f.1

ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 169

ICH5: chipset revision 2

ICH5: not 100% native mode: will probe irqs later

    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio

    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:DMA

hda: IC35L060AVV207-0, ATA DISK drive

ide0 at 0x1f0-0x1f7,0x3f6 on irq 14

hdc: DVD-RW IDE1008, ATAPI CD/DVD-ROM drive

hdd: LITE-ON LTR-52246S, ATAPI CD/DVD-ROM drive

ide1 at 0x170-0x177,0x376 on irq 15

hda: max request size: 1024KiB

hda: 78125000 sectors (40000 MB) w/1821KiB Cache, CHS=3D16383/255/63, UDMA(=
100)

hda: cache flushes supported

 hda: hda1 hda2 hda3 hda4

hdc: ATAPI 40X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(33)

Uniform CD-ROM driver Revision: 3.20

hdd: ATAPI 52X CD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)

mice: PS/2 mouse device common for all mice

md: md driver 0.90.1 MAX_MD_DEVS=3D256, MD_SB_DISKS=3D27

NET: Registered protocol family 2

IP: routing cache hash table of 8192 buckets, 64Kbytes

TCP established hash table entries: 262144 (order: 9, 2097152 bytes)

TCP bind hash table entries: 65536 (order: 7, 524288 bytes)

TCP: Hash tables configured (established 262144 bind 65536)

Starting balanced_irq

ACPI wakeup devices:=20

VBTN PCI0 USB0 USB1 USB2 USB3 PCI1  MOU=20

ACPI: (supports S0 S1 S4 S5)

Freeing unused kernel memory: 188k freed

Red Hat nash version 4.1.18 starting
Mounted /proc filesystem
md: raid1 personality registered as nr 3

Mounting sysfs
md: Autodetecting RAID arrays.

Creating /dev
SACPI: PCI interrupt 0000:00:1f.2[A] -> GSI 18 (level, low) -> IRQ 169

tarting udev
Lomd: autorun ...

md: considering hda2 ...

md:  adding hda2 ...

md: created md0

md: bind<hda2>

md: running: <hda2>

ading libata.ko raid1: raid set md0 active with 1 out of 2 mirrors

md: ... autorun DONE.

module
Loading ata1: SATA max UDMA/133 cmd 0xFE00 ctl 0xFE12 bmdma 0xFEA0 irq 169

ata_piix.ko moduata2: SATA max UDMA/133 cmd 0xFE20 ctl 0xFE32 bmdma 0xFEA8 =
irq 169

le
Loading raidKernel panic - not syncing: Attempted to kill init!

1.ko module
Cre ating root devic

------=_Part_264_13967463.1110417395127--
