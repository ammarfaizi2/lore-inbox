Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263911AbTDYUDQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 16:03:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263875AbTDYUDN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 16:03:13 -0400
Received: from odpn1.odpn.net ([212.40.96.53]:3803 "EHLO odpn1.odpn.net")
	by vger.kernel.org with ESMTP id S263871AbTDYUDM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 16:03:12 -0400
To: linux-kernel@vger.kernel.org
From: "Gabor Z. Papp" <gzp@myhost.mynet>
Subject: Re: Linux 2.4.21pre7-ac1
References: <200304141616.h3EGG1K22074@devserv.devel.redhat.com> <2895.3e9ae9be.d69c1@gzp1.gzp.hu> <2895.3e9ae9be.d69c1@gzp1.gzp.hu> <20030415133725.GA16728@carfax.org.uk>
Organization: Who, me?
User-Agent: tin/1.5.18-20030416 ("Peephole") (UNIX) (Linux/2.4.21-rc1-gzp2 (i686))
Message-ID: <345d.3ea99756.29f2b@gzp1.gzp.hu>
Date: Fri, 25 Apr 2003 20:15:18 -0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Hugo Mills <hugo-lkml@carfax.org.uk>:

| On Mon, Apr 14, 2003 at 05:02:54PM -0000, Gabor Z. Papp wrote:
|> ld -m elf_i386 -T /usr/src/linux-2.4.21-pre7-ac1-gzp2/arch/i386/vmlinux.lds -e stext arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/main.o init/version.o init/do_mounts.o \
|>         --start-group \
|>         arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o \
|>          drivers/char/char.o drivers/block/block.o drivers/misc/misc.o drivers/net/net.o drivers/char/drm/drm.o drivers/ide/idedriver.o drivers/scsi/scsidrv.o drivers/cdrom/driver.o drivers/pci/driver.o drivers/video/video.o drivers/media/media.o \
|>         net/network.o \
|>         /usr/src/linux-2.4.21-pre7-ac1-gzp2/arch/i386/lib/lib.a /usr/src/linux-2.4.21-pre7-ac1-gzp2/lib/lib.a /usr/src/linux-2.4.21-pre7-ac1-gzp2/arch/i386/lib/lib.a \
|>         --end-group \
|>         -o vmlinux
|> fs/fs.o(.text+0x1baa9): In function `do_quotactl':
|> : undefined reference to `sync_dquots_dev'
|> make: *** [vmlinux] Error 1
| 
|   I see this too. .config below.

Still exist in rc1-ac2

