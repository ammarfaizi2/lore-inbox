Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270886AbTGPOeY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 10:34:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270859AbTGPOeY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 10:34:24 -0400
Received: from unsol-intbg.internet-bg.net ([212.124.67.226]:6405 "HELO
	ns.unixsol.org") by vger.kernel.org with SMTP id S270956AbTGPOcM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 10:32:12 -0400
Message-ID: <3F156566.4040206@unixsol.org>
Date: Wed, 16 Jul 2003 17:47:02 +0300
From: Georgi Chorbadzhiyski <gf@unixsol.org>
Organization: Unix Solutions Ltd. (http://unixsol.org)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030514
X-Accept-Language: en, en-us, bg
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: akpm@digeo.com, jsimmons@infradead.org, rubini@ipvvis.unipv.it,
       vandrove@vc.cvut.cz
Subject: 2.6-test1-mm1 success, tiny mouse and framebuffer problems
Content-Type: multipart/mixed;
 boundary="------------070808050001010101000002"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070808050001010101000002
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi,
compiled and booted 2.6-test1-mm1 without any problem. I used my config from
2.4.21-ck3, "make oldconfig" and enabled my sound card's OSS module (I8xx).
After booting only two small problems, everything runs fine, except two small
regressions:

1. The wheel of the USB stopped working. It worked without problems in 2.4.21.
    When I plug the mouse in the PS/2 port everything is working fine.

2. I'm using framebuffer on Matrox G550 Dual Head. When 2.6 boots it always
    enables the head that has no cable plugged in. Everytime I reboot have to
    switch the cable to the other head.

P.S. Every file in sysfs is 4096 bytes, is this normal?

See attached files for more info.


-- 
Georgi Chorbadzhiyski
http://georgi.unixsol.org/


--------------070808050001010101000002
Content-Type: text/plain;
 name="config-2.6.0-test-mm1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="config-2.6.0-test-mm1"

CONFIG_X86=y
CONFIG_MMU=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y

CONFIG_EXPERIMENTAL=y

CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_SYSCTL=y
CONFIG_LOG_BUF_SHIFT=14
CONFIG_KALLSYMS=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y

CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_MODULE_FORCE_UNLOAD=y
CONFIG_OBSOLETE_MODPARM=y
CONFIG_KMOD=y

CONFIG_X86_PC=y
CONFIG_MPENTIUM4=y
CONFIG_X86_GENERIC=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=7
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_PREEMPT=y
CONFIG_X86_TSC=y
CONFIG_NOHIGHMEM=y
CONFIG_MTRR=y
CONFIG_HAVE_DEC_LOCK=y

CONFIG_PM=y

CONFIG_ACPI=y
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_FAN=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_BUS=y
CONFIG_ACPI_INTERPRETER=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SYSTEM=y
CONFIG_APM=m
CONFIG_APM_DO_ENABLE=y
CONFIG_APM_CPU_IDLE=y
CONFIG_APM_DISPLAY_BLANK=y


CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_NAMES=y
CONFIG_ISA=y
CONFIG_HOTPLUG=y

CONFIG_PCMCIA=y
CONFIG_PCMCIA_PROBE=y


CONFIG_KCORE_ELF=y
CONFIG_BINFMT_ELF=y




CONFIG_PNP=y


CONFIG_BLK_DEV_FD=m
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_NBD=m

CONFIG_IDE=y

CONFIG_BLK_DEV_IDE=y

CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDECD=y
CONFIG_BLK_DEV_IDESCSI=m
CONFIG_IDE_TASK_IOCTL=y

CONFIG_BLK_DEV_IDEPCI=y
CONFIG_BLK_DEV_GENERIC=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_IDEDMA_PCI_WIP=y
CONFIG_BLK_DEV_ADMA=y
CONFIG_BLK_DEV_PIIX=y
CONFIG_IDEDMA_AUTO=y
CONFIG_BLK_DEV_IDE_MODES=y

CONFIG_SCSI=m

CONFIG_BLK_DEV_SD=m
CONFIG_CHR_DEV_SG=m

CONFIG_SCSI_REPORT_LUNS=y




CONFIG_MD=y




CONFIG_NET=y

CONFIG_PACKET=y
CONFIG_NETFILTER=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y

CONFIG_IP_NF_CONNTRACK=m
CONFIG_IP_NF_FTP=m
CONFIG_IP_NF_IRC=m
CONFIG_IP_NF_TFTP=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_LIMIT=m
CONFIG_IP_NF_MATCH_MAC=m
CONFIG_IP_NF_MATCH_PKTTYPE=m
CONFIG_IP_NF_MATCH_MARK=m
CONFIG_IP_NF_MATCH_MULTIPORT=m
CONFIG_IP_NF_MATCH_TOS=m
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_DSCP=m
CONFIG_IP_NF_MATCH_AH_ESP=m
CONFIG_IP_NF_MATCH_LENGTH=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_MATCH_TCPMSS=m
CONFIG_IP_NF_MATCH_HELPER=m
CONFIG_IP_NF_MATCH_STATE=m
CONFIG_IP_NF_MATCH_CONNTRACK=m
CONFIG_IP_NF_MATCH_UNCLEAN=m
CONFIG_IP_NF_MATCH_OWNER=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_MIRROR=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_NAT_LOCAL=y
CONFIG_IP_NF_NAT_SNMP_BASIC=m
CONFIG_IP_NF_NAT_IRC=m
CONFIG_IP_NF_NAT_FTP=m
CONFIG_IP_NF_NAT_TFTP=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_TOS=m
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_DSCP=m
CONFIG_IP_NF_TARGET_MARK=m
CONFIG_IP_NF_TARGET_LOG=m
CONFIG_IP_NF_TARGET_ULOG=m
CONFIG_IP_NF_TARGET_TCPMSS=m
CONFIG_IP_NF_ARPTABLES=m
CONFIG_IP_NF_ARPFILTER=m


CONFIG_IPV6_SCTP__=y
CONFIG_VLAN_8021Q=y


CONFIG_NETDEVICES=y


CONFIG_NET_ETHERNET=y
CONFIG_NET_VENDOR_3COM=y
CONFIG_VORTEX=y

CONFIG_NET_PCI=y
CONFIG_E100=y






CONFIG_NET_PCMCIA=y
CONFIG_PCMCIA_PCNET=y





CONFIG_INPUT=y

CONFIG_INPUT_MOUSEDEV=m
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1280
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=1024
CONFIG_INPUT_JOYDEV=m
CONFIG_INPUT_EVDEV=m

CONFIG_SOUND_GAMEPORT=y
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y

CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y

CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y


CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256







CONFIG_AGP=y
CONFIG_AGP_INTEL=y
CONFIG_DRM=y
CONFIG_DRM_MGA=m




CONFIG_EXT2_FS=y
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_XATTR=y
CONFIG_JBD=y
CONFIG_FS_MBCACHE=y
CONFIG_REISERFS_FS=y
CONFIG_AUTOFS4_FS=y

CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_UDF_FS=m

CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m

CONFIG_PROC_FS=y
CONFIG_DEVPTS_FS=y
CONFIG_TMPFS=y
CONFIG_RAMFS=y


CONFIG_NFS_FS=y
CONFIG_NFS_V3=y
CONFIG_NFS_V4=y
CONFIG_NFS_DIRECTIO=y
CONFIG_NFSD=y
CONFIG_NFSD_V3=y
CONFIG_NFSD_TCP=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_EXPORTFS=y
CONFIG_SUNRPC=y
CONFIG_SMB_FS=y
CONFIG_CIFS=m
CONFIG_CODA_FS=m
CONFIG_INTERMEZZO_FS=m

CONFIG_MSDOS_PARTITION=y
CONFIG_SMB_NLS=y
CONFIG_NLS=y

CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_1251=m

CONFIG_FB=y
CONFIG_FB_VESA=y
CONFIG_VIDEO_SELECT=y
CONFIG_FB_MATROX=y
CONFIG_FB_MATROX_G450=y
CONFIG_FB_MATROX_G100=y
CONFIG_FB_MATROX_MULTIHEAD=y

CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y

CONFIG_LOGO=y
CONFIG_LOGO_LINUX_MONO=y
CONFIG_LOGO_LINUX_VGA16=y
CONFIG_LOGO_LINUX_CLUT224=y

CONFIG_SOUND=y


CONFIG_SOUND_PRIME=y
CONFIG_SOUND_ICH=y

CONFIG_USB=m

CONFIG_USB_DEVICEFS=y

CONFIG_USB_EHCI_HCD=m
CONFIG_USB_OHCI_HCD=m
CONFIG_USB_UHCI_HCD=m

CONFIG_USB_PRINTER=m
CONFIG_USB_STORAGE=m
CONFIG_USB_STORAGE_DEBUG=y
CONFIG_USB_STORAGE_DATAFAB=y
CONFIG_USB_STORAGE_FREECOM=y
CONFIG_USB_STORAGE_ISD200=y
CONFIG_USB_STORAGE_DPCM=y
CONFIG_USB_STORAGE_HP8200e=y
CONFIG_USB_STORAGE_SDDR09=y
CONFIG_USB_STORAGE_SDDR55=y
CONFIG_USB_STORAGE_JUMPSHOT=y

CONFIG_USB_HID=m
CONFIG_USB_HIDINPUT=y

CONFIG_USB_KBD=m
CONFIG_USB_MOUSE=m

CONFIG_USB_MDC800=m
CONFIG_USB_SCANNER=m
CONFIG_USB_MICROTEK=m
CONFIG_USB_HPUSBSCSI=m









CONFIG_DEBUG_KERNEL=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_DEBUG_INFO=y



CONFIG_X86_BIOS_REBOOT=y

--------------070808050001010101000002
Content-Type: text/plain;
 name="dmesg"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg"

Linux version 2.6.0-test1-mm1 (gf@gf) (gcc version 3.2.3) #1 Wed Jul 16 15:19:05 EEST 2003
Video mode to be used for restore is f00
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000ffeb000 (usable)
 BIOS-e820: 000000000ffeb000 - 000000000ffef000 (ACPI data)
 BIOS-e820: 000000000ffef000 - 000000000ffff000 (reserved)
 BIOS-e820: 000000000ffff000 - 0000000010000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
255MB LOWMEM available.
On node 0 totalpages: 65515
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 61419 pages, LIFO batch:14
  HighMem zone: 0 pages, LIFO batch:1
ACPI: RSDP (v000 ASUS                       ) @ 0x000f6b10
ACPI: RSDT (v001 ASUS   P4T-E    12336.12337) @ 0x0ffeb000
ACPI: FADT (v001 ASUS   P4T-E    12336.12337) @ 0x0ffeb100
ACPI: BOOT (v001 ASUS   P4T-E    12336.12337) @ 0x0ffeb040
ACPI: MADT (v001 ASUS   P4T-E    12336.12337) @ 0x0ffeb080
ACPI: DSDT (v001   ASUS P4T-E    00000.04096) @ 0x00000000
ACPI: BIOS passes blacklist
Building zonelist for node : 0
Kernel command line: BOOT_IMAGE=2.6.0-test-mm1 ro root=301 video=matroxfb:vesa:0x11b,fv:75Hz
Initializing CPU#0
PID hash table entries: 1024 (order 10: 8192 bytes)
Detected 1607.594 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 3170.30 BogoMIPS
Memory: 255488k/262060k available (2164k kernel code, 5864k reserved, 793k data, 128k init, 0k highmem)
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
-> /dev
-> /dev/console
-> /root
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 256K
CPU:     After generic, caps: 3febfbff 00000000 00000000 00000080
CPU: Intel(R) Pentium(R) 4 CPU 1.60GHz stepping 02
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v2.0 (20020519)
Initializing RT netlink socket
PCI: PCI BIOS revision 2.10 entry at 0xf0e90, last bus=2
PCI: Using configuration type 1
BIO: pool of 256 setup, 14Kb (56 bytes/bio)
biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
ACPI: Subsystem revision 20030714
    ACPI-0109: *** Error: No object was returned from [\_SB_.PCI0.PX40.UAR2._STA] (Node c12d7620), AE_NOT_EXIST
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 *4 5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LNKD] (IRQs *3 4 5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 *7 9 10 11 12 14 15)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
Transparent bridge - Intel Corp. 82801BA/CA/DB PCI Br
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI2._PRT]
Linux Plug and Play Support v0.96 (c) Adam Belay
Linux Kernel Card Services 3.1.22
  options:  [pci] [pm]
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 9
ACPI: PCI Interrupt Link [LNKF] enabled at IRQ 5
ACPI: PCI Interrupt Link [LNKG] enabled at IRQ 11
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
matroxfb: Matrox G550 detected
matroxfb: MTRR's turned on
matroxfb: 1280x1024x32bpp (virtual: 1280x65536)
matroxfb: framebuffer at 0xF6000000, mapped to 0xd080c000, size 33554432
fb0: MATROX frame buffer device
fb0: initializing hardware
pty: 256 Unix98 ptys configured
SBF: Simple Boot Flag extension found and enabled.
SBF: Setting boot flags 0x80
Enabling SEP on CPU 0
Journalled Block Device driver loaded
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
ACPI: Power Button (FF) [PWRF]
ACPI: Processor [CPU] (supports C1)
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected an Intel i850 Chipset.
agpgart: Maximum main memory to use for agp memory: 203M
agpgart: AGP aperture is 64M @ 0xf8000000
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
0000:02:0b.0: 3Com PCI 3c905B Cyclone 100baseTx at 0xd800. Vers LK1.1.19
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH2: IDE controller at PCI slot 0000:00:1f.1
ICH2: chipset revision 4
ICH2: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xb800-0xb807, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xb808-0xb80f, BIOS settings: hdc:pio, hdd:pio
hda: ST340016A, ATA DISK drive
anticipatory scheduling elevator
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: PLEXTOR CD-R PX-W4824A, ATAPI CD/DVD-ROM drive
hdd: PIONEER DVD-RW DVR-103, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: host protected area => 1
hda: 78165360 sectors (40021 MB) w/2048KiB Cache, CHS=77545/16/63, UDMA(100)
 hda: hda1 hda2
end_request: I/O error, dev hdc, sector 0
hdc: ATAPI 40X CD-ROM CD-R/RW drive, 4096kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
end_request: I/O error, dev hdd, sector 0
hdd: ATAPI 24X DVD-ROM DVD-R CD-R/RW drive, 2000kB Cache, DMA
matroxfb_crtc2: secondary head of fb0 was registered as fb1
input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
Intel 810 + AC97 Audio, version 0.24, 15:14:30 Jul 16 2003
PCI: Setting latency timer of device 0000:00:1f.5 to 64
i810: Intel ICH2 found at IO 0xe100 and 0xe000, MEM 0x0000 and 0x0000, IRQ 4
i810_audio: Audio Controller supports 6 channels.
i810_audio: Defaulting to base 2 channel mode.
i810_audio: Resetting connection 0
ac97_codec: AC97 Audio codec, id: ALG16 (ALC200/200P)
i810_audio: AC'97 codec 0 supports AMAP, total channels = 2
i810_audio: setting clocking to 48689
NET4: Linux TCP/IP 1.0 for NET4.0
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
802.1Q VLAN Support v1.8 Ben Greear <greearb@candelatech.com>
All bugs added by David S. Miller <davem@redhat.com>
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 128k freed
EXT3 FS on hda1, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda2, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
SCSI subsystem initialized
call_verify: server accept status: 2
call_verify: server accept status: 2
call_verify: server accept status: 2
RPC: garbage, exit EIO
nfs_get_root: getattr error = 5
nfs_read_super: get root inode failed
nfs warning: mount version older than kernel
call_verify: server accept status: 2
call_verify: server accept status: 2
call_verify: server accept status: 2
RPC: garbage, exit EIO
nfs_get_root: getattr error = 5
nfs_read_super: get root inode failed
nfs warning: mount version older than kernel
call_verify: server accept status: 2
call_verify: server accept status: 2
call_verify: server accept status: 2
RPC: garbage, exit EIO
nfs_get_root: getattr error = 5
nfs_read_super: get root inode failed
nfs warning: mount version older than kernel
call_verify: server accept status: 2
call_verify: server accept status: 2
call_verify: server accept status: 2
RPC: garbage, exit EIO
nfs_get_root: getattr error = 5
nfs_read_super: get root inode failed
nfs warning: mount version older than kernel
call_verify: server accept status: 2
call_verify: server accept status: 2
call_verify: server accept status: 2
RPC: garbage, exit EIO
nfs_get_root: getattr error = 5
nfs_read_super: get root inode failed
nfs warning: mount version older than kernel
blk: queue c041831c, I/O limit 4095Mb (mask 0xffffffff)
mtrr: no MTRR for f6000000,1000000 found
[drm] Initialized mga 3.1.0 20021029 on minor 0
agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 1x mode
agpgart: Putting AGP V2 device at 0000:01:00.0 into 1x mode

--------------070808050001010101000002
Content-Type: text/plain;
 name="lsmod"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lsmod"

Module                  Size  Used by
mga                   103064  34 
ide_scsi               12800  0 
sg                     29324  0 
scsi_mod               63508  2 ide_scsi,sg
mousedev                7508  1 
hid                    23296  0 
usbcore                95572  1 hid

--------------070808050001010101000002
Content-Type: text/plain;
 name="tree_sys"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="tree_sys"

.
|-- [          0]  block
|   |-- [          0]  hda
|   |   |-- [       4096]  dev
|   |   |-- [         46]  device -> ../../devices/pci0000:00/0000:00:1f.1/ide0/0.0
|   |   |-- [          0]  hda1
|   |   |   |-- [       4096]  dev
|   |   |   |-- [       4096]  size
|   |   |   |-- [       4096]  start
|   |   |   `-- [       4096]  stat
|   |   |-- [          0]  hda2
|   |   |   |-- [       4096]  dev
|   |   |   |-- [       4096]  size
|   |   |   |-- [       4096]  start
|   |   |   `-- [       4096]  stat
|   |   |-- [          0]  queue
|   |   |   |-- [          0]  iosched
|   |   |   |   |-- [       4096]  antic_expire
|   |   |   |   |-- [       4096]  read_batch_expire
|   |   |   |   |-- [       4096]  read_expire
|   |   |   |   |-- [       4096]  write_batch_expire
|   |   |   |   `-- [       4096]  write_expire
|   |   |   `-- [       4096]  nr_requests
|   |   |-- [       4096]  range
|   |   |-- [       4096]  size
|   |   `-- [       4096]  stat
|   |-- [          0]  hdc
|   |   |-- [       4096]  dev
|   |   |-- [         46]  device -> ../../devices/pci0000:00/0000:00:1f.1/ide1/1.0
|   |   |-- [          0]  queue
|   |   |   |-- [          0]  iosched
|   |   |   |   |-- [       4096]  antic_expire
|   |   |   |   |-- [       4096]  read_batch_expire
|   |   |   |   |-- [       4096]  read_expire
|   |   |   |   |-- [       4096]  write_batch_expire
|   |   |   |   `-- [       4096]  write_expire
|   |   |   `-- [       4096]  nr_requests
|   |   |-- [       4096]  range
|   |   |-- [       4096]  size
|   |   `-- [       4096]  stat
|   `-- [          0]  hdd
|       |-- [       4096]  dev
|       |-- [         46]  device -> ../../devices/pci0000:00/0000:00:1f.1/ide1/1.1
|       |-- [          0]  queue
|       |   |-- [          0]  iosched
|       |   |   |-- [       4096]  antic_expire
|       |   |   |-- [       4096]  read_batch_expire
|       |   |   |-- [       4096]  read_expire
|       |   |   |-- [       4096]  write_batch_expire
|       |   |   `-- [       4096]  write_expire
|       |   `-- [       4096]  nr_requests
|       |-- [       4096]  range
|       |-- [       4096]  size
|       `-- [       4096]  stat
|-- [          0]  bus
|   |-- [          0]  ide
|   |   |-- [          0]  devices
|   |   |   |-- [         49]  0.0 -> ../../../devices/pci0000:00/0000:00:1f.1/ide0/0.0
|   |   |   |-- [         49]  1.0 -> ../../../devices/pci0000:00/0000:00:1f.1/ide1/1.0
|   |   |   `-- [         49]  1.1 -> ../../../devices/pci0000:00/0000:00:1f.1/ide1/1.1
|   |   `-- [          0]  drivers
|   |       |-- [          0]  ide-cdrom
|   |       |-- [          0]  ide-disk
|   |       `-- [          0]  ide-scsi
|   |-- [          0]  ide-scsi
|   |   |-- [          0]  devices
|   |   `-- [          0]  drivers
|   |-- [          0]  pci
|   |   |-- [          0]  devices
|   |   |   |-- [         40]  0000:00:00.0 -> ../../../devices/pci0000:00/0000:00:00.0
|   |   |   |-- [         40]  0000:00:01.0 -> ../../../devices/pci0000:00/0000:00:01.0
|   |   |   |-- [         40]  0000:00:1e.0 -> ../../../devices/pci0000:00/0000:00:1e.0
|   |   |   |-- [         40]  0000:00:1f.0 -> ../../../devices/pci0000:00/0000:00:1f.0
|   |   |   |-- [         40]  0000:00:1f.1 -> ../../../devices/pci0000:00/0000:00:1f.1
|   |   |   |-- [         40]  0000:00:1f.2 -> ../../../devices/pci0000:00/0000:00:1f.2
|   |   |   |-- [         40]  0000:00:1f.3 -> ../../../devices/pci0000:00/0000:00:1f.3
|   |   |   |-- [         40]  0000:00:1f.4 -> ../../../devices/pci0000:00/0000:00:1f.4
|   |   |   |-- [         40]  0000:00:1f.5 -> ../../../devices/pci0000:00/0000:00:1f.5
|   |   |   |-- [         53]  0000:01:00.0 -> ../../../devices/pci0000:00/0000:00:01.0/0000:01:00.0
|   |   |   `-- [         53]  0000:02:0b.0 -> ../../../devices/pci0000:00/0000:00:1e.0/0000:02:0b.0
|   |   `-- [          0]  drivers
|   |       |-- [          0]  3c59x
|   |       |   |-- [         56]  0000:02:0b.0 -> ../../../../devices/pci0000:00/0000:00:1e.0/0000:02:0b.0
|   |       |   `-- [       4096]  new_id
|   |       |-- [          0]  PCI IDE
|   |       |   `-- [       4096]  new_id
|   |       |-- [          0]  PIIX IDE
|   |       |   |-- [         43]  0000:00:1f.1 -> ../../../../devices/pci0000:00/0000:00:1f.1
|   |       |   `-- [       4096]  new_id
|   |       |-- [          0]  agpgart-intel
|   |       |   |-- [         43]  0000:00:00.0 -> ../../../../devices/pci0000:00/0000:00:00.0
|   |       |   `-- [       4096]  new_id
|   |       |-- [          0]  e100
|   |       |   `-- [       4096]  new_id
|   |       |-- [          0]  intel810_audio
|   |       |   |-- [         43]  0000:00:1f.5 -> ../../../../devices/pci0000:00/0000:00:1f.5
|   |       |   `-- [       4096]  new_id
|   |       `-- [          0]  matroxfb
|   |           |-- [         56]  0000:01:00.0 -> ../../../../devices/pci0000:00/0000:00:01.0/0000:01:00.0
|   |           `-- [       4096]  new_id
|   |-- [          0]  pcmcia
|   |   |-- [          0]  devices
|   |   `-- [          0]  drivers
|   |       `-- [          0]  pcnet_cs
|   |-- [          0]  platform
|   |   |-- [          0]  devices
|   |   `-- [          0]  drivers
|   |-- [          0]  pnp
|   |   |-- [          0]  devices
|   |   `-- [          0]  drivers
|   |       `-- [          0]  system
|   |-- [          0]  scsi
|   |   |-- [          0]  devices
|   |   `-- [          0]  drivers
|   `-- [          0]  usb
|       |-- [          0]  devices
|       `-- [          0]  drivers
|           |-- [          0]  hid
|           |-- [          0]  hub
|           |-- [          0]  usb
|           `-- [          0]  usbfs
|-- [          0]  cdev
|   |-- [          0]  dev.console
|   |-- [          0]  dev.ptmx
|   |-- [          0]  dev.tty
|   |-- [          0]  dev.vc0
|   |-- [          0]  major
|   |   |-- [          0]  drm
|   |   |-- [          0]  fb
|   |   |-- [          0]  input
|   |   |-- [          0]  mem
|   |   |-- [          0]  misc
|   |   |-- [          0]  pcmcia
|   |   |-- [          0]  sg
|   |   |-- [          0]  sound
|   |   |-- [          0]  usb
|   |   `-- [          0]  vcs
|   `-- [          0]  tty
|       |-- [          0]  ptm
|       |-- [          0]  pts
|       |-- [          0]  pty
|       |-- [          0]  tty
|       `-- [          0]  ttyp
|-- [          0]  class
|   |-- [          0]  input
|   |-- [          0]  net
|   |   |-- [          0]  eth0
|   |   |   |-- [       4096]  addr_len
|   |   |   |-- [       4096]  address
|   |   |   |-- [       4096]  broadcast
|   |   |   |-- [         53]  device -> ../../../devices/pci0000:00/0000:00:1e.0/0000:02:0b.0
|   |   |   |-- [         30]  driver -> ../../../bus/pci/drivers/3c59x
|   |   |   |-- [       4096]  features
|   |   |   |-- [       4096]  flags
|   |   |   |-- [       4096]  ifindex
|   |   |   |-- [       4096]  iflink
|   |   |   |-- [       4096]  mtu
|   |   |   |-- [          0]  statistics
|   |   |   |   |-- [       4096]  collisions
|   |   |   |   |-- [       4096]  multicast
|   |   |   |   |-- [       4096]  rx_bytes
|   |   |   |   |-- [       4096]  rx_compressed
|   |   |   |   |-- [       4096]  rx_crc_errors
|   |   |   |   |-- [       4096]  rx_dropped
|   |   |   |   |-- [       4096]  rx_errors
|   |   |   |   |-- [       4096]  rx_fifo_errors
|   |   |   |   |-- [       4096]  rx_frame_errors
|   |   |   |   |-- [       4096]  rx_length_errors
|   |   |   |   |-- [       4096]  rx_missed_errors
|   |   |   |   |-- [       4096]  rx_over_errors
|   |   |   |   |-- [       4096]  rx_packets
|   |   |   |   |-- [       4096]  tx_aborted_errors
|   |   |   |   |-- [       4096]  tx_bytes
|   |   |   |   |-- [       4096]  tx_carrier_errors
|   |   |   |   |-- [       4096]  tx_compressed
|   |   |   |   |-- [       4096]  tx_dropped
|   |   |   |   |-- [       4096]  tx_errors
|   |   |   |   |-- [       4096]  tx_fifo_errors
|   |   |   |   |-- [       4096]  tx_heartbeat_errors
|   |   |   |   |-- [       4096]  tx_packets
|   |   |   |   `-- [       4096]  tx_window_errors
|   |   |   |-- [       4096]  tx_queue_len
|   |   |   `-- [       4096]  type
|   |   `-- [          0]  lo
|   |       |-- [       4096]  addr_len
|   |       |-- [       4096]  address
|   |       |-- [       4096]  broadcast
|   |       |-- [       4096]  features
|   |       |-- [       4096]  flags
|   |       |-- [       4096]  ifindex
|   |       |-- [       4096]  iflink
|   |       |-- [       4096]  mtu
|   |       |-- [          0]  statistics
|   |       |   |-- [       4096]  collisions
|   |       |   |-- [       4096]  multicast
|   |       |   |-- [       4096]  rx_bytes
|   |       |   |-- [       4096]  rx_compressed
|   |       |   |-- [       4096]  rx_crc_errors
|   |       |   |-- [       4096]  rx_dropped
|   |       |   |-- [       4096]  rx_errors
|   |       |   |-- [       4096]  rx_fifo_errors
|   |       |   |-- [       4096]  rx_frame_errors
|   |       |   |-- [       4096]  rx_length_errors
|   |       |   |-- [       4096]  rx_missed_errors
|   |       |   |-- [       4096]  rx_over_errors
|   |       |   |-- [       4096]  rx_packets
|   |       |   |-- [       4096]  tx_aborted_errors
|   |       |   |-- [       4096]  tx_bytes
|   |       |   |-- [       4096]  tx_carrier_errors
|   |       |   |-- [       4096]  tx_compressed
|   |       |   |-- [       4096]  tx_dropped
|   |       |   |-- [       4096]  tx_errors
|   |       |   |-- [       4096]  tx_fifo_errors
|   |       |   |-- [       4096]  tx_heartbeat_errors
|   |       |   |-- [       4096]  tx_packets
|   |       |   `-- [       4096]  tx_window_errors
|   |       |-- [       4096]  tx_queue_len
|   |       `-- [       4096]  type
|   |-- [          0]  pcmcia_socket
|   |-- [          0]  scsi_device
|   |-- [          0]  scsi_host
|   |-- [          0]  tty
|   |   |-- [          0]  console
|   |   |   `-- [       4096]  dev
|   |   |-- [          0]  ptmx
|   |   |   `-- [       4096]  dev
|   |   |-- [          0]  tty
|   |   |   `-- [       4096]  dev
|   |   |-- [          0]  tty0
|   |   |   `-- [       4096]  dev
|   |   |-- [          0]  tty1
|   |   |   `-- [       4096]  dev
|   |   |-- [          0]  tty10
|   |   |   `-- [       4096]  dev
|   |   |-- [          0]  tty11
|   |   |   `-- [       4096]  dev
|   |   |-- [          0]  tty12
|   |   |   `-- [       4096]  dev
|   |   |-- [          0]  tty13
|   |   |   `-- [       4096]  dev
|   |   |-- [          0]  tty14
|   |   |   `-- [       4096]  dev
|   |   |-- [          0]  tty15
|   |   |   `-- [       4096]  dev
|   |   |-- [          0]  tty16
|   |   |   `-- [       4096]  dev
|   |   |-- [          0]  tty17
|   |   |   `-- [       4096]  dev
|   |   |-- [          0]  tty18
|   |   |   `-- [       4096]  dev
|   |   |-- [          0]  tty19
|   |   |   `-- [       4096]  dev
|   |   |-- [          0]  tty2
|   |   |   `-- [       4096]  dev
|   |   |-- [          0]  tty20
|   |   |   `-- [       4096]  dev
|   |   |-- [          0]  tty21
|   |   |   `-- [       4096]  dev
|   |   |-- [          0]  tty22
|   |   |   `-- [       4096]  dev
|   |   |-- [          0]  tty23
|   |   |   `-- [       4096]  dev
|   |   |-- [          0]  tty24
|   |   |   `-- [       4096]  dev
|   |   |-- [          0]  tty25
|   |   |   `-- [       4096]  dev
|   |   |-- [          0]  tty26
|   |   |   `-- [       4096]  dev
|   |   |-- [          0]  tty27
|   |   |   `-- [       4096]  dev
|   |   |-- [          0]  tty28
|   |   |   `-- [       4096]  dev
|   |   |-- [          0]  tty29
|   |   |   `-- [       4096]  dev
|   |   |-- [          0]  tty3
|   |   |   `-- [       4096]  dev
|   |   |-- [          0]  tty30
|   |   |   `-- [       4096]  dev
|   |   |-- [          0]  tty31
|   |   |   `-- [       4096]  dev
|   |   |-- [          0]  tty32
|   |   |   `-- [       4096]  dev
|   |   |-- [          0]  tty33
|   |   |   `-- [       4096]  dev
|   |   |-- [          0]  tty34
|   |   |   `-- [       4096]  dev
|   |   |-- [          0]  tty35
|   |   |   `-- [       4096]  dev
|   |   |-- [          0]  tty36
|   |   |   `-- [       4096]  dev
|   |   |-- [          0]  tty37
|   |   |   `-- [       4096]  dev
|   |   |-- [          0]  tty38
|   |   |   `-- [       4096]  dev
|   |   |-- [          0]  tty39
|   |   |   `-- [       4096]  dev
|   |   |-- [          0]  tty4
|   |   |   `-- [       4096]  dev
|   |   |-- [          0]  tty40
|   |   |   `-- [       4096]  dev
|   |   |-- [          0]  tty41
|   |   |   `-- [       4096]  dev
|   |   |-- [          0]  tty42
|   |   |   `-- [       4096]  dev
|   |   |-- [          0]  tty43
|   |   |   `-- [       4096]  dev
|   |   |-- [          0]  tty44
|   |   |   `-- [       4096]  dev
|   |   |-- [          0]  tty45
|   |   |   `-- [       4096]  dev
|   |   |-- [          0]  tty46
|   |   |   `-- [       4096]  dev
|   |   |-- [          0]  tty47
|   |   |   `-- [       4096]  dev
|   |   |-- [          0]  tty48
|   |   |   `-- [       4096]  dev
|   |   |-- [          0]  tty49
|   |   |   `-- [       4096]  dev
|   |   |-- [          0]  tty5
|   |   |   `-- [       4096]  dev
|   |   |-- [          0]  tty50
|   |   |   `-- [       4096]  dev
|   |   |-- [          0]  tty51
|   |   |   `-- [       4096]  dev
|   |   |-- [          0]  tty52
|   |   |   `-- [       4096]  dev
|   |   |-- [          0]  tty53
|   |   |   `-- [       4096]  dev
|   |   |-- [          0]  tty54
|   |   |   `-- [       4096]  dev
|   |   |-- [          0]  tty55
|   |   |   `-- [       4096]  dev
|   |   |-- [          0]  tty56
|   |   |   `-- [       4096]  dev
|   |   |-- [          0]  tty57
|   |   |   `-- [       4096]  dev
|   |   |-- [          0]  tty58
|   |   |   `-- [       4096]  dev
|   |   |-- [          0]  tty59
|   |   |   `-- [       4096]  dev
|   |   |-- [          0]  tty6
|   |   |   `-- [       4096]  dev
|   |   |-- [          0]  tty60
|   |   |   `-- [       4096]  dev
|   |   |-- [          0]  tty61
|   |   |   `-- [       4096]  dev
|   |   |-- [          0]  tty62
|   |   |   `-- [       4096]  dev
|   |   |-- [          0]  tty63
|   |   |   `-- [       4096]  dev
|   |   |-- [          0]  tty7
|   |   |   `-- [       4096]  dev
|   |   |-- [          0]  tty8
|   |   |   `-- [       4096]  dev
|   |   `-- [          0]  tty9
|   |       `-- [       4096]  dev
|   |-- [          0]  usb
|   `-- [          0]  usb_host
|-- [          0]  devices
|   |-- [          0]  ide-scsi
|   |   |-- [       4096]  name
|   |   `-- [       4096]  power
|   |-- [          0]  legacy
|   |   |-- [       4096]  name
|   |   `-- [       4096]  power
|   |-- [          0]  pci0000:00
|   |   |-- [          0]  0000:00:00.0
|   |   |   |-- [       4096]  class
|   |   |   |-- [        256]  config
|   |   |   |-- [       4096]  device
|   |   |   |-- [       4096]  irq
|   |   |   |-- [       4096]  name
|   |   |   |-- [       4096]  power
|   |   |   |-- [       4096]  resource
|   |   |   |-- [       4096]  subsystem_device
|   |   |   |-- [       4096]  subsystem_vendor
|   |   |   `-- [       4096]  vendor
|   |   |-- [          0]  0000:00:01.0
|   |   |   |-- [          0]  0000:01:00.0
|   |   |   |   |-- [       4096]  class
|   |   |   |   |-- [        256]  config
|   |   |   |   |-- [       4096]  device
|   |   |   |   |-- [       4096]  irq
|   |   |   |   |-- [       4096]  name
|   |   |   |   |-- [       4096]  power
|   |   |   |   |-- [       4096]  resource
|   |   |   |   |-- [       4096]  subsystem_device
|   |   |   |   |-- [       4096]  subsystem_vendor
|   |   |   |   `-- [       4096]  vendor
|   |   |   |-- [       4096]  class
|   |   |   |-- [        256]  config
|   |   |   |-- [       4096]  device
|   |   |   |-- [       4096]  irq
|   |   |   |-- [       4096]  name
|   |   |   |-- [       4096]  power
|   |   |   |-- [       4096]  resource
|   |   |   |-- [       4096]  subsystem_device
|   |   |   |-- [       4096]  subsystem_vendor
|   |   |   `-- [       4096]  vendor
|   |   |-- [          0]  0000:00:1e.0
|   |   |   |-- [          0]  0000:02:0b.0
|   |   |   |   |-- [       4096]  class
|   |   |   |   |-- [        256]  config
|   |   |   |   |-- [       4096]  device
|   |   |   |   |-- [       4096]  irq
|   |   |   |   |-- [       4096]  name
|   |   |   |   |-- [       4096]  power
|   |   |   |   |-- [       4096]  resource
|   |   |   |   |-- [       4096]  subsystem_device
|   |   |   |   |-- [       4096]  subsystem_vendor
|   |   |   |   `-- [       4096]  vendor
|   |   |   |-- [       4096]  class
|   |   |   |-- [        256]  config
|   |   |   |-- [       4096]  device
|   |   |   |-- [       4096]  irq
|   |   |   |-- [       4096]  name
|   |   |   |-- [       4096]  power
|   |   |   |-- [       4096]  resource
|   |   |   |-- [       4096]  subsystem_device
|   |   |   |-- [       4096]  subsystem_vendor
|   |   |   `-- [       4096]  vendor
|   |   |-- [          0]  0000:00:1f.0
|   |   |   |-- [       4096]  class
|   |   |   |-- [        256]  config
|   |   |   |-- [       4096]  device
|   |   |   |-- [       4096]  irq
|   |   |   |-- [       4096]  name
|   |   |   |-- [       4096]  power
|   |   |   |-- [       4096]  resource
|   |   |   |-- [       4096]  subsystem_device
|   |   |   |-- [       4096]  subsystem_vendor
|   |   |   `-- [       4096]  vendor
|   |   |-- [          0]  0000:00:1f.1
|   |   |   |-- [       4096]  class
|   |   |   |-- [        256]  config
|   |   |   |-- [       4096]  device
|   |   |   |-- [          0]  ide0
|   |   |   |   |-- [          0]  0.0
|   |   |   |   |   |-- [         24]  block -> ../../../../../block/hda
|   |   |   |   |   |-- [       4096]  name
|   |   |   |   |   `-- [       4096]  power
|   |   |   |   |-- [       4096]  name
|   |   |   |   `-- [       4096]  power
|   |   |   |-- [          0]  ide1
|   |   |   |   |-- [          0]  1.0
|   |   |   |   |   |-- [         24]  block -> ../../../../../block/hdc
|   |   |   |   |   |-- [       4096]  name
|   |   |   |   |   `-- [       4096]  power
|   |   |   |   |-- [          0]  1.1
|   |   |   |   |   |-- [         24]  block -> ../../../../../block/hdd
|   |   |   |   |   |-- [       4096]  name
|   |   |   |   |   `-- [       4096]  power
|   |   |   |   |-- [       4096]  name
|   |   |   |   `-- [       4096]  power
|   |   |   |-- [       4096]  irq
|   |   |   |-- [       4096]  name
|   |   |   |-- [       4096]  power
|   |   |   |-- [       4096]  resource
|   |   |   |-- [       4096]  subsystem_device
|   |   |   |-- [       4096]  subsystem_vendor
|   |   |   `-- [       4096]  vendor
|   |   |-- [          0]  0000:00:1f.2
|   |   |   |-- [       4096]  class
|   |   |   |-- [        256]  config
|   |   |   |-- [       4096]  device
|   |   |   |-- [       4096]  irq
|   |   |   |-- [       4096]  name
|   |   |   |-- [       4096]  power
|   |   |   |-- [       4096]  resource
|   |   |   |-- [       4096]  subsystem_device
|   |   |   |-- [       4096]  subsystem_vendor
|   |   |   `-- [       4096]  vendor
|   |   |-- [          0]  0000:00:1f.3
|   |   |   |-- [       4096]  class
|   |   |   |-- [        256]  config
|   |   |   |-- [       4096]  device
|   |   |   |-- [       4096]  irq
|   |   |   |-- [       4096]  name
|   |   |   |-- [       4096]  power
|   |   |   |-- [       4096]  resource
|   |   |   |-- [       4096]  subsystem_device
|   |   |   |-- [       4096]  subsystem_vendor
|   |   |   `-- [       4096]  vendor
|   |   |-- [          0]  0000:00:1f.4
|   |   |   |-- [       4096]  class
|   |   |   |-- [        256]  config
|   |   |   |-- [       4096]  device
|   |   |   |-- [       4096]  irq
|   |   |   |-- [       4096]  name
|   |   |   |-- [       4096]  power
|   |   |   |-- [       4096]  resource
|   |   |   |-- [       4096]  subsystem_device
|   |   |   |-- [       4096]  subsystem_vendor
|   |   |   `-- [       4096]  vendor
|   |   |-- [          0]  0000:00:1f.5
|   |   |   |-- [       4096]  class
|   |   |   |-- [        256]  config
|   |   |   |-- [       4096]  device
|   |   |   |-- [       4096]  irq
|   |   |   |-- [       4096]  name
|   |   |   |-- [       4096]  power
|   |   |   |-- [       4096]  resource
|   |   |   |-- [       4096]  subsystem_device
|   |   |   |-- [       4096]  subsystem_vendor
|   |   |   `-- [       4096]  vendor
|   |   |-- [       4096]  name
|   |   `-- [       4096]  power
|   `-- [          0]  system
|       |-- [          0]  cpu
|       |   `-- [          0]  cpu0
|       |-- [          0]  i8259
|       |   `-- [          0]  i82590
|       |-- [          0]  pit
|       |   `-- [          0]  pit0
|       `-- [          0]  timer
|           `-- [          0]  timer0
`-- [          0]  firmware
    `-- [          0]  acpi
        `-- [          0]  namespace
            `-- [          0]  ACPI
                |-- [          0]  CPU
                |-- [          0]  PWRF
                `-- [          0]  _SB
                    |-- [          0]  LNKA
                    |-- [          0]  LNKB
                    |-- [          0]  LNKC
                    |-- [          0]  LNKD
                    |-- [          0]  LNKE
                    |-- [          0]  LNKF
                    |-- [          0]  LNKG
                    |-- [          0]  LNKH
                    |-- [          0]  MEM1
                    |-- [          0]  PCI0
                    |   |-- [          0]  AC97
                    |   |-- [          0]  IDE0
                    |   |   |-- [          0]  CHN0
                    |   |   |   |-- [          0]  DRV0
                    |   |   |   `-- [          0]  DRV1
                    |   |   `-- [          0]  CHN1
                    |   |       |-- [          0]  DRV0
                    |   |       `-- [          0]  DRV1
                    |   |-- [          0]  MCH0
                    |   |-- [          0]  PCI1
                    |   |-- [          0]  PCI2
                    |   |-- [          0]  PX40
                    |   |   |-- [          0]  COPR
                    |   |   |-- [          0]  DMA1
                    |   |   |-- [          0]  ECP
                    |   |   |-- [          0]  FDC0
                    |   |   |-- [          0]  GAME
                    |   |   |-- [          0]  IRDA
                    |   |   |-- [          0]  LPT
                    |   |   |-- [          0]  MIDI
                    |   |   |-- [          0]  PIC
                    |   |   |-- [          0]  PS2K
                    |   |   |-- [          0]  PS2M
                    |   |   |-- [          0]  RTC
                    |   |   |-- [          0]  SPKR
                    |   |   |-- [          0]  SYS1
                    |   |   |-- [          0]  SYS2
                    |   |   |-- [          0]  SYS3
                    |   |   |-- [          0]  TMR
                    |   |   `-- [          0]  UAR1
                    |   |-- [          0]  PX43
                    |   |-- [          0]  USB0
                    |   `-- [          0]  USB1
                    `-- [          0]  PWRB

262 directories, 304 files

--------------070808050001010101000002--

