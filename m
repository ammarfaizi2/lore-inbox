Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316971AbSH0VeB>; Tue, 27 Aug 2002 17:34:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317253AbSH0VeA>; Tue, 27 Aug 2002 17:34:00 -0400
Received: from [213.4.129.129] ([213.4.129.129]:23269 "EHLO tsmtp5.mail.isp")
	by vger.kernel.org with ESMTP id <S316971AbSH0VeA>;
	Tue, 27 Aug 2002 17:34:00 -0400
Date: Tue, 27 Aug 2002 23:37:40 +0200
From: Arador <diegocg@teleline.es>
To: linux-kernel@vger.kernel.org
Subject: 2.5.32: compilation error in pnpbios_core.c
Message-Id: <20020827233740.31bbda2e.diegocg@teleline.es>
X-Mailer: Sylpheed version 0.7.4claws (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


make[2]: Entering directory `/usr/src/unstable/drivers/pnp'
  gcc -Wp,-MD,./.pnpbios_core.o.d -D__KERNEL__ -I/usr/src/unstable/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i586 -nostdinc -iwithprefix include    -DKBUILD_BASENAME=pnpbios_core -DEXPORT_SYMTAB  -c -o pnpbios_core.o pnpbios_core.c
make[2]: Leaving directory `/usr/src/unstable/drivers/pnp'
make[1]: Leaving directory `/usr/src/unstable/drivers'
nvalid lvalue in unary `&'
pnpbios_core.c:169: invalid lvalue in unary `&'
pnpbios_core.c:169: invalid lvalue in unary `&'
pnpbios_core.c: In function `pnpbios_init':
pnpbios_core.c:1276: invalid lvalue in unary `&'
pnpbios_core.c:1276: invalid lvalue in unary `&'
pnpbios_core.c:1277: invalid lvalue in unary `&'
pnpbios_core.c:1277: invalid lvalue in unary `&'
pnpbios_core.c:1278: invalid lvalue in unary `&'
pnpbios_core.c:1278: invalid lvalue in unary `&'
make[2]: *** [pnpbios_core.o] Error 1
make[1]: *** [pnp] Error 2
make: *** [drivers] Error 2
