Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267760AbTADBOR>; Fri, 3 Jan 2003 20:14:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267763AbTADBOR>; Fri, 3 Jan 2003 20:14:17 -0500
Received: from smtp07.iddeo.es ([62.81.186.17]:13535 "EHLO smtp07.retemail.es")
	by vger.kernel.org with ESMTP id <S267760AbTADBON>;
	Fri, 3 Jan 2003 20:14:13 -0500
Date: Sat, 4 Jan 2003 02:22:43 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: [PATCHSET] New Year's Linux 2.4.21-pre2-jam2
Message-ID: <20030104012243.GA1541@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 2.0.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

HI, and HAPPY NEW YEAR to everybody !!

New release of this kinda-hacked-kernel. Now that Andre's ide and many bugfixes
are in mainline, there is hole for more things ;)

URL: http://giga.cps.unizar.es/~magallon/linux/kernel/2.4.21-pre2-jam2.tar.bz2
URL: http://giga.cps.unizar.es/~magallon/linux/kernel/2.4.21-pre2-jam2/

New ones:

15-binfmt-stack.bz2
    Fix AT_PLATFORM setup in binfmt_elf for hyper-threaded cpus, so glibc
    detects correctly i686 arch.

16-mremap-use-after-free.bz2
    Fix use of vmas after freed.
    Author: Marc-Christian Petersen <m.c.p@wolk-project.de>

50-aic-20021230.bz2
51-aic-20021230-dma-fix.bz2
    AIC 7xxx (upto U160) and 79xx (U320) scsi drivers. aic7xxx is updated and
    aic79xx is a new driver.
    Author: "Justin T. Gibbs" <gibbs@scsiguy.com>
    URL: http://people.freebsd.org/~gibbs/linux

56-DAC960.bz2
    Fix for the Promise driver to work under -aa tree. Not tested (I have not
    the hardware...), so get it and break it !!
    Author: Dave Olien <dmo@osdl.org>
    URL: http://www.osdl.org/archive/dmo/DAC960_2.4.20aa1/

Pending things that I think are bugfixes, apart from 15- and 16- (Marcelo ?,
I know some are already in your -bk)

02-printk.bz2
    Kill extra declaration of printk()

03-memparam.bz2
    Fix mem=XXX kernel parameter when user gives a size bigger than what
    kernel autodetected (kill a previous change)
    Author: Adrian Bunk <bunk@fs.tum.de>,
            Leonardo Gomes Figueira <sabbath@planetarium.com.br>

04-clone-detached.bz2
    Fix a crash that can be caused by a CLONE_DETACHED thread.
    Author: Ingo Molnar <mingo@elte.hu>

05-self_exec_id.bz2
    Fix bad signaling between threads when ancestor dies.
    Author: Zeuner, Axel <Axel.Zeuner@partner.commerzbank.com>

07-scsi-error-tmout.bz2
    Prevent endless loop in SCSI error handling.
    Author: Borzenkov Andrey <Andrej.Borsenkow@mow.siemens.ru>

08-ide-scsi-ref-count.bz2
    Fix for ide-scsi refcounting of used drivers.
    Author: Mikael Pettersson <mikpe@csd.uu.se>

20-x86-split-group.bz2
    (Only last hunk)
    Add prefetch for P4

And some harmless cleanups:

10-highpage-init.bz2
    Cleanup one_highpage_init() as in 2.5.
    Author: Christoph Hellwig <hch@sgi.com>

11-handle2dentry.bz2
    Factor out duplicated code for handle2dentry conversation.
    Author: Christoph Hellwig <hch@lst.de>

Enjoy!!

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.1 (Cooker) for i586
Linux 2.4.21-pre2-jam2 (gcc 3.2.1 (Mandrake Linux 9.1 3.2.1-2mdk))
