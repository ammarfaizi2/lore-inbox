Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289136AbSBDRhn>; Mon, 4 Feb 2002 12:37:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289142AbSBDRhe>; Mon, 4 Feb 2002 12:37:34 -0500
Received: from mail.gmx.net ([213.165.64.20]:59913 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S289136AbSBDRhP>;
	Mon, 4 Feb 2002 12:37:15 -0500
Date: Mon, 4 Feb 2002 18:36:41 +0100
From: Sebastian =?ISO-8859-1?Q?Dr=F6ge?= <sebastian.droege@gmx.de>
To: "Daniel E. Shipton" <dshipton@vrac.iastate.edu>
Cc: linux-kernel@vger.kernel.org, davej@suse.de
Subject: Re: Linux 2.5.3-dj2
Message-Id: <20020204183641.00a03c7a.sebastian.droege@gmx.de>
In-Reply-To: <1012841649.8335.6.camel@regatta>
In-Reply-To: <20020204154800.A13519@suse.de>
	<1012841649.8335.6.camel@regatta>
X-Mailer: Sylpheed version 0.7.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 boundary="=..wyYs(c?rWk_8t"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=..wyYs(c?rWk_8t
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi,
On 04 Feb 2002 10:54:09 -0600
"Daniel E. Shipton" <dshipton@vrac.iastate.edu> wrote:

> 2.5.3dj-1 would make bzimage and then die on the modules.....
> 
> this is 2.5.3-dj2 and
> make bzImage dies and results in the following below........
> 
> 
> 
> gcc -D__KERNEL__ -I/home/kernel/linux-2.5/include -Wall
> -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
> -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
> -march=i686   -DKBUILD_BASENAME=ptrace  -c -o ptrace.o ptrace.c
> In file included from ptrace.c:13:
> /home/kernel/linux-2.5/include/linux/highmem.h: In function `bh_kmap':
> /home/kernel/linux-2.5/include/linux/highmem.h:21: dereferencing pointer
> to incomplete type
> /home/kernel/linux-2.5/include/linux/highmem.h:21: warning: implicit
> declaration of function `bh_offset'
> /home/kernel/linux-2.5/include/linux/highmem.h: In function `bh_kunmap':
> /home/kernel/linux-2.5/include/linux/highmem.h:26: dereferencing pointer
> to incomplete type
> make[2]: *** [ptrace.o] Error 1
> make[2]: Leaving directory `/home/kernel/linux-2.5/kernel'
> make[1]: *** [first_rule] Error 2
> make[1]: Leaving directory `/home/kernel/linux-2.5/kernel'
> make: *** [_dir_kernel] Error 2
> 
I have the same errors in some other files... such as alsa or the radix tree page cache
Maybe this helps, maybe not ;)

Bye
--=..wyYs(c?rWk_8t
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)

iD8DBQE8Xsate9FFpVVDScsRAm+nAJ9BSlCmW2TVkCcPk6sMY7W903BWYgCgtlBH
bLuxPOgrn9LLOXGeuySq8XQ=
=ZnVU
-----END PGP SIGNATURE-----

--=..wyYs(c?rWk_8t--

