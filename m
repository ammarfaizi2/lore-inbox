Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271161AbRHYV0I>; Sat, 25 Aug 2001 17:26:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271165AbRHYVZ6>; Sat, 25 Aug 2001 17:25:58 -0400
Received: from cx552039-a.elcjn1.sdca.home.com ([24.177.44.17]:13698 "EHLO
	tigger.unnerving.org") by vger.kernel.org with ESMTP
	id <S271161AbRHYVZx>; Sat, 25 Aug 2001 17:25:53 -0400
Date: Sat, 25 Aug 2001 14:26:09 -0700 (PDT)
From: Gregory Ade <gkade@unnerving.org>
To: <linux-kernel@vger.kernel.org>
Subject: 2.4.8-ac11 compile error on sparc
Message-ID: <Pine.LNX.4.33.0108251424210.15717-100000@tigger.unnerving.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


trying to build 2.4.8-ac11 on my sparc, i get this:

gcc -D__KERNEL__ -I/usr/src/linux-2.4.8-ac11/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -m32 -pipe -mno-fpu -fcall-used-g5 -fcall-used-g7   -c -o init/main.o init/main.c
In file included from
/usr/src/linux-2.4.8-ac11/include/linux/pagemap.h:16,
                 from /usr/src/linux-2.4.8-ac11/include/linux/locks.h:8,
                 from /usr/src/linux-2.4.8-ac11/include/linux/devfs_fs_kernel.h:6,
                 from init/main.c:16:
/usr/src/linux-2.4.8-ac11/include/linux/highmem.h: In function `clear_user_highpage':
/usr/src/linux-2.4.8-ac11/include/linux/highmem.h:48: `KM_USER0' undeclared (first use in this function)
/usr/src/linux-2.4.8-ac11/include/linux/highmem.h:48: (Each undeclared identifier is reported only once
/usr/src/linux-2.4.8-ac11/include/linux/highmem.h:48: for each function it appears in.)
/usr/src/linux-2.4.8-ac11/include/linux/highmem.h: In function `copy_user_highpage':
/usr/src/linux-2.4.8-ac11/include/linux/highmem.h:89: `KM_USER0' undeclared (first use in this function)
/usr/src/linux-2.4.8-ac11/include/linux/highmem.h:90: `KM_USER1' undeclared (first use in this function)
make: *** [init/main.o] Error 1


as an aside, is there a version of 2.4 that *does* build on a sparc? =)

-- 
+---------------------------------------------------------------------------+
| Gregory K. Ade <gkade@unnerving.org> | http://unnerving.org/~gkade        |
+---------------------------------------------------------------------------+
| GnuPG Key Fingerprint: F4FC CC7D 613D BDBF 5365 E3D0 7905 0460 EAF4 844B  |
|  You can fetch my public key at search.keyserver.net (Key ID: EAF4844B)   |
+---------------------------------------------------------------------------+

