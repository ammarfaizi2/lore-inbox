Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267469AbUJNUx7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267469AbUJNUx7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 16:53:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267543AbUJNUwi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 16:52:38 -0400
Received: from postfix4-2.free.fr ([213.228.0.176]:33504 "EHLO
	postfix4-2.free.fr") by vger.kernel.org with ESMTP id S267469AbUJNUYF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 16:24:05 -0400
Message-ID: <416EE051.40705@free.fr>
Date: Thu, 14 Oct 2004 22:23:45 +0200
From: Laurent Riffard <laurent.riffard@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.6) Gecko/20040115
X-Accept-Language: fr-fr, fr, en
MIME-Version: 1.0
To: Alan Stern <stern@rowland.harvard.edu>
Cc: USB development list <linux-usb-devel@lists.sourceforge.net>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>
Subject: Re: 2.6.9-rc4-mm1 : oops when rmmod uhci_hcd  [was: 2.6.9-rc3-mm2
 : oops...]
References: <Pine.LNX.4.44L0.0410131133300.1181-100000@ida.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0410131133300.1181-100000@ida.rowland.org>
X-Enigmail-Version: 0.83.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigC8D0C7723861FB294E2318A6"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC8D0C7723861FB294E2318A6
Content-Type: multipart/mixed;
 boundary="------------050809040006060604090700"

This is a multi-part message in MIME format.
--------------050809040006060604090700
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


Alan Stern wrote:
[snip]
> My impression is that this problem arises somewhere within or
> below the free_irq routine.  I don't have the -mm2 sources, so I
> can't be any more precise than that.

Here is an updated dmesg for kernel 2.6.9-rc4-mm1. But I'm afraid it 
won't give more information, as the call stack is identical to the 
2.6.9-rc3-mm2 one.

I will try a vanilla kernel if it's needed.

-- 
laurent


--------------050809040006060604090700
Content-Type: text/plain;
 name="dmesg-2.6.9-rc4-mm1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg-2.6.9-rc4-mm1"

Linux version 2.6.9-rc4-mm1 (laurent@antares.localdomain) (gcc version 3.3.2 (Mandrake Linux 10.0 3.3.2-6mdk)) #15 Mon Oct 11 22:07:48 CEST 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000ffec000 (usable)
 BIOS-e820: 000000000ffec000 - 000000000ffef000 (ACPI data)
 BIOS-e820: 000000000ffef000 - 000000000ffff000 (reserved)
 BIOS-e820: 000000000ffff000 - 0000000010000000 (ACPI NVS)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
255MB LOWMEM available.
On node 0 totalpages: 65516
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 61420 pages, LIFO batch:14
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 ASUS                                  ) @ 0x000f6a80
ACPI: RSDT (v001 ASUS   A7V133-C 0x30303031 MSFT 0x31313031) @ 0x0ffec000
ACPI: FADT (v001 ASUS   A7V133-C 0x30303031 MSFT 0x31313031) @ 0x0ffec080
ACPI: BOOT (v001 ASUS   A7V133-C 0x30303031 MSFT 0x31313031) @ 0x0ffec040
ACPI: DSDT (v001   ASUS A7V133-C 0x00001000 MSFT 0x0100000b) @ 0x00000000
ACPI: PM-Timer IO Port: 0xe408
Built 1 zonelists
No local APIC present or hardware disabled
Initializing CPU#0
Kernel command line: resume=/dev/hdb6 root=/dev/hda6 init S
PID hash table entries: 1024 (order: 10, 16384 bytes)
Detected 1410.673 MHz processor.
Using pmtmr for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 256120k/262064k available (1775k kernel code, 5388k reserved, 793k data, 152k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 2793.47 BogoMIPS (lpj=1396736)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: 0383f9ff c1cbf9ff 00000000 00000000
CPU: After vendor identify, caps:  0383f9ff c1cbf9ff 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU: After all inits, caps:        0383f9ff c1cbf9ff 00000000 00000020
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: AMD Athlon(TM) XP 1600+ stepping 02
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
ACPI: IRQ9 SCI: Edge set to Level Trigger.
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xf1180, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040816
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
Linux Plug and Play Support v0.97 (c) Adam Belay
PCI: Using ACPI for IRQ routing
** PCI interrupts are no longer routed automatically.  If this
** causes a device to stop working, it is probably because the
** driver failed to call pci_enable_device().  As a temporary
** workaround, the "pci=routeirq" argument restores the old
** behavior.  If this argument makes the device work again,
** please email the output of "lspci" to bjorn.helgaas@hp.com
** so I can fix the driver.
Simple Boot Flag at 0x3a set to 0x1
Machine check exception polling timer started.
Initializing Cryptographic API
Applying VIA southbridge workaround.
PCI: Disabling Via external APIC routing
vesafb: probe of vesafb0 failed with error -6
ACPI: Power Button (FF) [PWRF]
ACPI: Processor [CPU0] (supports C1 C2, 16 throttling states)
ACPI: PS/2 Keyboard Controller [PS2K] at I/O 0x60, 0x64, irq 1
ACPI: PS/2 Mouse Controller [PS2M] at irq 12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:04.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci0000:00:04.1
    ide0: BM-DMA at 0xd800-0xd807, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xd808-0xd80f, BIOS settings: hdc:DMA, hdd:DMA
Probing IDE interface ide0...
hda: ST340016A, ATA DISK drive
hdb: Maxtor 6Y080L0, ATA DISK drive
elevator: using anticipatory as default io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: CD-950E/AKU, ATAPI CD/DVD-ROM drive
hdd: LITE-ON LTR-48125S, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
Probing IDE interface ide2...
ide2: Wait for ready failed before probe !
Probing IDE interface ide3...
ide3: Wait for ready failed before probe !
Probing IDE interface ide4...
ide4: Wait for ready failed before probe !
Probing IDE interface ide5...
ide5: Wait for ready failed before probe !
hda: max request size: 128KiB
hda: 78165360 sectors (40020 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(100)
hda: cache flushes not supported
 hda: hda1 hda2 hda3 < hda5 hda6 hda7 hda8 hda9 > hda4
hdb: max request size: 128KiB
hdb: 160086528 sectors (81964 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(100)
hdb: cache flushes supported
 hdb: hdb1 hdb2 < hdb5 hdb6 hdb7 hdb8 >
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard on isa0060/serio0
input: ImExPS/2 Generic Explorer Mouse on isa0060/serio1
NET: Registered protocol family 2
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
NET: Registered protocol family 1
ACPI: (supports S0 S1 S3 S4 S5)
ACPI wakeup devices: 
PWRB PCI0 UAR1 UAR2 USB0 USB1 
BIOS EDD facility v0.16 2004-Jun-25, 2 devices found
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 152k freed
kjournald starting.  Commit interval 5 seconds
Real Time Clock Driver v1.12
usbcore: registered new driver usbfs
usbcore: registered new driver hub
USB Universal Host Controller Interface driver v2.2
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 5
PCI: setting IRQ 5 as level-triggered
ACPI: PCI interrupt 0000:00:04.2[D] -> GSI 5 (level, low) -> IRQ 5
uhci_hcd 0000:00:04.2: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller
uhci_hcd 0000:00:04.2: irq 5, io base 0xd400
uhci_hcd 0000:00:04.2: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:04.3[D] -> GSI 5 (level, low) -> IRQ 5
uhci_hcd 0000:00:04.3: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (#2)
uhci_hcd 0000:00:04.3: irq 5, io base 0xd000
uhci_hcd 0000:00:04.3: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
usb 1-2: new low speed USB device using address 2
EXT3 FS on hda6, internal journal
device-mapper: 4.1.0-ioctl (2003-12-10) initialised: dm@uk.sistina.com
input: USB HID v1.10 Gamepad [THRUSTMASTER FireStorm Dual Analog 2] on usb-0000:00:04.2-2
usbcore: registered new driver usbhid
/home/laurent/kernel/linux-2.6/drivers/usb/input/hid-core.c: v2.0:USB HID core driver
Adding 64220k swap on /dev/hda5.  Priority:-1 extents:1
Adding 1052216k swap on /dev/hdb6.  Priority:-2 extents:1
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected VIA Twister-K/KT133x/KM133 chipset
agpgart: Maximum main memory to use for agp memory: 203M
agpgart: AGP aperture is 64M @ 0xe4000000
ReiserFS: dm-1: found reiserfs format "3.6" with standard journal
ReiserFS: dm-1: using ordered data mode
ReiserFS: dm-1: journal params: device dm-1, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: dm-1: checking transaction log (dm-1)
ReiserFS: dm-1: Using r5 hash to sort names
ReiserFS: dm-0: found reiserfs format "3.6" with standard journal
ReiserFS: dm-0: using ordered data mode
ReiserFS: dm-0: journal params: device dm-0, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: dm-0: checking transaction log (dm-0)
ReiserFS: dm-0: Using r5 hash to sort names
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-2, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
ohci1394: $Rev: 1223 $ Ben Collins <bcollins@debian.org>
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 10
PCI: setting IRQ 10 as level-triggered
ACPI: PCI interrupt 0000:00:0a.0[A] -> GSI 10 (level, low) -> IRQ 10
ohci1394: fw-host0: Unexpected PCI resource length of 1000!
ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[10]  MMIO=[d5800000-d58007ff]  Max Packet=[2048]
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00308d0120e085ca]
ne2k-pci.c:v1.03 9/22/2003 D. Becker/P. Gortmaker
  http://www.scyld.com/network/ne2k-pci.html
ACPI: PCI interrupt 0000:00:0d.0[A] -> GSI 5 (level, low) -> IRQ 5
eth0: RealTek RTL-8029 found at 0xa000, IRQ 5, 00:40:95:46:6E:2D.
uhci_hcd 0000:00:04.2: remove, state 1
usb usb1: USB disconnect, address 1
usb 1-2: USB disconnect, address 2
uhci_hcd 0000:00:04.2: USB bus 1 deregistered
uhci_hcd 0000:00:04.3: remove, state 1
usb usb2: USB disconnect, address 1
Unable to handle kernel paging request at virtual address 6b6b6b6b
 printing eip:
c0187949
*pde = 00000000
Oops: 0000 [#1]
PREEMPT 
Modules linked in: ne2k_pci 8390 crc32 ohci1394 ieee1394 nls_iso8859_1 nls_cp850 vfat fat reiser4 reiserfs via_agp agpgart joydev dm_mod usbhid uhci_hcd usbcore rtc
CPU:    0
EIP:    0060:[<c0187949>]    Not tainted VLI
EFLAGS: 00010246   (2.6.9-rc4-mm1) 
EIP is at remove_proc_entry+0x29/0x140
eax: 00000000   ebx: 6b6b6b6b   ecx: ffffffff   edx: cffdef58
esi: cf3df97c   edi: 6b6b6b6b   ebp: cf98fea0   esp: cf98fe7c
ds: 007b   es: 007b   ss: 0068
Process rmmod (pid: 2016, threadinfo=cf98e000 task=cc9225f0)
Stack: cfed3938 cf98fe90 c022da9d c03544f4 cffdef58 6b6b6b6b cf3659bc cf3df97c 
       00000005 cf98fec8 c0137711 00000286 00000003 cf98e000 00000282 c037eb40 
       cf3df97c cfed38f4 cfed3938 cf98feec d083d5ff d0842b4a d0821b74 cfed3990 
Call Trace:
 [<c0105e46>] show_stack+0xa6/0xb0
 [<c0105fbd>] show_registers+0x14d/0x1c0
 [<c01061a4>] die+0xe4/0x180
 [<c01168c1>] do_page_fault+0x4c1/0x631
 [<c0105a89>] error_code+0x2d/0x38
 [<c0137711>] free_irq+0xa1/0x110
 [<d083d5ff>] usb_hcd_pci_remove+0xaf/0x180 [usbcore]
 [<c01c42d6>] pci_device_remove+0x66/0x70
 [<c022ecb7>] device_release_driver+0x57/0x60
 [<c022ecd9>] driver_detach+0x19/0x30
 [<c022f17c>] bus_remove_driver+0x5c/0xa0
 [<c022f667>] driver_unregister+0x17/0x40
 [<c01c44ce>] pci_unregister_driver+0xe/0x20
 [<d0821a60>] uhci_hcd_cleanup+0x10/0x56 [uhci_hcd]
 [<c0131f07>] sys_delete_module+0x177/0x1a0
 [<c010502d>] sysenter_past_esp+0x52/0x71
Code: 00 00 55 89 e5 83 ec 24 85 d2 89 5d f4 89 75 f8 89 7d fc 89 55 ec 89 45 f0 0f 84 96 00 00 00 8b 5d f0 31 c0 b9 ff ff ff ff 89 df <f2> ae f7 d1 49 8b 42 34 8d 7a 34 89 ce 85 c0 74 6e 8b 0f 89 da 
 


--------------050809040006060604090700--

--------------enigC8D0C7723861FB294E2318A6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFBbuBdUqUFrirTu6IRAiHPAJ9F+hIgGo+gyP1fM6Y8KALwegVr7QCfY0ry
wtvUTIVPct1FugsR+nMtUmE=
=AKQF
-----END PGP SIGNATURE-----

--------------enigC8D0C7723861FB294E2318A6--
