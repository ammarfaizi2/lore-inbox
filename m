Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292555AbSCIIQm>; Sat, 9 Mar 2002 03:16:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292557AbSCIIQc>; Sat, 9 Mar 2002 03:16:32 -0500
Received: from [210.19.28.11] ([210.19.28.11]:37762 "EHLO dZuRa.Vault-ID.com")
	by vger.kernel.org with ESMTP id <S292555AbSCIIQM>;
	Sat, 9 Mar 2002 03:16:12 -0500
Date: Sat, 9 Mar 2002 16:13:15 +0800
From: Corporal Pisang <Corporal_Pisang@Counter-Strike.com.my>
To: linux-kernel@vger.kernel.org
Subject: 2.5.6-final compile error (idedriver)
Message-Id: <20020309161315.71799c1e.Corporal_Pisang@Counter-Strike.com.my>
Organization: CS Malaysia
X-Mailer: Sylpheed version 0.7.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
User-Agent: Half Life (Build 1760)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

make[1]: Leaving directory `/usr/src/linux/arch/i386/lib'
ld -m elf_i386 -T /usr/src/linux/arch/i386/vmlinux.lds -e stext arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/main.o init/version.o init/do_mounts.o \
        --start-group \
        arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o \
        /usr/src/linux/arch/i386/lib/lib.a /usr/src/linux/lib/lib.a /usr/src/linux/arch/i386/lib/lib.a \
         drivers/parport/driver.o drivers/base/base.o drivers/char/char.o drivers/block/block.o drivers/misc/misc.o drivers/net/net.o drivers/media/media.o drivers/char/agp/agp.o drivers/char/drm/drm.o drivers/ide/idedriver.o drivers/scsi/scsidrv.o drivers/cdrom/driver.o drivers/pci/driver.o drivers/pnp/pnp.o drivers/video/video.o drivers/usb/usbdrv.o drivers/input/inputdrv.o drivers/input/gameport/gamedrv.o drivers/input/serio/seriodrv.o \
        net/network.o \
        --end-group \
        -o vmlinux
drivers/ide/idedriver.o: In function `ata_module_init':
drivers/ide/idedriver.o(.text.init+0x9e9): undefined reference to `idescsi_init'
make: *** [vmlinux] Error 1


Regards.

-Ubaida-

