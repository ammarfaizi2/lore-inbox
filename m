Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289547AbSAVXUe>; Tue, 22 Jan 2002 18:20:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289545AbSAVXUY>; Tue, 22 Jan 2002 18:20:24 -0500
Received: from NODE1.HOSTING-NETWORK.COM ([66.186.193.1]:7941 "HELO
	hosting-network.com") by vger.kernel.org with SMTP
	id <S289544AbSAVXUS>; Tue, 22 Jan 2002 18:20:18 -0500
Subject: Intermezzo compile error in linux-2.5.2-dj4
From: Torrey Hoffman <thoffman@arnor.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 22 Jan 2002 15:23:28 -0800
Message-Id: <1011741810.25320.0.camel@shire.arnor.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Haven't seen this reported yet.

gcc -D__KERNEL__ -I/home/archive/Kernels/linux-2.5.2-dj4/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=i686 -DMODULE -DMODVERSIONS -include
/home/archive/Kernels/linux-2.5.2-dj4/include/linux/modversions.h 
-DKBUILD_BASENAME=vfs  -c -o vfs.o vfs.c
vfs.c: In function `presto_do_mknod':
vfs.c:1452: request for member `value' in something not a structure or
union
vfs.c:1452: request for member `value' in something not a structure or
union
make[2]: *** [vfs.o] Error 1
make[2]: Leaving directory
`/home/archive/Kernels/linux-2.5.2-dj4/fs/intermezzo'

Torrey

