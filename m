Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318085AbSIJTqd>; Tue, 10 Sep 2002 15:46:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318086AbSIJTqd>; Tue, 10 Sep 2002 15:46:33 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:47862 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S318085AbSIJTqc>; Tue, 10 Sep 2002 15:46:32 -0400
Date: Tue, 10 Sep 2002 21:51:12 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Miles Lane <miles.lane@attbi.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.33 -- pnpbios_core.c: 167: In function `call_pnp_bios':
 Invalid lvalue in unary `&'
In-Reply-To: <1031593997.11629.0.camel@turbulence.megapathdsl.net>
Message-ID: <Pine.NEB.4.44.0209102150520.18902-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9 Sep 2002, Miles Lane wrote:

>   gcc -Wp,-MD,./.pnpbios_core.o.d -D__KERNEL__
> -I/usr/src/linux-2.5.33/include -Wall -Wstrict-prototypes -Wno-trigraphs
> -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe
> -mpreferred-stack-boundary=2 -march=athlon  -nostdinc -iwithprefix
> include    -DKBUILD_BASENAME=pnpbios_core -DEXPORT_SYMTAB  -c -o
> pnpbios_core.o pnpbios_core.c
> pnpbios_core.c: In function `call_pnp_bios':
> pnpbios_core.c:167: invalid lvalue in unary `&'
> ...
> make[2]: *** [pnpbios_core.o] Error 1
> make[2]: Leaving directory `/usr/src/linux-2.5.33/drivers/pnp'
>
> CONFIG_MK7=y
> CONFIG_PNP=y
> CONFIG_PNPBIOS=y

This is a known issue and the fix is already in 2.5.34.

cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox

