Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312254AbSDXOPq>; Wed, 24 Apr 2002 10:15:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312256AbSDXOPp>; Wed, 24 Apr 2002 10:15:45 -0400
Received: from pieck.student.uva.nl ([146.50.96.22]:56742 "EHLO
	pieck.student.uva.nl") by vger.kernel.org with ESMTP
	id <S312254AbSDXOPo>; Wed, 24 Apr 2002 10:15:44 -0400
Content-Type: text/plain; charset=US-ASCII
From: rudmer@legolas.dynup.net
Reply-To: rudmer@legolas.dynup.net
To: davej@suse.de
Subject: Compile failure for 2.5.9-dj1
Date: Wed, 24 Apr 2002 16:15:44 +0200
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-Id: <02042416154400.06806@middle-earth.net>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I could not find any report of this, sorry if it is a duplicate..
error occurs when I started patching from 2.5.8-dj1 to 2.5.8 to 2.5.9 to 
2.5.9-dj1, and also when I patched 2.5.9 to 2.5.9-dj1.

	Rudmer

--
gcc -D__KERNEL__ -I/usr/src/linux-2.5.9-dj1/include -Wall -Wstrict-prototypes 
-Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer 
-pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4  -DMODULE  
-nostdinc -I /usr/lib/gcc-lib/i686-pc-linux-gnu/2.95.3/include 
-DKBUILD_BASENAME=ide_scsi
-c -o ide-scsi.o ide-scsi.c
ide-scsi.c:839: unknown field `abort' specified in initializer
ide-scsi.c:839: warning: initialization from incompatible pointer type
ide-scsi.c:840: unknown field `reset' specified in initializer
ide-scsi.c:840: warning: initialization from incompatible pointer type
make[2]: *** [ide-scsi.o] Error 1
make[2]: Leaving directory `/usr/src/linux-2.5.9-dj1/drivers/scsi'
make[1]: *** [_modsubdir_scsi] Error 2
make[1]: Leaving directory `/usr/src/linux-2.5.9-dj1/drivers'
make: *** [_mod_drivers] Error 2
