Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278353AbRJMSm2>; Sat, 13 Oct 2001 14:42:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278356AbRJMSmQ>; Sat, 13 Oct 2001 14:42:16 -0400
Received: from grip.panax.com ([63.163.40.2]:56082 "EHLO panax.com")
	by vger.kernel.org with ESMTP id <S278353AbRJMSmK>;
	Sat, 13 Oct 2001 14:42:10 -0400
Date: Sat, 13 Oct 2001 14:42:20 -0400
From: Patrick McFarland <unknown@panax.com>
To: Rik van Riel <riel@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Which is better at vm, and why? 2.2 or 2.4
Message-ID: <20011013144220.P249@localhost>
In-Reply-To: <20011013141709.L249@localhost> <Pine.LNX.4.33L.0110131526500.2847-100000@imladris.rielhome.conectiva>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="P9KQiUGMzYCFwWCN"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33L.0110131526500.2847-100000@imladris.rielhome.conectiva>
User-Agent: Mutt/1.3.22i
X-Operating-System: Linux 2.4.12 i586
X-Distributed: Join the Effort!  http://www.distributed.net/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--P9KQiUGMzYCFwWCN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Ill reiterate something here, im on a p133 with 16 megs. Yeah, the kind of =
the crappy ide controller that eats cpu time to swap. (Enough so that my mo=
use pointer will freeze in X that its swapping so much. Swapping is the onl=
y thing ive found that can pull that off) Swapping the least ammount would =
be the best for a box like that.

On 13-Oct-2001, Rik van Riel wrote:
> On Sat, 13 Oct 2001, Patrick McFarland wrote:
>=20
> > Hmm, I see that as very bad. There should be a bunch of sysctls to do
> > that easily.
>=20
> See /proc/sys/vm/* and the documentation ;)
>=20
> > Also, I heard that 2.4 (and I'm assuming 2.2 as well) swaps pages on a
> > last-used-age basis, instead of either a number-of-times-used or a
> > hybrid of the two. That kinda seems stupid,
>=20
> Don't worry since it's not true, at least the VM in the -ac
> kernels _does_ use a hybrid of access recency and frequency
> to determine page replacement.
>=20
> The -linus kernel, however only has LRU-like selection.
>=20
> At the moment the -linus kernel is faster than the -ac kernel
> for some workloads. This may have something to do with better
> clusterable IO ... when page replacement is less precise the
> chance that IO is clusterable is probably larger due to the
> way we scan.
>=20
> I plan to do more explicit IO clustering in -ac to try and
> remedy this difference.
>=20
> regards,
>=20
> Rik
> --=20
> DMCA, SSSCA, W3C?  Who cares?  http://thefreeworld.net/  (volunteers need=
ed)
>=20
> http://www.surriel.com/		http://distro.conectiva.com/
>=20

--=20
Patrick "Diablo-D3" McFarland || unknown@panax.com

--P9KQiUGMzYCFwWCN
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)

iD8DBQE7yIsL8Gvouk7G1cURAlZUAJ0YsBIHJEqEJPZC4sP1/hkQiCQl3wCeN9m/
LzvRQO80R8BHDO6prxd7M6o=
=UjXJ
-----END PGP SIGNATURE-----

--P9KQiUGMzYCFwWCN--
