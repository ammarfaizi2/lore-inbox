Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271309AbRIATpU>; Sat, 1 Sep 2001 15:45:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271331AbRIATpM>; Sat, 1 Sep 2001 15:45:12 -0400
Received: from smtp.polymtl.ca ([132.207.4.11]:54285 "EHLO smtp.polymtl.ca")
	by vger.kernel.org with ESMTP id <S271309AbRIAToy>;
	Sat, 1 Sep 2001 15:44:54 -0400
Date: Sat, 1 Sep 2001 15:21:01 -0400 (EDT)
From: Tester <tester@videotron.ca>
X-X-Sender: <Tester@TesterTop.PolyDom>
To: Linus Torvalds <torvalds@transmeta.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Bizzare crashes on IBM Thinkpad A22e.. yenta_socket related
In-Reply-To: <200109011456.f81EutI16218@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33.0109011513320.1294-100000@TesterTop.PolyDom>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I dont have ACPI enabled, but I have APM support...
Should I try enabling ACPI?

And the result of dmesg follows:

Linux version 2.4.9 (Tester@TesterTop) (gcc version 2.96 20000731 (Red Hat Linux 7.1 2.96-85)) #15 Fri Aug 31 16:04:04 EDT 2001
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000fff0000 (usable)
 BIOS-e820: 000000000fff0000 - 000000000fffec00 (ACPI data)
 BIOS-e820: 000000000fffec00 - 0000000010000000 (ACPI NVS)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
On node 0 totalpages: 65520
zone(0): 4096 pages.
zone(1): 61424 pages.
zone(2): 0 pages.
Kernel command line: auto BOOT_IMAGE=linux ro root=305 BOOT_FILE=/boot/vmlinuz
Initializing CPU#0
Detected 206.245 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 430.89 BogoMIPS
Memory: 255768k/262080k available (887k kernel code, 5924k reserved, 292k data, 176k init, 0k highmem)
Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount-cache hash table entries: 4096 (order: 3, 32768 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
CPU: Before vendor init, caps: 0383f9ff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 128K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: After vendor init, caps: 0383f9ff 00000000 00000000 00000000
CPU:     After generic, caps: 0383f9ff 00000000 00000000 00000000
CPU:             Common caps: 0383f9ff 00000000 00000000 00000000
CPU: Intel Celeron (Coppermine) stepping 0a
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfd9af, last bus=3
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Using IRQ router PIIX [8086/7198] at 00:07.0
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
IBM machine detected. Enabling interrupts during APM calls.
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.14)
Starting kswapd v1.8
Journalled Block Device driver loaded
pty: 256 Unix98 ptys configured
block: 128 slots per queue, batch=16
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller on PCI bus 00 dev 39
PIIX4: chipset revision 0
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1890-0x1897, BIOS settings: hda:DMA, hdb:DMA
hda: IC25N015ATDA04-0, ATA DISK drive
hdb: CD-224E, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: 29498175 sectors (15103 MB) w/347KiB Cache, CHS=1950/240/63
hdb: ATAPI 24X CD-ROM drive, 128kB Cache
Uniform CD-ROM driver Revision: 3.12
Partition check:
 hda: hda1 hda2 < hda5 hda6 hda7 >
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
IPv4 over IPv4 tunneling driver
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 176k freed
Adding Swap: 529160k swap-space (priority -1)
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
usb-uhci.c: $Revision: 1.259 $ time 16:13:30 Aug 31 2001
usb-uhci.c: High bandwidth mode enabled
PCI: Found IRQ 11 for device 00:07.2
usb-uhci.c: USB UHCI at I/O 0x18a0, IRQ 11
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
usb-uhci.c: v1.251:USB Universal Host Controller Interface driver
EXT3 FS 2.4-0.9.6-249, 18 Aug 2001 on ide0(3,5), internal journal
eepro100.c:v1.09j-t 9/29/99 Donald Becker http://cesdis.gsfc.nasa.gov/linux/drivers/eepro100.html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin <saw@saw.sw.com.sg> and others
PCI: Found IRQ 11 for device 00:03.0
PCI: Sharing IRQ 11 with 00:03.1
eth0: OEM i82557/i82558 10/100 Ethernet, 00:03:47:8E:AE:4D, IRQ 11.
  Board assembly a30469-008, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
    Secondary interface chip i82555.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x3258698e).
Intel 810 + AC97 Audio, version 0.03, 16:13:09 Aug 31 2001
PCI: Found IRQ 11 for device 00:00.1
PCI: Setting latency timer of device 00:00.1 to 64
i810: Intel 440MX found at IO 0x1800 and 0x2000, IRQ 11
ac97_codec: AC97 Audio codec, id: 0x4352:0x5935 (Unknown)
i810_audio: setting clocking to 177230
CSLIP: code copyright 1989 Regents of the University of California
PPP generic driver version 2.4.1
Loading Lucent Modem Controller driver version 6.00
Detected Parameters Irq=11 BaseAddress=0x1880 ComAddress=0x0
Lucent Modem Interface driver version 6.00 (2001-01-26) with SHARE_IRQ enabled
ttyLT00 at 0x1880 (irq = 11) is a Lucent Modem
PPP BSD Compression module registered
PPP Deflate Compression module registered

--
Olivier Crete
Tester
tester@videotron.ca


