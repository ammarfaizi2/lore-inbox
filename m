Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263309AbTEOBJv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 21:09:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263338AbTEOBJv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 21:09:51 -0400
Received: from garnet.acns.fsu.edu ([146.201.2.25]:54742 "EHLO
	garnet.acns.fsu.edu") by vger.kernel.org with ESMTP id S263309AbTEOBJe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 21:09:34 -0400
Message-ID: <3EC2EBC0.7020901@cox.net>
Date: Wed, 14 May 2003 21:22:08 -0400
From: David van Hoose <davidvh@cox.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [2.5.69-bk9] BUG & 'Unexpected hw_pointer value' messages
Content-Type: multipart/mixed;
 boundary="------------020100040708050305010407"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020100040708050305010407
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

With bk8 and bk9, I get messages saying 'Unexpected hw_pointer value' 
and it gives some info. I have attached the messages. Just jump to the 
end of the dmesg I've attached. There is also some BUG messages.
If there is anything that I could send to help debug this, let me know. 
I don't know exactly where to look with these.
Does it have to do with my kernel having preempt enabled?

Thanks,
David

--------------020100040708050305010407
Content-Type: text/plain;
 name="config-2.5.69-bk9"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="config-2.5.69-bk9"

CONFIG_X86=y
CONFIG_MMU=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_EXPERIMENTAL=y
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_SYSCTL=y
CONFIG_LOG_BUF_SHIFT=14
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_OBSOLETE_MODPARM=y
CONFIG_MODVERSIONS=y
CONFIG_KMOD=y
CONFIG_X86_PC=y
CONFIG_MPENTIUM4=y
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
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_TSC=y
CONFIG_X86_MCE=y
CONFIG_X86_MCE_NONFATAL=y
CONFIG_X86_MCE_P4THERMAL=y
CONFIG_MICROCODE=y
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
CONFIG_EDD=m
CONFIG_HIGHMEM4G=y
CONFIG_HIGHMEM=y
CONFIG_HIGHPTE=y
CONFIG_MTRR=y
CONFIG_HAVE_DEC_LOCK=y
CONFIG_PM=y
CONFIG_APM=y
CONFIG_APM_CPU_IDLE=y
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_NAMES=y
CONFIG_HOTPLUG=y
CONFIG_KCORE_ELF=y
CONFIG_BINFMT_AOUT=y
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=y
CONFIG_PARPORT=y
CONFIG_PARPORT_PC=y
CONFIG_PARPORT_PC_CML1=y
CONFIG_PARPORT_SERIAL=m
CONFIG_PARPORT_PC_FIFO=y
CONFIG_PARPORT_PC_SUPERIO=y
CONFIG_PARPORT_1284=y
CONFIG_PNP=y
CONFIG_PNP_NAMES=y
CONFIG_ISAPNP=y
CONFIG_PNPBIOS=y
CONFIG_BLK_DEV_FD=y
CONFIG_BLK_DEV_LOOP=y
CONFIG_BLK_DEV_NBD=m
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_BLK_DEV_INITRD=y
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDECD=y
CONFIG_BLK_DEV_IDEFLOPPY=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_BLK_DEV_GENERIC=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_IDEDMA_PCI_WIP=y
CONFIG_BLK_DEV_ADMA=y
CONFIG_BLK_DEV_SIS5513=y
CONFIG_IDEDMA_AUTO=y
CONFIG_BLK_DEV_IDE_MODES=y
CONFIG_SCSI=m
CONFIG_SCSI_REPORT_LUNS=y
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y
CONFIG_SCSI_PPA=m
CONFIG_SCSI_IMM=m
CONFIG_IEEE1394=m
CONFIG_IEEE1394_OHCI1394=m
CONFIG_IEEE1394_VIDEO1394=m
CONFIG_IEEE1394_ETH1394=m
CONFIG_IEEE1394_DV1394=m
CONFIG_IEEE1394_RAWIO=m
CONFIG_IEEE1394_CMP=m
CONFIG_IEEE1394_AMDTP=m
CONFIG_NET=y
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
CONFIG_NETLINK_DEV=y
CONFIG_NETFILTER=y
CONFIG_UNIX=y
CONFIG_NET_KEY=y
CONFIG_INET=y
CONFIG_NET_IPIP=m
CONFIG_NET_IPGRE=m
CONFIG_INET_AH=y
CONFIG_INET_ESP=y
CONFIG_INET_IPCOMP=y
CONFIG_IP_NF_CONNTRACK=y
CONFIG_IP_NF_FTP=y
CONFIG_IP_NF_IRC=y
CONFIG_IP_NF_TFTP=y
CONFIG_IP_NF_AMANDA=y
CONFIG_IP_NF_QUEUE=m
CONFIG_IP_NF_IPTABLES=y
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
CONFIG_IP_NF_MATCH_HELPER=y
CONFIG_IP_NF_MATCH_STATE=m
CONFIG_IP_NF_MATCH_CONNTRACK=m
CONFIG_IP_NF_MATCH_UNCLEAN=m
CONFIG_IP_NF_MATCH_OWNER=m
CONFIG_IP_NF_MATCH_PHYSDEV=m
CONFIG_IP_NF_FILTER=y
CONFIG_IP_NF_TARGET_REJECT=y
CONFIG_IP_NF_TARGET_MIRROR=m
CONFIG_IP_NF_NAT=y
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=y
CONFIG_IP_NF_TARGET_REDIRECT=y
CONFIG_IP_NF_NAT_LOCAL=y
CONFIG_IP_NF_NAT_SNMP_BASIC=m
CONFIG_IP_NF_NAT_IRC=y
CONFIG_IP_NF_NAT_FTP=y
CONFIG_IP_NF_NAT_TFTP=y
CONFIG_IP_NF_NAT_AMANDA=y
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
CONFIG_IPV6=y
CONFIG_IPV6_PRIVACY=y
CONFIG_INET6_AH=y
CONFIG_INET6_ESP=y
CONFIG_IP6_NF_QUEUE=m
CONFIG_IP6_NF_IPTABLES=y
CONFIG_IP6_NF_MATCH_LIMIT=m
CONFIG_IP6_NF_MATCH_MAC=m
CONFIG_IP6_NF_MATCH_RT=m
CONFIG_IP6_NF_MATCH_OPTS=m
CONFIG_IP6_NF_MATCH_FRAG=m
CONFIG_IP6_NF_MATCH_HL=m
CONFIG_IP6_NF_MATCH_MULTIPORT=m
CONFIG_IP6_NF_MATCH_OWNER=m
CONFIG_IP6_NF_MATCH_MARK=m
CONFIG_IP6_NF_MATCH_IPV6HEADER=m
CONFIG_IP6_NF_MATCH_AHESP=m
CONFIG_IP6_NF_MATCH_LENGTH=m
CONFIG_IP6_NF_MATCH_EUI64=m
CONFIG_IP6_NF_FILTER=y
CONFIG_IP6_NF_TARGET_LOG=y
CONFIG_IP6_NF_MANGLE=m
CONFIG_IP6_NF_TARGET_MARK=m
CONFIG_XFRM_USER=y
CONFIG_IPV6_SCTP__=y
CONFIG_VLAN_8021Q=m
CONFIG_LLC=y
CONFIG_LLC_UI=y
CONFIG_IPX=m
CONFIG_ATALK=m
CONFIG_DEV_APPLETALK=y
CONFIG_IPDDP=m
CONFIG_IPDDP_ENCAP=y
CONFIG_IPDDP_DECAP=y
CONFIG_BRIDGE=m
CONFIG_NETDEVICES=y
CONFIG_DUMMY=y
CONFIG_BONDING=m
CONFIG_NET_ETHERNET=y
CONFIG_NET_TULIP=y
CONFIG_TULIP=m
CONFIG_TULIP_MMIO=y
CONFIG_NET_PCI=y
CONFIG_SIS900=m
CONFIG_INPUT=y
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=y
CONFIG_INPUT_EVDEV=y
CONFIG_GAMEPORT=y
CONFIG_SOUND_GAMEPORT=y
CONFIG_GAMEPORT_NS558=y
CONFIG_GAMEPORT_EMU10K1=m
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_MOUSE_SERIAL=m
CONFIG_INPUT_JOYSTICK=y
CONFIG_JOYSTICK_ANALOG=y
CONFIG_INPUT_TOUCHSCREEN=y
CONFIG_INPUT_MISC=y
CONFIG_INPUT_PCSPKR=y
CONFIG_INPUT_UINPUT=m
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_EXTENDED=y
CONFIG_SERIAL_CORE=y
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_PRINTER=y
CONFIG_BUSMOUSE=y
CONFIG_HW_RANDOM=m
CONFIG_RTC=y
CONFIG_AGP=m
CONFIG_AGP_SIS=m
CONFIG_DRM=y
CONFIG_RAW_DRIVER=m
CONFIG_HANGCHECK_TIMER=m
CONFIG_EXT2_FS=y
CONFIG_EXT3_FS=y
CONFIG_JBD=y
CONFIG_JBD_DEBUG=y
CONFIG_QUOTA=y
CONFIG_QFMT_V1=m
CONFIG_QFMT_V2=m
CONFIG_QUOTACTL=y
CONFIG_AUTOFS_FS=m
CONFIG_AUTOFS4_FS=m
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_ZISOFS_FS=y
CONFIG_UDF_FS=m
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=y
CONFIG_NTFS_FS=m
CONFIG_PROC_FS=y
CONFIG_DEVPTS_FS=y
CONFIG_TMPFS=y
CONFIG_RAMFS=y
CONFIG_HFS_FS=m
CONFIG_EFS_FS=m
CONFIG_HPFS_FS=m
CONFIG_NFS_FS=m
CONFIG_NFS_V3=y
CONFIG_NFSD=m
CONFIG_NFSD_V3=y
CONFIG_NFSD_TCP=y
CONFIG_LOCKD=m
CONFIG_LOCKD_V4=y
CONFIG_EXPORTFS=m
CONFIG_SUNRPC=m
CONFIG_SUNRPC_GSS=m
CONFIG_RPCSEC_GSS_KRB5=m
CONFIG_SMB_FS=y
CONFIG_SMB_NLS_DEFAULT=y
CONFIG_SMB_NLS_REMOTE="cp437"
CONFIG_CIFS=m
CONFIG_PARTITION_ADVANCED=y
CONFIG_MSDOS_PARTITION=y
CONFIG_SMB_NLS=y
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_ISO8859_1=y
CONFIG_NLS_ISO8859_15=y
CONFIG_NLS_UTF8=y
CONFIG_VIDEO_SELECT=y
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_SOUND=m
CONFIG_SND=m
CONFIG_SND_SEQUENCER=m
CONFIG_SND_SEQ_DUMMY=m
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=m
CONFIG_SND_PCM_OSS=m
CONFIG_SND_SEQUENCER_OSS=y
CONFIG_SND_RTCTIMER=m
CONFIG_SND_DEBUG=y
CONFIG_SND_DEBUG_DETECT=y
CONFIG_SND_DUMMY=m
CONFIG_SND_VIRMIDI=m
CONFIG_SND_MTPAV=m
CONFIG_SND_SERIAL_U16550=m
CONFIG_SND_MPU401=m
CONFIG_SND_EMU10K1=m
CONFIG_SND_ENS1370=m
CONFIG_SND_ENS1371=m
CONFIG_SND_INTEL8X0=m
CONFIG_SND_USB_AUDIO=m
CONFIG_USB=m
CONFIG_USB_DEVICEFS=y
CONFIG_USB_BANDWIDTH=y
CONFIG_USB_EHCI_HCD=m
CONFIG_USB_OHCI_HCD=m
CONFIG_USB_UHCI_HCD=m
CONFIG_USB_AUDIO=m
CONFIG_USB_MIDI=m
CONFIG_USB_PRINTER=m
CONFIG_USB_HID=m
CONFIG_USB_HIDINPUT=y
CONFIG_USB_HIDDEV=y
CONFIG_USB_SCANNER=m
CONFIG_USB_USS720=m
CONFIG_USB_SERIAL=m
CONFIG_USB_SERIAL_GENERIC=y
CONFIG_USB_EMI26=m
CONFIG_USB_TIGL=m
CONFIG_PROFILING=y
CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_STACKOVERFLOW=y
CONFIG_DEBUG_SLAB=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_KALLSYMS=y
CONFIG_FRAME_POINTER=y
CONFIG_X86_EXTRA_IRQS=y
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_MPPARSE=y
CONFIG_CRYPTO=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_NULL=m
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA256=m
CONFIG_CRYPTO_SHA512=m
CONFIG_CRYPTO_DES=y
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_SERPENT=m
CONFIG_CRYPTO_AES=m
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRC32=m
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_X86_BIOS_REBOOT=y

--------------020100040708050305010407
Content-Type: text/plain;
 name="dmesg-2.5.69-bk9"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg-2.5.69-bk9"

iletype instead, the 'usbdevfs' name is deprecated.
ohci-hcd 00:03.0: new USB bus registered, assigned bus number 1
hub 1-0:0: USB hub found
hub 1-0:0: 2 ports detected
ohci-hcd 00:03.1: Silicon Integrated S 7001 (#2)
ohci-hcd 00:03.1: irq 9, pci mem e082f000
ohci-hcd 00:03.1: new USB bus registered, assigned bus number 2
hub 2-0:0: USB hub found
hub 2-0:0: 2 ports detected
ohci-hcd 00:03.2: Silicon Integrated S 7001 (#3)
ohci-hcd 00:03.2: irq 9, pci mem e0831000
ohci-hcd 00:03.2: new USB bus registered, assigned bus number 3
hub 3-0:0: USB hub found
hub 3-0:0: 2 ports detected
ehci-hcd 00:03.3: Silicon Integrated S SiS7002 USB 2.0
ehci-hcd 00:03.3: irq 9, pci mem e083a000
ehci-hcd 00:03.3: new USB bus registered, assigned bus number 4
PCI: cache line size of 128 is not supported by device 00:03.3
ehci-hcd 00:03.3: USB 2.0 enabled, EHCI 1.00, driver 2003-Jan-22
hub 4-0:0: USB hub found
hub 4-0:0: 6 ports detected
drivers/usb/core/usb.c: registered new driver hiddev
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
hub 4-0:0: debounce: port 1: delay 100ms stable 4 status 0x501
hub 4-0:0: debounce: port 2: delay 100ms stable 4 status 0x501
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on hda2, internal journal
Adding 1004020k swap on /dev/hda5.  Priority:-1 extents:1
hub 1-0:0: debounce: port 1: delay 100ms stable 4 status 0x301
hub 1-0:0: new USB device on port 1, assigned address 2
input: USB HID v1.10 Mouse [Logitech USB Receiver] on usb-00:03.0-1
hub 2-0:0: debounce: port 1: delay 100ms stable 4 status 0x101
hub 2-0:0: new USB device on port 1, assigned address 2
intel8x0: clocking to 48000
joystick(s) found
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Trying generic SiS routines for device id: 0648
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: AGP aperture is 128M @ 0xe0000000
usb 2-1: USB device not accepting new address=2 (error=-110)
hub 2-0:0: new USB device on port 1, assigned address 3
usb 2-1: USB device not accepting new address=3 (error=-110)
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on hda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on hda7, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
ohci1394: $Rev: 921 $ Ben Collins <bcollins@debian.org>
ohci1394_0: Unexpected PCI resource length of 1000!
ohci1394_0: OHCI-1394 1.0 (PCI): IRQ=[10]  MMIO=[de800000-de8007ff]  Max Packet=[2048]
ieee1394: unsolicited response packet received - np
ieee1394: contents: ffc00160 ffc00000 00000000 becd0404
ieee1394: unsolicited response packet received - np
ieee1394: contents: ffc00560 ffc00000 00000000 becd0404
ieee1394: unsolicited response packet received - np
ieee1394: contents: ffc00960 ffc00000 00000000 becd0404
ieee1394: ConfigROM quadlet transaction error for node 00:1023
Disabled Privacy Extensions on device c036bfa0(lo)
sis900.c: v1.08.06 9/24/2002
eth0: Realtek RTL8201 PHY transceiver found at address 1.
eth0: Using transceiver found at address 1 as default
eth0: SiS 900 PCI Fast Ethernet at 0x9800, IRQ 9, 00:e0:18:9d:4f:d0.
eth0: Media Link On 100mbps full-duplex 
Linux Tulip driver version 1.1.13 (May 11, 2002)
eth1: ADMtek Comet rev 17 at 0xe083c000, 00:20:78:04:68:6F, IRQ 9.
eth0: no IPv6 routers present
drivers/usb/serial/usb-serial.c: USB Serial support registered for Generic
drivers/usb/core/usb.c: registered new driver usbserial
drivers/usb/serial/usb-serial.c: USB Serial Driver core v2.0
nvidia: module license 'NVIDIA' taints kernel.
0: nvidia: loading NVIDIA Linux x86 nvidia.o Kernel Module  1.0-4363  Sat Apr 19 17:46:46 PDT 2003
agpgart: Found an AGP 2.0 compliant device at 00:00.0.
agpgart: Putting AGP V2 device at 00:00.0 into 4x mode
agpgart: Putting AGP V2 device at 01:00.0 into 4x mode
Unexpected hw_pointer value (stream = 1, delta: -1114, max jitter = 4456): wrong interrupt acknowledge?
Unexpected hw_pointer value (stream = 1, delta: -1106, max jitter = 4456): wrong interrupt acknowledge?
Unexpected hw_pointer value (stream = 1, delta: -1114, max jitter = 4456): wrong interrupt acknowledge?
Unexpected hw_pointer value (stream = 1, delta: -1114, max jitter = 4456): wrong interrupt acknowledge?
Unexpected hw_pointer value (stream = 1, delta: -1105, max jitter = 4456): wrong interrupt acknowledge?
Unexpected hw_pointer value (stream = 1, delta: -1114, max jitter = 4456): wrong interrupt acknowledge?
Unexpected hw_pointer value (stream = 1, delta: -1114, max jitter = 4456): wrong interrupt acknowledge?
Unexpected hw_pointer value (stream = 1, delta: -1106, max jitter = 4456): wrong interrupt acknowledge?
Unexpected hw_pointer value (stream = 1, delta: -1114, max jitter = 4456): wrong interrupt acknowledge?
Unexpected hw_pointer value (stream = 1, delta: -1113, max jitter = 4456): wrong interrupt acknowledge?
Unexpected hw_pointer value (stream = 1, delta: -1106, max jitter = 4456): wrong interrupt acknowledge?
Unexpected hw_pointer value (stream = 1, delta: -1114, max jitter = 4456): wrong interrupt acknowledge?
BUG: stream = 1, pos = 0x22d0, buffer size = 0x22d0, period size = 0x45a
Unexpected hw_pointer value (stream = 1, delta: -1110, max jitter = 4456): wrong interrupt acknowledge?
Unexpected hw_pointer value (stream = 1, delta: -1103, max jitter = 4456): wrong interrupt acknowledge?
Unexpected hw_pointer value (stream = 1, delta: -1114, max jitter = 4456): wrong interrupt acknowledge?
Unexpected hw_pointer value (stream = 1, delta: -1103, max jitter = 4456): wrong interrupt acknowledge?
Unexpected hw_pointer value (stream = 1, delta: -1114, max jitter = 4456): wrong interrupt acknowledge?
Unexpected hw_pointer value (stream = 1, delta: -1114, max jitter = 4456): wrong interrupt acknowledge?
Unexpected hw_pointer value (stream = 1, delta: -1106, max jitter = 4456): wrong interrupt acknowledge?
Unexpected hw_pointer value (stream = 1, delta: -1114, max jitter = 4456): wrong interrupt acknowledge?
BUG: stream = 1, pos = 0x22d0, buffer size = 0x22d0, period size = 0x45a
Unexpected hw_pointer value (stream = 1, delta: -1109, max jitter = 4456): wrong interrupt acknowledge?
Unexpected hw_pointer value (stream = 1, delta: -1102, max jitter = 4456): wrong interrupt acknowledge?
Unexpected hw_pointer value (stream = 1, delta: -1114, max jitter = 4456): wrong interrupt acknowledge?
Unexpected hw_pointer value (stream = 1, delta: -1107, max jitter = 4456): wrong interrupt acknowledge?
Unexpected hw_pointer value (stream = 1, delta: -1114, max jitter = 4456): wrong interrupt acknowledge?
Unexpected hw_pointer value (stream = 1, delta: -1114, max jitter = 4456): wrong interrupt acknowledge?
Unexpected hw_pointer value (stream = 1, delta: -1106, max jitter = 4456): wrong interrupt acknowledge?
Unexpected hw_pointer value (stream = 1, delta: -508, max jitter = 4456): wrong interrupt acknowledge?
Unexpected hw_pointer value (stream = 1, delta: -1114, max jitter = 4456): wrong interrupt acknowledge?
Unexpected hw_pointer value (stream = 1, delta: -1114, max jitter = 4456): wrong interrupt acknowledge?
Unexpected hw_pointer value (stream = 1, delta: -1106, max jitter = 4456): wrong interrupt acknowledge?
Unexpected hw_pointer value (stream = 1, delta: -506, max jitter = 4456): wrong interrupt acknowledge?
Unexpected hw_pointer value (stream = 1, delta: -1114, max jitter = 4456): wrong interrupt acknowledge?
Unexpected hw_pointer value (stream = 1, delta: -1114, max jitter = 4456): wrong interrupt acknowledge?
Unexpected hw_pointer value (stream = 1, delta: -1106, max jitter = 4456): wrong interrupt acknowledge?
Unexpected hw_pointer value (stream = 1, delta: -1114, max jitter = 4456): wrong interrupt acknowledge?
BUG: stream = 1, pos = 0x22d0, buffer size = 0x22d0, period size = 0x45a
Unexpected hw_pointer value (stream = 1, delta: -1109, max jitter = 4456): wrong interrupt acknowledge?
Unexpected hw_pointer value (stream = 1, delta: -1101, max jitter = 4456): wrong interrupt acknowledge?
Unexpected hw_pointer value (stream = 1, delta: -1114, max jitter = 4456): wrong interrupt acknowledge?
Unexpected hw_pointer value (stream = 1, delta: -1106, max jitter = 4456): wrong interrupt acknowledge?
Unexpected hw_pointer value (stream = 1, delta: -1114, max jitter = 4456): wrong interrupt acknowledge?
Unexpected hw_pointer value (stream = 1, delta: -1114, max jitter = 4456): wrong interrupt acknowledge?
Unexpected hw_pointer value (stream = 1, delta: -1106, max jitter = 4456): wrong interrupt acknowledge?
Unexpected hw_pointer value (stream = 1, delta: -1114, max jitter = 4456): wrong interrupt acknowledge?
Unexpected hw_pointer value (stream = 1, delta: -1114, max jitter = 4456): wrong interrupt acknowledge?
Unexpected hw_pointer value (stream = 1, delta: -1105, max jitter = 4456): wrong interrupt acknowledge?
Unexpected hw_pointer value (stream = 1, delta: -1114, max jitter = 4456): wrong interrupt acknowledge?
Unexpected hw_pointer value (stream = 0, delta: -1109, max jitter = 4456): wrong interrupt acknowledge?
Unexpected hw_pointer value (stream = 0, delta: -1102, max jitter = 4456): wrong interrupt acknowledge?
Unexpected hw_pointer value (stream = 0, delta: -1101, max jitter = 4456): wrong interrupt acknowledge?
Unexpected hw_pointer value (stream = 0, delta: -1097, max jitter = 4456): wrong interrupt acknowledge?
Unexpected hw_pointer value (stream = 0, delta: -1090, max jitter = 4456): wrong interrupt acknowledge?
Unexpected hw_pointer value (stream = 0, delta: -1114, max jitter = 4456): wrong interrupt acknowledge?
Unexpected hw_pointer value (stream = 0, delta: -1110, max jitter = 4456): wrong interrupt acknowledge?
Unexpected hw_pointer value (stream = 0, delta: -1101, max jitter = 4456): wrong interrupt acknowledge?
Unexpected hw_pointer value (stream = 0, delta: -1095, max jitter = 4456): wrong interrupt acknowledge?
Unexpected hw_pointer value (stream = 0, delta: -1084, max jitter = 4456): wrong interrupt acknowledge?
Unexpected hw_pointer value (stream = 0, delta: -1076, max jitter = 4456): wrong interrupt acknowledge?
Unexpected hw_pointer value (stream = 0, delta: -1074, max jitter = 4456): wrong interrupt acknowledge?
Unexpected hw_pointer value (stream = 0, delta: -1114, max jitter = 4456): wrong interrupt acknowledge?
Unexpected hw_pointer value (stream = 0, delta: -1109, max jitter = 4456): wrong interrupt acknowledge?
Unexpected hw_pointer value (stream = 0, delta: -1102, max jitter = 4456): wrong interrupt acknowledge?
Unexpected hw_pointer value (stream = 0, delta: -1097, max jitter = 4456): wrong interrupt acknowledge?
Unexpected hw_pointer value (stream = 0, delta: -1091, max jitter = 4456): wrong interrupt acknowledge?
Unexpected hw_pointer value (stream = 0, delta: -1114, max jitter = 4456): wrong interrupt acknowledge?
Unexpected hw_pointer value (stream = 0, delta: -1109, max jitter = 4456): wrong interrupt acknowledge?
Unexpected hw_pointer value (stream = 0, delta: -1102, max jitter = 4456): wrong interrupt acknowledge?
Unexpected hw_pointer value (stream = 0, delta: -1097, max jitter = 4456): wrong interrupt acknowledge?
Unexpected hw_pointer value (stream = 0, delta: -1091, max jitter = 4456): wrong interrupt acknowledge?
Unexpected hw_pointer value (stream = 0, delta: -1114, max jitter = 4456): wrong interrupt acknowledge?
Unexpected hw_pointer value (stream = 0, delta: -1109, max jitter = 4456): wrong interrupt acknowledge?
Unexpected hw_pointer value (stream = 0, delta: -1102, max jitter = 4456): wrong interrupt acknowledge?
Unexpected hw_pointer value (stream = 0, delta: -1097, max jitter = 4456): wrong interrupt acknowledge?
Unexpected hw_pointer value (stream = 0, delta: -1090, max jitter = 4456): wrong interrupt acknowledge?
Unexpected hw_pointer value (stream = 0, delta: -1114, max jitter = 4456): wrong interrupt acknowledge?
BUG: stream = 0, pos = 0x22d0, buffer size = 0x22d0, period size = 0x45a
Unexpected hw_pointer value (stream = 0, delta: -1104, max jitter = 4456): wrong interrupt acknowledge?
Unexpected hw_pointer value (stream = 0, delta: -1096, max jitter = 4456): wrong interrupt acknowledge?
Unexpected hw_pointer value (stream = 0, delta: -1083, max jitter = 4456): wrong interrupt acknowledge?
Unexpected hw_pointer value (stream = 0, delta: -1079, max jitter = 4456): wrong interrupt acknowledge?
Unexpected hw_pointer value (stream = 0, delta: -1071, max jitter = 4456): wrong interrupt acknowledge?
Unexpected hw_pointer value (stream = 0, delta: -1110, max jitter = 4456): wrong interrupt acknowledge?
Unexpected hw_pointer value (stream = 0, delta: -1101, max jitter = 4456): wrong interrupt acknowledge?
Unexpected hw_pointer value (stream = 0, delta: -1095, max jitter = 4456): wrong interrupt acknowledge?
Unexpected hw_pointer value (stream = 0, delta: -1084, max jitter = 4456): wrong interrupt acknowledge?
Unexpected hw_pointer value (stream = 0, delta: -1077, max jitter = 4456): wrong interrupt acknowledge?
Unexpected hw_pointer value (stream = 0, delta: -1114, max jitter = 4456): wrong interrupt acknowledge?
Unexpected hw_pointer value (stream = 0, delta: -1111, max jitter = 4456): wrong interrupt acknowledge?
Unexpected hw_pointer value (stream = 0, delta: -1104, max jitter = 4456): wrong interrupt acknowledge?
Unexpected hw_pointer value (stream = 0, delta: -1099, max jitter = 4456): wrong interrupt acknowledge?
Unexpected hw_pointer value (stream = 0, delta: -1092, max jitter = 4456): wrong interrupt acknowledge?
Unexpected hw_pointer value (stream = 0, delta: -1114, max jitter = 4456): wrong interrupt acknowledge?
Unexpected hw_pointer value (stream = 0, delta: -1109, max jitter = 4456): wrong interrupt acknowledge?
Unexpected hw_pointer value (stream = 0, delta: -1102, max jitter = 4456): wrong interrupt acknowledge?
Unexpected hw_pointer value (stream = 0, delta: -1097, max jitter = 4456): wrong interrupt acknowledge?
Unexpected hw_pointer value (stream = 0, delta: -1090, max jitter = 4456): wrong interrupt acknowledge?
Unexpected hw_pointer value (stream = 0, delta: -1114, max jitter = 4456): wrong interrupt acknowledge?
Unexpected hw_pointer value (stream = 0, delta: -1110, max jitter = 4456): wrong interrupt acknowledge?
Unexpected hw_pointer value (stream = 0, delta: -1100, max jitter = 4456): wrong interrupt acknowledge?
Unexpected hw_pointer value (stream = 0, delta: -1098, max jitter = 4456): wrong interrupt acknowledge?
Unexpected hw_pointer value (stream = 0, delta: -1093, max jitter = 4456): wrong interrupt acknowledge?
Unexpected hw_pointer value (stream = 0, delta: -1085, max jitter = 4456): wrong interrupt acknowledge?
Unexpected hw_pointer value (stream = 0, delta: -1114, max jitter = 4456): wrong interrupt acknowledge?
Unexpected hw_pointer value (stream = 0, delta: -1110, max jitter = 4456): wrong interrupt acknowledge?
Unexpected hw_pointer value (stream = 0, delta: -1100, max jitter = 4456): wrong interrupt acknowledge?
Unexpected hw_pointer value (stream = 0, delta: -1094, max jitter = 4456): wrong interrupt acknowledge?
Unexpected hw_pointer value (stream = 0, delta: -1086, max jitter = 4456): wrong interrupt acknowledge?
Unexpected hw_pointer value (stream = 0, delta: -1114, max jitter = 4456): wrong interrupt acknowledge?
BUG: stream = 0, pos = 0x22d0, buffer size = 0x22d0, period size = 0x45a
Unexpected hw_pointer value (stream = 0, delta: -1104, max jitter = 4456): wrong interrupt acknowledge?
Unexpected hw_pointer value (stream = 0, delta: -1096, max jitter = 4456): wrong interrupt acknowledge?
Unexpected hw_pointer value (stream = 0, delta: -1082, max jitter = 4456): wrong interrupt acknowledge?
Unexpected hw_pointer value (stream = 0, delta: -1074, max jitter = 4456): wrong interrupt acknowledge?

--------------020100040708050305010407--

