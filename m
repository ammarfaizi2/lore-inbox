Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286638AbRLVCn4>; Fri, 21 Dec 2001 21:43:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286640AbRLVCnr>; Fri, 21 Dec 2001 21:43:47 -0500
Received: from f236.law8.hotmail.com ([216.33.241.236]:21266 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S286638AbRLVCn1>;
	Fri, 21 Dec 2001 21:43:27 -0500
X-Originating-IP: [24.45.107.83]
From: "se d" <seandarcy@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: 2.4.17 build fails at network.o
Date: Fri, 21 Dec 2001 21:43:21 -0500
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F236jsdO0S5MVdnE0bN0000a020@hotmail.com>
X-OriginalArrivalTime: 22 Dec 2001 02:43:21.0705 (UTC) FILETIME=[6B887D90:01C18A92]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm trying to build 2.4.17. It fails as follows:


make[1]: Leaving directory `/opt/kernel/linux-2.4.17/arch/i386/lib'
ld -m elf_i386 -T /opt/kernel/linux-2.4.17/arch/i386/vmlinux.lds -e stext 
arch/i386/kernel/head.o arch/i386/kernel/init_tas
k.o init/main.o init/version.o \
	--start-group \
	arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o mm/mm.o fs/fs.o 
ipc/ipc.o \
	 drivers/char/char.o drivers/block/block.o drivers/misc/misc.o 
drivers/net/net.o drivers/media/media.o drivers/char
/agp/agp.o drivers/ide/idedriver.o drivers/scsi/scsidrv.o 
drivers/cdrom/driver.o drivers/sound/sounddrivers.o drivers/pci/d
river.o drivers/pnp/pnp.o drivers/video/video.o drivers/md/mddev.o \
	net/network.o \
	/opt/kernel/linux-2.4.17/arch/i386/lib/lib.a 
/opt/kernel/linux-2.4.17/lib/lib.a /opt/kernel/linux-2.4.17/arch/i386/
lib/lib.a \
	--end-group \
	-o vmlinux
net/network.o: In function `__rpc_schedule':
net/network.o(.text+0x49a0d): undefined reference to `rpciod_tcp_dispatcher'
make: *** [vmlinux] Error 1


_________________________________________________________________
Chat with friends online, try MSN Messenger: http://messenger.msn.com

