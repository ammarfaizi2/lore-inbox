Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265409AbSJXMR5>; Thu, 24 Oct 2002 08:17:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265405AbSJXMR5>; Thu, 24 Oct 2002 08:17:57 -0400
Received: from coruscant.franken.de ([193.174.159.226]:36833 "EHLO
	coruscant.gnumonks.org") by vger.kernel.org with ESMTP
	id <S265409AbSJXMR4>; Thu, 24 Oct 2002 08:17:56 -0400
Date: Thu, 24 Oct 2002 14:22:34 +0200
From: Harald Welte <laforge@gnumonks.org>
To: "David S. Miller" <davem@redhat.com>
Cc: bart.de.schuymer@pandora.be, coreteam@netfilter.org,
       linux-kernel@vger.kernel.org, buytenh@gnu.org
Subject: Re: [netfilter-core] [RFC] place to put bridge-netfilter specific data in the skbuff
Message-ID: <20021024142234.U2450@sunbeam.de.gnumonks.org>
References: <200210141953.38933.bart.de.schuymer@pandora.be> <200210142159.49290.bart.de.schuymer@pandora.be> <20021024101656.T2450@sunbeam.de.gnumonks.org> <20021024.011512.08605370.davem@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="H83aLI5Lttn3Hg7B"
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <20021024.011512.08605370.davem@redhat.com>; from davem@redhat.com on Thu, Oct 24, 2002 at 01:15:12AM -0700
X-Operating-System: Linux sunbeam.de.gnumonks.org 2.4.19-pre10-newnat-pptp
X-Date: Today is Setting Orange, the 3rd day of The Aftermath in the YOLD 3168
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--H83aLI5Lttn3Hg7B
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 24, 2002 at 01:15:12AM -0700, David Miller wrote:
>    From: Harald Welte <laforge@gnumonks.org>
>    Date: Thu, 24 Oct 2002 10:16:56 +0200
>=20
>    Mh. Since bridging firewall is cool, but not something everybody will
>    use by default [and it adds code as well as enlarges the skb], I think=
 it=20
>    should be a compiletime kernel config option.
>   =20
> This was my initial reaction, but both of us misunderstand what
> is going on I think.

Ok ;)

> If you use bridging, using netfilter on the bridged traffic "is not
> possible" without these bridge-netfilter changes.
>=20
> So he's saying, if we have bridging enable and netfilter, should
> bridge-netfilter be on, and right now I say yes.

Yes, this does perfectly make sense. This is the way to go.

--=20
Live long and prosper
- Harald Welte / laforge@gnumonks.org               http://www.gnumonks.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
"If this were a dictatorship, it'd be a heck of a lot easier, just so long
 as I'm the dictator."  --  George W. Bush Dec 18, 2000

--H83aLI5Lttn3Hg7B
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9t+YKXaXGVTD0i/8RAvTPAJ0dZY/Xuh1OBXawasc6thZP14qDiwCfTf5w
s83d3pVC3gAKvlhwt84pNvU=
=FRvH
-----END PGP SIGNATURE-----

--H83aLI5Lttn3Hg7B--
