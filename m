Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265479AbUADNKT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 08:10:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265494AbUADNKT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 08:10:19 -0500
Received: from coruscant.franken.de ([193.174.159.226]:49553 "EHLO
	coruscant.gnumonks.org") by vger.kernel.org with ESMTP
	id S265479AbUADNKM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 08:10:12 -0500
Date: Sun, 4 Jan 2004 13:24:41 +0100
From: Harald Welte <laforge@netfilter.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, linux-kernel@vger.kernel.org,
       christophe@saout.de, netfilter-devel@lists.netfilter.org
Subject: Re: [Bug 1764] New: conntrack oops while reading /proc/net/ip_conntrack
Message-ID: <20040104122441.GF858@obroa-skai.de.gnumonks.org>
Mail-Followup-To: Harald Welte <laforge@netfilter.org>,
	Rusty Russell <rusty@rustcorp.com.au>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	linux-kernel@vger.kernel.org, christophe@saout.de,
	netfilter-devel@lists.netfilter.org
References: <11020000.1072813876@[10.10.2.4]> <20040103152921.76d4362e.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GLp9dJVi+aaipsRk"
Content-Disposition: inline
In-Reply-To: <20040103152921.76d4362e.rusty@rustcorp.com.au>
X-Operating-System: Linux obroa-skai.de.gnumonks.org 2.6.0-test11
X-Date: Today is Prickle-Prickle, the 4th day of Chaos in the YOLD 3170
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--GLp9dJVi+aaipsRk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 03, 2004 at 03:29:21PM +1100, Rusty Russell wrote:
> Um, Harald, other developers,
>=20
> 	Shouldn't list_conntracks do
> READ_LOCK(&ip_conntrack_expect_tuple_lock) before walking the
> expect list?

Thanks Rusty, indeed it should.

> Here's a patch.  Does it do anything?

To the bug reporter(s): Please give feedback on that patch.

> Rusty.
--=20
- Harald Welte <laforge@netfilter.org>             http://www.netfilter.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
  "Fragmentation is like classful addressing -- an interesting early
   architectural error that shows how much experimentation was going
   on while IP was being designed."                    -- Paul Vixie

--GLp9dJVi+aaipsRk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/+AYIXaXGVTD0i/8RAnY0AJ0SCJ1aoZmzACMgRKkvheAaziMFIQCbBu/P
q1syJbvMF8fC9yX+/tUjax8=
=8qri
-----END PGP SIGNATURE-----

--GLp9dJVi+aaipsRk--
