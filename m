Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262134AbTCZTrr>; Wed, 26 Mar 2003 14:47:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262128AbTCZTrr>; Wed, 26 Mar 2003 14:47:47 -0500
Received: from cpt-dial-196-30-180-122.mweb.co.za ([196.30.180.122]:27008 "EHLO
	nosferatu.lan") by vger.kernel.org with ESMTP id <S262000AbTCZTrn>;
	Wed, 26 Mar 2003 14:47:43 -0500
Subject: Re: w83781d i2c driver updated for 2.5.66 (without sysfs support)
From: Martin Schlemmer <azarah@gentoo.org>
Reply-To: azarah@gentoo.org
To: Jan Dittmer <j.dittmer@portrix.net>
Cc: Greg KH <greg@kroah.com>, KML <linux-kernel@vger.kernel.org>,
       Dominik Brodowski <linux@brodo.de>, sensors@stimpy.netroedge.com
In-Reply-To: <3E82024A.4000809@portrix.net>
References: <1048582394.4774.7.camel@workshop.saharact.lan>
	 <20030325175603.GG15823@kroah.com> <1048705473.7569.10.camel@nosferatu.lan>
	 <3E82024A.4000809@portrix.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Ynr/LxAGDvxyxBJVDjjL"
Organization: 
Message-Id: <1048708449.7569.34.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3- 
Date: 26 Mar 2003 21:54:09 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Ynr/LxAGDvxyxBJVDjjL
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2003-03-26 at 21:40, Jan Dittmer wrote:
> Martin Schlemmer wrote:
> >=20
> > I did look at the changes needed for sysfs, but this beast have
> > about 6 ctl_tables, and is hairy in general.  I am not sure what
> > is the best way to do it for the different chips, so here is what
> > I have until I or somebody else can do the sysfs stuff.
> >=20
> I've just done this with the via686a driver. Saves about 100 lines of cod=
e.
>=20
> Comments?
>=20

Nice example, thanks =3D)  The w83781d does things in similar fashion,
except that it support 6 different 'models', that have more or less
the same readouts except for here and there a few more or less.


Regards,

--=20

Martin Schlemmer



--=-Ynr/LxAGDvxyxBJVDjjL
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+ggVgqburzKaJYLYRAvV0AJkB/HWNymc1o/QMU8V26kHuOFlmfgCfUlDI
nSZCcHH2s455OidEl1LS934=
=aVwK
-----END PGP SIGNATURE-----

--=-Ynr/LxAGDvxyxBJVDjjL--

