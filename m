Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293010AbSCXP0o>; Sun, 24 Mar 2002 10:26:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293457AbSCXP0f>; Sun, 24 Mar 2002 10:26:35 -0500
Received: from [203.199.230.87] ([203.199.230.87]:38017 "EHLO partha.home.net")
	by vger.kernel.org with ESMTP id <S293010AbSCXP0U>;
	Sun, 24 Mar 2002 10:26:20 -0500
Message-ID: <3C9E3CCF.43D5E42F@yahoo.com>
Date: Sun, 24 Mar 2002 20:53:35 +0000
From: Bhasker C V <spssjp@yahoo.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.5.5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: kernel list <linux-kernel@vger.kernel.org>
Subject: problems with kernel 2.5.6
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

 I have already complained about kernel 2.5.5 which had probles
compiling raid and lvm modules

 the problem is STILL CONTINUING !!!

 and newly,
 i tried to add ide-scsi emulation also ( for my CD-RW)
 and that ended up with this



--- snipped ---
make[2]: Leaving directory
`/users/cvb/current/linux-2.5.6/arch/i386/lib'
make[1]: Leaving directory
`/users/cvb/current/linux-2.5.6/arch/i386/lib'
ld -m elf_i386 -T /users/cvb/current/linux-2.5.6/arch/i386/vmlinux.lds
-e stext arch/i386/kernel/head.o arch/i386/kernel/init_task.o
init/main.o init/version.o init/do_mounts.o \
        --start-group \
        arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o
mm/mm.o fs/fs.o ipc/ipc.o \
        /users/cvb/current/linux-2.5.6/arch/i386/lib/lib.a
/users/cvb/current/linux-2.5.6/lib/lib.a
/users/cvb/current/linux-2.5.6/arch/i386/lib/lib.a \
         drivers/parport/driver.o drivers/base/base.o
drivers/char/char.o drivers/block/block.o drivers/misc/misc.o
drivers/net/net.o drivers/media/media.o drivers/char/agp/agp.o
drivers/char/drm/drm.o drivers/ide/idedriver.o drivers/scsi/scsidrv.o
drivers/cdrom/driver.o sound/sound.o drivers/pci/driver.o
drivers/pcmcia/pcmcia.o drivers/net/pcmcia/pcmcia_net.o
drivers/pnp/pnp.o drivers/video/video.o drivers/usb/usbdrv.o \
        net/network.o \
        --end-group \
        -o vmlinux
drivers/ide/idedriver.o: In function `ata_module_init':
drivers/ide/idedriver.o(.text.init+0x987): undefined reference to
`idescsi_init'
make: *** [vmlinux] Error 1



--------------------


 i went int the directory where the makefile, MAINTAINERS ... files
are present ( i.e the root of the kernel tree ) and
then tried both the 2.5.6 and the pre3 patch


patch =p0 < "path to the unzipped patch file "


 and the patch is giving lots of errors

 i am not sure if i am doing any mistake in the patching ; as far as i
know this is the proper method of patching the kernel source using the
patch downloaded from kernel.org

 I DID NOT get any response to my previous mail regarding kernel 2.5.5
although th full version of kernel has been removed from the site for
which i was happy - but a reply could have been more better to know if
you are still taking our feedbacks

 Linux is a community effort and if i am not being answered then it
makes no sense in building up linux to extent of workd domination over
all other OS !



--
Bye,
Bhasker C V
Web: http://spssjp.8m.com

If you want to feel rich, just count all the things you have that money can't buy



