Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261755AbTIYIJK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 04:09:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261763AbTIYIJK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 04:09:10 -0400
Received: from smtp6.clb.oleane.net ([213.56.31.26]:65466 "EHLO
	smtp6.clb.oleane.net") by vger.kernel.org with ESMTP
	id S261755AbTIYIJG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 04:09:06 -0400
Subject: Re: PS2 keyboard & mice mandatory again ?
From: Nicolas Mailhot <Nicolas.Mailhot@laposte.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030925074656.GA22543@ucw.cz>
References: <1064428364.1673.11.camel@rousalka.dyndns.org>
	 <20030925074656.GA22543@ucw.cz>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-BfgbcbnoQ0Oxhyb2pTAb"
Organization: Adresse personelle
Message-Id: <1064477341.13077.7.camel@ulysse.olympe.o2t>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-7) 
Date: Thu, 25 Sep 2003 10:09:01 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-BfgbcbnoQ0Oxhyb2pTAb
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

Le jeu 25/09/2003 =E0 09:46, Vojtech Pavlik a =E9crit :
> On Wed, Sep 24, 2003 at 08:32:54PM +0200, Nicolas Mailhot wrote:
> > Hi,
> >=20
> > 	I've just had the unpleasant surprise to find out that in the latest
> > 2.6 snapshots
> >=20
> > CONFIG_SERIO=3Dy
> > CONFIG_SERIO_I8042=3Dy
> >=20
> > is forced on everyone. I know the modularization of 8042 has generated =
a
> > lot of bug reports, but couldn't people just fix the damn option name
> > and description instead of making it mandatory ?
> >=20
> > There are already a lot of people  (me included) with a 100% usb input
> > setup. More are on the way (really a nice hub on the desk instead of
> > crawling under it to reach PS/2 ports is a no-brainer once you've teste=
d
> > it). Please revert this change.=20
>=20
> If you enable CONFIG_EMBEDDED, you can switch it off.

Great, now a standard mass-market computer is an embedded device. I can
(and will) certainly do it, but this looks like a ticking bomb to me.
More than half the original problems where the option was labelled
CONFIG_SERIO_I8042 instead of something user-understandable like PS/2
input, and it's just been replaced by another mess that will make no
sense to the average user. There's even no notice in the input menu to
where this was moved :(

Anyway, thanks for the tip. I hope for you I'm the first and last to ask
you about this.

Regards,

--=20
Nicolas Mailhot

--=-BfgbcbnoQ0Oxhyb2pTAb
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Ceci est une partie de message
	=?ISO-8859-1?Q?num=E9riquement?= =?ISO-8859-1?Q?_sign=E9e?=

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/cqKdI2bVKDsp8g0RAqjmAJ95svSyc2C2Ea1ffjxniMI2ZvUJ7ACg3nBg
qemeUhxS+TLMHtI6Uk3uLFI=
=paXW
-----END PGP SIGNATURE-----

--=-BfgbcbnoQ0Oxhyb2pTAb--

