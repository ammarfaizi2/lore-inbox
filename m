Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318704AbSG0GTX>; Sat, 27 Jul 2002 02:19:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318705AbSG0GTX>; Sat, 27 Jul 2002 02:19:23 -0400
Received: from [210.19.28.11] ([210.19.28.11]:21888 "EHLO
	dZuRa.int.Vault-ID.com") by vger.kernel.org with ESMTP
	id <S318704AbSG0GTW> convert rfc822-to-8bit; Sat, 27 Jul 2002 02:19:22 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Corporal Pisang <corporal_pisang@counter-strike.com.my>
Organization: Counter-Strike.com.my
To: linux-kernel@vger.kernel.org
Subject: 2.5.29 compile failure (pnpbios)
Date: Sat, 27 Jul 2002 14:28:46 +0800
User-Agent: KMail/1.4.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200207271428.46518.corporal_pisang@counter-strike.com.my>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

I get this error on 2.5.29.


gcc -Wp,-MD,./.pnpbios_core.o.d -D__KERNEL__ -I/usr/src/linux/include -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer 
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 
-march=athlon  -nostdinc -iwithprefix include    
-DKBUILD_BASENAME=pnpbios_core -DEXPORT_SYMTAB  -c -o pnpbios_core.o 
pnpbios_core.c
pnpbios_core.c: In function `call_pnp_bios':
pnpbios_core.c:165: `gdt' undeclared (first use in this function)
pnpbios_core.c:165: (Each undeclared identifier is reported only once
pnpbios_core.c:165: for each function it appears in.)
pnpbios_core.c: In function `pnpbios_init':
pnpbios_core.c:1268: `gdt' undeclared (first use in this function)
make[2]: *** [pnpbios_core.o] Error 1
make[2]: Leaving directory `/usr/src/linux/drivers/pnp'
make[1]: *** [pnp] Error 2
make[1]: Leaving directory `/usr/src/linux/drivers'
make: *** [drivers] Error 2

regards.

-- 
-----------------------
-Ubaida-

 
