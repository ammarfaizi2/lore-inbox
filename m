Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282111AbRKWLWv>; Fri, 23 Nov 2001 06:22:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282123AbRKWLWl>; Fri, 23 Nov 2001 06:22:41 -0500
Received: from ATuileries-103-2-2-113.abo.wanadoo.fr ([217.128.34.113]:9460
	"EHLO boo.taktile.com") by vger.kernel.org with ESMTP
	id <S282111AbRKWLWc>; Fri, 23 Nov 2001 06:22:32 -0500
Date: Fri, 23 Nov 2001 12:09:50 +0100
To: linux-kernel@vger.kernel.org
Subject: 2.4.15 compile problem on PPC
Message-ID: <20011123120950.A27067@boo.taktile.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
From: matthieu foillard <matthieu@taktile.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

do you know what's wrong with this ?
thanks.

make[2]: Leaving directory `/usr/src/linux/arch/ppc/xmon'
ld -T arch/ppc/vmlinux.lds -Ttext 0xc0000000 -Bstatic arch/ppc/kernel/head.o init/main.o init/version.o \
  --start-group \
  arch/ppc/kernel/kernel.o arch/ppc/mm/mm.o arch/ppc/lib/lib.o kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o arch/ppc/xmon/x.o \
  drivers/char/char.o drivers/block/block.o drivers/misc/misc.o drivers/net/net.o drivers/media/media.o drivers/ide/idedriver.o drivers/cdrom/driver.o drivers/sound/sounddrivers.o drivers/pci/driver.o drivers/pcmcia/pcmcia.o drivers/net/wireless/wireless_net.o drivers/macintosh/macintosh.o drivers/video/video.o drivers/usb/usbdrv.o drivers/input/inputdrv.o \
  net/network.o \
  /usr/src/linux/lib/lib.a \
  --end-group \
  -o vmlinux
  kernel/kernel.o: In function `show_task':
  kernel/kernel.o(.text+0x17e0): undefined reference to `show_trace_task'
  kernel/kernel.o(.text+0x17e0): relocation truncated to fit: R_PPC_REL24 show_trace_task
  make[1]: *** [vmlinux] Erreur 1
