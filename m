Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269920AbRHEF3X>; Sun, 5 Aug 2001 01:29:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269921AbRHEF3D>; Sun, 5 Aug 2001 01:29:03 -0400
Received: from newman.edw2.uc.edu ([129.137.2.198]:58890 "EHLO smtp.uc.edu")
	by vger.kernel.org with ESMTP id <S269920AbRHEF24>;
	Sun, 5 Aug 2001 01:28:56 -0400
Date: Sun, 5 Aug 2001 01:28:46 -0400 (EDT)
From: Robert Kuebel <kuebelr@email.uc.edu>
X-X-Sender: <kuebelr@oz.uc.edu>
To: <linux-kernel@vger.kernel.org>
Subject: system freezes w/ 2.4.7-pre4 and later
Message-ID: <Pine.OSF.4.33.0108050048300.23006-100000@oz.uc.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My system has been hanging since I switched from 2.4.7-pre3.  The
lock-up's seem to happen during periods of disk activity. I was usually
able to reproduce the hangs by untar-ing the kernel source a few times.
Also, these kernels tended to hang while fsck'ing.

2.4.7-pre3 was working fine, but 2.4.7-pre4 through 2.4.8-pre3 were not.
Also 2.4.7-ac6 froze on me.

I am running on an Abit KT7 and an IBM-DTLA-307045 IDE drive.

If there is anything I can do to help smash this bug, please let me know.

Also please 'cc:' me on any replies, I can only handle the digest form of
linux-kernel.

Thanks.
Rob.

This is my .config:
CONFIG_X86=y
CONFIG_ISA=y
CONFIG_UID16=y
CONFIG_MODULES=y
CONFIG_KMOD=y
CONFIG_MK7=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_USE_3DNOW=y
CONFIG_X86_PGE=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_NOHIGHMEM=y
CONFIG_MTRR=y
CONFIG_NET=y
CONFIG_PCI=y
CONFIG_PCI_GOBIOS=y
CONFIG_PCI_BIOS=y
CONFIG_SYSVIPC=y
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
CONFIG_BINFMT_ELF=y
CONFIG_PM=y
CONFIG_APM=y
CONFIG_BLK_DEV_FD=y
CONFIG_BLK_DEV_LOOP=m
CONFIG_PACKET=y
CONFIG_NETLINK=y
CONFIG_RTNETLINK=y
CONFIG_NETFILTER=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_NF_CONNTRACK=y
CONFIG_IP_NF_FTP=y
CONFIG_IP_NF_IPTABLES=y
CONFIG_IP_NF_MATCH_STATE=y
CONFIG_IP_NF_FILTER=y
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_NAT_FTP=m
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_BLK_DEV_IDECD=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_NETDEVICES=y
CONFIG_DUMMY=m
CONFIG_NET_ETHERNET=y
CONFIG_NET_PCI=y
CONFIG_TULIP=y
CONFIG_8139TOO=y
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=y
CONFIG_SERIAL_CONSOLE=y
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=64
CONFIG_MOUSE=y
CONFIG_PSMOUSE=y
CONFIG_DRM=y
CONFIG_DRM_TDFX=y
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_PROC_FS=y
CONFIG_DEVPTS_FS=y
CONFIG_EXT2_FS=y
CONFIG_MSDOS_PARTITION=y
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_VGA_CONSOLE=y
CONFIG_SOUND=y
CONFIG_SOUND_ES1371=y
CONFIG_USB=y
CONFIG_USB_DEVICEFS=y
CONFIG_USB_UHCI=y
CONFIG_USB_SERIAL=y
CONFIG_USB_SERIAL_VISOR=y


