Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289294AbSBJGPv>; Sun, 10 Feb 2002 01:15:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289299AbSBJGPn>; Sun, 10 Feb 2002 01:15:43 -0500
Received: from front2.mail.megapathdsl.net ([66.80.60.30]:6928 "EHLO
	front2.mail.megapathdsl.net") by vger.kernel.org with ESMTP
	id <S289294AbSBJGPd>; Sun, 10 Feb 2002 01:15:33 -0500
Subject: Re: 2.5.4-pre5 -- fbdev.c:1814: incompatible types in assignment in
	function `riva_set_fbinfo'
From: Miles Lane <miles@megapathdsl.net>
To: Skip Ford <skip.ford@verizon.net>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20020210055001.TYZI21100.out010.verizon.net@pool-141-150-235-204.delv.east.
	verizon.net>
In-Reply-To: <1013319396.28886.8.camel@turbulence.megapathdsl.net> 
	<20020210055001.TYZI21100.out010.verizon.net@pool-141-150-235-204.delv.east.
	verizon.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
X-Mailer: Evolution/1.1.0.99 (Preview Release)
Date: 09 Feb 2002 22:12:41 -0800
Message-Id: <1013321561.28886.10.camel@turbulence.megapathdsl.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Can someone apply this in the "dead simple obvious fixes"
maintainer tree?

Thanks,
	Miles

On Sat, 2002-02-09 at 21:47, Skip Ford wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Miles Lane wrote:
> > 
> > make[4]: Entering directory `/usr/src/linux/drivers/video/riva'
> > gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes
> > -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common
> > -pipe -mpreferred-stack-boundary=2 -march=athlon   
> > -DKBUILD_BASENAME=fbdev  -c -o fbdev.o fbdev.c
> > fbdev.c: In function `riva_set_fbinfo':
> > fbdev.c:1814: incompatible types in assignment
> > make[4]: *** [fbdev.o] Error 1
> > make[4]: Leaving directory `/usr/src/linux/drivers/video/riva'
> 
> Change the '-1' on line 1814 of drivers/video/riva/fbdev.c to 'NODEV'
> 
> - -- 
> Skip  ID: 0x7EDDDB0A
> -----BEGIN PGP SIGNATURE-----
> 
> iEYEARECAAYFAjxmCXEACgkQBMKxVH7d2wqOrQCfataAK2V5R4UYpHZ3EHliRjsf
> DCkAoO3ekxgZeKCggLYrC0NPvVQzw7RI
> =ywV/
> -----END PGP SIGNATURE-----
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


