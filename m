Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318816AbSIIRtL>; Mon, 9 Sep 2002 13:49:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318818AbSIIRtK>; Mon, 9 Sep 2002 13:49:10 -0400
Received: from sccrmhc02.attbi.com ([204.127.202.62]:34701 "EHLO
	sccrmhc02.attbi.com") by vger.kernel.org with ESMTP
	id <S318816AbSIIRtK>; Mon, 9 Sep 2002 13:49:10 -0400
Subject: 2.5.33 -- pnpbios_core.c: 167: In function `call_pnp_bios': 
	Invalid lvalue in unary `&'
From: Miles Lane <miles.lane@attbi.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8.99 
Date: 09 Sep 2002 10:53:17 -0700
Message-Id: <1031593997.11629.0.camel@turbulence.megapathdsl.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  gcc -Wp,-MD,./.pnpbios_core.o.d -D__KERNEL__
-I/usr/src/linux-2.5.33/include -Wall -Wstrict-prototypes -Wno-trigraphs
-O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe
-mpreferred-stack-boundary=2 -march=athlon  -nostdinc -iwithprefix
include    -DKBUILD_BASENAME=pnpbios_core -DEXPORT_SYMTAB  -c -o
pnpbios_core.o pnpbios_core.c
pnpbios_core.c: In function `call_pnp_bios':
pnpbios_core.c:167: invalid lvalue in unary `&'
...
make[2]: *** [pnpbios_core.o] Error 1
make[2]: Leaving directory `/usr/src/linux-2.5.33/drivers/pnp'

CONFIG_MK7=y
CONFIG_PNP=y
CONFIG_PNPBIOS=y


