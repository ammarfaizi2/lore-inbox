Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261957AbVDCXlL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261957AbVDCXlL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Apr 2005 19:41:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261958AbVDCXlK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Apr 2005 19:41:10 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:9956 "EHLO
	pd3mo2so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S261957AbVDCXlD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Apr 2005 19:41:03 -0400
Date: Sun, 03 Apr 2005 17:41:00 -0600
From: Jeremy Nickurak <atrus@lkml.spam.rifetech.com>
Subject: Re: Logitech MX1000 Horizontal Scrolling
In-reply-to: <87u0mn3l4e.fsf@blackdown.de>
To: linux-kernel@vger.kernel.org
Message-id: <1112571660.23238.5.camel@localhost>
MIME-version: 1.0
X-Mailer: Evolution 2.2.1.1
Content-type: multipart/signed; boundary="=-EJw03s4X4UkJ6mm3VmMD";
 protocol="application/pgp-signature"; micalg=pgp-sha1
References: <873bxfoq7g.fsf@quasar.esben-stien.name>
 <87zmylaenr.fsf@quasar.esben-stien.name> <20050204195410.GA5279@ucw.cz>
 <873bvyfsvs.fsf@quasar.esben-stien.name>
 <87zmxil0g8.fsf@quasar.esben-stien.name> <1110056942.16541.4.camel@localhost>
 <87sm37vfre.fsf@quasar.esben-stien.name>
 <87wtsjtii6.fsf@quasar.esben-stien.name> <20050308205210.GA3986@ucw.cz>
 <1112083646.12986.3.camel@localhost> <87psxcsq06.fsf@quasar.esben-stien.name>
 <87u0mn3l4e.fsf@blackdown.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-EJw03s4X4UkJ6mm3VmMD
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On dim, 2005-04-03 at 18:01 +0200, Juergen Kreileder wrote:
> Esben Stien <b0ef@esben-stien.name> writes:
>=20
> > Jeremy Nickurak <atrus@rifetech.com> writes:
> >
> >> I'm playing with this under 2.6.11.4=20
> >
> > I got 2.6.12-rc1=20
> >
> >> The vertical cruise control buttons work properly, with the
> >> exception of the extra button press.
> >
> > Yup, nice, I see the same
>=20
> Same here.
>=20
> >> But the horizontal buttons are mapping to 6/7 as non-repeat
> >> buttons, and adding simulateously the 4/5 events auto-repeated for
> >> as long as the button is down. That is to say, pressing the the
> >> horizontal scroll in a 2d scrolling area will scroll *diagonally*
> >> one step, then vertically until the button is released.
> >
> > Yup, seeing exactly the same here.=20
>=20
> Horizontal scrolling works fine for me.  I just get repeated 6/7
> events, nothing else.
>=20
> I'm using the configuration described at:
> http://blog.blackdown.de/2005/04/03/logitech-mx1000-configuration/

Well that's a big step up. My horizontal scrolling is now working
perfectly. I had never in my life seen a ZAxisMapping line with 4
buttons, but it seems to do the trick, and it's even worked its way into
the mouse man page since the last time I remember seeing it. (Running
current Xorg here, can't speak for XFree86 users)

Now it's just the vertical scroller issue.

-
Jeremy Nickurak

--=-EJw03s4X4UkJ6mm3VmMD
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBCUH8MtjFmtbiy5uYRAhT5AKCGAv59NxuPMHAOlR60F2s4LALBhQCcCTVx
TiqbUOXEXOP5edJDdHJxC8I=
=HZg/
-----END PGP SIGNATURE-----

--=-EJw03s4X4UkJ6mm3VmMD--
