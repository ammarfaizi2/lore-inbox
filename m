Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261743AbTKLEmz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 23:42:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261753AbTKLEmz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 23:42:55 -0500
Received: from dhcp160178171.columbus.rr.com ([24.160.178.171]:26497 "EHLO
	caphernaum.rivenstone.net") by vger.kernel.org with ESMTP
	id S261743AbTKLEmx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 23:42:53 -0500
Date: Tue, 11 Nov 2003 23:41:36 -0500
To: "David S. Miller" <davem@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com
Subject: Re: [OOPS] TLAN fails on ifconfig with CONFIG_HOTPLUG=n
Message-ID: <20031112044136.GA1401@rivenstone.net>
Mail-Followup-To: "David S. Miller" <davem@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	netdev@oss.sgi.com
References: <20031111222933.GA2868@rivenstone.net> <20031111153013.3b9eba6e.akpm@osdl.org> <20031111155518.52db3e71.davem@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UlVJffcvxoiEqYs2"
Content-Disposition: inline
In-Reply-To: <20031111155518.52db3e71.davem@redhat.com>
User-Agent: Mutt/1.5.4i
From: jhf@rivenstone.net (Joseph Fannin)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 11, 2003 at 03:55:18PM -0800, David S. Miller wrote:
> On Tue, 11 Nov 2003 15:30:13 -0800
> Andrew Morton <akpm@osdl.org> wrote:
>=20
> > Does this fix it?
>  ...
> > -} board_info[] __devinitdata =3D {
> > +} board_info[] =3D {
>=20
> This fix is needed, definitely.  Even if it doesn't cure this
> specific bug.
>=20
> I'll merge this into my networking tree and push to Linus.

    Even better, it fixes the bug. :-)  Thank you.
--=20
Joseph Fannin
jhf@rivenstone.net

"That's all I have to say about that." -- Forrest Gump.

--UlVJffcvxoiEqYs2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/sboAWv4KsgKfSVgRAi1HAJ9OWO45F4Y3NYG8P2leSMJOBUayIgCaA6CS
DcotuiHsTWlmmr+u3c5VGKk=
=JeWb
-----END PGP SIGNATURE-----

--UlVJffcvxoiEqYs2--
