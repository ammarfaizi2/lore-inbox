Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290113AbSBOQvB>; Fri, 15 Feb 2002 11:51:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290185AbSBOQul>; Fri, 15 Feb 2002 11:50:41 -0500
Received: from faui02.informatik.uni-erlangen.de ([131.188.30.102]:57850 "EHLO
	faui02.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id <S290156AbSBOQuj>; Fri, 15 Feb 2002 11:50:39 -0500
Date: Fri, 15 Feb 2002 17:50:35 +0100 (MET)
From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
X-X-Sender: sithglan@faui02.informatik.uni-erlangen.de
To: linux-kernel@vger.kernel.org
Subject: Problems compiling the 2.4.17 kernel drivers/char/char.o(.text.init+0xfbe):
 undefined reference to `early_serial_setup'
Message-ID: <Pine.GSO.4.44.0202151745400.3105-100000@faui02.informatik.uni-erlangen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You find my config under
http://wwwcip.informatik.uni-erlangen.de/~sithglan/config
I get the following error:

...snip...
make[1]: Leaving directory `/tmp/linux/arch/i386/lib'
ld -m elf_i386 -T /tmp/linux/arch/i386/vmlinux.lds -e stext
arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/main.o init/version.o
\
        --start-group \
        arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o mm/mm.o
fs/fs.o ipc/ipc.o \
         drivers/acpi/acpi.o drivers/char/char.o drivers/block/block.o
drivers/misc/misc.o drivers/net/net.o drivers/media/media.o
drivers/char/drm/drm.o drivers/net/fc/fc.o drivers/net/appletalk/appletalk.o
drivers/net/tokenring/tr.o drivers/net/wan/wan.o drivers/ide/idedriver.o
drivers/cdrom/driver.o drivers/pci/driver.o drivers/net/pcmcia/pcmcia_net.o
drivers/net/wireless/wireless_net.o drivers/pnp/pnp.o drivers/video/video.o
drivers/net/hamradio/hamradio.o drivers/md/mddev.o \
        net/network.o \
        /tmp/linux/arch/i386/lib/lib.a /tmp/linux/lib/lib.a
/tmp/linux/arch/i386/lib/lib.a \
        --end-group \
        -o vmlinux
drivers/char/char.o: In function `setup_serial_acpi':
drivers/char/char.o(.text.init+0xfbe): undefined reference to
`early_serial_setup'
make: *** [vmlinux] Error 1


Greetings, Thomas

Please reply directly to me because I am not on the list at moment.


