Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265169AbUATQEF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 11:04:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265437AbUATQEE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 11:04:04 -0500
Received: from h192n2fls310o1003.telia.com ([81.224.187.192]:22146 "EHLO
	cambrant.com") by vger.kernel.org with ESMTP id S265169AbUATQEB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 11:04:01 -0500
Date: Tue, 20 Jan 2004 17:03:57 +0100
From: Tim Cambrant <tim@cambrant.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.1-mm5 [Compile error]
Message-ID: <20040120160357.GA10881@cambrant.com>
References: <20040120000535.7fb8e683.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KsGdsel6WgEHnImy"
Content-Disposition: inline
In-Reply-To: <20040120000535.7fb8e683.akpm@osdl.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--KsGdsel6WgEHnImy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

When compiling 2.6.1-mm5 i get these errors:

  CC	drivers/net/net_init.o
In file included from drivers/net/net_init.c:53:
include/net/neighbour.h:216: parse error before `proc_handler'
include/net/neighbour.h:216: warning: function declaration isn't a prototype
make[2]: *** [drivers/net/net_init.o] Error 1
make[1]: *** [drivers/net] Error 2
make: *** [drivers] Error 2

=46rom what I'm able to see, nothing is wrong with the function declaration,
so I really cannot guess why this error show up. Then again, I'm no
programmer/developer, so someone else ought to take a look at this to
see what's causing these problems. This error is new in 2.6.1-mm5.
2.6.1-mm4 compiles cleanly and works beautifully.

I'd be happy to test any patches to help fixing the error.

                Tim Cambrant

--KsGdsel6WgEHnImy
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFADVFt+p4C2FlRhwIRAvpGAJ99ny8lPlt5Gyia6bZEJ6esF2xIwwCgjMHI
woh0JFZQdJkt/6xd8886sCg=
=wvxI
-----END PGP SIGNATURE-----

--KsGdsel6WgEHnImy--
