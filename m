Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262273AbTGFNoq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jul 2003 09:44:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262321AbTGFNoq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jul 2003 09:44:46 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:58009 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S262273AbTGFNop (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jul 2003 09:44:45 -0400
Date: Sun, 6 Jul 2003 10:56:53 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: "=?ISO-8859-2?Q?Rafa=B3?= 'rmrmg' Roszak" <rmrmg@wp.pl>
Cc: Michael Buesch <fsdeveloper@yahoo.de>, kai.germaschewski@gmx.de,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.4.21-bk1] isdn_ppp compile warning fix
In-Reply-To: <20030706113047.10a59491.rmrmg@wp.pl>
Message-ID: <Pine.LNX.4.55L.0307061056190.30050@freak.distro.conectiva>
References: <200307052058.55539.fsdeveloper@yahoo.de> <20030706113047.10a59491.rmrmg@wp.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Rafa,

Thats already fixed in -pre3.


On Sun, 6 Jul 2003, [ISO-8859-2] Rafa? 'rmrmg' Roszak wrote:

> begin  Michael Buesch <fsdeveloper@yahoo.de> quote:
>
> >fixes these warnings:
> >isdn_ppp.c: In function `isdn_ppp_free':
> >isdn_ppp.c:114: Warnung: concatenation of string literals with
>
> [root@slack:/usr/src/linux-2.4.21-bk1#] make bzImage
> [...]
>
> ld -m elf_i386 -T /usr/src/linux-2.4.21-bk1/arch/i386/vmlinux.lds -e
> stext arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/main.o
> init/version.o init/do_mounts.o \	--start-group \
> 	arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o mm/mm.o
> fs/fs.o ipc/ipc.o \	 drivers/char/char.o drivers/block/block.o
> drivers/misc/misc.o drivers/net/net.o drivers/char/drm/drm.o
> drivers/ide/idedriver.o drivers/scsi/scsidrv.o drivers/cdrom/driver.o
> drivers/sound/sounddrivers.o drivers/pci/driver.o drivers/video/video.o
> drivers/media/media.o drivers/isdn/vmlinux-obj.o \	net/network.o \
> 	/usr/src/linux-2.4.21-bk1/arch/i386/lib/lib.a
> /usr/src/linux-2.4.21-bk1/lib/lib.a
> /usr/src/linux-2.4.21-bk1/arch/i386/lib/lib.a \	--end-group \
> 	-o vmlinux
> arch/i386/kernel/kernel.o(.text+0x6f7d): In function `sys_ipc':
> : undefined reference to `sys_semtimedop'
> make: *** [vmlinux] B??d 1
>
> System: Slackware 9.0 with gcc-3.2.3
> config in attachment
> --
> registered Linux user 261525 | Wszystko jest trudne przy
> gg 2311504________rmrmg@wp.pl|    odpowiednim stopniu
> RMRMG signature version 0.0.2|        abstrakcji
>
