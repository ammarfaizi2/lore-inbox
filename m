Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313075AbSDOIIA>; Mon, 15 Apr 2002 04:08:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313088AbSDOIH7>; Mon, 15 Apr 2002 04:07:59 -0400
Received: from [210.19.28.11] ([210.19.28.11]:60033 "EHLO dZuRa.Vault-ID.com")
	by vger.kernel.org with ESMTP id <S313075AbSDOIH6>;
	Mon, 15 Apr 2002 04:07:58 -0400
Date: Mon, 15 Apr 2002 16:16:01 +0800
From: Corporal Pisang <Corporal_Pisang@Counter-Strike.com.my>
To: linux-kernel@vger.kernel.org
Subject: error compiling 2.5.8
Message-Id: <20020415161601.31430a76.Corporal_Pisang@Counter-Strike.com.my>
Organization: CS Malaysia
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
User-Agent: Half Life (Build 1760)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this error also occured in 2.5.8pre2, 2.5.8pre3, and now 2.5.8final.

make[2]: Leaving directory `/usr/src/linux/arch/i386/lib'
make[1]: Leaving directory `/usr/src/linux/arch/i386/lib'
ld -m elf_i386 -T /usr/src/linux/arch/i386/vmlinux.lds -e stext arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/main.o init/version.o init/do_mounts.o \
        --start-group \
        arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o \
        /usr/src/linux/arch/i386/lib/lib.a /usr/src/linux/lib/lib.a /usr/src/linux/arch/i386/lib/lib.a \
         drivers/parport/driver.o drivers/base/base.o drivers/char/char.o drivers/block/block.o drivers/misc/misc.o drivers/net/net.o drivers/media/media.o drivers/char/agp/agp.o drivers/char/drm/drm.o drivers/net/appletalk/appletalk.o drivers/ide/idedriver.o drivers/scsi/scsidrv.o drivers/cdrom/driver.o drivers/pci/driver.o drivers/pnp/pnp.o drivers/video/video.o drivers/usb/usbdrv.o drivers/input/inputdrv.o drivers/input/gameport/gamedrv.o drivers/input/serio/seriodrv.o \
        net/network.o \
        --end-group \
        -o vmlinux
init/main.o: In function `start_kernel':
init/main.o(.text.init+0x675): undefined reference to `setup_per_cpu_areas'
make: *** [vmlinux] Error 1


Regards,

-Ubaida-
