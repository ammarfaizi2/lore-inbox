Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313182AbSDZHb6>; Fri, 26 Apr 2002 03:31:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313238AbSDZHb5>; Fri, 26 Apr 2002 03:31:57 -0400
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:44548 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S313182AbSDZHbz>; Fri, 26 Apr 2002 03:31:55 -0400
Date: Fri, 26 Apr 2002 09:31:30 +0200
From: Jurriaan on Alpha <thunder7@xs4all.nl>
To: linux-kernel@vger.kernel.org
Subject: compiling cmipci in 2.5.10 on Alpha doesn't work
Message-ID: <20020426073130.GB28217@alpha.of.nowhere>
Reply-To: thunder7@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Message-Flag: Still using Outlook? Please Upgrade to real software!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I tried to compile 2.5.10 on my Alpha, but the cmipci module won't
compile:

cmipci.c:2399: elements of array `snd_cmipci_ids' have incomplete type
cmipci.c:2400: warning: excess elements in struct initializer
cmipci.c:2400: warning: (near initialization for `snd_cmipci_ids[0]')
cmipci.c:2400: warning: excess elements in struct initializer
cmipci.c:2400: warning: (near initialization for `snd_cmipci_ids[0]')
cmipci.c:2400: `PCI_ANY_ID' undeclared here (not in a function)
cmipci.c:2400: warning: excess elements in struct initializer
cmipci.c:2400: warning: (near initialization for `snd_cmipci_ids[0]')
cmipci.c:2400: `PCI_ANY_ID' undeclared here (not in a function)
cmipci.c:2400: warning: excess elements in struct initializer
cmipci.c:2400: warning: (near initialization for `snd_cmipci_ids[0]')
cmipci.c:2400: warning: excess elements in struct initializer
cmipci.c:2400: warning: (near initialization for `snd_cmipci_ids[0]')
cmipci.c:2400: warning: excess elements in struct initializer
cmipci.c:2400: warning: (near initialization for `snd_cmipci_ids[0]')
cmipci.c:2400: warning: excess elements in struct initializer
cmipci.c:2400: warning: (near initialization for `snd_cmipci_ids[0]')
cmipci.c:2401: warning: excess elements in struct initializer
cmipci.c:2401: warning: (near initialization for `snd_cmipci_ids[1]')
cmipci.c:2401: warning: excess elements in struct initializer
cmipci.c:2401: warning: (near initialization for `snd_cmipci_ids[1]')
cmipci.c:2401: `PCI_ANY_ID' undeclared here (not in a function)
cmipci.c:2401: warning: excess elements in struct initializer
cmipci.c:2401: warning: (near initialization for `snd_cmipci_ids[1]')
cmipci.c:2401: `PCI_ANY_ID' undeclared here (not in a function)
cmipci.c:2401: warning: excess elements in struct initializer
cmipci.c:2401: warning: (near initialization for `snd_cmipci_ids[1]')
cmipci.c:2401: warning: excess elements in struct initializer
cmipci.c:2401: warning: (near initialization for `snd_cmipci_ids[1]')
cmipci.c:2401: warning: excess elements in struct initializer
cmipci.c:2401: warning: (near initialization for `snd_cmipci_ids[1]')
cmipci.c:2401: warning: excess elements in struct initializer
cmipci.c:2401: warning: (near initialization for `snd_cmipci_ids[1]')
cmipci.c:2402: warning: excess elements in struct initializer
cmipci.c:2402: warning: (near initialization for `snd_cmipci_ids[2]')
cmipci.c:2402: warning: excess elements in struct initializer
cmipci.c:2402: warning: (near initialization for `snd_cmipci_ids[2]')
cmipci.c:2402: `PCI_ANY_ID' undeclared here (not in a function)
cmipci.c:2402: warning: excess elements in struct initializer
cmipci.c:2402: warning: (near initialization for `snd_cmipci_ids[2]')
cmipci.c:2402: `PCI_ANY_ID' undeclared here (not in a function)
cmipci.c:2402: warning: excess elements in struct initializer
cmipci.c:2402: warning: (near initialization for `snd_cmipci_ids[2]')
cmipci.c:2402: warning: excess elements in struct initializer
cmipci.c:2402: warning: (near initialization for `snd_cmipci_ids[2]')
cmipci.c:2402: warning: excess elements in struct initializer
cmipci.c:2402: warning: (near initialization for `snd_cmipci_ids[2]')
cmipci.c:2402: warning: excess elements in struct initializer
cmipci.c:2402: warning: (near initialization for `snd_cmipci_ids[2]')
cmipci.c:2403: warning: excess elements in struct initializer
cmipci.c:2403: warning: (near initialization for `snd_cmipci_ids[3]')
cmipci.c:2403: warning: excess elements in struct initializer
cmipci.c:2403: warning: (near initialization for `snd_cmipci_ids[3]')
cmipci.c:2403: `PCI_ANY_ID' undeclared here (not in a function)
cmipci.c:2403: warning: excess elements in struct initializer
cmipci.c:2403: warning: (near initialization for `snd_cmipci_ids[3]')
cmipci.c:2403: `PCI_ANY_ID' undeclared here (not in a function)
cmipci.c:2403: warning: excess elements in struct initializer
cmipci.c:2403: warning: (near initialization for `snd_cmipci_ids[3]')
cmipci.c:2403: warning: excess elements in struct initializer
cmipci.c:2403: warning: (near initialization for `snd_cmipci_ids[3]')
cmipci.c:2403: warning: excess elements in struct initializer
cmipci.c:2403: warning: (near initialization for `snd_cmipci_ids[3]')
cmipci.c:2403: warning: excess elements in struct initializer
cmipci.c:2403: warning: (near initialization for `snd_cmipci_ids[3]')
cmipci.c:2404: `PCI_VENDOR_ID_AL' undeclared here (not in a function)
cmipci.c:2404: warning: excess elements in struct initializer
cmipci.c:2404: warning: (near initialization for `snd_cmipci_ids[4]')
cmipci.c:2404: warning: excess elements in struct initializer
cmipci.c:2404: warning: (near initialization for `snd_cmipci_ids[4]')
cmipci.c:2404: `PCI_ANY_ID' undeclared here (not in a function)
cmipci.c:2404: warning: excess elements in struct initializer
cmipci.c:2404: warning: (near initialization for `snd_cmipci_ids[4]')
cmipci.c:2404: `PCI_ANY_ID' undeclared here (not in a function)
cmipci.c:2404: warning: excess elements in struct initializer
cmipci.c:2404: warning: (near initialization for `snd_cmipci_ids[4]')
cmipci.c:2404: warning: excess elements in struct initializer
cmipci.c:2404: warning: (near initialization for `snd_cmipci_ids[4]')
cmipci.c:2404: warning: excess elements in struct initializer
cmipci.c:2404: warning: (near initialization for `snd_cmipci_ids[4]')
cmipci.c:2404: warning: excess elements in struct initializer
cmipci.c:2404: warning: (near initialization for `snd_cmipci_ids[4]')
cmipci.c:2405: warning: excess elements in struct initializer
cmipci.c:2405: warning: (near initialization for `snd_cmipci_ids[5]')
cmipci.c:2406: invalid use of undefined type `struct pci_device_id'
cmipci.c: In function `snd_cmipci_free':
cmipci.c:2479: warning: implicit declaration of function `release_resource'
cmipci.c: In function `snd_cmipci_create':
cmipci.c:2508: warning: implicit declaration of function `pci_enable_device'
cmipci.c:2517: dereferencing pointer to incomplete type
cmipci.c:2521: warning: implicit declaration of function `pci_resource_start'
cmipci.c:2526: warning: implicit declaration of function `request_region'
cmipci.c:2526: warning: assignment makes pointer from integer without a cast
cmipci.c:2531: dereferencing pointer to incomplete type
cmipci.c:2532: dereferencing pointer to incomplete type
cmipci.c:2536: dereferencing pointer to incomplete type
cmipci.c:2538: warning: implicit declaration of function `pci_set_master'
cmipci.c: At top level:
cmipci.c:2668: sizeof applied to an incomplete type
cmipci.c: In function `snd_cmipci_probe':
cmipci.c:2689: dereferencing pointer to incomplete type
cmipci.c:2692: warning: unreachable code at beginning of switch statement
cmipci.c:2724: warning: implicit declaration of function `pci_set_drvdata'
cmipci.c: In function `snd_cmipci_remove':
cmipci.c:2732: warning: implicit declaration of function `pci_get_drvdata'
cmipci.c:2732: warning: passing arg 1 of `snd_card_free' makes pointer from integer without a cast
cmipci.c: At top level:
cmipci.c:2737: variable `driver' has initializer but incomplete type
cmipci.c:2738: unknown field `name' specified in initializer
cmipci.c:2738: warning: excess elements in struct initializer
cmipci.c:2738: warning: (near initialization for `driver')
cmipci.c:2739: unknown field `id_table' specified in initializer
cmipci.c:2739: warning: excess elements in struct initializer
cmipci.c:2739: warning: (near initialization for `driver')
cmipci.c:2740: unknown field `probe' specified in initializer
cmipci.c:2740: warning: excess elements in struct initializer
cmipci.c:2740: warning: (near initialization for `driver')
cmipci.c:2741: unknown field `remove' specified in initializer
cmipci.c:2741: warning: excess elements in struct initializer
cmipci.c:2741: warning: (near initialization for `driver')
cmipci.c: In function `alsa_card_cmipci_init':
cmipci.c:2748: warning: implicit declaration of function `pci_module_init'
cmipci.c: In function `alsa_card_cmipci_exit':
cmipci.c:2759: warning: implicit declaration of function `pci_unregister_driver'
cmipci.c: At top level:
cmipci.c:2731: warning: `snd_cmipci_remove' defined but not used
make[2]: *** [cmipci.o] Error 1
make[1]: *** [_modsubdir_pci] Error 2
make: *** [_mod_sound] Error 2

This is debian/Alpha (testing), on a Miata-type Alpha workstation.

.config:

CONFIG_ALPHA=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_EXPERIMENTAL=y
CONFIG_NET=y
CONFIG_SYSVIPC=y
CONFIG_SYSCTL=y
CONFIG_MODULES=y
CONFIG_KMOD=y
CONFIG_ALPHA_MIATA=y
CONFIG_ISA=y
CONFIG_EISA=y
CONFIG_PCI=y
CONFIG_ALPHA_EV5=y
CONFIG_ALPHA_EV56=y
CONFIG_ALPHA_CIA=y
CONFIG_ALPHA_PYXIS=y
CONFIG_PCI_NAMES=y
CONFIG_KCORE_ELF=y
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_EM86=y
CONFIG_PARPORT=m
CONFIG_BLK_DEV_FD=y
CONFIG_BLK_DEV_LOOP=m
CONFIG_PACKET=y
CONFIG_NETLINK_DEV=y
CONFIG_NETFILTER=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_ROUTE_VERBOSE=y
CONFIG_INET_ECN=y
CONFIG_SYN_COOKIES=y
CONFIG_IP_NF_CONNTRACK=m
CONFIG_IP_NF_FTP=m
CONFIG_IP_NF_IRC=m
CONFIG_IP_NF_QUEUE=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_NAT_IRC=m
CONFIG_IP_NF_NAT_FTP=m
CONFIG_IP_NF_COMPAT_IPCHAINS=y
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_VLAN_8021Q=m
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDECD=y
CONFIG_BLK_DEV_CMD640=y
CONFIG_BLK_DEV_CMD640_ENHANCED=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_BLK_DEV_ALI15X3=y
CONFIG_BLK_DEV_CMD64X=y
CONFIG_BLK_DEV_PDC202XX=y
CONFIG_PDC202XX_BURST=y
CONFIG_IDEDMA_AUTO=y
CONFIG_SCSI=y
CONFIG_BLK_DEV_SD=y
CONFIG_CHR_DEV_ST=y
CONFIG_BLK_DEV_SR=y
CONFIG_BLK_DEV_SR_VENDOR=y
CONFIG_CHR_DEV_SG=y
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_SYM53C8XX=y
CONFIG_NETDEVICES=y
CONFIG_DUMMY=m
CONFIG_NET_ETHERNET=y
CONFIG_HAPPYMEAL=y
CONFIG_DEPCA=y
CONFIG_HP100=y
CONFIG_NET_PCI=y
CONFIG_DL2K=m
CONFIG_NS83820=m
CONFIG_YELLOWFIN=y
CONFIG_NET_TULIP=y
CONFIG_DE2104X=m
CONFIG_TULIP=y
CONFIG_TULIP_MWI=y
CONFIG_TULIP_MMIO=y
CONFIG_DE4X5=y
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=y
CONFIG_UNIX98_PTYS=y
CONFIG_MOUSE=y
CONFIG_PSMOUSE=y
CONFIG_RTC=y
CONFIG_DRM=y
CONFIG_DRM_TDFX=y
CONFIG_REISERFS_FS=y
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=y
CONFIG_TMPFS=y
CONFIG_RAMFS=y
CONFIG_ISO9660_FS=y
CONFIG_PROC_FS=y
CONFIG_DEVPTS_FS=y
CONFIG_EXT2_FS=y
CONFIG_UDF_FS=y
CONFIG_OSF_PARTITION=y
CONFIG_MSDOS_PARTITION=y
CONFIG_NLS=y
CONFIG_NLS_CODEPAGE_437=y
CONFIG_VGA_CONSOLE=y
CONFIG_FB=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_FB_3DFX=y
CONFIG_FBCON_CFB8=y
CONFIG_FBCON_CFB16=y
CONFIG_FBCON_CFB32=y
CONFIG_FBCON_FONTS=y
CONFIG_FONT_SUN12x22=y
CONFIG_PCI_CONSOLE=y
CONFIG_SOUND=y
CONFIG_SND=m
CONFIG_SND_SEQUENCER=m
CONFIG_SND_SEQ_DUMMY=m
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=m
CONFIG_SND_PCM_OSS=m
CONFIG_SND_SEQUENCER_OSS=m
CONFIG_SND_RTCTIMER=m
CONFIG_SND_VERBOSE_PRINTK=y
CONFIG_SND_CMIPCI=m
CONFIG_USB=y
CONFIG_USB_OHCI=m
CONFIG_USB_SCANNER=m
CONFIG_INPUT=y
CONFIG_INPUT_KEYBDEV=y
CONFIG_INPUT_MOUSEDEV=y
CONFIG_SOUND_GAMEPORT=y
CONFIG_SERIO=y
CONFIG_SERIO_SERPORT=y
CONFIG_ALPHA_LEGACY_START_ADDRESS=y
CONFIG_DEBUG_KERNEL=y
CONFIG_MATHEMU=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_CRC32=y

Good luck,
Jurriaan
-- 
The unicorn stared unhappily at the dragon. "I don't suppose there's any
chance that thing is a vegetarian?" The dragon smiled. His pointed teeth
gleamed brightly in the sunlight.
	Simon R Green - Blue Moon Rising
GNU/Linux 2.4.19p7 on Debian/Alpha 990 bogomips load:1.52 0.83 0.58
