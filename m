Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315277AbSEaN2i>; Fri, 31 May 2002 09:28:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315278AbSEaN2h>; Fri, 31 May 2002 09:28:37 -0400
Received: from host3.onnethosting.com ([209.239.43.8]:26894 "EHLO
	host3.onnethosting.com") by vger.kernel.org with ESMTP
	id <S315277AbSEaN2g>; Fri, 31 May 2002 09:28:36 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Faisal Malallah <faisal@q80.com>
Reply-To: faisal@q80.com
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.19pre9-ac3
Date: Fri, 31 May 2002 16:37:11 +0300
User-Agent: KMail/1.4.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200205311637.11160.faisal@q80.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got this error while I was compiling 2.4.19-pre9-ac3 + preempt:

make[1]: Leaving directory `/mnt/ext2/linux/arch/i386/lib'
ld -m elf_i386 -T /mnt/ext2/linux/arch/i386/vmlinux.lds -e stext 
arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/main.o 
init/version.o init/do_mounts.o \
        --start-group \
        arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o mm/mm.o 
fs/fs.o ipc/ipc.o \
         drivers/parport/driver.o drivers/char/char.o drivers/block/block.o 
drivers/misc/misc.o drivers/net/net.o drivers/media/media.o 
drivers/char/drm/drm.o drivers/ide/idedriver.o drivers/cdrom/driver.o 
drivers/pci/driver.o drivers/net/pcmcia/pcmcia_net.o drivers/video/video.o \
        net/network.o \
        /mnt/ext2/linux/arch/i386/lib/lib.a /mnt/ext2/linux/lib/lib.a 
/mnt/ext2/linux/arch/i386/lib/lib.a \
        --end-group \
        -o vmlinux
arch/i386/kernel/kernel.o: In function `smp_invalidate_interrupt':
arch/i386/kernel/kernel.o(.text+0xefb1): undefined reference to `get_cpu'
arch/i386/kernel/kernel.o(.text+0xf023): undefined reference to `put_cpu'
make: *** [vmlinux] Error 1

