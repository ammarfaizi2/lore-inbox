Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314150AbSD0RSX>; Sat, 27 Apr 2002 13:18:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314154AbSD0RSW>; Sat, 27 Apr 2002 13:18:22 -0400
Received: from adsl-64-171-6-36.dsl.sntc01.pacbell.net ([64.171.6.36]:31741
	"EHLO k2-400.lameter.com") by vger.kernel.org with ESMTP
	id <S314150AbSD0RSW>; Sat, 27 Apr 2002 13:18:22 -0400
Date: Sat, 27 Apr 2002 10:18:20 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
To: linux-kernel@vger.kernel.org
Subject: 2.5.10-dj1 compilation failure
Message-ID: <Pine.LNX.4.44.0204271017510.5443-100000@k2-400.lameter.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

gcc -D__KERNEL__ -I/usr/src/linux-2.5.8/include -Wall -Wstrict-prototypes
-Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer
-pipe -mpreferred-stack-boundary=2 -march=k6   -nostdinc -I
/usr/lib/gcc-lib/i386-linux/2.95.4/include -DKBUILD_BASENAME=ide_scsi  -c
-o ide-scsi.o ide-scsi.c
ide-scsi.c:837: unknown field `abort' specified in initializer
ide-scsi.c:837: warning: initialization from incompatible pointer type
ide-scsi.c:838: unknown field `reset' specified in initializer
ide-scsi.c:838: warning: initialization from incompatible pointer type
make[3]: *** [ide-scsi.o] Error 1
make[3]: Leaving directory `/usr/src/linux-2.5.8/drivers/scsi'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/usr/src/linux-2.5.8/drivers/scsi'
make[1]: *** [_subdir_scsi] Error 2
make[1]: Leaving directory `/usr/src/linux-2.5.8/drivers'
make: *** [_dir_drivers] Error 2


