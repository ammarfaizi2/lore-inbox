Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267072AbSK2OzR>; Fri, 29 Nov 2002 09:55:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267078AbSK2OzR>; Fri, 29 Nov 2002 09:55:17 -0500
Received: from h24-80-147-251.no.shawcable.net ([24.80.147.251]:22801 "EHLO
	antichrist") by vger.kernel.org with ESMTP id <S267072AbSK2OzP>;
	Fri, 29 Nov 2002 09:55:15 -0500
Date: Fri, 29 Nov 2002 07:00:50 -0800
From: carbonated beverage <ramune@net-ronin.org>
To: linux-kernel@vger.kernel.org
Subject: 2.4.20 kernel link error
Message-ID: <20021129150050.GA5136@net-ronin.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anything other info needed?

gcc 2.95.4
binutils 2.12.90.0.1
Debian/woody
Linux 2.4.20

drivers/net/pcmcia/pcmcia_net.o: In function `smc_link_ok':
drivers/net/pcmcia/pcmcia_net.o(.text+0x280c): undefined reference to `mii_link_ok'
drivers/net/pcmcia/pcmcia_net.o: In function `smc_ethtool_ioctl':
drivers/net/pcmcia/pcmcia_net.o(.text+0x29ce): undefined reference to `mii_ethtool_gset'
drivers/net/pcmcia/pcmcia_net.o(.text+0x2a7d): undefined reference to `mii_ethtool_sset'
drivers/net/pcmcia/pcmcia_net.o(.text+0x2b1c): undefined reference to `mii_nway_restart'
drivers/net/pcmcia/pcmcia_net.o: In function `smc_ioctl':
drivers/net/pcmcia/pcmcia_net.o(.text+0x2b8d): undefined reference to `generic_mii_ioctl'
CONFIG_X86=y
CONFIG_UID16=y
CONFIG_EXPERIMENTAL=y
CONFIG_MODULES=y
CONFIG_M586MMX=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_X86_USE_STRING_486=y
CONFIG_X86_ALIGNMENT_16=y
CONFIG_X86_HAS_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_PPRO_FENCE=y
CONFIG_NOHIGHMEM=y
CONFIG_X86_TSC=y
CONFIG_NET=y
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_ISA=y
CONFIG_PCI_NAMES=y
CONFIG_HOTPLUG=y
CONFIG_PCMCIA=y
CONFIG_TCIC=y
CONFIG_I82365=y
CONFIG_SYSVIPC=y
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
CONFIG_BINFMT_ELF=y
CONFIG_PARPORT=y
CONFIG_PARPORT_PC=y
CONFIG_PARPORT_PC_CML1=y
CONFIG_PARPORT_PC_FIFO=y
CONFIG_PARPORT_1284=y
CONFIG_PNP=y
CONFIG_ISAPNP=y
CONFIG_BLK_DEV_LOOP=y
CONFIG_BLK_STATS=y
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
CONFIG_NETLINK_DEV=y
CONFIG_NETFILTER=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_SYN_COOKIES=y
CONFIG_IP_NF_IPTABLES=y
CONFIG_IP_NF_MATCH_UNCLEAN=y
CONFIG_IP_NF_MATCH_OWNER=y
CONFIG_IP_NF_FILTER=y
CONFIG_IP_NF_TARGET_REJECT=y
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDECS=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_BLK_DEV_ADMA=y
CONFIG_BLK_DEV_PIIX=y
CONFIG_PIIX_TUNING=y
CONFIG_IDEDMA_AUTO=y
CONFIG_BLK_DEV_IDE_MODES=y
CONFIG_NETDEVICES=y
CONFIG_NET_PCMCIA=y
CONFIG_PCMCIA_SMC91C92=y
CONFIG_INPUT=y
CONFIG_INPUT_KEYBDEV=y
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=800
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=600
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=y
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_PRINTER=y
CONFIG_MOUSE=y
CONFIG_PSMOUSE=y
CONFIG_RTC=y
CONFIG_EXT3_FS=y
CONFIG_JBD=y
CONFIG_JBD_DEBUG=y
CONFIG_TMPFS=y
CONFIG_RAMFS=y
CONFIG_PROC_FS=y
CONFIG_DEVPTS_FS=y
CONFIG_EXT2_FS=y
CONFIG_MSDOS_PARTITION=y
CONFIG_VGA_CONSOLE=y
CONFIG_VIDEO_SELECT=y
CONFIG_FB=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_FB_VGA16=y
CONFIG_VIDEO_SELECT=y
CONFIG_FBCON_VGA_PLANES=y
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
CONFIG_DEBUG_KERNEL=y
CONFIG_MAGIC_SYSRQ=y
