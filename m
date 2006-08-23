Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932323AbWHWEGi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932323AbWHWEGi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 00:06:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932324AbWHWEGi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 00:06:38 -0400
Received: from chilli.pcug.org.au ([203.10.76.44]:2511 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S932323AbWHWEGh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 00:06:37 -0400
Date: Wed, 23 Aug 2006 14:06:09 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Olaf Hering <olaf@aepfle.de>
Cc: Peter Korsgaard <jacmet@sunsite.dk>, linux-kernel@vger.kernel.org,
       device@lanana.org
Subject: Re: [PATCH] Update Documentation/devices.txt
Message-Id: <20060823140609.db24b42a.sfr@canb.auug.org.au>
In-Reply-To: <20060822172339.GA15581@aepfle.de>
References: <87d5aserky.fsf@slug.be.48ers.dk>
	<20060822172339.GA15581@aepfle.de>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Wed__23_Aug_2006_14_06_09_+1000_35j70_ePfpQs_A=U"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Wed__23_Aug_2006_14_06_09_+1000_35j70_ePfpQs_A=U
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 22 Aug 2006 19:23:39 +0200 Olaf Hering <olaf@aepfle.de> wrote:
>
> On Tue, Aug 22, Peter Korsgaard wrote:
>=20
>=20
> > -229 char	IBM iSeries virtual console
> > -		  0 =3D /dev/iseries/vtty0	First console port
> > -		  1 =3D /dev/iseries/vtty1	Second console port
> > +229 char	IBM iSeries/pSeries virtual console
> > +		  0 =3D /dev/hvc0			First console port
>=20
> hvc0 is pSeries only, iSeries uses tty1 for its OS400 provided telnet
> console. I doubt there is a hvc1.

There is a new driver for the iSeries console which uses /dev/hvc0.
You are correct that there is not hvc1 on iSeries.  (I actually submitted
the change to Devices.txt)

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__23_Aug_2006_14_06_09_+1000_35j70_ePfpQs_A=U
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFE69Q4FdBgD/zoJvwRAnFkAJ0cxjP90nkYn6kRUipSgAov9wuMEgCfdDKb
3/MForypQtYPdZhdPwEY30g=
=AjQF
-----END PGP SIGNATURE-----

--Signature=_Wed__23_Aug_2006_14_06_09_+1000_35j70_ePfpQs_A=U--
