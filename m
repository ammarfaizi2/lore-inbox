Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310212AbSCBAZf>; Fri, 1 Mar 2002 19:25:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310215AbSCBAZZ>; Fri, 1 Mar 2002 19:25:25 -0500
Received: from 12-249-51-60.client.attbi.com ([12.249.51.60]:27578 "EHLO noir")
	by vger.kernel.org with ESMTP id <S310212AbSCBAZK>;
	Fri, 1 Mar 2002 19:25:10 -0500
Date: Fri, 1 Mar 2002 18:25:10 -0600
From: Kain <kain@kain.org>
To: Julian Anastasov <ja@ssi.bg>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, Andi Kleen <ak@suse.de>
Subject: Re: OOPS: Multipath routing 2.4.17
Message-ID: <20020302002510.GA1743@kain.org>
In-Reply-To: <Pine.LNX.4.44.0203012316120.1420-100000@u.domain.uli>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EeQfGwPcQSOJBaQU"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0203012316120.1420-100000@u.domain.uli>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 02, 2002 at 12:27:40AM +0000, Julian Anastasov wrote:
> 	What about a different algorithm to apply weighted
> round robin (idea mostly from LVS), something like
> this code (entirely not tested) where fi->fib_power is not used
> and where fib_sync_up and fib_sync_down don't need to play
> with nh_power on nh_flags change:
>=20
> [function cut]=20

It would take me a few days I think to understand the net code enough to
code anything so I don't know if I can be of help there, but I'm willing
to put together some testcases for this, or the simple
slap-some-write-locks-in solution, and see if I can break it again.
--=20
"Don't dwell on reality; it will only keep you from greatness."
  -- Randall McBride, Jr.
**
Reality Engineer
Bryon Roche, Kain <kain@imperativesolutions.com>
<kain@kain.org>

--EeQfGwPcQSOJBaQU
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjyAG+YACgkQBK2G/mh4q9V2aACgpElYACypsfliexVv+nq2V1P3
kzoAnR0oBNLya2GIVj1JD7gF04jDxkPO
=E6UK
-----END PGP SIGNATURE-----

--EeQfGwPcQSOJBaQU--
