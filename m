Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261852AbSJASNr>; Tue, 1 Oct 2002 14:13:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262854AbSJASNr>; Tue, 1 Oct 2002 14:13:47 -0400
Received: from node-d-1ef6.a2000.nl ([62.195.30.246]:29678 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S261852AbSJASNq>; Tue, 1 Oct 2002 14:13:46 -0400
Subject: Re: compiling errors
From: Arjan van de Ven <arjanv@fenrus.demon.nl>
To: immortal1015 <immortal1015@hotpop.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <20021001180459.E4AD92F8147@smtp-1.hotpop.com>
References: <20021001180459.E4AD92F8147@smtp-1.hotpop.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-64vENYkFMJ1CD/sXLycd"
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 01 Oct 2002 20:22:04 +0200
Message-Id: <1033496525.2575.3.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-64vENYkFMJ1CD/sXLycd
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2002-10-01 at 20:07, immortal1015 wrote:
> I tried to compile the very simple kernel module code as following.
> I compile this code using gcc -c hello.c, but gcc tell me:
>  /usr/include/linux	/module.h:60 parse error before 'atomic_t'

you are using glibc headers to compile kernel code....

add -I/lib/modules/`uname -r`/build/include
to the gcc flags



--=-64vENYkFMJ1CD/sXLycd
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA9mefMxULwo51rQBIRAnhEAKCQa4P2uFvF03Y1asOvqAhih68f9gCgnvvh
OVHxSL+WQ7BzhNcXp9Rn+xY=
=cav0
-----END PGP SIGNATURE-----

--=-64vENYkFMJ1CD/sXLycd--

