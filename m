Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264088AbUFQWiA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264088AbUFQWiA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 18:38:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264096AbUFQWiA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 18:38:00 -0400
Received: from mh57.com ([217.160.185.21]:52626 "EHLO mithrin.mh57.de")
	by vger.kernel.org with ESMTP id S264088AbUFQWhh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 18:37:37 -0400
Date: Fri, 18 Jun 2004 00:37:29 +0200
From: Martin Hermanowski <martin@mh57.de>
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: space left on ext3 (2.6.6-bk3)
Message-ID: <20040617223729.GA2654@mh57.de>
References: <Pine.LNX.4.60.0406180018530.9599@poirot.grange>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="G4iJoqBmSsgzjUCe"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.60.0406180018530.9599@poirot.grange>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-Broken-Reverse-DNS: no host name found for IP address 2001:8d8:81:4d0:8000::1
X-Spam-Score: 0.2 (/)
X-Authenticated-ID: martin
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 18, 2004 at 12:23:25AM +0200, Guennadi Liakhovetski wrote:
> On a ext3 fs:
>=20
> fast:/mnt/tmp# df
> Filesystem           1K-blocks      Used Available Use% Mounted on
> /dev/sda3               958488    521864    387936  58% /mnt
>=20
> fast:/mnt/tmp# cat /dev/zero > zr
> cat: write error: No space left on device
>=20
> fast:/mnt/tmp# ls -l
> total 436624
> -rw-r--r--    1 root     root     446660608 Jun 18 00:23 zr
[...]
> Is this an expected behaviour?.. Yeah, it is nice to have more space than=
=20
> you think you have, but...

436192 blocks

958488-521864 =3D 436624 blocks

I think you have 5% reserved for root, as this is the default setting
when creating ext3 fs'.

LLAP, Martin

--G4iJoqBmSsgzjUCe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA0h0pmGb6Npij0ewRAtOuAJ9gh5xKnj7ehTI3CM4RoQ5ZLjaoDACgjcBd
uNblLlmww5X/JmNsQhycILI=
=To/d
-----END PGP SIGNATURE-----

--G4iJoqBmSsgzjUCe--
