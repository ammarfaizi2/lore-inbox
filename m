Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274612AbRITTCh>; Thu, 20 Sep 2001 15:02:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274613AbRITTC1>; Thu, 20 Sep 2001 15:02:27 -0400
Received: from ares.sot.com ([195.74.13.236]:54546 "EHLO ares.sot.com")
	by vger.kernel.org with ESMTP id <S274612AbRITTCN>;
	Thu, 20 Sep 2001 15:02:13 -0400
Date: Thu, 20 Sep 2001 22:02:37 +0300 (EEST)
From: Yaroslav Popovitch <yp@ares.sot.com>
To: linux-kernel@vger.kernel.org
Subject: CAPI2 is not compiled by gcc-3.0.1
Message-ID: <Pine.LNX.4.10.10109202152550.23645-100000@ares.sot.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I want only report,that isdn/capi.c with enabled CAPI2 is not compiled by
gcc-3.0.1 due to an internal compiler error:

Reading specs from /usr/lib/gcc-lib/i386-rpm-linux/3.0.1/specs
Configured with: ../configure --prefix=/usr --enable-shared
--enable-threads=posix --enable-haifa --host=i386-rpm-linux
Thread model: posix
gcc version 3.0.1
 /usr/lib/gcc-lib/i386-rpm-linux/3.0.1/cpp0 -lang-c -v
-I/home/yp/kernel-2.4.10/linux/include -D__GNUC__=3 -D__GNUC_MINOR__=0
-D__GNUC_PATCHLEVEL__=1 -D__ELF__ -Dunix -Dlinux -D__ELF__ -D__unix__
-D__linux__ -D__unix -D__linux -Asystem=posix -D__OPTIMIZE__
-D__STDC_HOSTED__=1 -Wall -Wstrict-prototypes -Wno-trigraphs -Acpu=i386
-Amachine=i386 -Di386 -D__i386 -D__i386__ -D__tune_i686__
-D__tune_pentiumpro__ -D__KERNEL__ -DMODULE -DMODVERSIONS -include
/home/yp/kernel-2.4.10/linux/include/linux/modversions.h capi.c capi.i
GNU CPP version 3.0.1 (cpplib) (i386 Linux/ELF)
ignoring nonexistent directory "/usr/i386-rpm-linux/include"
ignoring duplicate directory "/usr/include"
#include "..." search starts here:
#include <...> search starts here:
 /home/yp/kernel-2.4.10/linux/include
 /usr/include
 /usr/lib/gcc-lib/i386-rpm-linux/3.0.1/include
End of search list.
 /usr/lib/gcc-lib/i386-rpm-linux/3.0.1/cc1 -fpreprocessed capi.i -quiet
-dumpbase capi.c -mpreferred-stack-boundary=2 -mcpu=i686 -malign-jumps=3
-malign-functions=2 -O2 -Wall -Wstrict-prototypes -Wno-trigraphs -version
-fomit-frame-pointer -fno-strict-aliasing -fno-common -o capi.s
GNU CPP version 3.0.1 (cpplib) (i386 Linux/ELF)
GNU C version 3.0.1 (i386-rpm-linux)
        compiled by GNU C version 3.0.1.
capi.c: In function `capi_ioctl':
capi.c:1031: Unrecognizable insn:
(insn/i 1672 3383 3380 (parallel[ capi.c:1031: Internal error:
Segmentation fault


 I already had sent full report to gcc-bugs@gcc.gnu.org

Cheers,YP 


