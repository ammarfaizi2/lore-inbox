Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268832AbRHFVIK>; Mon, 6 Aug 2001 17:08:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268889AbRHFVIA>; Mon, 6 Aug 2001 17:08:00 -0400
Received: from ulima.unil.ch ([130.223.144.143]:35972 "EHLO ulima.unil.ch")
	by vger.kernel.org with ESMTP id <S268832AbRHFVHk>;
	Mon, 6 Aug 2001 17:07:40 -0400
Date: Mon, 6 Aug 2001 23:07:43 +0200
From: Gregoire Favre <greg@ulima.unil.ch>
To: linux-kernel@vger.kernel.org
Subject: 2.4.7-ac8 compilation error
Message-ID: <20010806230743.A12850@ulima.unil.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.19i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I got the following error while trying 2.4.7-ac8:

make[1]: Leaving directory `/usr/src/linux-2.4.7-ac8/arch/i386/lib'
ld -m elf_i386 -T /usr/src/linux-2.4.7-ac8/arch/i386/vmlinux.lds -e stext arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/main.o init/version.o \
	--start-group \
	arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o \
	 drivers/parport/driver.o drivers/char/char.o drivers/block/block.o drivers/misc/misc.o drivers/net/net.o drivers/media/media.o drivers/char/agp/agp.o drivers/char/drm/drm.o drivers/ide/idedriver.o drivers/scsi/scsidrv.o drivers/cdrom/driver.o drivers/pci/driver.o drivers/video/video.o drivers/usb/usbdrv.o drivers/net/irda/irda.o \
	net/network.o \
	/usr/src/linux-2.4.7-ac8/arch/i386/lib/lib.a /usr/src/linux-2.4.7-ac8/lib/lib.a /usr/src/linux-2.4.7-ac8/arch/i386/lib/lib.a \
	--end-group \
	-o vmlinux
mm/mm.o: In function `init_shmem_fs':
mm/mm.o(.text.init+0xec4): undefined reference to `shmem_set_size'
make: *** [vmlinux] Error 1

	Greg
________________________________________________________________
http://ulima.unil.ch/greg ICQ:16624071 mailto:greg@ulima.unil.ch
