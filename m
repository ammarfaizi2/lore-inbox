Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262585AbREVH6j>; Tue, 22 May 2001 03:58:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262587AbREVH6V>; Tue, 22 May 2001 03:58:21 -0400
Received: from zeus.kernel.org ([209.10.41.242]:62850 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S262594AbREVH6R>;
	Tue, 22 May 2001 03:58:17 -0400
Subject: Re: Linux 2.4.4-ac12 -- fs/fs.o: In function `bm_register_write':
	undefined reference to `lookup_one'
From: Miles Lane <miles@megapathdsl.net>
To: Alan Cox <laughing@shared-source.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010521201418.A2863@lightning.swansea.linux.org.uk>
In-Reply-To: <20010521201418.A2863@lightning.swansea.linux.org.uk>
Content-Type: text/plain
X-Mailer: Evolution/0.10 (Preview Release)
Date: 21 May 2001 22:53:28 -0700
Message-Id: <990510889.12510.0.camel@agate>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ld -m elf_i386 -T /usr/src/linux/arch/i386/vmlinux.lds -e stext arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/main.o init/version.o \
	--start-group \
	arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o \
	 drivers/char/char.o drivers/block/block.o drivers/misc/misc.o drivers/net/net.o drivers/media/media.o drivers/char/agp/agp.o drivers/char/drm/drm.o drivers/net/appletalk/appletalk.o drivers/ide/idedriver.o drivers/scsi/scsidrv.o drivers/cdrom/driver.o drivers/sound/sounddrivers.o drivers/pci/driver.o drivers/pcmcia/pcmcia.o drivers/pnp/pnp.o drivers/video/video.o \
	net/network.o \
	/usr/src/linux/arch/i386/lib/lib.a /usr/src/linux/lib/lib.a /usr/src/linux/arch/i386/lib/lib.a \
	--end-group \
	-o vmlinux
fs/fs.o: In function `bm_register_write':
fs/fs.o(.text+0x1b460): undefined reference to `lookup_one'
make: *** [vmlinux] Error 1

CONFIG_QUOTA=y
CONFIG_AUTOFS4_FS=y
CONFIG_REISERFS_FS=m
CONFIG_REISERFS_CHECK=y
CONFIG_HFS_FS=m
CONFIG_FAT_FS=m
CONFIG_VFAT_FS=m
CONFIG_TMPFS=y
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_PROC_FS=y
CONFIG_DEVFS_FS=y
CONFIG_DEVFS_DEBUG=y
CONFIG_DEVPTS_FS=y
CONFIG_EXT2_FS=y


