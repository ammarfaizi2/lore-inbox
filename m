Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289296AbSBJFuT>; Sun, 10 Feb 2002 00:50:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289294AbSBJFuJ>; Sun, 10 Feb 2002 00:50:09 -0500
Received: from out010pub.verizon.net ([206.46.170.133]:39661 "EHLO
	out010.verizon.net") by vger.kernel.org with ESMTP
	id <S289293AbSBJFuC>; Sun, 10 Feb 2002 00:50:02 -0500
Date: Sun, 10 Feb 2002 00:47:45 -0500
From: Skip Ford <skip.ford@verizon.net>
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.4-pre5 -- fbdev.c:1814: incompatible types in assignment in function `riva_set_fbinfo'
Mail-Followup-To: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1013319396.28886.8.camel@turbulence.megapathdsl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1013319396.28886.8.camel@turbulence.megapathdsl.net>; from miles@megapathdsl.net on Sat, Feb 09, 2002 at 09:36:36PM -0800
Message-Id: <20020210055001.TYZI21100.out010.verizon.net@pool-141-150-235-204.delv.east.verizon.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Miles Lane wrote:
> 
> make[4]: Entering directory `/usr/src/linux/drivers/video/riva'
> gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes
> -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common
> -pipe -mpreferred-stack-boundary=2 -march=athlon   
> -DKBUILD_BASENAME=fbdev  -c -o fbdev.o fbdev.c
> fbdev.c: In function `riva_set_fbinfo':
> fbdev.c:1814: incompatible types in assignment
> make[4]: *** [fbdev.o] Error 1
> make[4]: Leaving directory `/usr/src/linux/drivers/video/riva'

Change the '-1' on line 1814 of drivers/video/riva/fbdev.c to 'NODEV'

- -- 
Skip  ID: 0x7EDDDB0A
-----BEGIN PGP SIGNATURE-----

iEYEARECAAYFAjxmCXEACgkQBMKxVH7d2wqOrQCfataAK2V5R4UYpHZ3EHliRjsf
DCkAoO3ekxgZeKCggLYrC0NPvVQzw7RI
=ywV/
-----END PGP SIGNATURE-----
