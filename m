Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264631AbSJTTdH>; Sun, 20 Oct 2002 15:33:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264633AbSJTTdH>; Sun, 20 Oct 2002 15:33:07 -0400
Received: from port326.ds1-brh.adsl.cybercity.dk ([217.157.160.207]:6265 "EHLO
	mail.jaquet.dk") by vger.kernel.org with ESMTP id <S264631AbSJTTdG>;
	Sun, 20 Oct 2002 15:33:06 -0400
Date: Sun, 20 Oct 2002 21:39:06 +0200
From: Rasmus Andersen <rasmus@jaquet.dk>
To: bert hubert <ahu@ds9a.nl>, linux-kernel@vger.kernel.org
Subject: Re: Error in get_swap_page? (2.5.44)
Message-ID: <20021020213906.B17457@jaquet.dk>
References: <20021020213217.A17457@jaquet.dk> <20021020193652.GC26384@outpost.ds9a.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="8GpibOaaTibBMecb"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021020193652.GC26384@outpost.ds9a.nl>; from ahu@ds9a.nl on Sun, Oct 20, 2002 at 09:36:52PM +0200
X-PGP-Key: http://www.jaquet.dk/rasmus/pubkey.asc
X-PGP-Fingerprint: 925A 8E4B 6D63 1C22 BFB9  29CF 9592 4049 9E9E 26CE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--8GpibOaaTibBMecb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 20, 2002 at 09:36:52PM +0200, bert hubert wrote:
> On Sun, Oct 20, 2002 at 09:32:17PM +0200, Rasmus Andersen wrote:
>=20
> > Unless I am mistaken, we return stuff (entry) from the local=20
> > stack in swapfile.c::get_swap_page. Am I mistaken?
>=20
> Yes. This just returns a struct by value over the stack, which is frowned
> upon in some circles, but is not an error per se.

Hmm. You are right and I must be confused. -ENEEDSLEEP, apparently.

Thanks,
  Rasmus

--8GpibOaaTibBMecb
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE9swZalZJASZ6eJs4RAv0SAJ9zuAv7hZCt5iXj+u06KpPM2ca9vQCggLcC
hPU/ew6BFbAsZObo2CgA1r8=
=ecyY
-----END PGP SIGNATURE-----

--8GpibOaaTibBMecb--
