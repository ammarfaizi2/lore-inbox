Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266074AbTFWRNX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 13:13:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266075AbTFWRNX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 13:13:23 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:37902 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S266074AbTFWRNV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 13:13:21 -0400
Date: Mon, 23 Jun 2003 19:27:26 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Problems with PCMCIA/Orinoco
Message-ID: <20030623172726.GP6353@lug-owl.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0306171123540.1854-100000@blackstar.nl> <20030623103815.E23411@flint.arm.linux.org.uk> <20030623133746.GE6353@lug-owl.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4kf3ZaKr/mmDV0ZC"
Content-Disposition: inline
In-Reply-To: <20030623133746.GE6353@lug-owl.de>
User-Agent: Mutt/1.4i
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--4kf3ZaKr/mmDV0ZC
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, 2003-06-23 15:37:46 +0200, Jan-Benedict Glaw <jbglaw@lug-owl.de>
wrote in message <20030623133746.GE6353@lug-owl.de>:
> On Mon, 2003-06-23 10:38:15 +0100, Russell King <rmk@arm.linux.org.uk>
> wrote in message <20030623103815.E23411@flint.arm.linux.org.uk>:
> > On Tue, Jun 17, 2003 at 11:29:00AM +0200, bvermeul@blackstar.nl wrote:
> > > I'm having some problems with 2.5.71 (latest bk yesterday I believe).
> > > All works well (pcmcia works as advertised, with one tiny blip on
> > > the horizon), except when I want to reboot, when I get the following
> > > message:
> > >=20
> > > unregister_netdevice: waiting for eth1 to become free. Usage count =
=3D 1
> >=20
> > Is this still an outstanding problem in 2.5.73?
>=20
> I haven't shut down my laptop since I booted it with 2.5.73, but I can
> do so this evening.

Here's my reading off the screen:

	- /etc/init.d/pcmcia stop
	- The network card's lights go off
	- Above mentioned message starts and repeats every n seconds
	- /etc/init.d/networking stop is being executed, but doesn't
	  seem to stop the message. Though, it takes longer than
	  previously
	- The message appears last time just before APM powers my laptop
	  off...

This is with:

baerchen:~# uname -a
Linux baerchen 2.5.73 #1 Sun Jun 22 23:53:45 CEST 2003 i686 GNU/Linux
baerchen:~# cardctl ident
Socket 0:
  product info: "Xircom", "CreditCard 10/100", "CE3-10/100", "1.00"
  manfid: 0x0105, 0x010a
  function: 6 (network)
Socket 1:
  no product info available


MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
      ret =3D do_actions((curr | FREE_SPEECH) & ~(IRAQ_WAR_2 | DRM | TCPA));

--4kf3ZaKr/mmDV0ZC
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE+9zh9Hb1edYOZ4bsRAiosAJ9ABzRgmiw1aqb0VNBbQMxwSm/AtgCff+Vn
4S5ovqV2+nEbYXeYUwGqk7w=
=lx1y
-----END PGP SIGNATURE-----

--4kf3ZaKr/mmDV0ZC--
