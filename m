Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316674AbSFJFks>; Mon, 10 Jun 2002 01:40:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316675AbSFJFkr>; Mon, 10 Jun 2002 01:40:47 -0400
Received: from [210.19.28.11] ([210.19.28.11]:45697 "EHLO
	dZuRa.int.Vault-ID.com") by vger.kernel.org with ESMTP
	id <S316674AbSFJFkq> convert rfc822-to-8bit; Mon, 10 Jun 2002 01:40:46 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Corporal Pisang <corporal_pisang@counter-strike.com.my>
Organization: Counter-Strike.com.my
To: linux-kernel@vger.kernel.org
Subject: 2.5.21 pnpbios compile error.
Date: Mon, 10 Jun 2002 13:47:07 +0800
User-Agent: KMail/1.4.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200206101347.07394.corporal_pisang@counter-strike.com.my>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hi,

I get this error compiling 2.5.21

make[2]: Entering directory `/usr/src/linux/drivers/pnp'
  gcc -Wp,-MD,.pnpbios_proc.o.d -D__KERNEL__ -I/usr/src/linux/include -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer 
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 
-march=athlon  -nostdinc -iwithprefix include    
-DKBUILD_BASENAME=pnpbios_proc   -c -o pnpbios_proc.o pnpbios_proc.c
pnpbios_proc.c:193: parse error before "pnpbios_proc_init"
pnpbios_proc.c:194: warning: return type defaults to `int'
pnpbios_proc.c:248: parse error before "pnpbios_proc_exit"
pnpbios_proc.c:249: warning: return type defaults to `int'
pnpbios_proc.c:249: conflicting types for `pnpbios_proc_exit'
/usr/src/linux/include/linux/pnpbios.h:147: previous declaration of 
`pnpbios_proc_exit'
pnpbios_proc.c: In function `pnpbios_proc_exit':
pnpbios_proc.c:253: warning: `return' with no value, in function returning 
non-void
pnpbios_proc.c:269: warning: `return' with no value, in function returning 
non-void
make[2]: *** [pnpbios_proc.o] Error 1
make[2]: Leaving directory `/usr/src/linux/drivers/pnp'
make[1]: *** [_subdir_pnp] Error 2
make[1]: Leaving directory `/usr/src/linux/drivers'
make: *** [drivers] Error 2


Regards.

-- 
-Ubaida-
