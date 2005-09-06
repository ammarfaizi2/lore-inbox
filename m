Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932418AbVIFG77@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932418AbVIFG77 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 02:59:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932431AbVIFG77
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 02:59:59 -0400
Received: from ganesha.gnumonks.org ([213.95.27.120]:47779 "EHLO
	ganesha.gnumonks.org") by vger.kernel.org with ESMTP
	id S932418AbVIFG77 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 02:59:59 -0400
Date: Tue, 6 Sep 2005 08:59:52 +0200
From: Harald Welte <laforge@gnumonks.org>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Omnikey Cardman 4000 driver
Message-ID: <20050906065951.GA14984@sunbeam.de.gnumonks.org>
References: <20050906013545.GB16056@rama.de.gnumonks.org> <9a874849050905133650caa09e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="envbJBWh7q8WU6mo"
Content-Disposition: inline
In-Reply-To: <9a874849050905133650caa09e@mail.gmail.com>
User-Agent: mutt-ng devel-20050619 (Debian)
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--envbJBWh7q8WU6mo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 05, 2005 at 10:36:57PM +0200, Jesper Juhl wrote:
> On 9/6/05, Harald Welte <laforge@gnumonks.org> wrote:
> > Hi!
> >=20
> [snip]
> >=20
> > Please consider mergin mainline, thanks.
> >=20
> [snip]
>=20
> Wouldn't it be better to first merge it in -mm and get some wider
> testing before pushing for mainline?

=46rom my past experience (I'm involved in writing smartcard reader
drivers for some time now), users of smartcard readers tend to be
"typical corporate users" who won't run anything but the distribution
kernel. =20

I really doubt that the drivers would get much more testing in -mm than
they would in mainline.

Also, what is the point of putting entirely new code (no changes to
existing code!) into -mm?  I understand that changes to existing code
can inarguably benefit from some testing in -mm first.

But new drivers?  Where's the point?  The devices are not supported in
the existing kernel, so it cannot get worse by having a driver (even if
it still contains one or the other bug).

--=20
- Harald Welte <laforge@gnumonks.org>          	        http://gnumonks.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
"Privacy in residential applications is a desirable marketing option."
                                                  (ETSI EN 300 175-7 Ch. A6)

--envbJBWh7q8WU6mo
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDHT5nXaXGVTD0i/8RAnNPAJ0UdHGmhxLvQyBH3GeOT2GAt016qACgptVj
XbkBq/zP+RsazK74/W+mMpU=
=wsz3
-----END PGP SIGNATURE-----

--envbJBWh7q8WU6mo--
