Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264850AbTFWQIV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 12:08:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264862AbTFWQIU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 12:08:20 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:38411 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S264850AbTFWQHb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 12:07:31 -0400
Date: Mon, 23 Jun 2003 18:21:37 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.73 Mouse
Message-ID: <20030623162137.GL6353@lug-owl.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <3EF7010C.5090000@sixbit.org> <20030623171136.A21216@ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9dhkaBkwM1QzkQhP"
Content-Disposition: inline
In-Reply-To: <20030623171136.A21216@ucw.cz>
User-Agent: Mutt/1.4i
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--9dhkaBkwM1QzkQhP
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, 2003-06-23 17:11:36 +0200, Vojtech Pavlik <vojtech@suse.cz>
wrote in message <20030623171136.A21216@ucw.cz>:
> On Mon, Jun 23, 2003 at 09:30:52AM -0400, John Weber wrote:
>=20
> > My mouse suddenly stopped working with 2.5.73.  I am using a Synaptics=
=20
> > Touchpad --
> > with comes with a Dell laptop.  (I will test with an external mouse lat=
er).
> >=20
> > The SERIO I8042 driver seems to find my mouse, interrupts are firing,=
=20
> > and I enabled
> > the old /dev/psaux so that userland doesn't see anything different.=20
> > Most importantly,
> > the same config worked with 2.5.72.  I noticed that dmesg was slightly=
=20
> > different across
> > the two versions which suggests that something did change.
>=20
> Option 1)
> 	Use psmouse_noext option on the command line. This will
> 	restore the previous behavior easily and immediately.

Will try that.

> Option 2)
> 	Get the Synaptics XFree86 driver for 2.5 kernels from
> 	http://w1.894.telia.com/~u89404340/touchpad/index.html
> 	This will enable additional features with the pad, like
> 	palm detection, multitap gestures and more. It will also
> 	make the pad work, of course.

Not really an option - gpm isn't a X11 thing. I've even tested GPM's
"synps2" protocol driver - doesn't work the tiniest bit:/

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
      ret =3D do_actions((curr | FREE_SPEECH) & ~(IRAQ_WAR_2 | DRM | TCPA));

--9dhkaBkwM1QzkQhP
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE+9ykQHb1edYOZ4bsRAtvQAJ9C56FKRwN2HiFt4eXKO/tww84MbgCfTwD9
Oc1dDUmgoJn85JnOpGKKkU0=
=0dxp
-----END PGP SIGNATURE-----

--9dhkaBkwM1QzkQhP--
