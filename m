Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267482AbSLFBIa>; Thu, 5 Dec 2002 20:08:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267487AbSLFBIa>; Thu, 5 Dec 2002 20:08:30 -0500
Received: from mail46-s.fg.online.no ([148.122.161.46]:35522 "EHLO
	mail46.fg.online.no") by vger.kernel.org with ESMTP
	id <S267482AbSLFBI3>; Thu, 5 Dec 2002 20:08:29 -0500
Date: Fri, 6 Dec 2002 02:16:13 +0100
From: Michael <soppscum@online.no>
To: linux-kernel@vger.kernel.org
Subject: ide-scsi compile error in 2.5.50-mm1
Message-Id: <20021206021613.06a864ab.soppscum@online.no>
X-Mailer: Sylpheed version 0.8.5 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

make -f scripts/Makefile.build obj=drivers/scsi
  gcc -Wp,-MD,drivers/scsi/.ide-scsi.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=k6 -Iarch/i386/mach-generic -nostdinc -iwithprefix include -DMODULE   -DKBUILD_BASENAME=ide_scsi -DKBUILD_MODNAME=ide_scsi   -c -o drivers/scsi/ide-scsi.o drivers/scsi/ide-scsi.c
drivers/scsi/ide-scsi.c: In function `should_transform':
drivers/scsi/ide-scsi.c:767: structure has no member named `tag'
make[2]: *** [drivers/scsi/ide-scsi.o] Error 1
make[1]: *** [drivers/scsi] Error 2
make: *** [drivers] Error 2
