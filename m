Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266080AbTFWRUr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 13:20:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266079AbTFWRUr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 13:20:47 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:41742 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S266080AbTFWRUp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 13:20:45 -0400
Date: Mon, 23 Jun 2003 19:34:51 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.73 Mouse
Message-ID: <20030623173451.GQ6353@lug-owl.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <3EF7010C.5090000@sixbit.org> <20030623171136.A21216@ucw.cz> <20030623162137.GL6353@lug-owl.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yTDPf8dFFzrn4Hdx"
Content-Disposition: inline
In-Reply-To: <20030623162137.GL6353@lug-owl.de>
User-Agent: Mutt/1.4i
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--yTDPf8dFFzrn4Hdx
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, 2003-06-23 18:21:37 +0200, Jan-Benedict Glaw <jbglaw@lug-owl.de>
wrote in message <20030623162137.GL6353@lug-owl.de>:
> On Mon, 2003-06-23 17:11:36 +0200, Vojtech Pavlik <vojtech@suse.cz>
> wrote in message <20030623171136.A21216@ucw.cz>:
> > On Mon, Jun 23, 2003 at 09:30:52AM -0400, John Weber wrote:
> >=20
> > > My mouse suddenly stopped working with 2.5.73.  I am using a Synaptic=
s=20
> > > Touchpad --
> > > with comes with a Dell laptop.  (I will test with an external mouse l=
ater).
> > >=20
> > > The SERIO I8042 driver seems to find my mouse, interrupts are firing,=
=20
> > > and I enabled
> > > the old /dev/psaux so that userland doesn't see anything different.=
=20
> > > Most importantly,
> > > the same config worked with 2.5.72.  I noticed that dmesg was slightl=
y=20
> > > different across
> > > the two versions which suggests that something did change.
> >=20
> > Option 1)
> > 	Use psmouse_noext option on the command line. This will
> > 	restore the previous behavior easily and immediately.
>=20
> Will try that.

Well, it doesn't restore the old behavior. With Linux-2.5.n (n <=3D 72)
I could do a fast double-press onto the pad to have a left-click. This
doesn't work after supplying "psmouse_noext=3D1" to the module. Further
more, Windowmaker's menus don't any longer automatically pop up - I have
to press a mouse button to make that happen.

GPM (with "autops2" driver) works as before, though.

XFree uses "PS/2" as it's driver, directly using (legacy) /dev/psaux
device...

I was quite okay with the old behavior (though I haven't tested XFree
with the specialized Synaptics driver).

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
      ret =3D do_actions((curr | FREE_SPEECH) & ~(IRAQ_WAR_2 | DRM | TCPA));

--yTDPf8dFFzrn4Hdx
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE+9zo6Hb1edYOZ4bsRAhtGAJwMOA3MUOPtUI+kdUb/fg4kds5ZbwCcDSzo
3HQ24txyHt3Ir+e+RKa2IhY=
=Qbnr
-----END PGP SIGNATURE-----

--yTDPf8dFFzrn4Hdx--
