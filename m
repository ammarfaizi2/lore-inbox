Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945941AbWBONmK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945941AbWBONmK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 08:42:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945940AbWBONmK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 08:42:10 -0500
Received: from nproxy.gmail.com ([64.233.182.197]:24911 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1945941AbWBONmI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 08:42:08 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=T9ifSd5obhuu5jjjCRjLalru20tdo8g/qWVvjv5agZEiTkE0S/o1n8wsTtqMjDMiJm91W1XpLjX7k0I2dXqNjOoHOJlBRIHSOOiF7VGjRVzg/KoyYtCHY2Mic/+BcTbGSXjfy2seIomC0S/GRYj9GwMdZLiF+2H9PbXZFtG4144=
Message-ID: <cde01ae70602150542m1b57aa83l62508927276241b@mail.gmail.com>
Date: Wed, 15 Feb 2006 14:42:05 +0100
From: Lz <elezeta@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: Problems with sound on latest kernels.
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060214232222.1016fe87.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <cde01ae70602140558g6440af40mf59e3e1992088d3b@mail.gmail.com>
	 <1139934640.11659.95.camel@mindpipe>
	 <20060214232222.1016fe87.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/15/06, Andrew Morton <akpm@osdl.org> wrote:
>
> Poor guy - that's rocket science.  It looks like it's due to breakage in
> the pnp code anwyay.

Yeah, it seemed that to me, alsa wasn't even loaded at that time.
>
> Please set CONFIG_PNP_DEBUG=y and send us the output of `dmesg -s 1000000',
> thanks.
>

Linux version 2.6.16-rc3 (root@symbiosis) (gcc version 4.0.3 20060212
(prerelease) (Debian 4.0.2-9)) #2 PREEMPT Wed Feb 15 14:07:16 CET 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000020000000 (usable)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
512MB LOWMEM available.
On node 0 totalpages: 131072
 DMA zone: 4096 pages, LIFO batch:0
 DMA32 zone: 0 pages, LIFO batch:0
 Normal zone: 126976 pages, LIFO batch:31
 HighMem zone: 0 pages, LIFO batch:0
DMI not present or invalid.
ACPI: Unable to locate RSDP
Allocating PCI resources starting at 30000000 (gap: 20000000:dfff0000)
Built 1 zonelists
Kernel command line: BOOT_IMAGE=Debian ro root=302
Local APIC disabled by BIOS -- you can enable it with "lapic"
mapped APIC to ffffd000 (01402000)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 65536 bytes)
Detected 908.299 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 132x50
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 515228k/524288k available (2629k kernel code, 8636k reserved,
670k data, 192k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 1818.30 BogoMIPS (lpj=909151)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 0387f9ff 00000000 00000000 00000000
00000000 00000000 00000000
CPU: After vendor identify, caps: 0387f9ff 00000000 00000000 00000000
00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU serial number disabled.
CPU: After all inits, caps: 0383f9ff 00000000 00000000 00000040
00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel Pentium III (Coppermine) stepping 06
Checking 'hlt' instruction... OK.
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfb310, last bus=1
PCI: Using configuration type 1
ACPI: Subsystem revision 20060127
ACPI: Interpreter disabled.
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI: disabled
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00fbcc0
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xbce8, dseg 0xf0000
PnPBIOS: 16 nodes reported by PnP BIOS; 16 recorded by driver
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
Boot video device is 0000:01:00.0
PCI: Using IRQ router VIA [1106/0596] at 0000:00:07.0
pnp: the driver 'system' has been registered
pnp: match found with the PnP device '00:07' and the driver 'system'
pnp: match found with the PnP device '00:08' and the driver 'system'
pnp: match found with the PnP device '00:0b' and the driver 'system'
pnp: 00:0b: ioport range 0x260-0x267 has been reserved
PCI: Bridge: 0000:00:01.0
 IO window: d000-dfff
 MEM window: d8000000-dfffffff
 PREFETCH window: d0000000-d7ffffff
PCI: Setting latency timer of device 0000:00:01.0 to 64
audit: initializing netlink socket (disabled)
audit(1140013800.464:1): initialized
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
Activating ISA DMA hang workarounds.
fb: 3Dfx Voodoo5 memory = 32768K
isapnp: Scanning for PnP cards...
pnp: Calling quirk for 01:01.00
pnp: SB audio device quirk - increasing port range
pnp: Calling quirk for 01:01.03
pnp: AWE32 quirk - adding two ports
pnp: Calling quirk for 01:02.00
pnp: SB audio device quirk - increasing port range
isapnp: Card 'Creative SB AWE32 PnP'
isapnp: Card 'Creative ViBRA16C PnP'
isapnp: 2 Plug & Play cards detected total
Linux agpgart interface v0.101 (c) Dave Jones
[drm] Initialized drm 1.0.1 20051102
[drm] Initialized tdfx 1.0.0 20010216 on minor 0
pnp: the driver 'i8042 kbd' has been registered
pnp: match found with the PnP device '00:04' and the driver 'i8042 kbd'
pnp: the driver 'i8042 aux' has been registered
pnp: match found with the PnP device '00:0a' and the driver 'i8042 aux'
PNP: PS/2 Controller [PNP0303,PNP0f13] at 0x60,0x64 irq 1,12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
pnp: the driver 'serial' has been registered
pnp: match found with the PnP device '00:0c' and the driver 'serial'
00:0c: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
pnp: match found with the PnP device '00:10' and the driver 'serial'
00:10: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
loop: loaded (max 8 devices)
ne2k-pci.c:v1.03 9/22/2003 D. Becker/P. Gortmaker
 http://www.scyld.com/network/ne2k-pci.html
PCI: Found IRQ 9 for device 0000:00:0a.0
eth0: Winbond 89C940 found at 0xe800, IRQ 9, 00:20:18:80:27:A6.
PPP generic driver version 2.4.2
PPP MPPE Compression module registered
Linux video capture interface: v1.00
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:07.1
PCI: Via IRQ fixup for 0000:00:07.1, from 255 to 0
VP_IDE: chipset revision 16
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt82c596b (rev 23) IDE UDMA66 controller on pci0000:00:07.1
   ide0: BM-DMA at 0xe000-0xe007, BIOS settings: hda:DMA, hdb:pio
   ide1: BM-DMA at 0xe008-0xe00f, BIOS settings: hdc:DMA, hdd:DMA
Probing IDE interface ide0...
hda: ST360021A, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: HL-DT-ST GCE-8525B, ATAPI CD/DVD-ROM drive
hdd: HL-DT-ST DVDRAM GSA-4082B, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 117231408 sectors (60022 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(66)
hda: cache flushes not supported
 hda: hda1 hda2 hda3 < hda5 hda6 > hda4
hdc: ATAPI 52X CD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
hdd: ATAPI 32X DVD-ROM DVD-R-RAM CD-R/RW drive, 2048kB Cache, UDMA(33)
libata version 1.20 loaded.
USB Universal Host Controller Interface driver v2.3
PCI: Found IRQ 5 for device 0000:00:07.2
uhci_hcd 0000:00:07.2: UHCI Host Controller
uhci_hcd 0000:00:07.2: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:07.2: irq 5, io base 0x0000e400
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
Initializing USB Mass Storage driver...
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard as /class/input/input0
input: ImPS/2 Generic Wheel Mouse as /class/input/input1
input: PC Speaker as /class/input/input2
MC: drivers/edac/edac_mc.c version edac_mc  Ver: 2.0.0 Feb 15 2006
sb: Init: Starting Probe...
pnp: the driver 'OSS SndBlstr' has been registered
sb: PnP: Found Card Named = "Creative SB AWE32 PnP", Card PnP id =
CTL0042, Device PnP id = CTL0031
sb: PnP:      Detected at: io=0x0, irq=-1, dma=-1, dma16=-1
sb: ports busy.
sb: PnP: Found Card Named = "Creative ViBRA16C PnP", Card PnP id =
CTL0070, Device PnP id = CTL0001
sb: PnP:      Detected at: io=0x0, irq=-1, dma=-1, dma16=-1
sb: ports busy.
sb: Init: Done
pnp: the driver 'OSS SndBlstr' has been unregistered
Advanced Linux Sound Architecture Driver Version 1.0.11rc2 (Wed Jan 04
08:57:20 2006 UTC).
can't register device seq
pnp: the driver 'sb16' has been registered
pnp: the driver 'sb16' has been unregistered
pnp: the driver 'sbawe' has been registered
pnp: the driver 'sbawe' has been unregistered
ALSA device list:
 #0: Virtual MIDI Card 1
NET: Registered protocol family 2
IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
TCP established hash table entries: 131072 (order: 7, 524288 bytes)
TCP bind hash table entries: 65536 (order: 6, 262144 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
GRE over IPv4 tunneling driver
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
Using IPI Shortcut mode
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 192k freed
kjournald starting.  Commit interval 5 seconds
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
ide: failed opcode was: unknown
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
ide: failed opcode was: unknown
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
ide: failed opcode was: unknown
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
ide: failed opcode was: unknown
ide0: reset: success
EXT3 FS on hda2, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda5, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda4, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Adding 979924k swap on /dev/hda6.  Priority:-1 extents:1 across:979924k
mtrr: base(0xd0000000) is not aligned on a size(0x7d00000) boundary

--
Lz (elezeta@gmail.com).
http://elezeta.bounceme.net
