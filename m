Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281452AbRKFDnq>; Mon, 5 Nov 2001 22:43:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281451AbRKFDng>; Mon, 5 Nov 2001 22:43:36 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:26870
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S281449AbRKFDnX>; Mon, 5 Nov 2001 22:43:23 -0500
Date: Mon, 5 Nov 2001 19:43:16 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Terminator <jimmy@mtc.dhs.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel 2.4.14 compiling fail for loop device
Message-ID: <20011105194316.B665@mikef-linux.matchmail.com>
Mail-Followup-To: Terminator <jimmy@mtc.dhs.org>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0111051936090.18663-100000@www.mtc.dhs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0111051936090.18663-100000@www.mtc.dhs.org>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 05, 2001 at 07:39:29PM -0800, Terminator wrote:
> I tried to compile 2.4.14 with loop back device as kernel module, and
> got the following error. It seems it's removed from
> 
> ld -m elf_i386 -T /usr/src/linux-2.4.14/arch/i386/vmlinux.lds -e stext arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/main.o init/version.o \
>         --start-group \
>         arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o \
>          drivers/char/char.o drivers/block/block.o drivers/misc/misc.o drivers/net/net.o drivers/media/media.o drivers/ide/idedriver.o drivers/cdrom/driver.o drivers/pci/driver.o drivers/pnp/pnp.o drivers/video/video.o \
>         net/network.o \
>         /usr/src/linux-2.4.14/arch/i386/lib/lib.a /usr/src/linux-2.4.14/lib/lib.a /usr/src/linux-2.4.14/arch/i386/lib/lib.a \
>         --end-group \
>         -o vmlinux
> drivers/block/block.o: In function `lo_send':
> drivers/block/block.o(.text+0x86bf): undefined reference to `deactivate_page'
> drivers/block/block.o(.text+0x8709): undefined reference to `deactivate_page'

Did anyone have this problem with pre8???
