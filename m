Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263558AbTDNQvI (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 12:51:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263563AbTDNQvH (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 12:51:07 -0400
Received: from odpn1.odpn.net ([212.40.96.53]:9425 "EHLO odpn1.odpn.net")
	by vger.kernel.org with ESMTP id S263558AbTDNQvG (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Apr 2003 12:51:06 -0400
To: linux-kernel@vger.kernel.org
From: "Gabor Z. Papp" <gzp@myhost.mynet>
Subject: Re: Linux 2.4.21pre7-ac1
References: <200304141616.h3EGG1K22074@devserv.devel.redhat.com>
Organization: Who, me?
User-Agent: tin/1.5.18-20030412 ("Peephole") (UNIX) (Linux/2.4.21-pre6-gzp2 (i686))
Message-ID: <2895.3e9ae9be.d69c1@gzp1.gzp.hu>
Date: Mon, 14 Apr 2003 17:02:54 -0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ld -m elf_i386 -T /usr/src/linux-2.4.21-pre7-ac1-gzp2/arch/i386/vmlinux.lds -e stext arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/main.o init/version.o init/do_mounts.o \
        --start-group \
        arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o \
         drivers/char/char.o drivers/block/block.o drivers/misc/misc.o drivers/net/net.o drivers/char/drm/drm.o drivers/ide/idedriver.o drivers/scsi/scsidrv.o drivers/cdrom/driver.o drivers/pci/driver.o drivers/video/video.o drivers/media/media.o \
        net/network.o \
        /usr/src/linux-2.4.21-pre7-ac1-gzp2/arch/i386/lib/lib.a /usr/src/linux-2.4.21-pre7-ac1-gzp2/lib/lib.a /usr/src/linux-2.4.21-pre7-ac1-gzp2/arch/i386/lib/lib.a \
        --end-group \
        -o vmlinux
fs/fs.o(.text+0x1baa9): In function `do_quotactl':
: undefined reference to `sync_dquots_dev'
make: *** [vmlinux] Error 1


