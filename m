Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268446AbUHQV1q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268446AbUHQV1q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 17:27:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268451AbUHQV1q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 17:27:46 -0400
Received: from ctb-mesg6.saix.net ([196.25.240.78]:35027 "EHLO
	ctb-mesg6.saix.net") by vger.kernel.org with ESMTP id S268446AbUHQV1d
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 17:27:33 -0400
Subject: Re: 2.6.8.1-mm1 Tty problems?
From: Martin Schlemmer <azarah@nosferatu.za.org>
Reply-To: Martin Schlemmer <azarah@nosferatu.za.org>
To: ismail =?ISO-8859-1?Q?d=F6nmez?= <ismail.donmez@gmail.com>
Cc: Paul Fulghum <paulkf@microgate.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <2a4f155d040817124335766947@mail.gmail.com>
References: <2a4f155d040817070854931025@mail.gmail.com>
	 <412247FF.5040301@microgate.com>
	 <2a4f155d0408171116688a87f1@mail.gmail.com>
	 <4122501B.7000106@microgate.com>
	 <2a4f155d04081712005fdcdd9b@mail.gmail.com>
	 <41225D16.2050702@microgate.com>
	 <2a4f155d040817124335766947@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-lgXUsbtAUuu6CM7RAt+d"
Message-Id: <1092778259.8998.12.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 17 Aug 2004 23:30:59 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-lgXUsbtAUuu6CM7RAt+d
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 2004-08-17 at 21:43, ismail d=C3=B6nmez wrote:
> > That does not look right.
> > Char dev 3 is the pty major.
> > This could be left over from running with the controlling-tty patch.
> >=20
> > Try recreating /dev/tty as a char special file:
> > mknod -m 666 /dev/tty c 5 0
>=20
> Hmm I use udev and /dev/tty dir is created again at startup. So
> something else is broken too I think.
>=20

Just fix the permissions in
/etc/udev/permissions.d/50-udev.permissions, and file a bug with
your distribution if its not self-compiled.

--=20
Martin Schlemmer

--=-lgXUsbtAUuu6CM7RAt+d
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBBInkTqburzKaJYLYRApA/AJ0TjesMan55Ap3t1kU9aKo8/6FWOgCeOyeT
Foz/PHCCyS+mEK7btPPJq4M=
=VlJe
-----END PGP SIGNATURE-----

--=-lgXUsbtAUuu6CM7RAt+d--

