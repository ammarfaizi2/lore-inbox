Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264962AbSL2QWf>; Sun, 29 Dec 2002 11:22:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265012AbSL2QWf>; Sun, 29 Dec 2002 11:22:35 -0500
Received: from mailout05.sul.t-online.com ([194.25.134.82]:45194 "EHLO
	mailout05.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S264962AbSL2QWe>; Sun, 29 Dec 2002 11:22:34 -0500
Message-Id: <4.3.2.7.2.20021229173032.00b57740@pop.t-online.de>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Sun, 29 Dec 2002 17:31:30 +0100
To: linux-kernel@vger.kernel.org
From: margitsw@t-online.de (Margit Schubert-While)
Subject: Re: [PATCHSET] 2.4.21-pre2-jp15
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ld -m elf_i386 -T /var/tmp/linux-2.4.20/arch/i386/vmlinux.lds -e stext 
arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/main.o 
init/version.o init/do_mounts.o \
         --start-group \
         arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o 
mm/mm.o fs/fs.o ipc/ipc.o \
          drivers/acpi/acpi.o drivers/char/char.o drivers/block/block.o 
drivers/misc/misc.o drivers/net/net.o drivers/media/media.o 
drivers/char/drm/drm.o drivers/net/fc/fc.o 
drivers/net/appletalk/appletalk.o drivers/net/tokenring/tr.o 
drivers/net/wan/wan.o drivers/atm/atm.o drivers/ide/idedriver.o 
drivers/scsi/scsidrv.o drivers/cdrom/driver.o drivers/pci/driver.o 
drivers/net/pcmcia/pcmcia_net.o drivers/net/wireless/wireless_net.o 
drivers/video/video.o drivers/net/hamradio/hamradio.o drivers/md/mddev.o 
drivers/isdn/vmlinux-obj.o drivers/sensors/sensor.o \
         net/network.o \
         grsecurity/grsec.o \
         crypto/crypto.o \
         /var/tmp/linux-2.4.20/arch/i386/lib/lib.a 
/var/tmp/linux-2.4.20/lib/lib.a /var/tmp/linux-2.4.20/arch/i386/lib/lib.a \
         --end-group \
         -o vmlinux
drivers/char/char.o: In function `sysrq_handle_preempt_log':
drivers/char/char.o(.text+0x1c79e): undefined reference to `show_preempt_log'
make: *** [vmlinux] Error 1

Margit 

