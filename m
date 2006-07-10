Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161290AbWGJBzT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161290AbWGJBzT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 21:55:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161291AbWGJBzT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 21:55:19 -0400
Received: from chilli.pcug.org.au ([203.10.76.44]:29141 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S1161290AbWGJBzR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 21:55:17 -0400
Date: Mon, 10 Jul 2006 11:55:01 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "Albert Cahalan" <acahalan@gmail.com>
Cc: linux-kernel@vger.kernel.org, device@lanana.org
Subject: Re: devices.txt errors
Message-Id: <20060710115501.09379b97.sfr@canb.auug.org.au>
In-Reply-To: <787b0d920607091022l4e4e7b1en41781a50a1ab048f@mail.gmail.com>
References: <787b0d920607082349h59ec36f7nc477e3cc9f9b6c77@mail.gmail.com>
	<20060710024315.7dacd7f9.sfr@canb.auug.org.au>
	<787b0d920607091022l4e4e7b1en41781a50a1ab048f@mail.gmail.com>
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Mon__10_Jul_2006_11_55_01_+1000_BzRWUq.mE7jj4ZZ_"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Mon__10_Jul_2006_11_55_01_+1000_BzRWUq.mE7jj4ZZ_
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, 9 Jul 2006 13:22:53 -0400 "Albert Cahalan" <acahalan@gmail.com> wro=
te:
>
> On 7/9/06, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > On Sun, 9 Jul 2006 02:49:19 -0400 "Albert Cahalan" <acahalan@gmail.com>=
 wrote:
> > >
> > > Some names, like "/dev/iseries/vtty%d", are too damn big.
> >
> > As far as I know they were never used and certainly aren't now.  We did
> > once use /dev/viocons/%d, but that went away a long time ago (before the
> > code was in the mainline kernel).  Major 229 is now used by the pSeries
> > Hypervisor consoles (/dev/hvc%d) and hopefully soon by a new iSeries
> > hypervisor console with the same name.
>=20
> Since that still isn't in devices.txt...
>=20
> /dev/ttyHV%d would match the standard pattern better.
> (assuming you only need 3-digit numbers)

However, it is already in the mainline kernel (the pSeries HV console) and
in common use ...

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Mon__10_Jul_2006_11_55_01_+1000_BzRWUq.mE7jj4ZZ_
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQFEsbN7FdBgD/zoJvwRAkzDAJ0QYZQipMTbFHka8el1mvlyvLqJswCfb6AU
3OprUis3n57ZdcEvu1cEzQA=
=DseR
-----END PGP SIGNATURE-----

--Signature=_Mon__10_Jul_2006_11_55_01_+1000_BzRWUq.mE7jj4ZZ_--
