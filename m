Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261397AbSJIHpY>; Wed, 9 Oct 2002 03:45:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261398AbSJIHpY>; Wed, 9 Oct 2002 03:45:24 -0400
Received: from a200042123172.rev.prima.com.ar ([200.42.123.172]:9734 "EHLO
	reloco.dhis.org") by vger.kernel.org with ESMTP id <S261397AbSJIHpX>;
	Wed, 9 Oct 2002 03:45:23 -0400
Message-ID: <3DA3DFE5.5060507@technisys.com.ar>
Date: Wed, 09 Oct 2002 04:51:01 -0300
From: =?ISO-8859-1?Q?Nicol=E1s_Lichtmaier?= <nick@technisys.com.ar>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2a) Gecko/20020915
X-Accept-Language: es-ar, es, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.5.41 does not build: 8250.c: icount has incomplete type.
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    gcc -Wp,-MD,drivers/serial/.8250.o.d -D__KERNEL__ -Iinclude -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=i686 -Iarch/i386/mach-generic -nostdinc -iwithprefix include
-DMODULE   -DKBUILD_BASENAME=8250 -DEXPORT_SYMTAB  -c -o
drivers/serial/8250.o drivers/serial/8250.c
In file included from drivers/serial/8250.c:34:
include/linux/serialP.h:50: field `icount' has incomplete type
make[3]: *** [drivers/serial/8250.o] Error 1
make[2]: *** [drivers/serial] Error 2
make[1]: *** [drivers] Error 2
make[1]: Leaving directory `/home/nick/soft/linux-2.5.41'
make: *** [stamp-build] Error 2

