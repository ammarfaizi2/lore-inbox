Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132118AbRDJUJO>; Tue, 10 Apr 2001 16:09:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132056AbRDJUJF>; Tue, 10 Apr 2001 16:09:05 -0400
Received: from [212.18.191.177] ([212.18.191.177]:18693 "EHLO smtp.netc.pt")
	by vger.kernel.org with ESMTP id <S132118AbRDJUIt>;
	Tue, 10 Apr 2001 16:08:49 -0400
Message-ID: <002601c0c1fa$0da9f200$1d081ed5@fabi>
From: "Andre Manuel Rocha Lourenco" <andyrock50@netc.pt>
To: <linux-kernel@vger.kernel.org>
Subject: kernel 2.4.3
Date: Tue, 10 Apr 2001 21:08:43 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2615.200
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2615.200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Hi!
I downloaded the patch to kernel 2.4.3 but it just doesn't compile on my
system! I have been using kernel 2.4 since 2.4.0-test8 without problems...
Here are the last lines of the compilation output: (in Portuguese)


make[2]: Saindo do diretório `/usr/src/linux/arch/i386/lib'
make[1]: Saindo do diretório `/usr/src/linux/arch/i386/lib'
ld -m elf_i386 -T /usr/src/linux/arch/i386/vmlinux.lds -e stext
arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/main.o
init/version.o \
        --start-group \
        arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o mm/mm.o
fs/fs.o ipc/ipc.o \
        drivers/block/block.o drivers/char/char.o drivers/misc/misc.o
drivers/net/net.o drivers/media/media.o  drivers/char/agp/agp.o
drivers/char/drm/drm.o drivers/net/fc/fc.o drivers/ide/idedriver.o
drivers/cdrom/driver.o drivers/sound/sounddrivers.o drivers/pci/driver.o
drivers/mtd/mtdlink.o drivers/pnp/pnp.o drivers/video/video.o
drivers/usb/usbdrv.o drivers/input/inputdrv.o drivers/i2o/i2o.o
drivers/i2c/i2c.o drivers/md/mddev.o \
        net/network.o \
        /usr/src/linux/arch/i386/lib/lib.a /usr/src/linux/lib/lib.a
/usr/src/linux/arch/i386/lib/lib.a \
        --end-group \
        -o vmlinux
net/network.o(.data+0x2d84): undefined reference to
`sysctl_ipx_pprop_broadcasting'
make: ** [vmlinux] Erro 1
[root@localhost linux]#



It you reply to this message please reply also to andrelourenco@yahoo.com ,
'cause I am not receiving the kernel mailing list. Thanks,

Andre Lourenco

