Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278120AbRKMSqm>; Tue, 13 Nov 2001 13:46:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277528AbRKMSqc>; Tue, 13 Nov 2001 13:46:32 -0500
Received: from beppo.feral.com ([192.67.166.79]:15373 "EHLO beppo.feral.com")
	by vger.kernel.org with ESMTP id <S277341AbRKMSqQ>;
	Tue, 13 Nov 2001 13:46:16 -0500
Date: Tue, 13 Nov 2001 10:46:05 -0800 (PST)
From: Matthew Jacob <mjacob@feral.com>
Reply-To: mjacob@feral.com
To: Keith Owens <kaos@ocs.com.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: Announce: modutils 2.4.11 is available 
In-Reply-To: <26919.1005458129@ocs3.intra.ocs.com.au>
Message-ID: <Pine.BSF.4.21.0111131045540.78620-100000@beppo>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


FWIW:

 obj_gpl_license.c
gcc -O2 -Wall -I./../include -D_GNU_SOURCE  -DCONFIG_ROOT_CHECK_OFF=0
-DCOMMON_3264 -DELF_MACHINE_H='"elf_ppc64.h"' -DARCH_ppc64 -DONLY_64 -c -o
obj_ppc64_64.o obj_ppc64.c
In file included from ../include/obj.h:34,
                 from obj_ppc64.c:25:
../include/elf_ppc64.h:89: unbalanced `#endif'
make[1]: *** [obj_ppc64_64.o] Error 1
make[1]: Leaving directory `/usr/src/modutils-2.4.11/obj'
make: *** [all] Error 2


PPC, with older (2.2) kernel



