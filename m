Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279420AbRKFOHo>; Tue, 6 Nov 2001 09:07:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279418AbRKFOHe>; Tue, 6 Nov 2001 09:07:34 -0500
Received: from [200.210.19.82] ([200.210.19.82]:49792 "HELO
	interno.centercursos.com.br") by vger.kernel.org with SMTP
	id <S279382AbRKFOHQ>; Tue, 6 Nov 2001 09:07:16 -0500
Message-ID: <3BE7EE15.7030308@uol.com.br>
Date: Tue, 06 Nov 2001 12:05:09 -0200
From: Michel Angelo da Silva Pereira <michelcultivo@uol.com.br>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011019 Netscape6/6.2
X-Accept-Language: en-us
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Error compiling 2.4.14
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

make[2]: Entering directory `/usr/src/linux/arch/i386/lib'
make[2]: Nothing to be done for `all_targets'.
make[2]: Leaving directory `/usr/src/linux/arch/i386/lib'
make[1]: Leaving directory `/usr/src/linux/arch/i386/lib'
ld -m elf_i386 -T /usr/src/linux/arch/i386/vmlinux.lds -e stext 
arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/main.o 
init/version.o \
         --start-group \
         arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o 
mm/mm.o fs/fs.o ipc/ipc.o \
          drivers/char/char.o drivers/block/block.o drivers/misc/misc.o 
drivers/net/net.o drivers/media/media.o drivers/char/agp/agp.o 
drivers/ide/idedriver.o drivers/cdrom/driver.o drivers/pci/driver.o 
drivers/pnp/pnp.o drivers/video/video.o \
         net/network.o \
         /usr/src/linux/arch/i386/lib/lib.a /usr/src/linux/lib/lib.a 
/usr/src/linux/arch/i386/lib/lib.a \
         --end-group \
         -o vmlinux
drivers/block/block.o: In function `lo_send':
drivers/block/block.o(.text+0xa41f): undefined reference to 
`deactivate_page'
drivers/block/block.o(.text+0xa469): undefined reference to 
`deactivate_page'
make: *** [vmlinux] Error 1
[root@interno linux]#

[root@interno linux]# gcc -v
Reading specs from /usr/lib/gcc-lib/i386-conectiva-linux/2.95.3/specs
gcc version 2.95.3 20010315 (release) (conectiva)

-- 
=================================================
Michel Angelo da Silva Pereira
Borges & Rinolfi Soluções em Redes Corporativas
Security Officer - Consultor em Linux
www.techs.com.br/kidmumu - UIN 4553082 - LC 83522

Meu HD tem 100k de bad sector e 100M de bad-windows.
=================================================

