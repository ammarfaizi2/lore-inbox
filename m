Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262614AbSJBVie>; Wed, 2 Oct 2002 17:38:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262616AbSJBVie>; Wed, 2 Oct 2002 17:38:34 -0400
Received: from services.erkkila.org ([24.97.94.217]:13449 "EHLO erkkila.org")
	by vger.kernel.org with ESMTP id <S262614AbSJBVic>;
	Wed, 2 Oct 2002 17:38:32 -0400
Message-ID: <3D9B689B.2040807@erkkila.org>
Date: Wed, 02 Oct 2002 21:43:55 +0000
From: "Paul E. Erkkila" <pee@erkkila.org>
Reply-To: pee@erkkila.org
Organization: ErkkilaDotOrg
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2b) Gecko/20021002
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, hermes@gibson.dropbear.id.au
Subject: compile failure in orinoco_cs.c (from bk pull)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The orinoco_cs.c wireless driver no longer compiles after yesterdays
tree changes.

make[3]: Entering directory `/usr/src/linux-2.5/drivers/net/wireless'
  gcc -Wp,-MD,./.orinoco_cs.o.d -D__KERNEL__ 
-I/usr/src/linux-2.5/include -Wall -Wstrict-prototypes -Wno-trigraphs 
-O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe 
-mpreferred-stack-boundary=2 -march=i686 
-I/usr/src/linux-2.5/arch/i386/mach-generic -nostdinc -iwithprefix 
include    -DKBUILD_BASENAME=orinoco_cs   -c -o orinoco_cs.o orinoco_cs.c
orinoco_cs.c:35:26: linux/tqueue.h: No such file or directory
make[3]: *** [orinoco_cs.o] Error 1
make[3]: Leaving directory `/usr/src/linux-2.5/drivers/net/wireless'
make[2]: *** [wireless] Error 2
make[2]: Leaving directory `/usr/src/linux-2.5/drivers/net'
make[1]: *** [net] Error 2
make[1]: Leaving directory `/usr/src/linux-2.5/drivers'
make: *** [drivers] Error 2

thanks,

-pee


