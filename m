Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313767AbSDHVoE>; Mon, 8 Apr 2002 17:44:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313768AbSDHVoD>; Mon, 8 Apr 2002 17:44:03 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:22515
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S313767AbSDHVoC>; Mon, 8 Apr 2002 17:44:02 -0400
Date: Mon, 8 Apr 2002 14:46:12 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Alan Cox <alan@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.19pre5-ac3
Message-ID: <20020408214612.GR961@matchmail.com>
Mail-Followup-To: Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org
In-Reply-To: <200204051945.g35JjnX23183@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 05, 2002 at 02:45:49PM -0500, Alan Cox wrote:
> Linux 2.4.19pre5-ac3
> o	Software suspend initial patch 		(Pavel Machek, Gabor Kuti,..)
> 	| Don't enable this idly. Its here to get exposure and so
> 	| people can bring the rest of the code up to meet its needs as
> 	| well as fix it.
> 	| Read the docs first!

Didn't enable software suspend, but I do use ACPI...

make[2]: Leaving directory `/src/2.4.19-pre5-ac3/net'
ld -m elf_i386 -T /src/2.4.19-pre5-ac3/arch/i386/vmlinux.lds -e stext arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/main.o init/version.o init/do_mounts.o \
	--start-group \
	arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o \
	 drivers/acpi/acpi.o drivers/char/char.o drivers/block/block.o drivers/misc/misc.o drivers/net/net.o drivers/media/media.o drivers/char/drm/drm.o drivers/net/fc/fc.o drivers/ide/idedriver.o drivers/scsi/scsidrv.o drivers/cdrom/driver.o drivers/pci/driver.o drivers/pnp/pnp.o drivers/video/video.o drivers/md/mddev.o \
	net/network.o \
	/src/2.4.19-pre5-ac3/arch/i386/lib/lib.a /src/2.4.19-pre5-ac3/lib/lib.a /src/2.4.19-pre5-ac3/arch/i386/lib/lib.a \
	--end-group \
	-o vmlinux
drivers/acpi/acpi.o: In function `sm_osl_proc_write_sleep':
drivers/acpi/acpi.o(.text+0x18324): undefined reference to `software_suspend'
make[1]: *** [vmlinux] Error 1
make[1]: Leaving directory `/src/2.4.19-pre5-ac3'
make: *** [stamp-build] Error 2
