Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317402AbSHAXwa>; Thu, 1 Aug 2002 19:52:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317355AbSHAXwa>; Thu, 1 Aug 2002 19:52:30 -0400
Received: from dial-2-203.emitel.hu ([195.228.182.203]:24963 "EHLO
	bazooka.enclave.net") by vger.kernel.org with ESMTP
	id <S317402AbSHAXw3>; Thu, 1 Aug 2002 19:52:29 -0400
Date: Fri, 2 Aug 2002 01:32:53 +0200
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.30
Message-ID: <20020801233253.GA524@bazooka.saturnus.vein.hu>
References: <Pine.LNX.4.33.0208011425410.1612-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0208011425410.1612-100000@penguin.transmeta.com>
User-Agent: Mutt/1.3.28i
From: Banai Zoltan <bazooka@emitel.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There is a complie error:

gcc -Wp,-MD,./.nls_utf8.o.d -D__KERNEL__ -I/usr/src/linux-2.5.24/include
-Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=i686 -nostdinc -iwithprefix include    -DKBUILD_BASENAME=nls_utf8
-c -o nls_utf8.o nls_utf8.c
ld -m elf_i386  -r -o built-in.o nls_base.o nls_cp437.o nls_cp850.o
nls_cp852.o nls_iso8859-1.o nls_iso8859-2.o nls_utf8.o
make[2]: Leaving directory `/usr/src/linux-2.5.24/fs/nls'
make[2]: Entering directory `/usr/src/linux-2.5.24/fs/partitions'
gcc -Wp,-MD,./.check.o.d -D__KERNEL__
-I/usr/src/linux-2.5.24/include -Wall -Wstrict-prototypes
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing
-fno-common -pipe -mpreferred-stack-boundary=2 -march=i686
-nostdinc -iwithprefix include    -DKBUILD_BASENAME=check
-DEXPORT_SYMTAB  -c -o check.o check.c
check.c: In function `devfs_register_partitions':
check.c:470: array subscript is not an integer
make[2]: *** [check.o] Error 1
make[2]: Leaving directory `/usr/src/linux-2.5.24/fs/partitions'
make[1]: *** [partitions] Error 2
make[1]: Leaving directory `/usr/src/linux-2.5.24/fs'
make: *** [fs] Error 2

Greatings,
--
Banai
