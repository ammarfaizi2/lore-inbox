Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318263AbSG3NYM>; Tue, 30 Jul 2002 09:24:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318264AbSG3NYM>; Tue, 30 Jul 2002 09:24:12 -0400
Received: from mailout10.sul.t-online.com ([194.25.134.21]:18911 "EHLO
	mailout10.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S318263AbSG3NYJ> convert rfc822-to-8bit; Tue, 30 Jul 2002 09:24:09 -0400
Content-Type: text/plain; charset=US-ASCII
From: Marc-Christian Petersen <mcp@linux-systeme.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [ERROR] with 2.4.19[rc2|rc3]: Linking error scsidrv.o
Date: Tue, 30 Jul 2002 14:23:47 +0200
X-Mailer: KMail [version 1.4]
Cc: linux-kernel@vger.kernel.org
References: <200207301232.50704.mcp@linux-systeme.de> <1028031721.6725.20.camel@irongate.swansea.linux.org.uk>
In-Reply-To: <1028031721.6725.20.camel@irongate.swansea.linux.org.uk>
Organization: Linux-Systeme GmbH
X-PRIORITY: 2 (High)
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200207301423.47664.mcp@linux-systeme.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 30 July 2002 14:22, Alan Cox wrote:

Hi Alan,

> On Tue, 2002-07-30 at 11:32, Marc-Christian Petersen wrote:
> > ld -m elf_i386 -T /usr/src/linux/arch/i386/vmlinux.lds -e stext
> > arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/main.o
> > init/version.o --start-group arch/i386/kernel/kernel.o arch/i386/mm/mm.o
> > kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o  drivers/char/char.o
> > drivers/block/block.o drivers/misc/misc.o drivers/net/net.o
> > drivers/media/media.o drivers/scsi/scsidrv.o drivers/cdrom/driver.o
> > drivers/video/video.o net/network.o /usr/src/linux/arch/i386/lib/lib.a
> > /usr/src/linux/lib/lib.a /usr/src/linux/arch/i386/lib/lib.a
> > --end-group  -o vmlinux
> > drivers/scsi/scsidrv.o: In function `ahc_proc_write_seeprom':
> > drivers/scsi/scsidrv.o(.text+0xdba9): undefined reference to
> > `ahc_acquire_seeprom'
> > drivers/scsi/scsidrv.o(.text+0xdc33): undefined reference to
> > `ahc_release_seeprom'

> Known problem - fixed in -ac, or for the base enable CONFIG_PCI. I'll
> push the fix to Marcelo for 2.4.20pre
Could you send me the fix please Alan? :) Thanks alot!


-- 
Kind regards
        Marc-Christian Petersen

http://sourceforge.net/projects/wolk

PGP/GnuPG Key: 1024D/569DE2E3DB441A16
Fingerprint: 3469 0CF8 CA7E 0042 7824 080A 569D E2E3 DB44 1A16
Key available at www.keyserver.net. Encrypted e-mail preferred.

