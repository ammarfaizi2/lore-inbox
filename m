Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266576AbSKOSKS>; Fri, 15 Nov 2002 13:10:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266601AbSKOSKS>; Fri, 15 Nov 2002 13:10:18 -0500
Received: from fed1mtao03.cox.net ([68.6.19.242]:8149 "EHLO fed1mtao03.cox.net")
	by vger.kernel.org with ESMTP id <S266576AbSKOSJ2>;
	Fri, 15 Nov 2002 13:09:28 -0500
Message-ID: <037901c28cd2$e2611830$0200a8c0@cirilium.com>
From: "Mark Hamblin" <MarkHamblin@cox.net>
To: <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0211141634060.12390-100000@penguin.transmeta.com>
Subject: Linux 2.5.47 -- Trouble booting Xwindows
Date: Fri, 15 Nov 2002 11:14:45 -0700
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0376_01C28C98.34100D20"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_0376_01C28C98.34100D20
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

I am trying to set up 2.5.47.  This is my first time building a kernel from
scratch, and I've managed to boot as far as runlevel 3.  However, when I
attempt to boot at runlevel 5, the screen goes black and I have to cycle
power.  I'm guessing I have something set wrong for my video card.  I have
included output from dmesg, lspci, and my config.  I would appreciate any
help.

Thank you.
Mark

------=_NextPart_000_0376_01C28C98.34100D20
Content-Type: text/plain;
	name="demsg.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="demsg.txt"

Linux version 2.4.18-3 (bhcompile@daffy.perf.redhat.com) (gcc version =
2.96 20000731 (Red Hat Linux 7.3 2.96-110)) #1 Thu Apr 18 07:37:53 EDT =
2002=0A=
BIOS-provided physical RAM map:=0A=
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)=0A=
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)=0A=
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)=0A=
 BIOS-e820: 0000000000100000 - 000000000fff0000 (usable)=0A=
 BIOS-e820: 000000000fff0000 - 000000000fff8000 (ACPI data)=0A=
 BIOS-e820: 000000000fff8000 - 0000000010000000 (ACPI NVS)=0A=
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)=0A=
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)=0A=
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)=0A=
On node 0 totalpages: 65520=0A=
zone(0): 4096 pages.=0A=
zone(1): 61424 pages.=0A=
zone(2): 0 pages.=0A=
Kernel command line: ro root=3D/dev/hde2=0A=
Initializing CPU#0=0A=
Detected 996.578 MHz processor.=0A=
Console: colour VGA+ 80x25=0A=
Calibrating delay loop... 1985.74 BogoMIPS=0A=
Memory: 255440k/262080k available (1119k kernel code, 6252k reserved, =
775k data, 280k init, 0k highmem)=0A=
Dentry cache hash table entries: 32768 (order: 6, 262144 bytes)=0A=
Inode cache hash table entries: 16384 (order: 5, 131072 bytes)=0A=
Mount-cache hash table entries: 4096 (order: 3, 32768 bytes)=0A=
Buffer cache hash table entries: 16384 (order: 4, 65536 bytes)=0A=
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)=0A=
CPU: Before vendor init, caps: 0383fbff 00000000 00000000, vendor =3D 0=0A=
CPU: L1 I cache: 16K, L1 D cache: 16K=0A=
CPU: L2 cache: 256K=0A=
CPU: After vendor init, caps: 0383fbff 00000000 00000000 00000000=0A=
Intel machine check architecture supported.=0A=
Intel machine check reporting enabled on CPU#0.=0A=
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000=0A=
CPU:             Common caps: 0383fbff 00000000 00000000 00000000=0A=
CPU: Intel Pentium III (Coppermine) stepping 0a=0A=
Enabling fast FPU save and restore... done.=0A=
Enabling unmasked SIMD FPU exception support... done.=0A=
Checking 'hlt' instruction... OK.=0A=
POSIX conformance testing by UNIFIX=0A=
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)=0A=
mtrr: detected mtrr type: Intel=0A=
PCI: PCI BIOS revision 2.10 entry at 0xfdb01, last bus=3D1=0A=
PCI: Using configuration type 1=0A=
PCI: Probing PCI hardware=0A=
PCI: Using IRQ router VIA [1106/0686] at 00:07.0=0A=
isapnp: Scanning for PnP cards...=0A=
isapnp: No Plug & Play device found=0A=
Linux NET4.0 for Linux 2.4=0A=
Based upon Swansea University Computer Society NET3.039=0A=
Initializing RT netlink socket=0A=
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16)=0A=
Starting kswapd=0A=
VFS: Diskquotas version dquot_6.5.0 initialized=0A=
pty: 2048 Unix98 ptys configured=0A=
Serial driver version 5.05c (2001-07-08) with MANY_PORTS MULTIPORT =
SHARE_IRQ SERIAL_PCI ISAPNP enabled=0A=
ttyS00 at 0x03f8 (irq =3D 4) is a 16550A=0A=
Real Time Clock Driver v1.10e=0A=
block: 496 slots per queue, batch=3D124=0A=
Uniform Multi-Platform E-IDE driver Revision: 6.31=0A=
ide: Assuming 33MHz system bus speed for PIO modes; override with =
idebus=3Dxx=0A=
VP_IDE: IDE controller on PCI bus 00 dev 39=0A=
VP_IDE: chipset revision 16=0A=
VP_IDE: not 100% native mode: will probe irqs later=0A=
ide: Assuming 33MHz system bus speed for PIO modes; override with =
idebus=3Dxx=0A=
VP_IDE: VIA vt82c686a (rev 22) IDE UDMA66 controller on pci00:07.1=0A=
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:pio, hdb:pio=0A=
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:pio=0A=
PDC20265: IDE controller on PCI bus 00 dev 80=0A=
PCI: Found IRQ 11 for device 00:10.0=0A=
PDC20265: chipset revision 2=0A=
ide: Found promise 20265 in RAID mode.=0A=
PDC20265: not 100% native mode: will probe irqs later=0A=
PDC20265: ROM enabled at 0xdffc0000=0A=
PDC20265: (U)DMA Burst Bit ENABLED Primary MASTER Mode Secondary MASTER =
Mode.=0A=
    ide2: BM-DMA at 0xcc00-0xcc07, BIOS settings: hde:pio, hdf:pio=0A=
    ide3: BM-DMA at 0xcc08-0xcc0f, BIOS settings: hdg:DMA, hdh:pio=0A=
hdc: SR243T, ATAPI CD/DVD-ROM drive=0A=
hde: WDC WD400BB-32BSA0, ATA DISK drive=0A=
ide1 at 0x170-0x177,0x376 on irq 15=0A=
ide2 at 0xdc00-0xdc07,0xd802 on irq 11=0A=
blk: queue c035ed6c, I/O limit 4095Mb (mask 0xffffffff)=0A=
hde: 78165360 sectors (40021 MB) w/2048KiB Cache, CHS=3D77545/16/63, =
UDMA(100)=0A=
ide-floppy driver 0.99.newide=0A=
Partition check:=0A=
 hde: hde1 hde2 hde3=0A=
Floppy drive(s): fd0 is 1.44M=0A=
FDC 0 is a post-1991 82077=0A=
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize=0A=
ide-floppy driver 0.99.newide=0A=
md: md driver 0.90.0 MAX_MD_DEVS=3D256, MD_SB_DISKS=3D27=0A=
md: Autodetecting RAID arrays.=0A=
md: autorun ...=0A=
md: ... autorun DONE.=0A=
NET4: Linux TCP/IP 1.0 for NET4.0=0A=
IP Protocols: ICMP, UDP, TCP, IGMP=0A=
IP: routing cache hash table of 2048 buckets, 16Kbytes=0A=
TCP: Hash tables configured (established 16384 bind 16384)=0A=
Linux IP multicast router 0.06 plus PIM-SM=0A=
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.=0A=
RAMDISK: Compressed image found at block 0=0A=
Freeing initrd memory: 122k freed=0A=
VFS: Mounted root (ext2 filesystem).=0A=
Journalled Block Device driver loaded=0A=
kjournald starting.  Commit interval 5 seconds=0A=
EXT3-fs: mounted filesystem with ordered data mode.=0A=
Freeing unused kernel memory: 280k freed=0A=
Adding Swap: 524152k swap-space (priority -1)=0A=
usb.c: registered new driver usbdevfs=0A=
usb.c: registered new driver hub=0A=
usb-uhci.c: $Revision: 1.275 $ time 07:43:07 Apr 18 2002=0A=
usb-uhci.c: High bandwidth mode enabled=0A=
PCI: Found IRQ 5 for device 00:07.3=0A=
PCI: Sharing IRQ 5 with 00:07.2=0A=
PCI: Sharing IRQ 5 with 00:0f.0=0A=
usb-uhci.c: USB UHCI at I/O 0xc000, IRQ 5=0A=
usb-uhci.c: Detected 2 ports=0A=
usb.c: new USB bus registered, assigned bus number 1=0A=
hub.c: USB hub found=0A=
hub.c: 2 ports detected=0A=
PCI: Found IRQ 5 for device 00:07.2=0A=
PCI: Sharing IRQ 5 with 00:07.3=0A=
PCI: Sharing IRQ 5 with 00:0f.0=0A=
usb-uhci.c: USB UHCI at I/O 0xbc00, IRQ 5=0A=
usb-uhci.c: Detected 2 ports=0A=
usb.c: new USB bus registered, assigned bus number 2=0A=
hub.c: USB hub found=0A=
hub.c: 2 ports detected=0A=
usb-uhci.c: v1.275:USB Universal Host Controller Interface driver=0A=
EXT3 FS 2.4-0.9.17, 10 Jan 2002 on ide2(33,2), internal journal=0A=
kjournald starting.  Commit interval 5 seconds=0A=
EXT3 FS 2.4-0.9.17, 10 Jan 2002 on ide2(33,1), internal journal=0A=
EXT3-fs: mounted filesystem with ordered data mode.=0A=
ide-floppy driver 0.99.newide=0A=
hdc: ATAPI 24X CD-ROM drive, 128kB Cache, UDMA(33)=0A=
Uniform CD-ROM driver Revision: 3.12=0A=
hdc: DMA disabled=0A=
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]=0A=
parport_pc: Via 686A parallel port: io=3D0x378=0A=
eepro100.c:v1.09j-t 9/29/99 Donald Becker =
http://www.scyld.com/network/eepro100.html=0A=
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin =
<saw@saw.sw.com.sg> and others=0A=
PCI: Found IRQ 5 for device 00:0f.0=0A=
PCI: Sharing IRQ 5 with 00:07.3=0A=
PCI: Sharing IRQ 5 with 00:07.2=0A=
eth0: OEM i82557/i82558 10/100 Ethernet, 00:20:ED:06:9B:B7, IRQ 5.=0A=
  Board assembly 727095-004, Physical connectors present: RJ45=0A=
  Primary interface chip i82555 PHY #1.=0A=
  General self-test: passed.=0A=
  Serial sub-system self-test: passed.=0A=
  Internal registers self-test: passed.=0A=
  ROM checksum self-test: passed (0x04f4518b).=0A=
PCI: Found IRQ 3 for device 00:0e.0=0A=
eth1: OEM i82557/i82558 10/100 Ethernet, 00:20:ED:06:9B:B6, IRQ 3.=0A=
  Board assembly 727095-004, Physical connectors present: RJ45=0A=
  Primary interface chip i82555 PHY #1.=0A=
  General self-test: passed.=0A=
  Serial sub-system self-test: passed.=0A=
  Internal registers self-test: passed.=0A=
  ROM checksum self-test: passed (0x04f4518b).=0A=

------=_NextPart_000_0376_01C28C98.34100D20
Content-Type: text/plain;
	name="lspci.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="lspci.txt"

00:00.0 Host bridge: VIA Technologies, Inc. VT82C693A/694x [Apollo =
PRO133x] (rev c4)=0A=
00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo =
MVP3/Pro133x AGP]=0A=
00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] =
(rev 22)=0A=
00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 10)=0A=
00:07.2 USB Controller: VIA Technologies, Inc. USB (rev 10)=0A=
00:07.3 USB Controller: VIA Technologies, Inc. USB (rev 10)=0A=
00:07.4 SMBus: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev =
30)=0A=
00:0e.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] =
(rev 08)=0A=
00:0f.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] =
(rev 08)=0A=
00:10.0 RAID bus controller: Promise Technology, Inc. 20265 (rev 02)=0A=
01:00.0 VGA compatible controller: ATI Technologies Inc Rage XL AGP 2X =
(rev 27)=0A=

------=_NextPart_000_0376_01C28C98.34100D20
Content-Type: application/octet-stream;
	name=".config"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename=".config"

#=0A=
# Automatically generated make config: don't edit=0A=
#=0A=
CONFIG_X86=3Dy=0A=
CONFIG_MMU=3Dy=0A=
CONFIG_SWAP=3Dy=0A=
CONFIG_UID16=3Dy=0A=
CONFIG_GENERIC_ISA_DMA=3Dy=0A=
=0A=
#=0A=
# Code maturity level options=0A=
#=0A=
# CONFIG_EXPERIMENTAL is not set=0A=
=0A=
#=0A=
# General setup=0A=
#=0A=
CONFIG_NET=3Dy=0A=
CONFIG_SYSVIPC=3Dy=0A=
CONFIG_BSD_PROCESS_ACCT=3Dy=0A=
CONFIG_SYSCTL=3Dy=0A=
=0A=
#=0A=
# Loadable module support=0A=
#=0A=
CONFIG_MODULES=3Dy=0A=
CONFIG_MODVERSIONS=3Dy=0A=
CONFIG_KMOD=3Dy=0A=
=0A=
#=0A=
# Processor type and features=0A=
#=0A=
# CONFIG_M386 is not set=0A=
# CONFIG_M486 is not set=0A=
# CONFIG_M586 is not set=0A=
# CONFIG_M586TSC is not set=0A=
# CONFIG_M586MMX is not set=0A=
CONFIG_M686=3Dy=0A=
# CONFIG_MPENTIUMIII is not set=0A=
# CONFIG_MPENTIUM4 is not set=0A=
# CONFIG_MK6 is not set=0A=
# CONFIG_MK7 is not set=0A=
# CONFIG_MELAN is not set=0A=
# CONFIG_MCRUSOE is not set=0A=
# CONFIG_MWINCHIPC6 is not set=0A=
# CONFIG_MWINCHIP2 is not set=0A=
# CONFIG_MWINCHIP3D is not set=0A=
# CONFIG_MCYRIXIII is not set=0A=
CONFIG_X86_CMPXCHG=3Dy=0A=
CONFIG_X86_XADD=3Dy=0A=
CONFIG_X86_L1_CACHE_SHIFT=3D5=0A=
CONFIG_RWSEM_XCHGADD_ALGORITHM=3Dy=0A=
CONFIG_X86_PPRO_FENCE=3Dy=0A=
CONFIG_X86_WP_WORKS_OK=3Dy=0A=
CONFIG_X86_INVLPG=3Dy=0A=
CONFIG_X86_BSWAP=3Dy=0A=
CONFIG_X86_POPAD_OK=3Dy=0A=
CONFIG_X86_TSC=3Dy=0A=
CONFIG_X86_GOOD_APIC=3Dy=0A=
CONFIG_X86_USE_PPRO_CHECKSUM=3Dy=0A=
# CONFIG_HUGETLB_PAGE is not set=0A=
# CONFIG_SMP is not set=0A=
# CONFIG_PREEMPT is not set=0A=
# CONFIG_X86_UP_APIC is not set=0A=
CONFIG_X86_MCE=3Dy=0A=
# CONFIG_X86_MCE_NONFATAL is not set=0A=
# CONFIG_CPU_FREQ is not set=0A=
CONFIG_TOSHIBA=3Dm=0A=
CONFIG_I8K=3Dm=0A=
CONFIG_MICROCODE=3Dm=0A=
CONFIG_X86_MSR=3Dm=0A=
CONFIG_X86_CPUID=3Dm=0A=
# CONFIG_NOHIGHMEM is not set=0A=
CONFIG_HIGHMEM4G=3Dy=0A=
# CONFIG_HIGHMEM64G is not set=0A=
CONFIG_HIGHMEM=3Dy=0A=
# CONFIG_HIGHPTE is not set=0A=
# CONFIG_MATH_EMULATION is not set=0A=
CONFIG_MTRR=3Dy=0A=
=0A=
#=0A=
# Power management options (ACPI, APM)=0A=
#=0A=
=0A=
#=0A=
# ACPI Support=0A=
#=0A=
# CONFIG_ACPI is not set=0A=
# CONFIG_PM is not set=0A=
=0A=
#=0A=
# Bus options (PCI, PCMCIA, EISA, MCA, ISA)=0A=
#=0A=
CONFIG_PCI=3Dy=0A=
# CONFIG_PCI_GOBIOS is not set=0A=
# CONFIG_PCI_GODIRECT is not set=0A=
CONFIG_PCI_GOANY=3Dy=0A=
CONFIG_PCI_BIOS=3Dy=0A=
CONFIG_PCI_DIRECT=3Dy=0A=
# CONFIG_SCx200 is not set=0A=
CONFIG_PCI_NAMES=3Dy=0A=
CONFIG_ISA=3Dy=0A=
CONFIG_EISA=3Dy=0A=
# CONFIG_MCA is not set=0A=
CONFIG_HOTPLUG=3Dy=0A=
=0A=
#=0A=
# PCMCIA/CardBus support=0A=
#=0A=
CONFIG_PCMCIA=3Dm=0A=
CONFIG_CARDBUS=3Dy=0A=
CONFIG_I82092=3Dm=0A=
CONFIG_I82365=3Dm=0A=
CONFIG_TCIC=3Dm=0A=
=0A=
#=0A=
# PCI Hotplug Support=0A=
#=0A=
=0A=
#=0A=
# Executable file formats=0A=
#=0A=
CONFIG_KCORE_ELF=3Dy=0A=
# CONFIG_KCORE_AOUT is not set=0A=
# CONFIG_BINFMT_AOUT is not set=0A=
CONFIG_BINFMT_ELF=3Dy=0A=
CONFIG_BINFMT_MISC=3Dm=0A=
=0A=
#=0A=
# Memory Technology Devices (MTD)=0A=
#=0A=
# CONFIG_MTD is not set=0A=
=0A=
#=0A=
# Parallel port support=0A=
#=0A=
CONFIG_PARPORT=3Dm=0A=
CONFIG_PARPORT_PC=3Dm=0A=
CONFIG_PARPORT_PC_PCMCIA=3Dm=0A=
# CONFIG_PARPORT_OTHER is not set=0A=
CONFIG_PARPORT_1284=3Dy=0A=
=0A=
#=0A=
# Plug and Play configuration=0A=
#=0A=
CONFIG_PNP=3Dy=0A=
# CONFIG_PNP_NAMES is not set=0A=
# CONFIG_PNP_DEBUG is not set=0A=
=0A=
#=0A=
# Protocols=0A=
#=0A=
=0A=
#=0A=
# Block devices=0A=
#=0A=
CONFIG_BLK_DEV_FD=3Dy=0A=
# CONFIG_BLK_DEV_XD is not set=0A=
# CONFIG_PARIDE is not set=0A=
# CONFIG_BLK_CPQ_DA is not set=0A=
# CONFIG_BLK_CPQ_CISS_DA is not set=0A=
# CONFIG_BLK_DEV_DAC960 is not set=0A=
CONFIG_BLK_DEV_LOOP=3Dm=0A=
CONFIG_BLK_DEV_NBD=3Dm=0A=
CONFIG_BLK_DEV_RAM=3Dy=0A=
CONFIG_BLK_DEV_RAM_SIZE=3D4096=0A=
CONFIG_BLK_DEV_INITRD=3Dy=0A=
# CONFIG_LBD is not set=0A=
=0A=
#=0A=
# ATA/ATAPI/MFM/RLL device support=0A=
#=0A=
CONFIG_IDE=3Dy=0A=
=0A=
#=0A=
# IDE, ATA and ATAPI Block devices=0A=
#=0A=
CONFIG_BLK_DEV_IDE=3Dy=0A=
=0A=
#=0A=
# Please see Documentation/ide.txt for help/info on IDE drives=0A=
#=0A=
# CONFIG_BLK_DEV_HD_IDE is not set=0A=
# CONFIG_BLK_DEV_HD is not set=0A=
CONFIG_BLK_DEV_IDEDISK=3Dy=0A=
CONFIG_IDEDISK_MULTI_MODE=3Dy=0A=
# CONFIG_IDEDISK_STROKE is not set=0A=
CONFIG_BLK_DEV_IDECS=3Dm=0A=
CONFIG_BLK_DEV_IDECD=3Dm=0A=
CONFIG_BLK_DEV_IDEFLOPPY=3Dy=0A=
CONFIG_BLK_DEV_IDESCSI=3Dm=0A=
# CONFIG_IDE_TASK_IOCTL is not set=0A=
=0A=
#=0A=
# IDE chipset support/bugfixes=0A=
#=0A=
CONFIG_BLK_DEV_CMD640=3Dy=0A=
# CONFIG_BLK_DEV_CMD640_ENHANCED is not set=0A=
CONFIG_BLK_DEV_IDEPCI=3Dy=0A=
# CONFIG_BLK_DEV_GENERIC is not set=0A=
CONFIG_IDEPCI_SHARE_IRQ=3Dy=0A=
CONFIG_BLK_DEV_IDEDMA_PCI=3Dy=0A=
# CONFIG_BLK_DEV_OFFBOARD is not set=0A=
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set=0A=
CONFIG_IDEDMA_PCI_AUTO=3Dy=0A=
# CONFIG_IDEDMA_ONLYDISK is not set=0A=
CONFIG_BLK_DEV_IDEDMA=3Dy=0A=
CONFIG_BLK_DEV_ADMA=3Dy=0A=
CONFIG_BLK_DEV_AEC62XX=3Dy=0A=
CONFIG_BLK_DEV_ALI15X3=3Dy=0A=
# CONFIG_WDC_ALI15X3 is not set=0A=
CONFIG_BLK_DEV_AMD74XX=3Dy=0A=
# CONFIG_AMD74XX_OVERRIDE is not set=0A=
CONFIG_BLK_DEV_CMD64X=3Dy=0A=
CONFIG_BLK_DEV_CY82C693=3Dy=0A=
CONFIG_BLK_DEV_CS5530=3Dy=0A=
CONFIG_BLK_DEV_HPT34X=3Dy=0A=
CONFIG_BLK_DEV_HPT366=3Dy=0A=
CONFIG_BLK_DEV_PIIX=3Dy=0A=
# CONFIG_BLK_DEV_NFORCE is not set=0A=
# CONFIG_BLK_DEV_NS87415 is not set=0A=
CONFIG_BLK_DEV_PDC202XX_OLD=3Dy=0A=
# CONFIG_BLK_DEV_PDC202XX_NEW is not set=0A=
CONFIG_BLK_DEV_RZ1000=3Dy=0A=
CONFIG_BLK_DEV_SVWKS=3Dy=0A=
# CONFIG_BLK_DEV_SIIMAGE is not set=0A=
CONFIG_BLK_DEV_SIS5513=3Dy=0A=
CONFIG_BLK_DEV_SLC90E66=3Dy=0A=
# CONFIG_BLK_DEV_TRM290 is not set=0A=
CONFIG_BLK_DEV_VIA82CXXX=3Dy=0A=
# CONFIG_IDE_CHIPSETS is not set=0A=
CONFIG_IDEDMA_AUTO=3Dy=0A=
# CONFIG_IDEDMA_IVB is not set=0A=
CONFIG_BLK_DEV_PDC202XX=3Dy=0A=
CONFIG_BLK_DEV_IDE_MODES=3Dy=0A=
=0A=
#=0A=
# SCSI device support=0A=
#=0A=
CONFIG_SCSI=3Dm=0A=
=0A=
#=0A=
# SCSI support type (disk, tape, CD-ROM)=0A=
#=0A=
CONFIG_BLK_DEV_SD=3Dm=0A=
CONFIG_CHR_DEV_ST=3Dm=0A=
CONFIG_CHR_DEV_OSST=3Dm=0A=
CONFIG_BLK_DEV_SR=3Dm=0A=
CONFIG_BLK_DEV_SR_VENDOR=3Dy=0A=
CONFIG_CHR_DEV_SG=3Dm=0A=
=0A=
#=0A=
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs=0A=
#=0A=
# CONFIG_SCSI_MULTI_LUN is not set=0A=
# CONFIG_SCSI_REPORT_LUNS is not set=0A=
CONFIG_SCSI_CONSTANTS=3Dy=0A=
CONFIG_SCSI_LOGGING=3Dy=0A=
=0A=
#=0A=
# SCSI low-level drivers=0A=
#=0A=
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set=0A=
# CONFIG_SCSI_7000FASST is not set=0A=
# CONFIG_SCSI_ACARD is not set=0A=
# CONFIG_SCSI_AHA152X is not set=0A=
# CONFIG_SCSI_AHA1542 is not set=0A=
# CONFIG_SCSI_AHA1740 is not set=0A=
# CONFIG_SCSI_AIC7XXX is not set=0A=
# CONFIG_SCSI_AIC7XXX_OLD is not set=0A=
# CONFIG_SCSI_DPT_I2O is not set=0A=
# CONFIG_SCSI_ADVANSYS is not set=0A=
# CONFIG_SCSI_IN2000 is not set=0A=
# CONFIG_SCSI_AM53C974 is not set=0A=
# CONFIG_SCSI_MEGARAID is not set=0A=
# CONFIG_SCSI_BUSLOGIC is not set=0A=
# CONFIG_SCSI_CPQFCTS is not set=0A=
# CONFIG_SCSI_DMX3191D is not set=0A=
# CONFIG_SCSI_DTC3280 is not set=0A=
# CONFIG_SCSI_EATA is not set=0A=
# CONFIG_SCSI_EATA_DMA is not set=0A=
# CONFIG_SCSI_EATA_PIO is not set=0A=
# CONFIG_SCSI_FUTURE_DOMAIN is not set=0A=
# CONFIG_SCSI_GDTH is not set=0A=
# CONFIG_SCSI_GENERIC_NCR5380 is not set=0A=
# CONFIG_SCSI_GENERIC_NCR5380_MMIO is not set=0A=
# CONFIG_SCSI_IPS is not set=0A=
# CONFIG_SCSI_INITIO is not set=0A=
# CONFIG_SCSI_INIA100 is not set=0A=
# CONFIG_SCSI_PPA is not set=0A=
# CONFIG_SCSI_IMM is not set=0A=
# CONFIG_SCSI_NCR53C406A is not set=0A=
# CONFIG_SCSI_NCR53C7xx is not set=0A=
# CONFIG_SCSI_SYM53C8XX_2 is not set=0A=
# CONFIG_SCSI_NCR53C8XX is not set=0A=
# CONFIG_SCSI_SYM53C8XX is not set=0A=
# CONFIG_SCSI_PAS16 is not set=0A=
# CONFIG_SCSI_PCI2000 is not set=0A=
# CONFIG_SCSI_PCI2220I is not set=0A=
# CONFIG_SCSI_PSI240I is not set=0A=
# CONFIG_SCSI_QLOGIC_FAS is not set=0A=
# CONFIG_SCSI_QLOGIC_ISP is not set=0A=
# CONFIG_SCSI_QLOGIC_FC is not set=0A=
# CONFIG_SCSI_QLOGIC_1280 is not set=0A=
# CONFIG_SCSI_SEAGATE is not set=0A=
# CONFIG_SCSI_SIM710 is not set=0A=
# CONFIG_SCSI_SYM53C416 is not set=0A=
# CONFIG_SCSI_DC390T is not set=0A=
# CONFIG_SCSI_T128 is not set=0A=
# CONFIG_SCSI_U14_34F is not set=0A=
# CONFIG_SCSI_ULTRASTOR is not set=0A=
# CONFIG_SCSI_NSP32 is not set=0A=
=0A=
#=0A=
# PCMCIA SCSI adapter support=0A=
#=0A=
# CONFIG_SCSI_PCMCIA is not set=0A=
=0A=
#=0A=
# Old CD-ROM drivers (not SCSI, not IDE)=0A=
#=0A=
# CONFIG_CD_NO_IDESCSI is not set=0A=
=0A=
#=0A=
# Multi-device support (RAID and LVM)=0A=
#=0A=
CONFIG_MD=3Dy=0A=
CONFIG_BLK_DEV_MD=3Dy=0A=
CONFIG_MD_LINEAR=3Dm=0A=
CONFIG_MD_RAID0=3Dm=0A=
CONFIG_MD_RAID1=3Dm=0A=
CONFIG_MD_RAID5=3Dm=0A=
CONFIG_MD_MULTIPATH=3Dm=0A=
# CONFIG_BLK_DEV_DM is not set=0A=
=0A=
#=0A=
# Fusion MPT device support=0A=
#=0A=
# CONFIG_FUSION is not set=0A=
=0A=
#=0A=
# I2O device support=0A=
#=0A=
# CONFIG_I2O is not set=0A=
=0A=
#=0A=
# Networking options=0A=
#=0A=
CONFIG_PACKET=3Dy=0A=
CONFIG_PACKET_MMAP=3Dy=0A=
CONFIG_NETLINK_DEV=3Dy=0A=
# CONFIG_NETFILTER is not set=0A=
CONFIG_FILTER=3Dy=0A=
CONFIG_UNIX=3Dy=0A=
# CONFIG_NET_KEY is not set=0A=
CONFIG_INET=3Dy=0A=
CONFIG_IP_MULTICAST=3Dy=0A=
CONFIG_IP_ADVANCED_ROUTER=3Dy=0A=
CONFIG_IP_MULTIPLE_TABLES=3Dy=0A=
CONFIG_IP_ROUTE_NAT=3Dy=0A=
CONFIG_IP_ROUTE_MULTIPATH=3Dy=0A=
CONFIG_IP_ROUTE_TOS=3Dy=0A=
CONFIG_IP_ROUTE_VERBOSE=3Dy=0A=
CONFIG_IP_ROUTE_LARGE_TABLES=3Dy=0A=
# CONFIG_IP_PNP is not set=0A=
CONFIG_NET_IPIP=3Dm=0A=
CONFIG_NET_IPGRE=3Dm=0A=
CONFIG_NET_IPGRE_BROADCAST=3Dy=0A=
CONFIG_IP_MROUTE=3Dy=0A=
CONFIG_IP_PIMSM_V1=3Dy=0A=
CONFIG_IP_PIMSM_V2=3Dy=0A=
# CONFIG_INET_ECN is not set=0A=
CONFIG_SYN_COOKIES=3Dy=0A=
# CONFIG_INET_AH is not set=0A=
# CONFIG_INET_ESP is not set=0A=
CONFIG_VLAN_8021Q=3Dm=0A=
# CONFIG_LLC is not set=0A=
CONFIG_DECNET=3Dm=0A=
CONFIG_DECNET_SIOCGIFCONF=3Dy=0A=
# CONFIG_BRIDGE is not set=0A=
=0A=
#=0A=
# QoS and/or fair queueing=0A=
#=0A=
CONFIG_NET_SCHED=3Dy=0A=
CONFIG_NET_SCH_CBQ=3Dm=0A=
# CONFIG_NET_SCH_HTB is not set=0A=
CONFIG_NET_SCH_CSZ=3Dm=0A=
CONFIG_NET_SCH_PRIO=3Dm=0A=
CONFIG_NET_SCH_RED=3Dm=0A=
CONFIG_NET_SCH_SFQ=3Dm=0A=
CONFIG_NET_SCH_TEQL=3Dm=0A=
CONFIG_NET_SCH_TBF=3Dm=0A=
CONFIG_NET_SCH_GRED=3Dm=0A=
CONFIG_NET_SCH_DSMARK=3Dm=0A=
CONFIG_NET_QOS=3Dy=0A=
CONFIG_NET_ESTIMATOR=3Dy=0A=
CONFIG_NET_CLS=3Dy=0A=
CONFIG_NET_CLS_TCINDEX=3Dm=0A=
CONFIG_NET_CLS_ROUTE4=3Dm=0A=
CONFIG_NET_CLS_ROUTE=3Dy=0A=
CONFIG_NET_CLS_FW=3Dm=0A=
CONFIG_NET_CLS_U32=3Dm=0A=
CONFIG_NET_CLS_RSVP=3Dm=0A=
CONFIG_NET_CLS_RSVP6=3Dm=0A=
CONFIG_NET_CLS_POLICE=3Dy=0A=
=0A=
#=0A=
# Network testing=0A=
#=0A=
# CONFIG_NET_PKTGEN is not set=0A=
=0A=
#=0A=
# Network device support=0A=
#=0A=
CONFIG_NETDEVICES=3Dy=0A=
=0A=
#=0A=
# ARCnet devices=0A=
#=0A=
# CONFIG_ARCNET is not set=0A=
CONFIG_DUMMY=3Dm=0A=
CONFIG_BONDING=3Dm=0A=
CONFIG_EQUALIZER=3Dm=0A=
CONFIG_TUN=3Dm=0A=
=0A=
#=0A=
# Ethernet (10 or 100Mbit)=0A=
#=0A=
CONFIG_NET_ETHERNET=3Dy=0A=
CONFIG_HAPPYMEAL=3Dm=0A=
CONFIG_SUNGEM=3Dm=0A=
CONFIG_NET_VENDOR_3COM=3Dy=0A=
CONFIG_EL1=3Dm=0A=
CONFIG_EL2=3Dm=0A=
CONFIG_ELPLUS=3Dm=0A=
CONFIG_EL3=3Dm=0A=
CONFIG_3C515=3Dm=0A=
CONFIG_VORTEX=3Dm=0A=
CONFIG_LANCE=3Dm=0A=
CONFIG_NET_VENDOR_SMC=3Dy=0A=
CONFIG_WD80x3=3Dm=0A=
CONFIG_ULTRA=3Dm=0A=
CONFIG_ULTRA32=3Dm=0A=
CONFIG_SMC9194=3Dm=0A=
CONFIG_NET_VENDOR_RACAL=3Dy=0A=
CONFIG_NI52=3Dm=0A=
CONFIG_NI65=3Dm=0A=
=0A=
#=0A=
# Tulip family network device support=0A=
#=0A=
# CONFIG_NET_TULIP is not set=0A=
CONFIG_DEPCA=3Dm=0A=
CONFIG_HP100=3Dm=0A=
CONFIG_NET_ISA=3Dy=0A=
CONFIG_E2100=3Dm=0A=
CONFIG_EWRK3=3Dm=0A=
CONFIG_EEXPRESS=3Dm=0A=
CONFIG_EEXPRESS_PRO=3Dm=0A=
CONFIG_HPLAN_PLUS=3Dm=0A=
CONFIG_HPLAN=3Dm=0A=
CONFIG_LP486E=3Dm=0A=
CONFIG_ETH16I=3Dm=0A=
CONFIG_NE2000=3Dm=0A=
CONFIG_NET_PCI=3Dy=0A=
CONFIG_PCNET32=3Dm=0A=
CONFIG_ADAPTEC_STARFIRE=3Dm=0A=
CONFIG_APRICOT=3Dm=0A=
CONFIG_CS89x0=3Dm=0A=
CONFIG_DGRS=3Dm=0A=
CONFIG_EEPRO100=3Dm=0A=
# CONFIG_E100 is not set=0A=
# CONFIG_FEALNX is not set=0A=
CONFIG_NATSEMI=3Dm=0A=
CONFIG_NE2K_PCI=3Dm=0A=
CONFIG_8139TOO=3Dm=0A=
# CONFIG_8139TOO_PIO is not set=0A=
# CONFIG_8139TOO_TUNE_TWISTER is not set=0A=
CONFIG_8139TOO_8129=3Dy=0A=
# CONFIG_8139_OLD_RX_RESET is not set=0A=
CONFIG_SIS900=3Dm=0A=
CONFIG_EPIC100=3Dm=0A=
CONFIG_SUNDANCE=3Dm=0A=
# CONFIG_SUNDANCE_MMIO is not set=0A=
CONFIG_TLAN=3Dm=0A=
CONFIG_VIA_RHINE=3Dm=0A=
CONFIG_NET_POCKET=3Dy=0A=
CONFIG_ATP=3Dm=0A=
CONFIG_DE600=3Dm=0A=
CONFIG_DE620=3Dm=0A=
=0A=
#=0A=
# Ethernet (1000 Mbit)=0A=
#=0A=
# CONFIG_ACENIC is not set=0A=
# CONFIG_DL2K is not set=0A=
# CONFIG_E1000 is not set=0A=
# CONFIG_NS83820 is not set=0A=
# CONFIG_HAMACHI is not set=0A=
# CONFIG_SK98LIN is not set=0A=
# CONFIG_TIGON3 is not set=0A=
# CONFIG_FDDI is not set=0A=
CONFIG_PLIP=3Dm=0A=
CONFIG_PPP=3Dm=0A=
CONFIG_PPP_FILTER=3Dy=0A=
CONFIG_PPP_ASYNC=3Dm=0A=
CONFIG_PPP_SYNC_TTY=3Dm=0A=
CONFIG_PPP_DEFLATE=3Dm=0A=
# CONFIG_PPP_BSDCOMP is not set=0A=
CONFIG_SLIP=3Dm=0A=
CONFIG_SLIP_COMPRESSED=3Dy=0A=
CONFIG_SLIP_SMART=3Dy=0A=
CONFIG_SLIP_MODE_SLIP6=3Dy=0A=
=0A=
#=0A=
# Wireless LAN (non-hamradio)=0A=
#=0A=
# CONFIG_NET_RADIO is not set=0A=
=0A=
#=0A=
# Token Ring devices=0A=
#=0A=
# CONFIG_TR is not set=0A=
# CONFIG_NET_FC is not set=0A=
=0A=
#=0A=
# Wan interfaces=0A=
#=0A=
# CONFIG_WAN is not set=0A=
=0A=
#=0A=
# PCMCIA network device support=0A=
#=0A=
# CONFIG_NET_PCMCIA is not set=0A=
=0A=
#=0A=
# Amateur Radio support=0A=
#=0A=
# CONFIG_HAMRADIO is not set=0A=
=0A=
#=0A=
# IrDA (infrared) support=0A=
#=0A=
CONFIG_IRDA=3Dm=0A=
=0A=
#=0A=
# IrDA protocols=0A=
#=0A=
CONFIG_IRLAN=3Dm=0A=
CONFIG_IRNET=3Dm=0A=
CONFIG_IRCOMM=3Dm=0A=
CONFIG_IRDA_ULTRA=3Dy=0A=
=0A=
#=0A=
# IrDA options=0A=
#=0A=
CONFIG_IRDA_CACHE_LAST_LSAP=3Dy=0A=
CONFIG_IRDA_FAST_RR=3Dy=0A=
# CONFIG_IRDA_DEBUG is not set=0A=
=0A=
#=0A=
# Infrared-port device drivers=0A=
#=0A=
=0A=
#=0A=
# SIR device drivers=0A=
#=0A=
CONFIG_IRTTY_SIR=3Dm=0A=
=0A=
#=0A=
# Dongle support=0A=
#=0A=
CONFIG_DONGLE=3Dy=0A=
CONFIG_ESI_DONGLE=3Dm=0A=
CONFIG_ACTISYS_DONGLE=3Dm=0A=
CONFIG_TEKRAM_DONGLE=3Dm=0A=
=0A=
#=0A=
# Old SIR device drivers=0A=
#=0A=
# CONFIG_IRTTY_OLD is not set=0A=
CONFIG_IRPORT_SIR=3Dm=0A=
=0A=
#=0A=
# Old Serial dongle support=0A=
#=0A=
# CONFIG_DONGLE_OLD is not set=0A=
=0A=
#=0A=
# FIR device drivers=0A=
#=0A=
CONFIG_NSC_FIR=3Dm=0A=
CONFIG_WINBOND_FIR=3Dm=0A=
# CONFIG_TOSHIBA_OLD is not set=0A=
CONFIG_TOSHIBA_FIR=3Dm=0A=
=0A=
#=0A=
# ISDN subsystem=0A=
#=0A=
# CONFIG_ISDN_BOOL is not set=0A=
=0A=
#=0A=
# Telephony Support=0A=
#=0A=
CONFIG_PHONE=3Dm=0A=
CONFIG_PHONE_IXJ=3Dm=0A=
CONFIG_PHONE_IXJ_PCMCIA=3Dm=0A=
=0A=
#=0A=
# Input device support=0A=
#=0A=
CONFIG_INPUT=3Dy=0A=
=0A=
#=0A=
# Userland interfaces=0A=
#=0A=
CONFIG_INPUT_MOUSEDEV=3Dm=0A=
# CONFIG_INPUT_MOUSEDEV_PSAUX is not set=0A=
CONFIG_INPUT_MOUSEDEV_SCREEN_X=3D1024=0A=
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=3D768=0A=
CONFIG_INPUT_JOYDEV=3Dm=0A=
# CONFIG_INPUT_TSDEV is not set=0A=
CONFIG_INPUT_EVDEV=3Dm=0A=
# CONFIG_INPUT_EVBUG is not set=0A=
=0A=
#=0A=
# Input I/O drivers=0A=
#=0A=
# CONFIG_GAMEPORT is not set=0A=
CONFIG_SOUND_GAMEPORT=3Dy=0A=
CONFIG_SERIO=3Dy=0A=
CONFIG_SERIO_I8042=3Dy=0A=
# CONFIG_SERIO_SERPORT is not set=0A=
# CONFIG_SERIO_CT82C710 is not set=0A=
# CONFIG_SERIO_PARKBD is not set=0A=
=0A=
#=0A=
# Input Device Drivers=0A=
#=0A=
CONFIG_INPUT_KEYBOARD=3Dy=0A=
CONFIG_KEYBOARD_ATKBD=3Dy=0A=
# CONFIG_KEYBOARD_SUNKBD is not set=0A=
# CONFIG_KEYBOARD_XTKBD is not set=0A=
# CONFIG_KEYBOARD_NEWTON is not set=0A=
# CONFIG_INPUT_MOUSE is not set=0A=
# CONFIG_INPUT_JOYSTICK is not set=0A=
# CONFIG_INPUT_TOUCHSCREEN is not set=0A=
# CONFIG_INPUT_MISC is not set=0A=
=0A=
#=0A=
# Character devices=0A=
#=0A=
CONFIG_VT=3Dy=0A=
CONFIG_VT_CONSOLE=3Dy=0A=
CONFIG_HW_CONSOLE=3Dy=0A=
# CONFIG_SERIAL_NONSTANDARD is not set=0A=
=0A=
#=0A=
# Serial drivers=0A=
#=0A=
=0A=
#=0A=
# Non-8250 serial port support=0A=
#=0A=
CONFIG_UNIX98_PTYS=3Dy=0A=
CONFIG_UNIX98_PTY_COUNT=3D2048=0A=
CONFIG_PRINTER=3Dm=0A=
CONFIG_LP_CONSOLE=3Dy=0A=
CONFIG_PPDEV=3Dm=0A=
# CONFIG_TIPAR is not set=0A=
=0A=
#=0A=
# I2C support=0A=
#=0A=
# CONFIG_I2C is not set=0A=
=0A=
#=0A=
# Mice=0A=
#=0A=
CONFIG_BUSMOUSE=3Dm=0A=
# CONFIG_QIC02_TAPE is not set=0A=
=0A=
#=0A=
# Watchdog Cards=0A=
#=0A=
CONFIG_WATCHDOG=3Dy=0A=
# CONFIG_WATCHDOG_NOWAYOUT is not set=0A=
CONFIG_SOFT_WATCHDOG=3Dm=0A=
CONFIG_WDT=3Dm=0A=
CONFIG_WDTPCI=3Dm=0A=
# CONFIG_WDT_501 is not set=0A=
CONFIG_PCWATCHDOG=3Dm=0A=
CONFIG_ACQUIRE_WDT=3Dm=0A=
CONFIG_ADVANTECH_WDT=3Dm=0A=
CONFIG_EUROTECH_WDT=3Dm=0A=
CONFIG_IB700_WDT=3Dm=0A=
CONFIG_I810_TCO=3Dm=0A=
# CONFIG_MIXCOMWD is not set=0A=
# CONFIG_SCx200_WDT is not set=0A=
# CONFIG_60XX_WDT is not set=0A=
CONFIG_W83877F_WDT=3Dm=0A=
CONFIG_MACHZ_WDT=3Dm=0A=
CONFIG_INTEL_RNG=3Dm=0A=
CONFIG_AMD_RNG=3Dm=0A=
CONFIG_NVRAM=3Dm=0A=
CONFIG_RTC=3Dy=0A=
CONFIG_DTLK=3Dm=0A=
CONFIG_R3964=3Dm=0A=
# CONFIG_APPLICOM is not set=0A=
=0A=
#=0A=
# Ftape, the floppy tape device driver=0A=
#=0A=
# CONFIG_FTAPE is not set=0A=
CONFIG_AGP=3Dy=0A=
CONFIG_AGP_INTEL=3Dy=0A=
CONFIG_AGP_I810=3Dy=0A=
CONFIG_AGP_VIA=3Dy=0A=
CONFIG_AGP_AMD=3Dy=0A=
CONFIG_AGP_SIS=3Dy=0A=
CONFIG_AGP_ALI=3Dy=0A=
CONFIG_AGP_SWORKS=3Dy=0A=
# CONFIG_AGP_AMD_8151 is not set=0A=
CONFIG_DRM=3Dy=0A=
CONFIG_DRM_TDFX=3Dm=0A=
CONFIG_DRM_R128=3Dy=0A=
CONFIG_DRM_RADEON=3Dm=0A=
CONFIG_DRM_I810=3Dm=0A=
CONFIG_DRM_I830=3Dm=0A=
CONFIG_DRM_MGA=3Dm=0A=
=0A=
#=0A=
# PCMCIA character devices=0A=
#=0A=
# CONFIG_SYNCLINK_CS is not set=0A=
# CONFIG_MWAVE is not set=0A=
# CONFIG_RAW_DRIVER is not set=0A=
=0A=
#=0A=
# Multimedia devices=0A=
#=0A=
# CONFIG_VIDEO_DEV is not set=0A=
=0A=
#=0A=
# File systems=0A=
#=0A=
CONFIG_QUOTA=3Dy=0A=
# CONFIG_QFMT_V1 is not set=0A=
# CONFIG_QFMT_V2 is not set=0A=
CONFIG_QUOTACTL=3Dy=0A=
CONFIG_AUTOFS_FS=3Dm=0A=
CONFIG_AUTOFS4_FS=3Dm=0A=
CONFIG_REISERFS_FS=3Dm=0A=
# CONFIG_REISERFS_CHECK is not set=0A=
CONFIG_REISERFS_PROC_INFO=3Dy=0A=
CONFIG_EXT3_FS=3Dm=0A=
CONFIG_EXT3_FS_XATTR=3Dy=0A=
# CONFIG_EXT3_FS_POSIX_ACL is not set=0A=
CONFIG_JBD=3Dy=0A=
# CONFIG_JBD_DEBUG is not set=0A=
CONFIG_FAT_FS=3Dm=0A=
CONFIG_MSDOS_FS=3Dm=0A=
CONFIG_VFAT_FS=3Dm=0A=
CONFIG_CRAMFS=3Dm=0A=
CONFIG_TMPFS=3Dy=0A=
CONFIG_RAMFS=3Dy=0A=
CONFIG_ISO9660_FS=3Dy=0A=
CONFIG_JOLIET=3Dy=0A=
CONFIG_ZISOFS=3Dy=0A=
CONFIG_JFS_FS=3Dm=0A=
# CONFIG_JFS_POSIX_ACL is not set=0A=
CONFIG_JFS_DEBUG=3Dy=0A=
# CONFIG_JFS_STATISTICS is not set=0A=
CONFIG_MINIX_FS=3Dm=0A=
CONFIG_VXFS_FS=3Dm=0A=
# CONFIG_NTFS_FS is not set=0A=
# CONFIG_HPFS_FS is not set=0A=
CONFIG_PROC_FS=3Dy=0A=
CONFIG_DEVPTS_FS=3Dy=0A=
# CONFIG_QNX4FS_FS is not set=0A=
CONFIG_ROMFS_FS=3Dm=0A=
CONFIG_EXT2_FS=3Dy=0A=
# CONFIG_EXT2_FS_XATTR is not set=0A=
CONFIG_SYSV_FS=3Dm=0A=
CONFIG_UDF_FS=3Dm=0A=
CONFIG_UFS_FS=3Dm=0A=
# CONFIG_XFS_FS is not set=0A=
=0A=
#=0A=
# Network File Systems=0A=
#=0A=
CONFIG_CODA_FS=3Dm=0A=
CONFIG_NFS_FS=3Dm=0A=
CONFIG_NFS_V3=3Dy=0A=
CONFIG_NFSD=3Dm=0A=
CONFIG_NFSD_V3=3Dy=0A=
CONFIG_SUNRPC=3Dm=0A=
CONFIG_LOCKD=3Dm=0A=
CONFIG_LOCKD_V4=3Dy=0A=
CONFIG_EXPORTFS=3Dm=0A=
# CONFIG_CIFS is not set=0A=
CONFIG_SMB_FS=3Dm=0A=
# CONFIG_SMB_NLS_DEFAULT is not set=0A=
CONFIG_NCP_FS=3Dm=0A=
CONFIG_NCPFS_PACKET_SIGNING=3Dy=0A=
CONFIG_NCPFS_IOCTL_LOCKING=3Dy=0A=
CONFIG_NCPFS_STRONG=3Dy=0A=
CONFIG_NCPFS_NFS_NS=3Dy=0A=
CONFIG_NCPFS_OS2_NS=3Dy=0A=
CONFIG_NCPFS_SMALLDOS=3Dy=0A=
CONFIG_NCPFS_NLS=3Dy=0A=
CONFIG_NCPFS_EXTRAS=3Dy=0A=
CONFIG_ZISOFS_FS=3Dy=0A=
CONFIG_FS_MBCACHE=3Dy=0A=
=0A=
#=0A=
# Partition Types=0A=
#=0A=
CONFIG_PARTITION_ADVANCED=3Dy=0A=
# CONFIG_ACORN_PARTITION is not set=0A=
CONFIG_OSF_PARTITION=3Dy=0A=
# CONFIG_AMIGA_PARTITION is not set=0A=
# CONFIG_ATARI_PARTITION is not set=0A=
CONFIG_MAC_PARTITION=3Dy=0A=
CONFIG_MSDOS_PARTITION=3Dy=0A=
CONFIG_BSD_DISKLABEL=3Dy=0A=
CONFIG_MINIX_SUBPARTITION=3Dy=0A=
CONFIG_SOLARIS_X86_PARTITION=3Dy=0A=
CONFIG_UNIXWARE_DISKLABEL=3Dy=0A=
# CONFIG_LDM_PARTITION is not set=0A=
CONFIG_SGI_PARTITION=3Dy=0A=
# CONFIG_ULTRIX_PARTITION is not set=0A=
CONFIG_SUN_PARTITION=3Dy=0A=
# CONFIG_EFI_PARTITION is not set=0A=
CONFIG_SMB_NLS=3Dy=0A=
CONFIG_NLS=3Dy=0A=
=0A=
#=0A=
# Native Language Support=0A=
#=0A=
CONFIG_NLS_DEFAULT=3D"iso8859-1"=0A=
CONFIG_NLS_CODEPAGE_437=3Dm=0A=
CONFIG_NLS_CODEPAGE_737=3Dm=0A=
CONFIG_NLS_CODEPAGE_775=3Dm=0A=
CONFIG_NLS_CODEPAGE_850=3Dm=0A=
CONFIG_NLS_CODEPAGE_852=3Dm=0A=
CONFIG_NLS_CODEPAGE_855=3Dm=0A=
CONFIG_NLS_CODEPAGE_857=3Dm=0A=
CONFIG_NLS_CODEPAGE_860=3Dm=0A=
CONFIG_NLS_CODEPAGE_861=3Dm=0A=
CONFIG_NLS_CODEPAGE_862=3Dm=0A=
CONFIG_NLS_CODEPAGE_863=3Dm=0A=
CONFIG_NLS_CODEPAGE_864=3Dm=0A=
CONFIG_NLS_CODEPAGE_865=3Dm=0A=
CONFIG_NLS_CODEPAGE_866=3Dm=0A=
CONFIG_NLS_CODEPAGE_869=3Dm=0A=
CONFIG_NLS_CODEPAGE_936=3Dm=0A=
CONFIG_NLS_CODEPAGE_950=3Dm=0A=
CONFIG_NLS_CODEPAGE_932=3Dm=0A=
CONFIG_NLS_CODEPAGE_949=3Dm=0A=
CONFIG_NLS_CODEPAGE_874=3Dm=0A=
CONFIG_NLS_ISO8859_8=3Dm=0A=
CONFIG_NLS_CODEPAGE_1250=3Dm=0A=
CONFIG_NLS_CODEPAGE_1251=3Dm=0A=
CONFIG_NLS_ISO8859_1=3Dm=0A=
CONFIG_NLS_ISO8859_2=3Dm=0A=
CONFIG_NLS_ISO8859_3=3Dm=0A=
CONFIG_NLS_ISO8859_4=3Dm=0A=
CONFIG_NLS_ISO8859_5=3Dm=0A=
CONFIG_NLS_ISO8859_6=3Dm=0A=
CONFIG_NLS_ISO8859_7=3Dm=0A=
CONFIG_NLS_ISO8859_9=3Dm=0A=
CONFIG_NLS_ISO8859_13=3Dm=0A=
CONFIG_NLS_ISO8859_14=3Dm=0A=
CONFIG_NLS_ISO8859_15=3Dm=0A=
CONFIG_NLS_KOI8_R=3Dm=0A=
CONFIG_NLS_KOI8_U=3Dm=0A=
CONFIG_NLS_UTF8=3Dm=0A=
=0A=
#=0A=
# Console drivers=0A=
#=0A=
CONFIG_VGA_CONSOLE=3Dy=0A=
CONFIG_VIDEO_SELECT=3Dy=0A=
=0A=
#=0A=
# Sound=0A=
#=0A=
CONFIG_SOUND=3Dm=0A=
=0A=
#=0A=
# Open Sound System=0A=
#=0A=
# CONFIG_SOUND_PRIME is not set=0A=
=0A=
#=0A=
# Advanced Linux Sound Architecture=0A=
#=0A=
# CONFIG_SND is not set=0A=
=0A=
#=0A=
# USB support=0A=
#=0A=
CONFIG_USB=3Dm=0A=
# CONFIG_USB_DEBUG is not set=0A=
=0A=
#=0A=
# Miscellaneous USB options=0A=
#=0A=
CONFIG_USB_DEVICEFS=3Dy=0A=
CONFIG_USB_LONG_TIMEOUT=3Dy=0A=
=0A=
#=0A=
# USB Host Controller Drivers=0A=
#=0A=
CONFIG_USB_EHCI_HCD=3Dm=0A=
# CONFIG_USB_OHCI_HCD is not set=0A=
# CONFIG_USB_UHCI_HCD_ALT is not set=0A=
=0A=
#=0A=
# USB Device Class drivers=0A=
#=0A=
CONFIG_USB_AUDIO=3Dm=0A=
# CONFIG_USB_BLUETOOTH_TTY is not set=0A=
# CONFIG_USB_MIDI is not set=0A=
CONFIG_USB_ACM=3Dm=0A=
CONFIG_USB_PRINTER=3Dm=0A=
CONFIG_USB_STORAGE=3Dm=0A=
# CONFIG_USB_STORAGE_DEBUG is not set=0A=
CONFIG_USB_STORAGE_FREECOM=3Dy=0A=
CONFIG_USB_STORAGE_ISD200=3Dy=0A=
CONFIG_USB_STORAGE_DPCM=3Dy=0A=
=0A=
#=0A=
# USB Human Interface Devices (HID)=0A=
#=0A=
CONFIG_USB_HID=3Dm=0A=
# CONFIG_USB_HIDINPUT is not set=0A=
# CONFIG_USB_HIDDEV is not set=0A=
=0A=
#=0A=
# USB HID Boot Protocol drivers=0A=
#=0A=
# CONFIG_USB_KBD is not set=0A=
# CONFIG_USB_MOUSE is not set=0A=
CONFIG_USB_AIPTEK=3Dm=0A=
CONFIG_USB_WACOM=3Dm=0A=
# CONFIG_USB_POWERMATE is not set=0A=
# CONFIG_USB_XPAD is not set=0A=
=0A=
#=0A=
# USB Imaging devices=0A=
#=0A=
CONFIG_USB_SCANNER=3Dm=0A=
CONFIG_USB_MICROTEK=3Dm=0A=
=0A=
#=0A=
# USB Multimedia devices=0A=
#=0A=
CONFIG_USB_DABUSB=3Dm=0A=
=0A=
#=0A=
# Video4Linux support is needed for USB Multimedia device support=0A=
#=0A=
=0A=
#=0A=
# USB Network adaptors=0A=
#=0A=
CONFIG_USB_KAWETH=3Dm=0A=
CONFIG_USB_PEGASUS=3Dm=0A=
CONFIG_USB_USBNET=3Dm=0A=
=0A=
#=0A=
# USB port drivers=0A=
#=0A=
CONFIG_USB_USS720=3Dm=0A=
=0A=
#=0A=
# USB Serial Converter support=0A=
#=0A=
CONFIG_USB_SERIAL=3Dm=0A=
CONFIG_USB_SERIAL_GENERIC=3Dy=0A=
CONFIG_USB_SERIAL_BELKIN=3Dm=0A=
CONFIG_USB_SERIAL_WHITEHEAT=3Dm=0A=
CONFIG_USB_SERIAL_DIGI_ACCELEPORT=3Dm=0A=
CONFIG_USB_SERIAL_EMPEG=3Dm=0A=
CONFIG_USB_SERIAL_VISOR=3Dm=0A=
CONFIG_USB_SERIAL_IPAQ=3Dm=0A=
CONFIG_USB_SERIAL_EDGEPORT=3Dm=0A=
# CONFIG_USB_SERIAL_EDGEPORT_TI is not set=0A=
CONFIG_USB_SERIAL_KEYSPAN_PDA=3Dm=0A=
CONFIG_USB_SERIAL_KEYSPAN=3Dm=0A=
# CONFIG_USB_SERIAL_KEYSPAN_USA28 is not set=0A=
# CONFIG_USB_SERIAL_KEYSPAN_USA28X is not set=0A=
CONFIG_USB_SERIAL_KEYSPAN_USA28XA=3Dy=0A=
CONFIG_USB_SERIAL_KEYSPAN_USA28XB=3Dy=0A=
# CONFIG_USB_SERIAL_KEYSPAN_USA19 is not set=0A=
# CONFIG_USB_SERIAL_KEYSPAN_USA18X is not set=0A=
# CONFIG_USB_SERIAL_KEYSPAN_USA19W is not set=0A=
# CONFIG_USB_SERIAL_KEYSPAN_USA19QW is not set=0A=
# CONFIG_USB_SERIAL_KEYSPAN_USA19QI is not set=0A=
# CONFIG_USB_SERIAL_KEYSPAN_USA49W is not set=0A=
CONFIG_USB_SERIAL_MCT_U232=3Dm=0A=
CONFIG_USB_SERIAL_PL2303=3Dm=0A=
CONFIG_USB_SERIAL_XIRCOM=3Dm=0A=
=0A=
#=0A=
# USB Miscellaneous drivers=0A=
#=0A=
CONFIG_USB_EMI26=3Dm=0A=
# CONFIG_USB_TIGL is not set=0A=
# CONFIG_USB_LCD is not set=0A=
=0A=
#=0A=
# Bluetooth support=0A=
#=0A=
# CONFIG_BT is not set=0A=
=0A=
#=0A=
# Kernel hacking=0A=
#=0A=
CONFIG_DEBUG_KERNEL=3Dy=0A=
# CONFIG_DEBUG_STACKOVERFLOW is not set=0A=
# CONFIG_DEBUG_SLAB is not set=0A=
# CONFIG_DEBUG_IOVIRT is not set=0A=
CONFIG_MAGIC_SYSRQ=3Dy=0A=
# CONFIG_DEBUG_SPINLOCK is not set=0A=
# CONFIG_DEBUG_HIGHMEM is not set=0A=
CONFIG_KALLSYMS=3Dy=0A=
=0A=
#=0A=
# Security options=0A=
#=0A=
CONFIG_SECURITY_CAPABILITIES=3Dy=0A=
=0A=
#=0A=
# Cryptographic options=0A=
#=0A=
# CONFIG_CRYPTO is not set=0A=
=0A=
#=0A=
# Library routines=0A=
#=0A=
# CONFIG_CRC32 is not set=0A=
CONFIG_ZLIB_INFLATE=3Dy=0A=
CONFIG_ZLIB_DEFLATE=3Dm=0A=
CONFIG_X86_BIOS_REBOOT=3Dy=0A=

------=_NextPart_000_0376_01C28C98.34100D20--

