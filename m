Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129444AbRCLCzP>; Sun, 11 Mar 2001 21:55:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129443AbRCLCzG>; Sun, 11 Mar 2001 21:55:06 -0500
Received: from ogg075-025.resnet.wisc.edu ([146.151.75.25]:13828 "HELO
	wioggin.awwgeez") by vger.kernel.org with SMTP id <S129440AbRCLCyu>;
	Sun, 11 Mar 2001 21:54:50 -0500
From: tmwhitehead@students.wisc.edu
Date: Sun, 11 Mar 2001 20:54:08 -0600
To: linux-kernel@vger.kernel.org
Subject: make: *** [vmlinux] Error 1
Message-ID: <20010311205408.A5102@wioggin.awwgeez>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Operating-System: Linux 2.2.18 i686
X-Mantrae: On Wisconsin! Eat a Rock!
X-Verse: Isaiah 40:21-31
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On a compile of 2.4.2 I get the following (using make bzImage) 


make[2]: Leaving directory `/usr/src/linux-2.4.2/linux/arch/i386/lib'
make[1]: Leaving directory `/usr/src/linux-2.4.2/linux/arch/i386/lib'
ld -m elf_i386 -T /usr/src/linux-2.4.2/linux/arch/i386/vmlinux.lds -e stext
arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/main.o init/version.o
\
        --start-group \
        arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o mm/mm.o
fs/fs.o ipc/ipc.o \
        drivers/block/block.o drivers/char/char.o drivers/misc/misc.o
drivers/net/net.o drivers/media/media.o  drivers/parport/driver.o
drivers/char/agp/agp.o drivers/ide/idedriver.o drivers/cdrom/driver.o
drivers/pci/driver.o drivers/pnp/pnp.o drivers/video/video.o \
        net/network.o \
        /usr/src/linux-2.4.2/linux/arch/i386/lib/lib.a
/usr/src/linux-2.4.2/linux/lib/lib.a
/usr/src/linux-2.4.2/linux/arch/i386/lib/lib.a \
        --end-group \
        -o vmlinux
init/main.o: In function `check_fpu':
init/main.o(.text.init+0x63): undefined reference to `__buggy_fxsr_alignment'
make: *** [vmlinux] Error 1


