Return-Path: <linux-kernel-owner+w=401wt.eu-S933216AbWLaUl1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933216AbWLaUl1 (ORCPT <rfc822;w@1wt.eu>);
	Sun, 31 Dec 2006 15:41:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933218AbWLaUl1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Dec 2006 15:41:27 -0500
Received: from phlare.wyrms.net ([66.140.245.109]:33574 "EHLO phlare.wyrms.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933216AbWLaUl0 (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
	Sun, 31 Dec 2006 15:41:26 -0500
Subject: Re: compile failure on 2.6.19
From: Robin Cook <rcook@wyrms.net>
To: Linux-kernel <Linux-kernel@vger.kernel.org>
In-Reply-To: <9c21eeae0612311027p17737cc0q765aca18fe22fd38@mail.gmail.com>
References: <1167585932.3730.9.camel@localhost>
	 <9c21eeae0612311027p17737cc0q765aca18fe22fd38@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-b21nC3E/A6RVzs8lVUtz"
Date: Sun, 31 Dec 2006 14:41:25 -0600
Message-Id: <1167597685.3503.0.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-b21nC3E/A6RVzs8lVUtz
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

That fixed the problem.

Thanks

On Sun, 2006-12-31 at 10:27 -0800, David Brown wrote:
> On 12/31/06, Robin Cook <rcook@wyrms.net> wrote:
> > I am getting this error when I try to compile 2.6.19 and 2.6.19.1.
> >
> > I ran make mrproper and make menuconfig then ran make and got the below
> > error.
> >
> >   HOSTLD  scripts/kconfig/conf
> > scripts/kconfig/conf -s arch/i386/Kconfig
> >   CHK     include/linux/version.h
> >   UPD     include/linux/version.h
> > /bin/sh: -c: line 0: syntax error near unexpected token `('
> > /bin/sh: -c: line 0: `set -e; echo '  CHK
> > include/linux/utsrelease.h'; mkdir -p include/linux/;     if [ `echo -n
> > "2.6.19.1 .file null .ident
> > GCC:(GNU)4.1.1 .section .note.GNU-stack,,@progbits" | wc -c ` -gt 64 ];
> > then echo '"2.6.19.1 .file null .ident
> > GCC:(GNU)4.1.1 .section .note.GNU-stack,,@progbits" exceeds 64
> > characters' >&2; exit 1; fi; (echo \#define UTS_RELEASE \"2.6.19.1 .fil=
e
> > null .ident GCC:(GNU)4.1.1 .section .note.GNU-stack,,@progbits\";) <
> > include/config/kernel.release > include/linux/utsrelease.h.tmp; if [ -r
> > include/linux/utsrelease.h ] && cmp -s include/linux/utsrelease.h
> > include/linux/utsrelease.h.tmp; then rm -f
> > include/linux/utsrelease.h.tmp; else echo '  UPD
> > include/linux/utsrelease.h'; mv -f include/linux/utsrelease.h.tmp
> > include/linux/utsrelease.h; fi'
> > make: *** [include/linux/utsrelease.h] Error 2
>=20
> I'd check /dev/null and make sure it's not a regular file this
> happened to me a while back
>=20
> - David Brown
>=20

--=-b21nC3E/A6RVzs8lVUtz
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iQIVAwUARZggdUR0KI3mhyXmAQI7Vg//UiNR9kHfoztTiaKcSLnDPSlPfAjAkIe2
CmTjBMGI4t+4t8GOwz4TXiBkB8A2ONTiTsBjNDr/tWB9H0No5sW1oCm6UvBiCHod
msLmtnn9691/o47LLQAPxBXucTgRSAHhWWSOOz27RJOT0g/lEE4NcyRWZOs7LP9S
C/Dm5JVAtfkiVMXQ+ds4OU6f4ca5p7MH73El7nlyySNkVdc5xF68CWVEPaS3mLDG
xMbIADotQfHXHZbhK/eqt8EW313aPjG2002S4/GFTuKb3bESArdQJwN7eAss/AUw
96l3SRICe/jDsxXl0mFTu8UUX0+5DJm5atBFyyPviJA6yETkziwbjW94UbAT7jhL
ZSP2Hr/MwYQ9NbI2FNuVr8fuAEarqDRURsqfOecvGKO7b45QAaRcgYOcSVRLn0Kn
KqcwiWx0kNmdlNK2HPjQQEgNMUxsU8y2otbaV7AyWixq5IVrEymYawDDe5h8lEuw
qwSNx57jSpiwFHnJSzKRURZC0pfg3HihimrioUqcQuFNchKUb8yToKMKyUBggEDr
eT/4Onf3CSsr9POGW+qDKiCAY361b0dMx0nErnIRPWNl7wp7mWEjPj5I4DTK89gp
zpK1hJIj1fJMaKLM6xZfaeXgkYr47aIDU5eT0Q5E14EApBUtt11L2gAet500XWuI
BWSzHCHoFGc=
=pUr2
-----END PGP SIGNATURE-----

--=-b21nC3E/A6RVzs8lVUtz--

