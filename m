Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261449AbSJMHYs>; Sun, 13 Oct 2002 03:24:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261450AbSJMHYs>; Sun, 13 Oct 2002 03:24:48 -0400
Received: from [203.94.130.164] ([203.94.130.164]:13018 "EHLO bad-sports.com")
	by vger.kernel.org with ESMTP id <S261449AbSJMHYr>;
	Sun, 13 Oct 2002 03:24:47 -0400
Date: Sun, 13 Oct 2002 16:14:44 +1000 (EST)
From: Brett <brett@bad-sports.com>
To: linux-kernel@vger.kernel.org
Subject: kbuild error in 2.5.4[12]
Message-ID: <Pine.LNX.4.44.0210131613200.2373-100000@bad-sports.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hey,

Got this error when compiling with CONFIG_PCMCIA_QLOGIC=m

make -f drivers/scsi/pcmcia/Makefile
  gcc -Wp,-MD,drivers/scsi/pcmcia/.qlogic_stub.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i586 -Iarch/i386/mach-generic -nostdinc -iwithprefix include -DMODULE   -DKBUILD_BASENAME=qlogic_stub   -c -o drivers/scsi/pcmcia/qlogic_stub.o drivers/scsi/pcmcia/qlogic_stub.c
make[3]: *** No rule to make target `drivers/scsi/pcmcia/qlogicfas.s', needed by `drivers/scsi/pcmcia/qlogicfas.o'.  Stop.
make[2]: *** [drivers/scsi/pcmcia] Error 2
make[1]: *** [drivers/scsi] Error 2
make: *** [drivers] Error 2

thanks,

	/ Brett Pemberton

