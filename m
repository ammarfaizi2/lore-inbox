Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268275AbUJJM2X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268275AbUJJM2X (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Oct 2004 08:28:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268279AbUJJM2X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Oct 2004 08:28:23 -0400
Received: from r3az252.chello.upc.cz ([213.220.243.252]:137 "EHLO
	aquarius.doma") by vger.kernel.org with ESMTP id S268275AbUJJM1D
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Oct 2004 08:27:03 -0400
Message-ID: <41692A8E.5080205@ribosome.natur.cuni.cz>
Date: Sun, 10 Oct 2004 14:26:54 +0200
From: =?windows-1252?Q?Martin_MOKREJ=8A?= 
	<mmokrejs@ribosome.natur.cuni.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040914
X-Accept-Language: cs, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.9-rc3: kernel BUG at drivers/block/as-iosched.c:1853!
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------070802020905020301020309"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070802020905020301020309
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi,
 today I've copied some photos from my digital camera OlympusC5050 via USB to my ASUS P4C800-E Deluxe box. I've got the following error:

usb-storage: *** thread awakened.
usb-storage: Command READ_10 (10 bytes)
usb-storage:  28 00 00 02 b4 7d 00 00 60 00
usb-storage: Bulk Command S 0x43425355 T 0x30dc1 L 49152 F 128 Trg 0 LUN 0 CL 10
usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
usb-storage: Status code -71; transferred 31/31
usb-storage: -- unknown error
usb-storage: Bulk command transfer result=4
usb-storage: -- transport indicates error, resetting
usb-storage: usb_stor_Bulk_reset called
usb-storage: usb_stor_control_msg: rq=ff rqtype=21 value=0000 index=00 len=0
uhci_hcd 0000:00:1d.1: uhci_result_control: failed with status 440000
[f176f240] link (3176f1e2) element (267ba000)
 0: [e67ba000] link (267ba080) e0 Stalled CRC/Timeo Length=7 MaxLen=7 DT0 EndPt=0 Dev=4, PID=2d(SETUP) (buf=31776040)
 1: [e67ba080] link (00000001) e3 IOC Active Length=0 MaxLen=7ff DT1 EndPt=0 Dev=4, PID=69(IN) (buf=00000000)

usb-storage: Soft reset failed: -71
usb-storage: scsi cmd done, result=0x70000
usb-storage: *** thread sleeping.
SCSI error : <2 0 0 0> return code = 0x70000
end_request: I/O error, dev sdb, sector 177277
Buffer I/O error on device sdb1, logical block 177214
usb-storage: queuecommand called
usb-storage: *** thread awakened.
usb-storage: Command READ_10 (10 bytes)
usb-storage:  28 00 00 02 b4 7e 00 00 5f 00
usb-storage: Bulk Command S 0x43425355 T 0x30dc8 L 48640 F 128 Trg 0 LUN 0 CL 10
usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
usb-storage: Status code -71; transferred 31/31
usb-storage: -- unknown error
usb-storage: Bulk command transfer result=4
usb-storage: -- transport indicates error, resetting
usb-storage: usb_stor_Bulk_reset called
usb-storage: usb_stor_control_msg: rq=ff rqtype=21 value=0000 index=00 len=0
uhci_hcd 0000:00:1d.1: uhci_result_control: failed with status 440000
[f176f240] link (3176f1e2) element (267ba000)
 0: [e67ba000] link (267ba080) e0 Stalled CRC/Timeo Length=7 MaxLen=7 DT0 EndPt=0 Dev=4, PID=2d(SETUP) (buf=31776040)
 1: [e67ba080] link (00000001) e3 IOC Active Length=0 MaxLen=7ff DT1 EndPt=0 Dev=4, PID=69(IN) (buf=00000000)

usb-storage: Soft reset failed: -71
usb-storage: scsi cmd done, result=0x70000
usb-storage: *** thread sleeping.
SCSI error : <2 0 0 0> return code = 0x70000
end_request: I/O error, dev sdb, sector 177278
Buffer I/O error on device sdb1, logical block 177215
usb-storage: queuecommand called
usb-storage: *** thread awakened.
usb-storage: Command READ_10 (10 bytes)
usb-storage:  28 00 00 02 b4 7f 00 00 5e 00
usb-storage: Bulk Command S 0x43425355 T 0x30dc9 L 48128 F 128 Trg 0 LUN 0 CL 10
usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
usb-storage: Status code -71; transferred 31/31
usb-storage: -- unknown error
usb-storage: Bulk command transfer result=4
usb-storage: -- transport indicates error, resetting
usb-storage: usb_stor_Bulk_reset called
usb-storage: usb_stor_control_msg: rq=ff rqtype=21 value=0000 index=00 len=0
uhci_hcd 0000:00:1d.1: uhci_result_control: failed with status 440000
[f176f240] link (3176f1e2) element (267ba000)
 0: [e67ba000] link (267ba080) e0 Stalled CRC/Timeo Length=7 MaxLen=7 DT0 EndPt=0 Dev=4, PID=2d(SETUP) (buf=31776040)
 1: [e67ba080] link (00000001) e3 IOC Active Length=0 MaxLen=7ff DT1 EndPt=0 Dev=4, PID=69(IN) (buf=00000000)

usb-storage: Soft reset failed: -71
usb-storage: scsi cmd done, result=0x70000
usb-storage: *** thread sleeping.
SCSI error : <2 0 0 0> return code = 0x70000
end_request: I/O error, dev sdb, sector 177279
Buffer I/O error on device sdb1, logical block 177216
usb-storage: queuecommand called
usb-storage: *** thread awakened.
usb-storage: Command READ_10 (10 bytes)
usb-storage:  28 00 00 02 b4 80 00 00 5d 00
usb-storage: Bulk Command S 0x43425355 T 0x30dca L 47616 F 128 Trg 0 LUN 0 CL 10
usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
usb-storage: Status code -71; transferred 31/31
usb-storage: -- unknown error
usb-storage: Bulk command transfer result=4
usb-storage: -- transport indicates error, resetting
usb-storage: usb_stor_Bulk_reset called
usb-storage: usb_stor_control_msg: rq=ff rqtype=21 value=0000 index=00 len=0
uhci_hcd 0000:00:1d.1: uhci_result_control: failed with status 440000
[f176f240] link (3176f1e2) element (267ba000)
 0: [e67ba000] link (267ba080) e0 Stalled CRC/Timeo Length=7 MaxLen=7 DT0 EndPt=0 Dev=4, PID=2d(SETUP) (buf=31776040)
 1: [e67ba080] link (00000001) e3 IOC Active Length=0 MaxLen=7ff DT1 EndPt=0 Dev=4, PID=69(IN) (buf=00000000)

[big cut here of repeated messages as above]

usb-storage: *** thread awakened.
usb-storage: Command READ_10 (10 bytes)
usb-storage:  28 00 00 02 b4 df 00 00 7d 00
usb-storage: Bulk Command S 0x43425355 T 0x30e75 L 64000 F 128 Trg 0 LUN 0 CL 10
usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
usb-storage: Status code -19; transferred 0/31
usb-storage: -- unknown error
usb-storage: Bulk command transfer result=4
usb-storage: -- transport indicates error, resetting
usb-storage: usb_stor_Bulk_reset called
usb-storage: usb_stor_control_msg: rq=ff rqtype=21 value=0000 index=00 len=0
usb-storage: Soft reset failed: -19
usb-storage: scsi cmd done, result=0x70000
usb-storage: *** thread sleeping.
usb-storage: storage_disconnect() called
usb-storage: usb_stor_stop_transport called
SCSI error : <2 0 0 0> return code = 0x70000
end_request: I/O error, dev sdb, sector 177375
Buffer I/O error on device sdb1, logical block 177312
usb-storage: queuecommand called
usb-storage: *** thread awakened.
usb-storage: No command during disconnect
usb-storage: *** thread sleeping.
usb-storage: command_abort called
usb-storage: -- nothing to abort
usb-storage: device_reset called
usb-storage: No reset during disconnect
usb-storage: bus_reset called
usb-storage: No reset during disconnect
scsi: Device offlined - not ready after error recovery: host 2 channel 0 id 0 lun 0
sd 2:0:0:0: Illegal state transition cancel->offline
Badness in scsi_device_set_state at drivers/scsi/scsi_lib.c:1688
[<c0105da8>] dump_stack+0x17/0x1b
[<c02f560a>] scsi_device_set_state+0xb9/0x104
[<c02f3812>] scsi_eh_offline_sdevs+0x5d/0x77
[<c02f3c03>] scsi_unjam_host+0x96/0x98
[<c02f3ca1>] scsi_error_handler+0x9c/0xbb
[<c0103299>] kernel_thread_helper+0x5/0xb
SCSI error : <2 0 0 0> return code = 0x70000
end_request: I/O error, dev sdb, sector 177376
Buffer I/O error on device sdb1, logical block 177313
usb-storage: queuecommand called
usb-storage: *** thread awakened.
usb-storage: No command during disconnect
usb-storage: *** thread sleeping.
usb-storage: command_abort called
usb-storage: -- nothing to abort
------------[ cut here ]------------
kernel BUG at drivers/block/as-iosched.c:1853!
invalid operand: 0000 [#1]
PREEMPT SMP DEBUG_PAGEALLOC
Modules linked in: usb_storage eth1394 ohci_hcd ohci1394 ieee1394 ehci_hcd uhci_hcd radeon intel_agp agpgart e1000
CPU:    0
EIP:    0060:[<c02c02d9>]    Not tainted VLI
EFLAGS: 00010206   (2.6.9-rc3) 
EIP is at as_exit+0x48/0x5c
eax: c73c9f04   ebx: c73c9ef8   ecx: 00000000   edx: 00000002
esi: c820ceac   edi: 00000292   ebp: c818febc   esp: c818feb8
ds: 007b   es: 007b   ss: 0068
Process scsi_eh_2 (pid: 9191, threadinfo=c818e000 task=c5203ab0)
Stack: c820ce20 c818fec4 c02b7e9b c818fed4 c02b9aa8 c2c4ed84 c2c4ebf8 c818feec 
      c02f6f30 dc2d1ebc c2c4eda8 c049b4a8 c049b4c0 c818ff04 c02b4035 002220a0 
      002220a0 00000046 c818ff18 c818ff1c c022c65d dc2d1ee0 c2c4edc0 c022c65f 
Call Trace:
[<c0105d7b>] show_stack+0x7a/0x90
[<c0105efe>] show_registers+0x152/0x1b6
[<c01060fd>] die+0x10c/0x18f
[<c010656c>] do_invalid_op+0xe6/0xe8
[<c01059bd>] error_code+0x2d/0x38
[<c02b7e9b>] elevator_exit+0x11/0x13
[<c02b9aa8>] blk_cleanup_queue+0x35/0x7c
[<c02f6f30>] scsi_device_dev_release+0xeb/0xfa
[<c02b4035>] device_release+0x56/0x5a
[<c022c65d>] kobject_cleanup+0x84/0x86
[<c022c969>] kref_put+0x34/0x8f
[<c02f0e57>] __scsi_iterate_devices+0x5d/0x67
[<c02f33a6>] scsi_eh_stu+0x89/0xe3
[<c02f3a98>] scsi_eh_ready_devs+0x1c/0x71
[<c02f3c03>] scsi_unjam_host+0x96/0x98
[<c02f3ca1>] scsi_error_handler+0x9c/0xbb
[<c0103299>] kernel_thread_helper+0x5/0xb
Code: 43 0c 39 43 0c 75 24 8b 43 70 e8 1c db e7 ff 8b 83 d4 00 00 00 e8 96 b3 ff ff 8b 43 30 e8 eb 42 e8 ff 89 d8 5b 5d e9 e2 42 e8 ff <0f> 0b 3d 07 6e c5 40 c0 eb d2 0f 0b 3c 07 6e c5 40 c0 eb c0 55 


# lspci   
0000:00:00.0 Host bridge: Intel Corp. 82875P Memory Controller Hub (rev 02)
0000:00:01.0 PCI bridge: Intel Corp. 82875P Processor to AGP Controller (rev 02)
0000:00:03.0 PCI bridge: Intel Corp. 82875P Processor to PCI to CSA Bridge (rev 02)
0000:00:1d.0 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #1 (rev 02)
0000:00:1d.1 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #2 (rev 02)
0000:00:1d.2 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #3 (rev 02)
0000:00:1d.3 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #4 (rev 02)
0000:00:1d.7 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB2 EHCI Controller (rev 02)
0000:00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB/EB/ER Hub interface to PCI Bridge (rev c2)
0000:00:1f.0 ISA bridge: Intel Corp. 82801EB/ER (ICH5/ICH5R) LPC Bridge (rev 02)
0000:00:1f.1 IDE interface: Intel Corp. 82801EB/ER (ICH5/ICH5R) Ultra ATA 100 Storage Controller (rev 02)
0000:00:1f.2 IDE interface: Intel Corp. 82801EB (ICH5) Serial ATA 150 Storage Controller (rev 02)
0000:00:1f.3 SMBus: Intel Corp. 82801EB/ER (ICH5/ICH5R) SMBus Controller (rev 02)
0000:00:1f.5 Multimedia audio controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) AC'97 Audio Controller (rev 02)
0000:01:00.0 VGA compatible controller: ATI Technologies Inc RV280 [Radeon 9200] (rev 01)
0000:01:00.1 Display controller: ATI Technologies Inc RV280 [Radeon 9200] (Secondary) (rev 01)
0000:02:01.0 Ethernet controller: Intel Corp. 82547EI Gigabit Ethernet Controller (LOM)
0000:03:03.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host Controller (rev 46)
# cat /proc/interrupts 
          CPU0       CPU1       
 0:    2423221          0    IO-APIC-edge  timer
 1:       4673          0    IO-APIC-edge  i8042
 8:          2          0    IO-APIC-edge  rtc
 9:          0          0   IO-APIC-level  acpi
14:         15          0    IO-APIC-edge  ide0
16:     132778          0   IO-APIC-level  uhci_hcd, uhci_hcd, radeon@pci:0000:01:00.0
17:          0          0   IO-APIC-level  Intel ICH5
18:     363711          0   IO-APIC-level  libata, uhci_hcd, eth0
19:     116639          0   IO-APIC-level  uhci_hcd
20:          3          0   IO-APIC-level  ohci1394
23:          4          0   IO-APIC-level  ehci_hcd
NMI:          0          0 
LOC:    2422867    2423208 
ERR:          0
MIS:          0
# cat /proc/acpi/info 
version:                 20040715
# cat /proc/scsi/usb-storage/2  
  Host scsi2: usb-storage
      Vendor: OLYMPUS
     Product: C5050Z  
Serial Number: 000242752403
    Protocol: Transparent SCSI
   Transport: Bulk
      Quirks:
# 

I've attached output from dmesg(1) after next reboot. The camera was turned on so it got detected on USB immediately.
I suspect those uhci_hcd messages might actually cause the subsequent kernel crash.

Please Cc: me in replies. Thanks.

--------------070802020905020301020309
Content-Type: text/plain;
 name="dmes"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmes"

Linux version 2.6.9-rc3 (root@aquarius) (gcc version 3.3.4 20040623 (Gentoo Linux 3.3.4-r1, ssp-3.3.2-2, pie-8.7.6)) #2 SMP Fri Oct 1 09:32:18 CEST 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e8000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003ff30000 (usable)
 BIOS-e820: 000000003ff30000 - 000000003ff40000 (ACPI data)
 BIOS-e820: 000000003ff40000 - 000000003fff0000 (ACPI NVS)
 BIOS-e820: 000000003fff0000 - 0000000040000000 (reserved)
 BIOS-e820: 00000000ffb80000 - 0000000100000000 (reserved)
127MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000ff780
On node 0 totalpages: 261936
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 225280 pages, LIFO batch:16
  HighMem zone: 32560 pages, LIFO batch:7
DMI 2.3 present.
ACPI: RSDP (v002 ACPIAM                                    ) @ 0x000f9e30
ACPI: XSDT (v001 A M I  OEMXSDT  0x02000423 MSFT 0x00000097) @ 0x3ff30100
ACPI: FADT (v003 A M I  OEMFACP  0x02000423 MSFT 0x00000097) @ 0x3ff30290
ACPI: MADT (v001 A M I  OEMAPIC  0x02000423 MSFT 0x00000097) @ 0x3ff30390
ACPI: OEMB (v001 A M I  OEMBIOS  0x02000423 MSFT 0x00000097) @ 0x3ff40040
ACPI: DSDT (v001  P4CED P4CED102 0x00000102 INTL 0x02002026) @ 0x00000000
ACPI: PM-Timer IO Port: 0x808
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:2 APIC version 20
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1 15:2 APIC version 20
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Built 1 zonelists
Kernel command line: root=/dev/sda2 ide=reverse agp=try_unsupported console=ttyS0,57600n8 console=tty0 vga=792
ide_setup: ide=reverse : Enabled support for IDE inverse scan order.
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 65536 bytes)
Detected 3450.837 MHz processor.
Using pmtmr for high-res timesource
Console: colour dummy device 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 1032100k/1047744k available (2784k kernel code, 15004k reserved, 1561k data, 204k init, 130240k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 6848.51 BogoMIPS (lpj=3424256)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000
CPU: After vendor identify, caps:  bfebfbff 00000000 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
CPU: After all inits, caps:        bfebfbf7 00000000 00000000 00000080
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU0: Thermal monitoring enabled
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
 tbxface-0117 [02] acpi_load_tables      : ACPI Tables successfully acquired
Parsing all Control Methods:......................................................................................................................................................
Table [DSDT](id F004) - 511 Objects with 48 Devices 150 Methods 14 Regions
ACPI Namespace successfully loaded at root c05c087c
evxfevnt-0093 [03] acpi_enable           : Transition to ACPI mode successful
CPU0: Intel(R) Pentium(R) 4 CPU 3.00GHz stepping 09
per-CPU timeslice cutoff: 1462.79 usecs.
task migration cache decay timeout: 2 msecs.
Booting processor 1/1 eip 3000
Initializing CPU#1
Calibrating delay loop... 6881.28 BogoMIPS (lpj=3440640)
CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000
CPU: After vendor identify, caps:  bfebfbff 00000000 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
CPU: After all inits, caps:        bfebfbf7 00000000 00000000 00000080
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel P4/Xeon Extended MCE MSRs (12) available
CPU1: Thermal monitoring enabled
CPU1: Intel(R) Pentium(R) 4 CPU 3.00GHz stepping 09
Total of 2 processors activated (13729.79 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 pin1=2 pin2=-1
checking TSC synchronization across 2 CPUs: passed.
Brought up 2 CPUs
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xf0031, last bus=3
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040715
evgpeblk-0980 [07] ev_create_gpe_block   : GPE 00 to 1F [_GPE] 4 regs at 0000000000000828 on int 0x9
evgpeblk-0989 [07] ev_create_gpe_block   : Found 9 Wake, Enabled 0 Runtime GPEs in this block
Completing Region/Field/Buffer/Package initialization:................................................................................................................
Initialized 13/14 Regions 42/42 Fields 41/41 Buffers 16/16 Packages (520 nodes)
Executing all Device _STA and_INI methods:....................................................
52 Devices found containing: 52 _STA, 1 _INI methods
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P4._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P2._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 10 *11 12 14 15)
Linux Plug and Play Support v0.97 (c) Adam Belay
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00f5230
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0x5e1a, dseg 0xf0000
PnPBIOS: Missing SMALL_TAG_ENDDEP tag
PnPBIOS: Missing SMALL_TAG_ENDDEP tag
PnPBIOS: Missing SMALL_TAG_ENDDEP tag
PNPBIOS fault.. attempting recovery.
PnPBIOS: Warning! Your PnP BIOS caused a fatal error. Attempting to continue
PnPBIOS: You may need to reboot with the "nobiospnp" option to operate stably
PnPBIOS: Check with your vendor for an updated BIOS
PnPBIOS: get_dev_node: unexpected status 0x28
PnPBIOS: 12 nodes reported by PnP BIOS; 12 recorded by driver
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
ACPI: PCI interrupt 0000:00:1d.0[A] -> GSI 16 (level, low) -> IRQ 16
ACPI: PCI interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 19
ACPI: PCI interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 18
ACPI: PCI interrupt 0000:00:1d.3[A] -> GSI 16 (level, low) -> IRQ 16
ACPI: PCI interrupt 0000:00:1d.7[D] -> GSI 23 (level, low) -> IRQ 23
ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 18
ACPI: PCI interrupt 0000:00:1f.2[A] -> GSI 18 (level, low) -> IRQ 18
ACPI: PCI interrupt 0000:00:1f.3[B] -> GSI 17 (level, low) -> IRQ 17
ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 17 (level, low) -> IRQ 17
ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 16
ACPI: PCI interrupt 0000:02:01.0[A] -> GSI 18 (level, low) -> IRQ 18
ACPI: PCI interrupt 0000:03:03.0[A] -> GSI 20 (level, low) -> IRQ 20
Machine check exception polling timer started.
IA-32 Microcode Update Driver: v1.14 <tigran@veritas.com>
Starting balanced_irq
highmem bounce pool size: 64 pages
devfs: 2004-01-31 Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
Initializing Cryptographic API
radeonfb_pci_register BEGIN
ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 16
radeonfb: probed DDR SGRAM 131072k videoram
radeonfb: mapped 16384k videoram
radeonfb: Found Intel x86 BIOS ROM Image
radeonfb: Retreived PLL infos from BIOS
radeonfb: Reference=27.00 MHz (RefDiv=12) Memory=250.00 Mhz, System=200.00 MHz
1 chips in connector info
 - chip 1 has 2 connectors
  * connector 0 of type 2 (CRT) : 2300
  * connector 1 of type 3 (DVI-I) : 3201
Starting monitor auto detection...
radeonfb: I2C (port 1) ... not found
radeonfb: I2C (port 2) ... found TMDS panel
radeonfb: I2C (port 3) ... not found
radeonfb: I2C (port 4) ... not found
radeonfb: I2C (port 2) ... found TMDS panel
radeonfb: I2C (port 3) ... not found
radeonfb: I2C (port 4) ... not found
radeonfb: Monitor 1 type DFP found
radeonfb: EDID probed
radeonfb: Monitor 2 type no found
Parsing EDID data for panel info
Setting up default mode based on panel info
hStart = 1328, hEnd = 1440, hTotal = 1688
vStart = 1025, vEnd = 1028, vTotal = 1066
h_total_disp = 0x9f00d2	   hsync_strt_wid = 0xe052a
v_total_disp = 0x3ff0429	   vsync_strt_wid = 0x30400
pixclock = 9259
freq = 10800
post div = 0x1
fb_div = 0x60
ppll_div_3 = 0x10060
lvds_gen_cntl: 08000008
Console: switching to colour frame buffer device 160x64
radeonfb: ATI Radeon Ya  DDR SGRAM 128 MB
radeonfb_pci_register END
ACPI: Power Button (FF) [PWRF]
ACPI: Processor [CPU1] (supports C1)
ACPI: Processor [CPU2] (supports C1)
lp: driver loaded but no devices found
Real Time Clock Driver v1.12
Non-volatile memory driver v1.2
Hangcheck: starting hangcheck timer 0.5.0 (tick is 180 seconds, margin is 60 seconds).
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE,EPP]
parport0: irq 7 detected
lp0: using parport0 (polling).
lp0: console ready
Using anticipatory io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
loop: loaded (max 8 devices)
nbd: registered device at major 43
Linux video capture interface: v1.00
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH5: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 18
ICH5: chipset revision 2
ICH5: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:pio, hdd:pio
Probing IDE interface ide0...
hda: SONY DVD RW DRU-510A, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hda: ATAPI 32X DVD-ROM DVD-R CD-R/RW drive, 8192kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
libata version 1.02 loaded.
ata_piix version 1.02
ACPI: PCI interrupt 0000:00:1f.2[A] -> GSI 18 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ata1: SATA max UDMA/133 cmd 0xEFE0 ctl 0xEFAE bmdma 0xEF60 irq 18
ata2: SATA max UDMA/133 cmd 0xEFA0 ctl 0xEFAA bmdma 0xEF68 irq 18
ata1: dev 0 cfg 49:2f00 82:7c6b 83:7f09 84:4003 85:7c69 86:3e01 87:4003 88:207f
ata1: dev 0 ATA, max UDMA/133, 490234752 sectors: lba48
ata1: dev 0 configured for UDMA/133
scsi0 : ata_piix
ata2: SATA port has no device.
scsi1 : ata_piix
  Vendor: ATA       Model: Maxtor 7Y250M0    Rev: YAR5
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 490234752 512-byte hdwr sectors (251000 MB)
SCSI device sda: drive cache: write back
 /dev/scsi/host0/bus0/target0/lun0: p1 p2 p3
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard on isa0060/serio0
i2c /dev entries driver
Advanced Linux Sound Architecture Driver Version 1.0.6 (Sun Aug 15 07:17:53 2004 UTC).
ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 17 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:00:1f.5 to 64
AC'97 0 analog subsections not ready
intel8x0_measure_ac97_clock: measured 49876 usecs
intel8x0: clocking to 48000
ALSA device list:
  #0: Intel ICH5 at 0xfebfb800, irq 17
NET: Registered protocol family 2
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 17
p4-clockmod: P4/Xeon(TM) CPU On-Demand Clock Modulation available
ACPI: (supports S0 S1 S3 S4 S5)
ACPI wakeup devices: 
P0P4 MC97 USB1 USB2 USB3 USB4 EUSB PS2K ILAN 
BIOS EDD facility v0.16 2004-Jun-25, 1 devices found
ReiserFS: sda2: found reiserfs format "3.6" with standard journal
ReiserFS: sda2: using ordered data mode
ReiserFS: sda2: journal params: device sda2, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: sda2: checking transaction log (sda2)
ReiserFS: sda2: replayed 22 transactions in 1 seconds
ReiserFS: sda2: Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 204k freed
Adding 8032492k swap on /dev/sda3.  Priority:-1 extents:1
e1000: Ignoring new-style parameters in presence of obsolete ones
Intel(R) PRO/1000 Network Driver - version 5.3.19-k2-NAPI
Copyright (c) 1999-2004 Intel Corporation.
ACPI: PCI interrupt 0000:02:01.0[A] -> GSI 18 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:02:01.0 to 64
e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected an Intel i875 Chipset.
agpgart: Maximum main memory to use for agp memory: 941M
agpgart: AGP aperture is 256M @ 0xd0000000
ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 16
[drm] Initialized radeon 1.11.0 20020828 on minor 0: ATI Technologies Inc RV280 [Radeon 9200]
e1000: eth0: e1000_watchdog: NIC Link is Up 100 Mbps Full Duplex
USB Universal Host Controller Interface driver v2.2
ACPI: PCI interrupt 0000:00:1d.0[A] -> GSI 16 (level, low) -> IRQ 16
uhci_hcd 0000:00:1d.0: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #1
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: irq 16, io base 0000ef00
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:1d.0: detected 2 ports
usb usb1: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: default language 0x0409
usb usb1: Product: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #1
usb usb1: Manufacturer: Linux 2.6.9-rc3 uhci_hcd
usb usb1: SerialNumber: 0000:00:1d.0
usb usb1: hotplug
usb usb1: adding 1-0:1.0 (config #1, interface 0)
usb 1-0:1.0: hotplug
hub 1-0:1.0: usb_probe_interface
hub 1-0:1.0: usb_probe_interface - got id
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
hub 1-0:1.0: standalone hub
hub 1-0:1.0: no power switching (usb 1.0)
hub 1-0:1.0: individual port over-current protection
hub 1-0:1.0: power on to power good time: 2ms
hub 1-0:1.0: local power source is good
ACPI: PCI interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 19
uhci_hcd 0000:00:1d.1: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #2
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: irq 19, io base 0000ef20
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.1: detected 2 ports
usb usb2: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb2: default language 0x0409
usb usb2: Product: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #2
usb usb2: Manufacturer: Linux 2.6.9-rc3 uhci_hcd
usb usb2: SerialNumber: 0000:00:1d.1
usb usb2: hotplug
usb usb2: adding 2-0:1.0 (config #1, interface 0)
usb 2-0:1.0: hotplug
hub 2-0:1.0: usb_probe_interface
hub 2-0:1.0: usb_probe_interface - got id
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
hub 2-0:1.0: standalone hub
hub 2-0:1.0: no power switching (usb 1.0)
hub 2-0:1.0: individual port over-current protection
hub 2-0:1.0: power on to power good time: 2ms
hub 2-0:1.0: local power source is good
ACPI: PCI interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 18
uhci_hcd 0000:00:1d.2: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #3
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: irq 18, io base 0000ef40
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.2: detected 2 ports
usb usb3: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb3: default language 0x0409
usb usb3: Product: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #3
usb usb3: Manufacturer: Linux 2.6.9-rc3 uhci_hcd
usb usb3: SerialNumber: 0000:00:1d.2
usb usb3: hotplug
usb usb3: adding 3-0:1.0 (config #1, interface 0)
usb 3-0:1.0: hotplug
hub 3-0:1.0: usb_probe_interface
hub 3-0:1.0: usb_probe_interface - got id
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
hub 3-0:1.0: standalone hub
hub 3-0:1.0: no power switching (usb 1.0)
hub 3-0:1.0: individual port over-current protection
hub 3-0:1.0: power on to power good time: 2ms
hub 3-0:1.0: local power source is good
ACPI: PCI interrupt 0000:00:1d.3[A] -> GSI 16 (level, low) -> IRQ 16
uhci_hcd 0000:00:1d.3: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #4
uhci_hcd 0000:00:1d.1: port 1 portsc 01a3
hub 2-0:1.0: port 1, status 0301, change 0001, 1.5 Mb/s
PCI: Setting latency timer of device 0000:00:1d.3 to 64
uhci_hcd 0000:00:1d.3: irq 16, io base 0000ef80
uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1d.3: detected 2 ports
usb usb4: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb4: default language 0x0409
usb usb4: Product: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #4
usb usb4: Manufacturer: Linux 2.6.9-rc3 uhci_hcd
usb usb4: SerialNumber: 0000:00:1d.3
usb usb4: hotplug
usb usb4: adding 4-0:1.0 (config #1, interface 0)
usb 4-0:1.0: hotplug
hub 4-0:1.0: usb_probe_interface
hub 4-0:1.0: usb_probe_interface - got id
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
hub 4-0:1.0: standalone hub
hub 4-0:1.0: no power switching (usb 1.0)
hub 4-0:1.0: individual port over-current protection
hub 4-0:1.0: power on to power good time: 2ms
hub 4-0:1.0: local power source is good
hub 2-0:1.0: debounce: port 1: total 100ms stable 100ms status 0x301
uhci_hcd 0000:00:1d.1: CTRL: TypeReq=0x2301 val=0x2 idx=0x0 len=0 ==> -32
usb 2-1: new low speed USB device using address 2
usb 2-1: skipped 1 descriptor after interface
usb 2-1: new device strings: Mfr=1, Product=2, SerialNumber=0
usb 2-1: default language 0x0409
usb 2-1: Product: USB-PS/2 Optical Mouse
usb 2-1: Manufacturer: Logitech
usb 2-1: hotplug
usb 2-1: adding 2-1:1.0 (config #1, interface 0)
usb 2-1:1.0: hotplug
usbhid 2-1:1.0: usb_probe_interface
usbhid 2-1:1.0: usb_probe_interface - got id
input: USB HID v1.10 Mouse [Logitech USB-PS/2 Optical Mouse] on usb-0000:00:1d.1-1
uhci_hcd 0000:00:1d.1: port 2 portsc 0093
hub 2-0:1.0: port 2, status 0101, change 0001, 12 Mb/s
hub 2-0:1.0: debounce: port 2: total 100ms stable 100ms status 0x101
usb 2-2: new full speed USB device using address 3
usb 2-2: new device strings: Mfr=1, Product=2, SerialNumber=3
usb 2-2: default language 0x0409
usb 2-2: Product: C5050Z  
usb 2-2: Manufacturer: OLYMPUS
usb 2-2: SerialNumber: 000242752403
usb 2-2: hotplug
usb 2-2: adding 2-2:1.0 (config #1, interface 0)
usb 2-2:1.0: hotplug
Initializing USB Mass Storage driver...
usb-storage 2-2:1.0: usb_probe_interface
usb-storage 2-2:1.0: usb_probe_interface - got id
usb-storage: USB Mass Storage device detected
usb-storage: -- associate_dev
usb-storage: Vendor: 0x07b4, Product: 0x0105, Revision: 0x0100
usb-storage: Interface Subclass: 0x06, Protocol: 0x50
usb-storage: Vendor: OLYMPUS,  Product: C5050Z  
usb-storage: Transport: Bulk
usb-storage: Protocol: Transparent SCSI
usb-storage: usb_stor_control_msg: rq=fe rqtype=a1 value=0000 index=00 len=1
usb-storage: GetMaxLUN command result is 1, data is 0
scsi2 : SCSI emulation for USB Mass Storage devices
usb-storage: *** thread sleeping.
usb-storage: queuecommand called
usb-storage: *** thread awakened.
usb-storage: Command INQUIRY (6 bytes)
usb-storage:  12 00 00 00 24 00
usb-storage: Bulk Command S 0x43425355 T 0xd57 L 36 F 128 Trg 0 LUN 0 CL 6
usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
usb-storage: Status code 0; transferred 31/31
usb-storage: -- transfer complete
usb-storage: Bulk command transfer result=0
usb-storage: usb_stor_bulk_transfer_buf: xfer 36 bytes
usb-storage: Status code 0; transferred 36/36
usb-storage: -- transfer complete
usb-storage: Bulk data transfer result 0x0
usb-storage: Attempting to get CSW...
usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
usb-storage: Status code 0; transferred 13/13
usb-storage: -- transfer complete
usb-storage: Bulk status result = 0
usb-storage: Bulk Status S 0x53425355 T 0xd57 R 0 Stat 0x0
usb-storage: scsi cmd done, result=0x0
  Vendor: OLYMPUS   Model: C5050Z            Rev: 1.00
  Type:   Direct-Access                      ANSI SCSI revision: 02
usb-storage: *** thread sleeping.
usb-storage: queuecommand called
usb-storage: *** thread awakened.
usb-storage: Command TEST_UNIT_READY (6 bytes)
usb-storage:  00 00 00 00 00 00
usb-storage: Bulk Command S 0x43425355 T 0xd58 L 0 F 0 Trg 0 LUN 0 CL 6
usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
usb-storage: Status code 0; transferred 31/31
usb-storage: -- transfer complete
usb-storage: Bulk command transfer result=0
usb-storage: Attempting to get CSW...
usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
usb-storage: Status code 0; transferred 13/13
usb-storage: -- transfer complete
usb-storage: Bulk status result = 0
usb-storage: Bulk Status S 0x53425355 T 0xd58 R 0 Stat 0x0
usb-storage: scsi cmd done, result=0x0
usb-storage: *** thread sleeping.
usb-storage: queuecommand called
usb-storage: *** thread awakened.
usb-storage: Command READ_CAPACITY (10 bytes)
usb-storage:  25 00 00 00 00 00 00 00 00 00
usb-storage: Bulk Command S 0x43425355 T 0xd59 L 8 F 128 Trg 0 LUN 0 CL 10
usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
usb-storage: Status code 0; transferred 31/31
usb-storage: -- transfer complete
usb-storage: Bulk command transfer result=0
usb-storage: usb_stor_bulk_transfer_buf: xfer 8 bytes
usb-storage: Status code 0; transferred 8/8
usb-storage: -- transfer complete
usb-storage: Bulk data transfer result 0x0
usb-storage: Attempting to get CSW...
usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
usb-storage: Status code 0; transferred 13/13
usb-storage: -- transfer complete
usb-storage: Bulk status result = 0
usb-storage: Bulk Status S 0x53425355 T 0xd59 R 0 Stat 0x0
usb-storage: scsi cmd done, result=0x0
usb-storage: *** thread sleeping.
SCSI device sdb: 1006992 512-byte hdwr sectors (516 MB)
usb-storage: queuecommand called
usb-storage: *** thread awakened.
usb-storage: Command MODE_SENSE (6 bytes)
usb-storage:  1a 00 3f 00 c0 00
usb-storage: Bulk Command S 0x43425355 T 0xd5a L 192 F 128 Trg 0 LUN 0 CL 6
usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
usb-storage: Status code 0; transferred 31/31
usb-storage: -- transfer complete
usb-storage: Bulk command transfer result=0
usb-storage: usb_stor_bulk_transfer_buf: xfer 192 bytes
usb-storage: Status code 0; transferred 192/192
usb-storage: -- transfer complete
usb-storage: Bulk data transfer result 0x0
usb-storage: Attempting to get CSW...
usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
usb-storage: Status code 0; transferred 13/13
usb-storage: -- transfer complete
usb-storage: Bulk status result = 0
usb-storage: Bulk Status S 0x53425355 T 0xd5a R 0 Stat 0x0
usb-storage: scsi cmd done, result=0x0
usb-storage: *** thread sleeping.
sdb: Write Protect is off
sdb: Mode Sense: 18 00 00 08
sdb: assuming drive cache: write through
usb-storage: queuecommand called
usb-storage: *** thread awakened.
usb-storage: Command TEST_UNIT_READY (6 bytes)
usb-storage:  00 00 00 00 00 00
usb-storage: Bulk Command S 0x43425355 T 0xd5b L 0 F 0 Trg 0 LUN 0 CL 6
usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
usb-storage: Status code 0; transferred 31/31
usb-storage: -- transfer complete
usb-storage: Bulk command transfer result=0
usb-storage: Attempting to get CSW...
usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
usb-storage: Status code 0; transferred 13/13
usb-storage: -- transfer complete
usb-storage: Bulk status result = 0
usb-storage: Bulk Status S 0x53425355 T 0xd5b R 0 Stat 0x0
usb-storage: scsi cmd done, result=0x0
usb-storage: *** thread sleeping.
usb-storage: queuecommand called
usb-storage: *** thread awakened.
usb-storage: Command ALLOW_MEDIUM_REMOVAL (6 bytes)
usb-storage:  1e 00 00 00 01 00
usb-storage: Bulk Command S 0x43425355 T 0xd5d L 0 F 0 Trg 0 LUN 0 CL 6
usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
usb-storage: Status code 0; transferred 31/31
usb-storage: -- transfer complete
usb-storage: Bulk command transfer result=0
usb-storage: Attempting to get CSW...
usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
usb-storage: Status code 0; transferred 13/13
usb-storage: -- transfer complete
usb-storage: Bulk status result = 0
usb-storage: Bulk Status S 0x53425355 T 0xd5d R 0 Stat 0x0
usb-storage: scsi cmd done, result=0x0
usb-storage: *** thread sleeping.
 /dev/scsi/host2/bus0/target0/lun0:<7>usb-storage: queuecommand called
usb-storage: *** thread awakened.
usb-storage: Command READ_10 (10 bytes)
usb-storage:  28 00 00 00 00 00 00 00 08 00
usb-storage: Bulk Command S 0x43425355 T 0xd5e L 4096 F 128 Trg 0 LUN 0 CL 10
usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
usb-storage: Status code 0; transferred 31/31
usb-storage: -- transfer complete
usb-storage: Bulk command transfer result=0
usb-storage: usb_stor_bulk_transfer_sglist: xfer 4096 bytes, 1 entries
ehci_hcd: block sizes: qh 128 qtd 96 itd 192 sitd 96
ACPI: PCI interrupt 0000:00:1d.7[D] -> GSI 23 (level, low) -> IRQ 23
ehci_hcd 0000:00:1d.7: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB2 EHCI Controller
ehci_hcd 0000:00:1d.7: reset hcs_params 0x104208 dbg=1 cc=4 pcc=2 ordered !ppc ports=8
ehci_hcd 0000:00:1d.7: reset hcc_params 6871 thresh 7 uframes 1024 64 bit addr
ehci_hcd 0000:00:1d.7: capability 0001 at 68
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: irq 23, pci mem f9d50c00
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 5
ehci_hcd 0000:00:1d.7: reset command 080002 (park)=0 ithresh=8 period=1024 Reset HALT
usb-storage: Status code 0; transferred 4096/4096
usb-storage: -- transfer complete
usb-storage: Bulk data transfer result 0x0
usb-storage: Attempting to get CSW...
usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
usb-storage: Status code 0; transferred 13/13
usb-storage: -- transfer complete
usb-storage: Bulk status result = 0
usb-storage: Bulk Status S 0x53425355 T 0xd5e R 0 Stat 0x0
usb-storage: scsi cmd done, result=0x0
usb-storage: *** thread sleeping.
 p1
usb-storage: queuecommand called
usb-storage: *** thread awakened.
usb-storage: Command ALLOW_MEDIUM_REMOVAL (6 bytes)
usb-storage:  1e 00 00 00 00 00
usb-storage: Bulk Command S 0x43425355 T 0xd5f L 0 F 0 Trg 0 LUN 0 CL 6
usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
PCI: cache line size of 128 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: init command 010001 (park)=0 ithresh=1 period=1024 RUN
ehci_hcd 0000:00:1d.7: USB 2.0 enabled, EHCI 1.00, driver 2004-May-10
ehci_hcd 0000:00:1d.7: supports USB remote wakeup
usb usb5: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb5: default language 0x0409
usb usb5: Product: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB2 EHCI Controller
usb usb5: Manufacturer: Linux 2.6.9-rc3 ehci_hcd
usb usb5: SerialNumber: 0000:00:1d.7
usb usb5: hotplug
usb-storage: Status code 0; transferred 31/31
usb-storage: -- transfer complete
usb-storage: Bulk command transfer result=0
usb-storage: Attempting to get CSW...
usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
usb-storage: Status code -84; transferred 0/13
usb-storage: -- unknown error
usb-storage: Bulk status result = 4
usb-storage: -- transport indicates error, resetting
usb-storage: usb_stor_Bulk_reset called
usb-storage: usb_stor_control_msg: rq=ff rqtype=21 value=0000 index=00 len=0
uhci_hcd 0000:00:1d.1: uhci_result_control: failed with status 440000
[f115f270] link (3115f1e2) element (3126a040)
  0: [f126a040] link (3126a080) e0 Stalled CRC/Timeo Length=7 MaxLen=7 DT0 EndPt=0 Dev=3, PID=2d(SETUP) (buf=311b5040)
  1: [f126a080] link (00000001) e3 IOC Active Length=0 MaxLen=7ff DT1 EndPt=0 Dev=3, PID=69(IN) (buf=00000000)

usb-storage: Soft reset failed: -71
usb-storage: scsi cmd done, result=0x70000
usb-storage: *** thread sleeping.
usb-storage: queuecommand called
usb-storage: *** thread awakened.
usb-storage: Command ALLOW_MEDIUM_REMOVAL (6 bytes)
usb-storage:  1e 00 00 00 00 00
usb-storage: Bulk Command S 0x43425355 T 0xd60 L 0 F 0 Trg 0 LUN 0 CL 6
usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
usb-storage: Status code -71; transferred 31/31
usb-storage: -- unknown error
usb-storage: Bulk command transfer result=4
usb-storage: -- transport indicates error, resetting
usb-storage: usb_stor_Bulk_reset called
usb-storage: usb_stor_control_msg: rq=ff rqtype=21 value=0000 index=00 len=0
uhci_hcd 0000:00:1d.1: uhci_result_control: failed with status 440000
[f115f270] link (3115f1e2) element (3126a040)
  0: [f126a040] link (3126a080) e0 Stalled CRC/Timeo Length=7 MaxLen=7 DT0 EndPt=0 Dev=3, PID=2d(SETUP) (buf=311b5040)
  1: [f126a080] link (00000001) e3 IOC Active Length=0 MaxLen=7ff DT1 EndPt=0 Dev=3, PID=69(IN) (buf=00000000)

usb-storage: Soft reset failed: -71
usb-storage: scsi cmd done, result=0x70000
usb-storage: *** thread sleeping.
usb-storage: queuecommand called
usb-storage: *** thread awakened.
usb-storage: Command ALLOW_MEDIUM_REMOVAL (6 bytes)
usb-storage:  1e 00 00 00 00 00
usb-storage: Bulk Command S 0x43425355 T 0xd61 L 0 F 0 Trg 0 LUN 0 CL 6
usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
usb-storage: Status code -71; transferred 31/31
usb-storage: -- unknown error
usb-storage: Bulk command transfer result=4
usb-storage: -- transport indicates error, resetting
usb-storage: usb_stor_Bulk_reset called
usb-storage: usb_stor_control_msg: rq=ff rqtype=21 value=0000 index=00 len=0
uhci_hcd 0000:00:1d.1: uhci_result_control: failed with status 440000
[f115f270] link (3115f1e2) element (3126a040)
  0: [f126a040] link (3126a080) e0 Stalled CRC/Timeo Length=7 MaxLen=7 DT0 EndPt=0 Dev=3, PID=2d(SETUP) (buf=311b5040)
  1: [f126a080] link (00000001) e3 IOC Active Length=0 MaxLen=7ff DT1 EndPt=0 Dev=3, PID=69(IN) (buf=00000000)

usb-storage: Soft reset failed: -71
usb-storage: scsi cmd done, result=0x70000
usb-storage: *** thread sleeping.
usb-storage: queuecommand called
usb-storage: *** thread awakened.
usb-storage: Command ALLOW_MEDIUM_REMOVAL (6 bytes)
usb-storage:  1e 00 00 00 00 00
usb-storage: Bulk Command S 0x43425355 T 0xd62 L 0 F 0 Trg 0 LUN 0 CL 6
usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
usb-storage: Status code -71; transferred 31/31
usb-storage: -- unknown error
usb-storage: Bulk command transfer result=4
usb-storage: -- transport indicates error, resetting
usb-storage: usb_stor_Bulk_reset called
usb-storage: usb_stor_control_msg: rq=ff rqtype=21 value=0000 index=00 len=0
uhci_hcd 0000:00:1d.1: uhci_result_control: failed with status 440000
[f115f270] link (3115f1e2) element (3126a040)
  0: [f126a040] link (3126a080) e0 Stalled CRC/Timeo Length=7 MaxLen=7 DT0 EndPt=0 Dev=3, PID=2d(SETUP) (buf=311b5040)
  1: [f126a080] link (00000001) e3 IOC Active Length=0 MaxLen=7ff DT1 EndPt=0 Dev=3, PID=69(IN) (buf=00000000)

usb-storage: Soft reset failed: -71
usb-storage: scsi cmd done, result=0x70000
usb-storage: *** thread sleeping.
usb-storage: queuecommand called
usb-storage: *** thread awakened.
usb-storage: Command ALLOW_MEDIUM_REMOVAL (6 bytes)
usb-storage:  1e 00 00 00 00 00
usb-storage: Bulk Command S 0x43425355 T 0xd63 L 0 F 0 Trg 0 LUN 0 CL 6
usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
usb-storage: Status code -71; transferred 31/31
usb-storage: -- unknown error
usb-storage: Bulk command transfer result=4
usb-storage: -- transport indicates error, resetting
usb-storage: usb_stor_Bulk_reset called
usb-storage: usb_stor_control_msg: rq=ff rqtype=21 value=0000 index=00 len=0
uhci_hcd 0000:00:1d.1: uhci_result_control: failed with status 440000
[f115f240] link (3115f1e2) element (3126a000)
  0: [f126a000] link (3126a040) e0 Stalled CRC/Timeo Length=7 MaxLen=7 DT0 EndPt=0 Dev=3, PID=2d(SETUP) (buf=311b5040)
  1: [f126a040] link (00000001) e3 IOC Active Length=0 MaxLen=7ff DT1 EndPt=0 Dev=3, PID=69(IN) (buf=00000000)

usb-storage: Soft reset failed: -71
usb-storage: scsi cmd done, result=0x70000
usb-storage: *** thread sleeping.
Attached scsi removable disk sdb at scsi2, channel 0, id 0, lun 0
Attached scsi generic sg1 at scsi2, channel 0, id 0, lun 0,  type 0
usb-storage: queuecommand called
usb-storage: *** thread awakened.
usb-storage: Bad target number (1:0)
usb-storage: scsi cmd done, result=0x40000
usb-storage: *** thread sleeping.
usb-storage: queuecommand called
usb-storage: *** thread awakened.
usb-storage: Bad target number (2:0)
usb-storage: scsi cmd done, result=0x40000
usb-storage: *** thread sleeping.
usb-storage: queuecommand called
usb-storage: *** thread awakened.
usb-storage: Bad target number (3:0)
usb-storage: scsi cmd done, result=0x40000
usb-storage: *** thread sleeping.
usb-storage: queuecommand called
usb-storage: *** thread awakened.
usb-storage: Bad target number (4:0)
usb-storage: scsi cmd done, result=0x40000
usb-storage: *** thread sleeping.
usb-storage: queuecommand called
usb-storage: *** thread awakened.
usb-storage: Bad target number (5:0)
usb-storage: scsi cmd done, result=0x40000
usb-storage: *** thread sleeping.
usb-storage: queuecommand called
usb-storage: *** thread awakened.
usb-storage: Bad target number (6:0)
usb-storage: scsi cmd done, result=0x40000
usb-storage: *** thread sleeping.
usb-storage: queuecommand called
usb-storage: *** thread awakened.
usb-storage: Bad target number (7:0)
usb-storage: scsi cmd done, result=0x40000
usb-storage: *** thread sleeping.
USB Mass Storage device found at 3
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
usb usb5: adding 5-0:1.0 (config #1, interface 0)
usb 5-0:1.0: hotplug
hub 5-0:1.0: usb_probe_interface
hub 5-0:1.0: usb_probe_interface - got id
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 8 ports detected
hub 5-0:1.0: standalone hub
hub 5-0:1.0: ganged power switching
hub 5-0:1.0: individual port over-current protection
hub 5-0:1.0: Single TT
hub 5-0:1.0: TT requires at most 8 FS bit times
hub 5-0:1.0: power on to power good time: 20ms
hub 5-0:1.0: local power source is good
hub 5-0:1.0: enabling power on all ports
uhci_hcd 0000:00:1d.1: port 1 portsc 008a
hub 2-0:1.0: port 1, status 0100, change 0003, 12 Mb/s
usb 2-1: USB disconnect, address 2
usb 2-1: usb_disable_device nuking all URBs
usb 2-1: unregistering interface 2-1:1.0
usb 2-1:1.0: hotplug
usb 2-1: unregistering device
usb 2-1: hotplug
hub 2-0:1.0: debounce: port 1: total 100ms stable 100ms status 0x100
uhci_hcd 0000:00:1d.1: port 2 portsc 008a
hub 2-0:1.0: port 2, status 0100, change 0003, 12 Mb/s
usb 2-2: USB disconnect, address 3
usb 2-2: usb_disable_device nuking all URBs
usb 2-2: unregistering interface 2-2:1.0
usb-storage: storage_disconnect() called
usb-storage: usb_stor_stop_transport called
usb-storage: -- usb_stor_release_resources
usb-storage: -- sending exit command to thread
usb-storage: *** thread awakened.
usb-storage: -- exit command received
usb-storage: -- dissociate_dev
usb 2-2:1.0: hotplug
usb 2-2: unregistering device
usb 2-2: hotplug
hub 2-0:1.0: debounce: port 2: total 100ms stable 100ms status 0x100
ehci_hcd 0000:00:1d.7: GetStatus port 3 status 001403 POWER sig=k  CSC CONNECT
hub 5-0:1.0: port 3, status 0501, change 0001, 480 Mb/s
uhci_hcd 0000:00:1d.0: suspend_hc
hub 5-0:1.0: debounce: port 3: total 100ms stable 100ms status 0x501
ehci_hcd 0000:00:1d.7: port 3 low speed --> companion
ehci_hcd 0000:00:1d.7: GetStatus port 3 status 003002 POWER OWNER sig=se0  CSC
ehci_hcd 0000:00:1d.7: GetStatus port 4 status 001803 POWER sig=j  CSC CONNECT
hub 5-0:1.0: port 4, status 0501, change 0001, 480 Mb/s
uhci_hcd 0000:00:1d.2: suspend_hc
hub 5-0:1.0: debounce: port 4: total 100ms stable 100ms status 0x501
hub 5-0:1.0: port 4 not reset yet, waiting 50ms
ehci_hcd 0000:00:1d.7: port 4 full speed --> companion
ehci_hcd 0000:00:1d.7: GetStatus port 4 status 003801 POWER OWNER sig=j  CONNECT
uhci_hcd 0000:00:1d.1: port 1 portsc 01a3
hub 2-0:1.0: port 1, status 0301, change 0001, 1.5 Mb/s
ieee1394: Initialized config rom entry `ip1394'
ohci1394: $Rev: 1223 $ Ben Collins <bcollins@debian.org>
ACPI: PCI interrupt 0000:03:03.0[A] -> GSI 20 (level, low) -> IRQ 20
hub 2-0:1.0: debounce: port 1: total 100ms stable 100ms status 0x301
uhci_hcd 0000:00:1d.1: CTRL: TypeReq=0x2301 val=0x2 idx=0x0 len=0 ==> -32
ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[20]  MMIO=[feaef800-feaeffff]  Max Packet=[2048]
ohci_hcd: 2004 Feb 02 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci_hcd: block sizes: ed 64 td 64
usb 2-1: new low speed USB device using address 4
usb 2-1: skipped 1 descriptor after interface
usb 2-1: new device strings: Mfr=1, Product=2, SerialNumber=0
usb 2-1: default language 0x0409
usb 2-1: Product: USB-PS/2 Optical Mouse
usb 2-1: Manufacturer: Logitech
usb 2-1: hotplug
uhci_hcd 0000:00:1d.3: suspend_hc
usb 2-1: adding 2-1:1.0 (config #1, interface 0)
usb 2-1:1.0: hotplug
usbhid 2-1:1.0: usb_probe_interface
usbhid 2-1:1.0: usb_probe_interface - got id
input: USB HID v1.10 Mouse [Logitech USB-PS/2 Optical Mouse] on usb-0000:00:1d.1-1
uhci_hcd 0000:00:1d.1: port 2 portsc 0093
hub 2-0:1.0: port 2, status 0101, change 0001, 12 Mb/s
hub 2-0:1.0: debounce: port 2: total 100ms stable 100ms status 0x101
usb 2-2: new full speed USB device using address 5
usb 2-2: new device strings: Mfr=1, Product=2, SerialNumber=3
usb 2-2: default language 0x0409
usb 2-2: Product: C5050Z  
usb 2-2: Manufacturer: OLYMPUS
usb 2-2: SerialNumber: 000242752403
usb 2-2: hotplug
usb 2-2: adding 2-2:1.0 (config #1, interface 0)
usb 2-2:1.0: hotplug
usb-storage 2-2:1.0: usb_probe_interface
usb-storage 2-2:1.0: usb_probe_interface - got id
usb-storage: USB Mass Storage device detected
usb-storage: -- associate_dev
usb-storage: Vendor: 0x07b4, Product: 0x0105, Revision: 0x0100
usb-storage: Interface Subclass: 0x06, Protocol: 0x50
usb-storage: Vendor: OLYMPUS,  Product: C5050Z  
usb-storage: Transport: Bulk
usb-storage: Protocol: Transparent SCSI
usb-storage: usb_stor_control_msg: rq=fe rqtype=a1 value=0000 index=00 len=1
usb-storage: GetMaxLUN command result is 1, data is 0
scsi3 : SCSI emulation for USB Mass Storage devices
usb-storage: *** thread sleeping.
usb-storage: queuecommand called
usb-storage: *** thread awakened.
usb-storage: Command INQUIRY (6 bytes)
usb-storage:  12 00 00 00 24 00
usb-storage: Bulk Command S 0x43425355 T 0xda4 L 36 F 128 Trg 0 LUN 0 CL 6
usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
usb-storage: Status code 0; transferred 31/31
usb-storage: -- transfer complete
usb-storage: Bulk command transfer result=0
usb-storage: usb_stor_bulk_transfer_buf: xfer 36 bytes
usb-storage: Status code 0; transferred 36/36
usb-storage: -- transfer complete
usb-storage: Bulk data transfer result 0x0
usb-storage: Attempting to get CSW...
usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
usb-storage: Status code 0; transferred 13/13
usb-storage: -- transfer complete
usb-storage: Bulk status result = 0
usb-storage: Bulk Status S 0x53425355 T 0xda4 R 0 Stat 0x0
usb-storage: scsi cmd done, result=0x0
usb-storage: *** thread sleeping.
  Vendor: OLYMPUS   Model: C5050Z            Rev: 1.00
  Type:   Direct-Access                      ANSI SCSI revision: 02
usb-storage: queuecommand called
usb-storage: *** thread awakened.
usb-storage: Command TEST_UNIT_READY (6 bytes)
usb-storage:  00 00 00 00 00 00
usb-storage: Bulk Command S 0x43425355 T 0xda5 L 0 F 0 Trg 0 LUN 0 CL 6
usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
usb-storage: Status code 0; transferred 31/31
usb-storage: -- transfer complete
usb-storage: Bulk command transfer result=0
usb-storage: Attempting to get CSW...
usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
usb-storage: Status code 0; transferred 13/13
usb-storage: -- transfer complete
usb-storage: Bulk status result = 0
usb-storage: Bulk Status S 0x53425355 T 0xda5 R 0 Stat 0x0
usb-storage: scsi cmd done, result=0x0
usb-storage: *** thread sleeping.
usb-storage: queuecommand called
usb-storage: *** thread awakened.
usb-storage: Command READ_CAPACITY (10 bytes)
usb-storage:  25 00 00 00 00 00 00 00 00 00
usb-storage: Bulk Command S 0x43425355 T 0xda7 L 8 F 128 Trg 0 LUN 0 CL 10
usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
usb-storage: Status code 0; transferred 31/31
usb-storage: -- transfer complete
usb-storage: Bulk command transfer result=0
usb-storage: usb_stor_bulk_transfer_buf: xfer 8 bytes
usb-storage: Status code 0; transferred 8/8
usb-storage: -- transfer complete
usb-storage: Bulk data transfer result 0x0
usb-storage: Attempting to get CSW...
usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
usb-storage: Status code 0; transferred 13/13
usb-storage: -- transfer complete
usb-storage: Bulk status result = 0
usb-storage: Bulk Status S 0x53425355 T 0xda7 R 0 Stat 0x0
usb-storage: scsi cmd done, result=0x0
usb-storage: *** thread sleeping.
SCSI device sdb: 1006992 512-byte hdwr sectors (516 MB)
usb-storage: queuecommand called
usb-storage: *** thread awakened.
usb-storage: Command MODE_SENSE (6 bytes)
usb-storage:  1a 00 3f 00 c0 00
usb-storage: Bulk Command S 0x43425355 T 0xda8 L 192 F 128 Trg 0 LUN 0 CL 6
usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
usb-storage: Status code 0; transferred 31/31
usb-storage: -- transfer complete
usb-storage: Bulk command transfer result=0
usb-storage: usb_stor_bulk_transfer_buf: xfer 192 bytes
usb-storage: Status code 0; transferred 192/192
usb-storage: -- transfer complete
usb-storage: Bulk data transfer result 0x0
usb-storage: Attempting to get CSW...
usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
usb-storage: Status code 0; transferred 13/13
usb-storage: -- transfer complete
usb-storage: Bulk status result = 0
usb-storage: Bulk Status S 0x53425355 T 0xda8 R 0 Stat 0x0
usb-storage: scsi cmd done, result=0x0
usb-storage: *** thread sleeping.
sdb: Write Protect is off
sdb: Mode Sense: 18 00 00 08
sdb: assuming drive cache: write through
usb-storage: queuecommand called
usb-storage: *** thread awakened.
usb-storage: Command TEST_UNIT_READY (6 bytes)
usb-storage:  00 00 00 00 00 00
usb-storage: Bulk Command S 0x43425355 T 0xda9 L 0 F 0 Trg 0 LUN 0 CL 6
usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
usb-storage: Status code 0; transferred 31/31
usb-storage: -- transfer complete
usb-storage: Bulk command transfer result=0
usb-storage: Attempting to get CSW...
usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
usb-storage: Status code 0; transferred 13/13
usb-storage: -- transfer complete
usb-storage: Bulk status result = 0
usb-storage: Bulk Status S 0x53425355 T 0xda9 R 0 Stat 0x0
usb-storage: scsi cmd done, result=0x0
usb-storage: *** thread sleeping.
usb-storage: queuecommand called
usb-storage: *** thread awakened.
usb-storage: Command ALLOW_MEDIUM_REMOVAL (6 bytes)
usb-storage:  1e 00 00 00 01 00
usb-storage: Bulk Command S 0x43425355 T 0xdab L 0 F 0 Trg 0 LUN 0 CL 6
usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
usb-storage: Status code 0; transferred 31/31
usb-storage: -- transfer complete
usb-storage: Bulk command transfer result=0
usb-storage: Attempting to get CSW...
usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
usb-storage: Status code 0; transferred 13/13
usb-storage: -- transfer complete
usb-storage: Bulk status result = 0
usb-storage: Bulk Status S 0x53425355 T 0xdab R 0 Stat 0x0
usb-storage: scsi cmd done, result=0x0
usb-storage: *** thread sleeping.
 /dev/scsi/host3/bus0/target0/lun0:<7>usb-storage: queuecommand called
usb-storage: *** thread awakened.
usb-storage: Command READ_10 (10 bytes)
usb-storage:  28 00 00 00 00 00 00 00 08 00
usb-storage: Bulk Command S 0x43425355 T 0xdac L 4096 F 128 Trg 0 LUN 0 CL 10
usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
usb-storage: Status code 0; transferred 31/31
usb-storage: -- transfer complete
usb-storage: Bulk command transfer result=0
usb-storage: usb_stor_bulk_transfer_sglist: xfer 4096 bytes, 1 entries
usb-storage: Status code 0; transferred 4096/4096
usb-storage: -- transfer complete
usb-storage: Bulk data transfer result 0x0
usb-storage: Attempting to get CSW...
usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
usb-storage: Status code 0; transferred 13/13
usb-storage: -- transfer complete
usb-storage: Bulk status result = 0
usb-storage: Bulk Status S 0x53425355 T 0xdac R 0 Stat 0x0
usb-storage: scsi cmd done, result=0x0
usb-storage: *** thread sleeping.
 p1
usb-storage: queuecommand called
usb-storage: *** thread awakened.
usb-storage: Command ALLOW_MEDIUM_REMOVAL (6 bytes)
usb-storage:  1e 00 00 00 00 00
usb-storage: Bulk Command S 0x43425355 T 0xdae L 0 F 0 Trg 0 LUN 0 CL 6
usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
usb-storage: Status code 0; transferred 31/31
usb-storage: -- transfer complete
usb-storage: Bulk command transfer result=0
usb-storage: Attempting to get CSW...
usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
usb-storage: Status code 0; transferred 13/13
usb-storage: -- transfer complete
usb-storage: Bulk status result = 0
usb-storage: Bulk Status S 0x53425355 T 0xdae R 0 Stat 0x0
usb-storage: scsi cmd done, result=0x0
usb-storage: *** thread sleeping.
Attached scsi removable disk sdb at scsi3, channel 0, id 0, lun 0
Attached scsi generic sg1 at scsi3, channel 0, id 0, lun 0,  type 0
usb-storage: queuecommand called
usb-storage: *** thread awakened.
usb-storage: Bad target number (1:0)
usb-storage: scsi cmd done, result=0x40000
usb-storage: *** thread sleeping.
usb-storage: queuecommand called
usb-storage: *** thread awakened.
usb-storage: Bad target number (2:0)
usb-storage: scsi cmd done, result=0x40000
usb-storage: *** thread sleeping.
usb-storage: queuecommand called
usb-storage: *** thread awakened.
usb-storage: Bad target number (3:0)
usb-storage: scsi cmd done, result=0x40000
usb-storage: *** thread sleeping.
usb-storage: queuecommand called
usb-storage: *** thread awakened.
usb-storage: Bad target number (4:0)
usb-storage: scsi cmd done, result=0x40000
usb-storage: *** thread sleeping.
usb-storage: queuecommand called
usb-storage: *** thread awakened.
usb-storage: Bad target number (5:0)
usb-storage: scsi cmd done, result=0x40000
usb-storage: *** thread sleeping.
usb-storage: queuecommand called
usb-storage: *** thread awakened.
usb-storage: Bad target number (6:0)
usb-storage: scsi cmd done, result=0x40000
usb-storage: *** thread sleeping.
usb-storage: queuecommand called
usb-storage: *** thread awakened.
usb-storage: Bad target number (7:0)
usb-storage: scsi cmd done, result=0x40000
usb-storage: *** thread sleeping.
USB Mass Storage device found at 5
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00e018000041c60e]
eth1394: $Rev: 1224 $ Ben Collins <bcollins@debian.org>
eth1394: eth1: IEEE-1394 IPv4 over 1394 Ethernet (fw-host0)
e1000: eth0: e1000_watchdog: NIC Link is Up 100 Mbps Full Duplex
process `named' is using obsolete setsockopt SO_BSDCOMPAT
uhci_hcd 0000:00:1d.1: port 2 portsc 008a
hub 2-0:1.0: port 2, status 0100, change 0003, 12 Mb/s
usb 2-2: USB disconnect, address 5
usb 2-2: usb_disable_device nuking all URBs
usb 2-2: unregistering interface 2-2:1.0
usb-storage: storage_disconnect() called
usb-storage: usb_stor_stop_transport called
usb-storage: -- usb_stor_release_resources
usb-storage: -- sending exit command to thread
usb-storage: *** thread awakened.
usb-storage: -- exit command received
usb-storage: -- dissociate_dev
usb 2-2:1.0: hotplug
usb 2-2: unregistering device
usb 2-2: hotplug
hub 2-0:1.0: debounce: port 2: total 100ms stable 100ms status 0x100
ehci_hcd 0000:00:1d.7: GetStatus port 4 status 001002 POWER sig=se0  CSC
hub 5-0:1.0: port 4, status 0100, change 0001, 12 Mb/s
hub 5-0:1.0: debounce: port 4: total 100ms stable 100ms status 0x100
agpgart: Found an AGP 3.0 compliant device at 0000:00:00.0.
agpgart: X passes broken AGP3 flags (1f004a0f). Fixed.
agpgart: Putting AGP V3 device at 0000:00:00.0 into 8x mode
agpgart: Putting AGP V3 device at 0000:01:00.0 into 8x mode
[drm] Loading R200 Microcode

--------------070802020905020301020309--
