Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261861AbRFGFP0>; Thu, 7 Jun 2001 01:15:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261897AbRFGFPS>; Thu, 7 Jun 2001 01:15:18 -0400
Received: from web10401.mail.yahoo.com ([216.136.130.93]:11279 "HELO
	web10401.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S261861AbRFGFPM>; Thu, 7 Jun 2001 01:15:12 -0400
Message-ID: <20010607051511.44709.qmail@web10401.mail.yahoo.com>
Date: Thu, 7 Jun 2001 15:15:11 +1000 (EST)
From: =?iso-8859-1?q?Steve=20Kieu?= <haiquy@yahoo.com>
Subject: 2.2.20 pre2 compilation broken
To: kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

here is the message:

ld -m elf_i386 -T
/mnt/hda3/linux-2.2.19/arch/i386/vmlinux.lds -e stext
arch/i386/kernel/head.o arch/i386/kernel/init_task.o
init/main.o init/version.o \
        --start-group \
        arch/i386/kernel/kernel.o arch/i386/mm/mm.o
kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o \
        fs/filesystems.a \
        net/network.a \
        drivers/block/block.a drivers/char/char.o
drivers/misc/misc.a drivers/net/net.a
drivers/cdrom/cdrom.a drivers/sound/sounddrivers.o
drivers/pci/pci.a drivers/video/video.a \
        /mnt/hda3/linux-2.2.19/arch/i386/lib/lib.a
/mnt/hda3/linux-2.2.19/lib/lib.a
/mnt/hda3/linux-2.2.19/arch/i386/lib/lib.a \
        --end-group \
        -o vmlinux
fs/filesystems.a(reiserfs.o): In function
`ip_check_balance':
reiserfs.o(.text+0x9dde): undefined reference to
`memset'
make: *** [vmlinux] Error 1

Regards,



=====
S.KIEU

_____________________________________________________________________________
http://messenger.yahoo.com.au - Yahoo! Messenger
- Voice chat, mail alerts, stock quotes and favourite news and lots more!
