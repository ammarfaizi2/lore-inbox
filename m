Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318211AbSHKJAm>; Sun, 11 Aug 2002 05:00:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318216AbSHKJAm>; Sun, 11 Aug 2002 05:00:42 -0400
Received: from 212.68.254.82.brutele.be ([212.68.254.82]:8583 "EHLO stargate")
	by vger.kernel.org with ESMTP id <S318211AbSHKJAl>;
	Sun, 11 Aug 2002 05:00:41 -0400
Date: Sun, 11 Aug 2002 11:04:27 +0200
From: Stephane Wirtel <stephane.wirtel@belgacom.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux 2.5.31 - compile error with pnpbios in pnpbios_core.c
Message-ID: <20020811090427.GA7494@stargate.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


there are the lines of this error 

make[3]: Entering directory `/usr/src/linux-2.5.31/drivers/pnp'
  gcc -Wp,-MD,./.pnpbios_core.o.d -D__KERNEL__
  -I/usr/src/linux-2.5.31/include -Wall -Wstrict-prototypes -Wno-trigraphs
  -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe
  -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4  -nostdinc
  -iwithprefix include    -DKBUILD_BASENAME=pnpbios_core -DEXPORT_SYMTAB
  -c -o pnpbios_core.o pnpbios_core.c
  pnpbios_core.c: In function `call_pnp_bios':
  pnpbios_core.c:166: invalid lvalue in unary `&'
  pnpbios_core.c:166: invalid lvalue in unary `&'
  pnpbios_core.c:168: invalid lvalue in unary `&'
  pnpbios_core.c:168: invalid lvalue in unary `&'
  pnpbios_core.c: In function `pnpbios_init':
  pnpbios_core.c:1275: invalid lvalue in unary `&'
  pnpbios_core.c:1275: invalid lvalue in unary `&'
  pnpbios_core.c:1276: invalid lvalue in unary `&'
  pnpbios_core.c:1276: invalid lvalue in unary `&'
  pnpbios_core.c:1277: invalid lvalue in unary `&'
  pnpbios_core.c:1277: invalid lvalue in unary `&'
  make[3]: *** [pnpbios_core.o] Error 1
  make[3]: Leaving directory `/usr/src/linux-2.5.31/drivers/pnp'
  make[2]: *** [pnp] Error 2
  make[2]: Leaving directory `/usr/src/linux-2.5.31/drivers'
  make[1]: *** [drivers] Error 2
  make[1]: Leaving directory `/usr/src/linux-2.5.31'
  make: *** [bzImage] Error 2
  bash-2.05a# 
  


best regards,

stephane wirtel


-- 
Stephane Wirtel <stephane.wirtel@belgacom.net>
Web : www.linux-mons.be	 "Linux Is Not UniX !!!"
Address :
    Rue de cartier, 53
    6030 Marchienne-au-Pont
    Belgium
Phone :	+32 474 768 072
