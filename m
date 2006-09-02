Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751623AbWIBVla@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751623AbWIBVla (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Sep 2006 17:41:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751621AbWIBVla
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Sep 2006 17:41:30 -0400
Received: from hentges.net ([81.169.178.128]:61677 "EHLO
	h6563.serverkompetenz.net") by vger.kernel.org with ESMTP
	id S1751620AbWIBVl3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Sep 2006 17:41:29 -0400
Subject: Re: sky2 hangs on me again: This time 200 kb/s IPv4 traffic, not
	easily reproducable
From: Matthias Hentges <oe@hentges.net>
To: shogunx <shogunx@sleekfreak.ath.cx>
Cc: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
       Stephen Hemminger <shemminger@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0609021540440.25420-100000@sleekfreak.ath.cx>
References: <Pine.LNX.4.44.0609021540440.25420-100000@sleekfreak.ath.cx>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-kNfxxjDyL1nDEidKA0ku"
Date: Sat, 02 Sep 2006 23:42:23 +0200
Message-Id: <1157233344.18988.7.camel@mhcln03>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-kNfxxjDyL1nDEidKA0ku
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Am Samstag, den 02.09.2006, 15:41 -0400 schrieb shogunx:
> On Sat, 2 Sep 2006, Matthias Hentges wrote:
>=20
> > Am Freitag, den 01.09.2006, 22:41 -0400 schrieb shogunx:
> > > > >
> > > > > Has this not been fixed in the 2.6.18 git?
> > > >
> > > > Good question. I'll try 2.6.18-rc4-mm3 and report back.
> > >
> > > I am having no problems with 2.6.18-rc5, which I just built and teste=
d.
> >
> > The NIC is up and running for about 9hrs now w/ -rc4-mm3, thanks for th=
e
> > heads up!
>=20
> Hey, no worries.  I have a friend who has has that problem for some time,
> and I just got one of those cards myself, albeint in an ExpressCard
> format.
>=20
> Glad its working.

Well, it just crapped out on me again :(

Sep  2 23:36:13 localhost kernel: NETDEV WATCHDOG: eth2: transmit timed
out
Sep  2 23:36:13 localhost kernel: sky2 hardware hung? flushing

Only a rmmod / modprobe cycle helps at this point.
--=20
Matthias 'CoreDump' Hentges=20

Webmaster of hentges.net and OpenZaurus developer.
You can reach me in #openzaurus on Freenode.

My OS: Debian SID. Geek by Nature, Linux by Choice

--=-kNfxxjDyL1nDEidKA0ku
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBE+fq/Aq2P5eLUP5IRAuyLAKD8yzp7ECWEPwrUmvER0BO6NAwZtwCg8RYe
afACkEWsUmivdX/9+p9Nf1A=
=Fe+o
-----END PGP SIGNATURE-----

--=-kNfxxjDyL1nDEidKA0ku--


-- 
VGER BF report: H 0.0457149
