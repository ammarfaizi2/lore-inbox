Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261187AbVFMSju@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261187AbVFMSju (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 14:39:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261194AbVFMSju
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 14:39:50 -0400
Received: from rproxy.gmail.com ([64.233.170.200]:44233 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261187AbVFMShX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 14:37:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:content-transfer-encoding:in-reply-to:user-agent:from;
        b=uBI2lErLI5WcBcKJqwt5hMXKnKHSkUPpyUjc8grN31ssPiU3mdvXzlpONwqzjUQAqdV1l4FvwCyYJK6gD7cml7cqBYMvzI4CNbZQ91bO9PuoovF4KiS95WEH2ScYrjh9ewh808HVIoD3Q83L+DVSwOWrMDEQKsmdhiRGxwP8X6E=
Date: Mon, 13 Jun 2005 20:37:19 +0200
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: dino@in.ibm.com, Andrew Morton <akpm@osdl.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: What breaks aic7xxx in post 2.6.12-rc2 ?
Message-ID: <20050613183719.GA8653@gmail.com>
References: <20050530150950.GA14351@gmail.com> <1117467248.4913.9.camel@mulgrave> <20050530160147.GD14351@gmail.com> <1117477040.4913.12.camel@mulgrave> <20050530190716.GA9239@gmail.com> <1118081857.5045.49.camel@mulgrave> <20050607085710.GB9230@gmail.com> <1118590709.4967.6.camel@mulgrave> <20050613145000.GA12057@gmail.com> <1118674783.5079.9.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1118674783.5079.9.camel@mulgrave>
User-Agent: Mutt/1.5.6i
From: =?utf-8?Q?Gr=E9goire?= Favre <gregoire.favre@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I hope it's right now :

Bootdata ok (command line is root=/dev/sdc2 parport=auto video=vesafb:mtrr,ywrap,1024x800-16@75 vga=0xF07 console=ttyS0)

Linux version 2.6.12-rc6 (root@gregoire) (gcc version 3.4.3 20041125 (Gentoo Linux 3.4.3-r1, ssp-3.4.3-0, pie-8.7.7)) #2 Sun Jun 12 19:50:13 CEST 2005

BIOS-provided physical RAM map:

 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)

 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)

 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)

 BIOS-e820: 0000000000100000 - 000000003fff0000 (usable)

 BIOS-e820: 000000003fff0000 - 000000003fff8000 (ACPI data)

 BIOS-e820: 000000003fff8000 - 0000000040000000 (ACPI NVS)

 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)

 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)

 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)

ACPI: PM-Timer IO Port: 0x808

ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)

Processor #0 15:12 APIC version 16

ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])

IOAPIC[0]: apic_id 2, version 3, address 0xfec00000, GSI 0-23

ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)

ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)

Setting APIC routing to flat

Using ACPI (MADT) for SMP configuration information

Allocating PCI resources starting at 40000000 (gap: 40000000:bec00000)

Built 1 zonelists

Kernel command line: root=/dev/sdc2 parport=auto video=vesafb:mtrr,ywrap,1024x800-16@75 vga=0xF07 console=ttyS0

Initializing CPU#0

PID hash table entries: 4096 (order: 12, 131072 bytes)

time.c: Using 3.579545 MHz PM timer.

time.c: Detected 2000.089 MHz processor.

time.c: Using PIT/TSC based timekeeping.

Console: colour VGA+ 80x60

Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)

Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)

Memory: 1025304k/1048512k available (3137k kernel code, 22512k reserved, 1305k data, 160k init)

Mount-cache hash table entries: 256

CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)

CPU: L2 Cache: 512K (64 bytes/line)

CPU: AMD Athlon(tm) 64 Processor 3000+ stepping 00

Using local APIC timer interrupts.

Detected 12.500 MHz APIC timer.

testing NMI watchdog ... OK.

NET: Registered protocol family 16

PCI: Using configuration type 1

mtrr: v2.0 (20020519)

ACPI: Subsystem revision 20050309

ACPI: Interpreter enabled

ACPI: Using IOAPIC for interrupt routing

ACPI: PCI Root Bridge [PCI0] (0000:00)

PCI: Probing PCI hardware (bus 00)

ACPI: Power Resource [URP1] (off)

ACPI: Power Resource [URP2] (off)

ACPI: Power Resource [FDDP] (off)

ACPI: Power Resource [LPTP] (off)

ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 *11 12 14 15)

ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *10 11 12 14 15)

ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 10 11 12 14 15)

ACPI: PCI Interrupt Link [LNKD] (IRQs *3 4 5 6 7 10 11 12 14 15)

ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.

ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.

ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.

ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.

SCSI subsystem initialized

usbcore: registered new driver usbfs

usbcore: registered new driver hub

PCI: Using ACPI for IRQ routing

PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report

IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 13:02:28 ak Exp $

NTFS driver 2.1.22 [Flags: R/O].

EFS: 1.0a - http://aeschi.ch.eu.org/efs/

SGI XFS with large block/inode numbers, no debug enabled

Initializing Cryptographic API

ACPI: Power Button (FF) [PWRF]

ACPI: Sleep Button (CM) [SLPB]

Real Time Clock Driver v1.12

Non-volatile memory driver v1.2

serio: i8042 AUX port at 0x60,0x64 irq 12

serio: i8042 KBD port at 0x60,0x64 irq 1

Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled

ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A

parport0: PC-style at 0x378 [PCSPP(,...)]

io scheduler noop registered

io scheduler anticipatory registered

io scheduler deadline registered

io scheduler cfq registered

Floppy drive(s): fd0 is 1.44M

FDC 0 is a post-1991 82077

r8169 Gigabit Ethernet driver 2.2LK loaded

ACPI: PCI Interrupt 0000:00:0b.0[A] -> GSI 16 (level, low) -> IRQ 16

r8169: NAPI enabled

eth0: RTL8169 at 0xffffc20000002b00, 00:0c:76:bd:22:23, IRQ 16

Linux video capture interface: v1.00

Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2

ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx

VP_IDE: IDE controller at PCI slot 0000:00:0f.1

ACPI: PCI Interrupt 0000:00:0f.1[A] -> GSI 20 (level, low) -> IRQ 20

VP_IDE: chipset revision 6

VP_IDE: not 100% native mode: will probe irqs later

VP_IDE: VIA vt8237 (rev 00) IDE UDMA133 controller on pci0000:00:0f.1

    ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:pio

    ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:DMA, hdd:pio

hda: IC35L120AVVA07-0, ATA DISK drive

ide0 at 0x1f0-0x1f7,0x3f6 on irq 14

hdc: SONY DVD RW DRU-500A, ATAPI CD/DVD-ROM drive

hdd: IOMEGA ZIP 250 ATAPI Floppy, ATAPI FLOPPY drive

hdd: set_drive_speed_status: status=0x51 { DriveReady SeekComplete Error }

hdd: set_drive_speed_status: error=0x04 { AbortedCommand }

ide1 at 0x170-0x177,0x376 on irq 15

hda: max request size: 128KiB

hda: 241254720 sectors (123522 MB) w/1863KiB Cache, CHS=65535/16/63, UDMA(100)

hda: cache flushes supported

 hda: hda1 hda2 hda3 hda4

hdc: ATAPI 16X DVD-ROM DVD-R CD-R/RW drive, 8192kB Cache, UDMA(33)

Uniform CD-ROM driver Revision: 3.20

ide-floppy driver 0.99.newide

hdd: No disk in drive

hdd: 244736kB, 239/64/32 CHS, 4096 kBps, 512 sector size, 2941 rpm

ACPI: PCI Interrupt 0000:00:05.0[A] -> GSI 16 (level, low) -> IRQ 16

ACPI: PCI Interrupt 0000:00:0a.0[A] -> GSI 17 (level, low) -> IRQ 17

scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36

        <Adaptec 29160B Ultra160 SCSI adapter>

        aic7892: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs



 target0:0:0: SC IS ffff81003fca8b40

 target0:0:0: ULTRA2

 target0:0:0: scsirate IS 0x83, min_period is 10

  Vendor: IBM       Model: DDRS-39130D       Rev: DC1B

  Type:   Direct-Access                      ANSI SCSI revision: 02

 target0:0:0: asynchronous.

scsi0:A:0:0: Tagged Queuing enabled.  Depth 253

 target0:0:0: Beginning Domain Validation

 target0:0:0: wide asynchronous.

 target0:0:0: Domain Validation skipping write tests

 target0:0:0: FAST-40 WIDE SCSI 80.0 MB/s ST (25 ns, offset 15)

 target0:0:0: Ending Domain Validation

 target0:0:1: SC IS ffff81003fca8b40

 target0:0:1: ULTRA2

 target0:0:1: scsirate IS 0x83, min_period is 10

 target0:0:2: SC IS ffff81003fca8b40

 target0:0:2: ULTRA2

 target0:0:2: scsirate IS 0x83, min_period is 10

 target0:0:3: SC IS ffff81003fca8b40

 target0:0:3: ULTRA2

 target0:0:3: scsirate IS 0x83, min_period is 10

 target0:0:4: SC IS ffff81003fca8b40

 target0:0:4: ULTRA2

 target0:0:4: scsirate IS 0x83, min_period is 10

 target0:0:5: SC IS ffff81003fca8b40

 target0:0:5: ULTRA2

 target0:0:5: scsirate IS 0x83, min_period is 10

 target0:0:6: SC IS ffff81003fca8b40

 target0:0:6: ULTRA2

 target0:0:6: scsirate IS 0x83, min_period is 10

 target0:0:8: SC IS ffff81003fca8b40

 target0:0:8: ULTRA2

 target0:0:8: scsirate IS 0x83, min_period is 10

 target0:0:9: SC IS ffff81003fca8b40

 target0:0:9: ULTRA2

 target0:0:9: scsirate IS 0x83, min_period is 10

 target0:0:10: SC IS ffff81003fca8b40

 target0:0:10: ULTRA2

 target0:0:10: scsirate IS 0x83, min_period is 10

 target0:0:11: SC IS ffff81003fca8b40

 target0:0:11: ULTRA2

 target0:0:11: scsirate IS 0x83, min_period is 10

 target0:0:12: SC IS ffff81003fca8b40

 target0:0:12: ULTRA2

 target0:0:12: scsirate IS 0x83, min_period is 10

 target0:0:13: SC IS ffff81003fca8b40

 target0:0:13: ULTRA2

 target0:0:13: scsirate IS 0x83, min_period is 10

 target0:0:14: SC IS ffff81003fca8b40

 target0:0:14: ULTRA2

 target0:0:14: scsirate IS 0x83, min_period is 10

 target0:0:15: SC IS ffff81003fca8b40

 target0:0:15: ULTRA2

 target0:0:15: scsirate IS 0x83, min_period is 10

  Vendor: SEAGATE   Model: ST336706LW        Rev: 0108

  Type:   Direct-Access                      ANSI SCSI revision: 03

 target0:0:15: asynchronous.

scsi0:A:15:0: Tagged Queuing enabled.  Depth 253

 target0:0:15: Beginning Domain Validation

 target0:0:15: wide asynchronous.

 target0:0:15: FAST-40 WIDE SCSI 80.0 MB/s ST (25 ns, offset 63)

 target0:0:15: Ending Domain Validation

scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36

        <Adaptec 2940 Ultra SCSI adapter>

        aic7880: Ultra Single Channel A, SCSI Id=7, 16/253 SCBs



 target1:0:0: SC IS ffff81003fca89c0

 target1:0:0: scsirate IS 0xf, min_period is 9

 target1:0:1: SC IS ffff81003fca89c0

 target1:0:1: scsirate IS 0xf, min_period is 9

 target1:0:1: asynchronous.

  Vendor: TOSHIBA   Model: DVD-ROM SD-M1201  Rev: 1R08

  Type:   CD-ROM                             ANSI SCSI revision: 02

 target1:0:1: Beginning Domain Validation

 target1:0:1: Domain Validation skipping write tests

 target1:0:1: FAST-20 SCSI 20.0 MB/s ST (50 ns, offset 15)

scsi1:0:1:0: Attempting to queue an ABORT message

CDB: 0x12 0x0 0x0 0x0 0x60 0x0

scsi1: At time of recovery, card was not paused

>>>>>>>>>>>>>>>>>> Dump Card State Begins <<<<<<<<<<<<<<<<<

scsi1: Dumping Card State in Data-in phase, at SEQADDR 0x7c

Card was paused

ACCUM = 0x0, SINDEX = 0xb8, DINDEX = 0xa8, ARG_2 = 0x0

HCNT = 0x60 SCBPTR = 0x0

SCSISIGI[0x44] ERROR[0x0] SCSIBUSL[0x0] LASTPHASE[0x40] 

SCSISEQ[0x12] SBLKCTL[0x0] SCSIRATE[0xf] SEQCTL[0x10] 

SEQ_FLAGS[0x20] SSTAT0[0x0] SSTAT1[0x2] SSTAT2[0x0] 

SSTAT3[0x0] SIMODE0[0x0] SIMODE1[0xac] SXFRCTL0[0xa0] 

DFCNTRL[0x38] DFSTATUS[0x40] 

STACK: 0x0 0x162 0x192 0x6e

SCB count = 4

Kernel NEXTQSCB = 3

Card NEXTQSCB = 3

QINFIFO entries: 

Waiting Queue entries: 

Disconnected Queue entries: 

QOUTFIFO entries: 

Sequencer Free SCB List: 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 

Sequencer SCB Info: 

  0 SCB_CONTROL[0x48] SCB_SCSIID[0x17] SCB_LUN[0x0] SCB_TAG[0x2] 

  1 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] 

  2 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] 

  3 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] 

  4 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] 

  5 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] 

  6 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] 

  7 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] 

  8 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] 

  9 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] 

 10 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] 

 11 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] 

 12 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] 

 13 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] 

 14 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] 

 15 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] 

Pending list: 

  2 SCB_CONTROL[0x48] SCB_SCSIID[0x17] SCB_LUN[0x0] 

Kernel Free SCB list: 1 0 

Untagged Q(1): 2 



<<<<<<<<<<<<<<<<< Dump Card State Ends >>>>>>>>>>>>>>>>>>

scsi1:0:1:0: Device is active, asserting ATN

Recovery code sleeping

Recovery code awake

Timer Expired

aic7xxx_abort returns 0x2003

scsi1:0:1:0: Attempting to queue a TARGET RESET message

CDB: 0x12 0x0 0x0 0x0 0x60 0x0

aic7xxx_dev_reset returns 0x2003

Recovery SCB completes

Unable to handle kernel NULL pointer dereference at 0000000000000150 RIP: 

<ffffffff802fcd62>{scsi_is_host_device+2}

PGD 0 

Oops: 0000 [1] PREEMPT 

CPU 0 

Modules linked in:

Pid: 297, comm: scsi_eh_1 Not tainted 2.6.12-rc6

RIP: 0010:[<ffffffff802fcd62>] <ffffffff802fcd62>{scsi_is_host_device+2}

RSP: 0000:ffff81003fd67ce0  EFLAGS: 00010046

RAX: 0000000000000000 RBX: 0000000000000028 RCX: 0000000000000013

RDX: ffff81003fcd6e80 RSI: 0000000000000041 RDI: 0000000000000028

RBP: 0000000000000000 R08: 0000000000000200 R09: 0000000000000000

R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000041

R13: ffff81003fcdae00 R14: 0000000000000000 R15: ffff81003fcdac00

FS:  0000000000000000(0000) GS:ffffffff8059c340(0000) knlGS:0000000000000000

CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b

CR2: 0000000000000150 CR3: 0000000000101000 CR4: 00000000000006e0

Process scsi_eh_1 (pid: 297, threadinfo ffff81003fd66000, task ffff81003fcee130)

Stack: ffffffff8031ae68 ffff81003fd67d08 ffffffff00000050 0000000000000000 

       0000000000000000 08ff000000000000 0000000000000000 0000000000000008 

       ffff81003fccf130 0000000000000000 

Call Trace:<ffffffff8031ae68>{ahc_send_async+328} <ffffffff8031afcf>{ahc_send_async+687}

       <ffffffff803096af>{ahc_run_untagged_queues+31} <ffffffff8030a877>{ahc_set_syncrate+583}

       <ffffffff80311176>{ahc_reset_channel+886} <ffffffff8031a077>{ahc_linux_bus_reset+39}

       <ffffffff802ff112>{scsi_try_bus_reset+82} <ffffffff80300144>{scsi_error_handler+1444}

       <ffffffff8010f383>{child_rip+8} <ffffffff802ffba0>{scsi_error_handler+0}

       <ffffffff8010f37b>{child_rip+0} 



Code: 48 81 bf 28 01 00 00 c0 d0 2f 80 0f 94 c0 c3 66 66 66 90 66 

RIP <ffffffff802fcd62>{scsi_is_host_device+2} RSP <ffff81003fd67ce0>

CR2: 0000000000000150

 <6>note: scsi_eh_1[297] exited with preempt_count 1
-- 
	Gr�goire Favre
