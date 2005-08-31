Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932065AbVHaKQM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932065AbVHaKQM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 06:16:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932073AbVHaKQM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 06:16:12 -0400
Received: from lug-owl.de ([195.71.106.12]:2260 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S932065AbVHaKQL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 06:16:11 -0400
Date: Wed, 31 Aug 2005 12:16:10 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Rahul Tank <rahul5311@yahoo.co.in>,
       Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: serial port multiplexing
Message-ID: <20050831101610.GB27695@lug-owl.de>
Mail-Followup-To: Rahul Tank <rahul5311@yahoo.co.in>,
	Linux-kernel <linux-kernel@vger.kernel.org>
References: <20050825122045.57008.qmail@web8401.mail.in.yahoo.com> <20050831111048.E26480@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2B/JsCI69OhZNC5r"
Content-Disposition: inline
In-Reply-To: <20050831111048.E26480@flint.arm.linux.org.uk>
X-Operating-System: Linux mail 2.6.12.3lug-owl 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--2B/JsCI69OhZNC5r
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 2005-08-31 11:10:48 +0100, Russell King <rmk+lkml@arm.linux.org.uk>=
 wrote:
> On Thu, Aug 25, 2005 at 01:20:45PM +0100, Rahul Tank wrote:
> >     I am a newbee tryinging for serial port
> > multiplexing. Currently my driver supports for one
> > port
> > (/dev/ttyS0). However i want to use the same physical
> > port for 2 virtual ports.I am NOT sending two type of
> > data simultaneously. I want to first reigister my
> > driver for /dev/ttyS0. When the kernel  has booted ,i
> > want to disable it. Then i want to enable the driver
> > to register for say /dev/ttyS1.
> >   in short i don't want the console to have controle
> > over the serial port.
>=20
> Try setting the kernel message level to zero after boot.  That
> will prevent the kernel from displaying any further messages to
> that serial port, except when a serious problem (eg, oops) occurs.

Alternatively, IIRC one of the printk-nullifying patches were taken
some time ago. You should be able to eleminate any printk()s through
kernel configuration in the embedded menu.

MfG, JBG

--=20
Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481             =
_ O _
"Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg  =
_ _ O
 f=C3=BCr einen Freien Staat voll Freier B=C3=BCrger"  | im Internet! |   i=
m Irak!   O O O
ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TCPA)=
);

--2B/JsCI69OhZNC5r
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDFYNqHb1edYOZ4bsRApPGAJ4sU3ryNOcJ8e5WZUYtkWKuP7migACgkKnQ
KdkBY3+ZNmG+QPr3vgSsQaM=
=BBJM
-----END PGP SIGNATURE-----

--2B/JsCI69OhZNC5r--
