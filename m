Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267050AbSLKIGJ>; Wed, 11 Dec 2002 03:06:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267052AbSLKIGJ>; Wed, 11 Dec 2002 03:06:09 -0500
Received: from math.ut.ee ([193.40.5.125]:26301 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id <S267050AbSLKIGI>;
	Wed, 11 Dec 2002 03:06:08 -0500
Date: Wed, 11 Dec 2002 10:13:52 +0200 (EET)
From: Meelis Roos <mroos@linux.ee>
To: linux-kernel@vger.kernel.org
Subject: IDE does not compile for PPC in 2.4.20+bk
Message-ID: <Pine.GSO.4.44.0212111012400.24645-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

make[1]: Entering directory `/home/mroos/compile/linux-2.4/arch/ppc/kernel'
gcc -D__KERNEL__ -I/home/mroos/compile/linux-2.4/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -I/home/mroos/compile/linux-2.4/arch/ppc -fsigned-char -msoft-float -pipe -ffixed-r2 -Wno-uninitialized -mmultiple -mstring   -nostdinc -iwithprefix include -DKBUILD_BASENAME=setup  -c -o setup.o setup.c
setup.c: In function `ppc_generic_ide_fix_driveid':
setup.c:674: structure has no member named `word89'
setup.c:674: structure has no member named `word89'
setup.c:674: structure has no member named `word89'
setup.c:674: structure has no member named `word89'
setup.c:675: structure has no member named `word90'
setup.c:675: structure has no member named `word90'
setup.c:675: structure has no member named `word90'
setup.c:675: structure has no member named `word90'
setup.c:677: structure has no member named `word92'
setup.c:677: structure has no member named `word92'
setup.c:677: structure has no member named `word92'
setup.c:677: structure has no member named `word92'
setup.c:681: structure has no member named `words95_99'
setup.c:681: structure has no member named `words95_99'
setup.c:681: structure has no member named `words95_99'
setup.c:681: structure has no member named `words95_99'

-- 
Meelis Roos (mroos@linux.ee)

