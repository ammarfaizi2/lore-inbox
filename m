Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261653AbSIPN3B>; Mon, 16 Sep 2002 09:29:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261679AbSIPN3B>; Mon, 16 Sep 2002 09:29:01 -0400
Received: from 205-158-62-105.outblaze.com ([205.158.62.105]:17897 "HELO
	ws4-4.us4.outblaze.com") by vger.kernel.org with SMTP
	id <S261653AbSIPN3A>; Mon, 16 Sep 2002 09:29:00 -0400
Message-ID: <20020916133353.7709.qmail@linuxmail.org>
Content-Type: text/plain; charset="iso-8859-15"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Paolo Ciarrocchi" <ciarrocchi@linuxmail.org>
To: linux-kernel@vger.kernel.org
Date: Mon, 16 Sep 2002 21:33:53 +0800
Subject: Re: Linux 2.5.35
X-Originating-Ip: 193.76.202.244
X-Originating-Server: ws4-4.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
I can not compile 2.5.35
#make install
...
...
...
make[1]: Leaving directory `/usr/src/linux-2.5.33/arch/i386/pci'
  gcc -E -Wp,-MD,arch/i386/.vmlinux.lds.s.d_ -D__ASSEMBLY__ -D__KERNEL__ -I/usr/src/linux-2.5.33/include -nostdinc -iwithprefix include   -P -C -Ui386   -o arch/i386/vmlinux.lds.s arch/i386/vmlinux.lds.S
    Generating build number
    make[1]: Entering directory `/usr/src/linux-2.5.33/init'
      Generating /usr/src/linux-2.5.33/include/linux/compile.h (unchanged)
      make[1]: Leaving directory `/usr/src/linux-2.5.33/init'
        ld -m elf_i386 -T arch/i386/vmlinux.lds.s -e stext arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/init.o --start-group arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o security/built-in.o /usr/src/linux-2.5.33/arch/i386/lib/lib.a lib/lib.a /usr/src/linux-2.5.33/arch/i386/lib/lib.a drivers/built-in.o sound/sound.o arch/i386/pci/pci.o net/network.o --end-group -o vmlinux
	fs/fs.o: In function `flush_old_exec':
	fs/fs.o(.text+0xa227): undefined reference to `wait_task_inactive'
	make: *** [vmlinux] Error 1


Any hints?

Paolo
-- 
Get your free email from www.linuxmail.org 


Powered by Outblaze
