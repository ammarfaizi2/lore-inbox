Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266574AbUJNHu4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266574AbUJNHu4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 03:50:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269992AbUJNHu4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 03:50:56 -0400
Received: from lug-owl.de ([195.71.106.12]:32462 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S266574AbUJNHux (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 03:50:53 -0400
Date: Thu, 14 Oct 2004 09:50:53 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Alexander Wigen <alex@wigen.net>
Cc: Greg KH <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: pl2303/usb-serial driver problem in 2.4.27-pre6
Message-ID: <20041014075052.GV5033@lug-owl.de>
Mail-Followup-To: Alexander Wigen <alex@wigen.net>,
	Greg KH <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>
References: <416A6CF8.5050106@kharkiv.com.ua> <200410131932.28896.alex@wigen.net> <20041013174251.GB17291@kroah.com> <200410141406.58960.alex@wigen.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Efvj0OqvPr19h3JK"
Content-Disposition: inline
In-Reply-To: <200410141406.58960.alex@wigen.net>
X-Operating-System: Linux mail 2.6.8-rc4 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Efvj0OqvPr19h3JK
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 2004-10-14 14:06:58 +0000, Alexander Wigen <alex@wigen.net>
wrote in message <200410141406.58960.alex@wigen.net>:
> On Wednesday 13 October 2004 17:42, Greg KH wrote:
> > On Wed, Oct 13, 2004 at 07:32:28PM +0000, Alexander Wigen wrote:

> I had the problem on two laptops and a stationary machine running 2.4.20.=
 I=20
> dug out the old gps device and am happy to say the problem is gone on=20
> 2.6.8.1. I don't have a 2.4 kernel handy so I can't say if the problem is=
=20
> still present in the 2.4 branch.

2.4.20 is quite old; additionally, the pl2303 driver has known problems
(Oops on device removal while the device node is opened for example...).
2.6.x just works (last famous words, I know...) but I suggest you just
upgrade to 2.6.x. I'm using this driver basically each day (for GPS
receiver and a number of serial links for serial console) and never
had a problem with it (except on 2.4.x).

MfG, JBG

--=20
Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481             =
_ O _
"Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg  =
_ _ O
 fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Irak! =
  O O O
ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TCPA)=
);

--Efvj0OqvPr19h3JK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBbi/cHb1edYOZ4bsRAktCAJ4+hCe2tRgPoaS57QxMJ8YNpgNNVwCfWZc4
XepNpykDQwAlnHhPbcQE70k=
=rH7D
-----END PGP SIGNATURE-----

--Efvj0OqvPr19h3JK--
