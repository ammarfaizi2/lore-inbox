Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263874AbTETTH5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 May 2003 15:07:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263879AbTETTH5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 May 2003 15:07:57 -0400
Received: from web40603.mail.yahoo.com ([66.218.78.140]:44701 "HELO
	web40603.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263874AbTETTH4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 May 2003 15:07:56 -0400
Message-ID: <20030520192051.70826.qmail@web40603.mail.yahoo.com>
Date: Tue, 20 May 2003 12:20:51 -0700 (PDT)
From: Miles T Lane <miles_lane@yahoo.com>
Subject: 2.5.69-bk14 (PPC build) -- drivers/char/agp/uninorth-agp.c:283: unknown field `suspend' specified in initializer
To: linux-kernel@vger.kernel.org
Cc: paulus@samba.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gnu C                  3.2.2
Gnu make               3.80
util-linux             2.11x
mount                  2.11x
e2fsprogs              1.32
pcmcia-cs              3.2.3
PPP                    2.4.1
Linux C Library        2.3.1
Dynamic linker (ldd)   2.3.1
Procps                 3.1.6
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               4.5.7

make -f scripts/Makefile.build obj=drivers/char/agp
  gcc -Wp,-MD,drivers/char/agp/.uninorth-agp.o.d
-D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes
-Wno-tr
igraphs -O2 -fno-strict-aliasing -fno-common
-Iarch/ppc -msoft-float -pipe -ffixed-r2
-Wno-uninitialized
-mmultiple -mstring -fomit-frame-pointer -nostdinc
-iwithprefix include    -DKBUILD_BASENAME=uninorth_agp
 -DKBUILD_MODNAME=uninorth_agp -c -o
drivers/char/agp/uninorth-agp.o
drivers/char/agp/uninorth-agp.c
drivers/char/agp/uninorth-agp.c:283: unknown field
`suspend' specified in initializer
drivers/char/agp/uninorth-agp.c:283:
`agp_generic_suspend' undeclared here (not in a
function)
drivers/char/agp/uninorth-agp.c:283: warning: excess
elements in struct initializer
drivers/char/agp/uninorth-agp.c:283: warning: (near
initialization for `uninorth_agp_driver')
drivers/char/agp/uninorth-agp.c:284: unknown field
`resume' specified in initializer
drivers/char/agp/uninorth-agp.c:284:
`agp_generic_resume' undeclared here (not in a
function)
drivers/char/agp/uninorth-agp.c:284: warning: excess
elements in struct initializer
drivers/char/agp/uninorth-agp.c:284: warning: (near
initialization for `uninorth_agp_driver')
make[3]: *** [drivers/char/agp/uninorth-agp.o] Error 1


__________________________________
Do you Yahoo!?
The New Yahoo! Search - Faster. Easier. Bingo.
http://search.yahoo.com
