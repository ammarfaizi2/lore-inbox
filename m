Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261173AbSKBOVb>; Sat, 2 Nov 2002 09:21:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261186AbSKBOVb>; Sat, 2 Nov 2002 09:21:31 -0500
Received: from coruscant.franken.de ([193.174.159.226]:33759 "EHLO
	coruscant.gnumonks.org") by vger.kernel.org with ESMTP
	id <S261173AbSKBOVa>; Sat, 2 Nov 2002 09:21:30 -0500
Date: Sat, 2 Nov 2002 15:25:12 +0100
From: Harald Welte <laforge@gnumonks.org>
To: Loic Jaquemet <ljaquemet@gatwick.westerngeco.slb.com>
Cc: netfilter-devel@lists.netfilter.org,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Patch?: linux-2.5.45/net/ipv4/netfilter dst.pmtu compilation fixes
Message-ID: <20021102152512.J8635@sunbeam.de.gnumonks.org>
References: <3DC29100.FDA579A5@gatwick.westerngeco.slb.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jHB9a7dTjJ2Ks2DP"
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <3DC29100.FDA579A5@gatwick.westerngeco.slb.com>; from ljaquemet@gatwick.westerngeco.slb.com on Fri, Nov 01, 2002 at 02:34:40PM +0000
X-Operating-System: Linux sunbeam.de.gnumonks.org 2.4.19-pre10-newnat-pptp
X-Date: Today is Pungenday, the 6th day of The Aftermath in the YOLD 3168
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--jHB9a7dTjJ2Ks2DP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 01, 2002 at 02:34:40PM +0000, Loic Jaquemet wrote:
>=20
> also see
> http://marc.theaimsgroup.com/?l=3Dlinux-kernel&m=3D103614599321384&w=3D1
>=20
> linux-2.5.45 appears to have replaced dst_entry.pmtu with
> dst_entry.metrics[RTAX_PMTU] and created a helper function
> dst_pmtu(struct dst_entry*), presumably to simplify future changes
> like this one.   Now the
> files compile.  That is as much as I have tested.
>=20
>  I am not currently familiar with this code, so I could easily
> have misunderstood something in this patch.

I will forward your patch for kernel inclusion.
--=20
Live long and prosper
- Harald Welte / laforge@gnumonks.org               http://www.gnumonks.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
"If this were a dictatorship, it'd be a heck of a lot easier, just so long
 as I'm the dictator."  --  George W. Bush Dec 18, 2000

--jHB9a7dTjJ2Ks2DP
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9w+BIXaXGVTD0i/8RAoxoAJ9E4Xrso8FTRpyAZ7YtHBuBsVaNBwCcCXr+
AysjrdHrDGzIEljdnGkjNI8=
=fVf0
-----END PGP SIGNATURE-----

--jHB9a7dTjJ2Ks2DP--
