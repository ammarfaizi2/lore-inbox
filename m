Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269649AbUICMJM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269649AbUICMJM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 08:09:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269666AbUICMJG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 08:09:06 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:39852 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S269649AbUICMGf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 08:06:35 -0400
Date: Fri, 3 Sep 2004 14:06:34 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Kalin KOZHUHAROV <kalin@thinrope.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.8.1 0/2] leds: new class for led devices
Message-ID: <20040903120634.GK6985@lug-owl.de>
Mail-Followup-To: Kalin KOZHUHAROV <kalin@thinrope.net>,
	linux-kernel@vger.kernel.org
References: <1094157190l.4235l.2l@hydra> <ch8tdd$1uf$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ENS8W0Tt0j5TmTCM"
Content-Disposition: inline
In-Reply-To: <ch8tdd$1uf$1@sea.gmane.org>
X-Operating-System: Linux mail 2.6.8-rc4 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ENS8W0Tt0j5TmTCM
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 2004-09-03 13:54:04 +0900, Kalin KOZHUHAROV <kalin@thinrope.net>
wrote in message <ch8tdd$1uf$1@sea.gmane.org>:
> John Lenz wrote:
> >This is an attempt to provide an alternative to the current arm =20
> >specific led interface.  This arm interface does not integrate well =20
> >with the device model and sysfs.
> I am just curious, but what specific hardware devices can be controlled=
=20
> with this?

For example, the smaller VAX computers offer 8 LEDs which show system
status during IPL. After boot finished, the OS may use them...

> >function : a read/write attribute that sets the current function of =20
> > timer : the led blinks on and off on a timer
> > idle : the led turns off when the system is idle and on when not idle
> > power : the led represents the current power state
> > user : the led is controlled by user space

Is idle/timer/power hardware-controlled (eg. by a secondary processor,
direct chipset implementation) or is switching on/off controlled by
kernel (eg. heartbeat, IO and ethernet for the LEDs you can find on some
PA-RISC machines)?

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

--ENS8W0Tt0j5TmTCM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBOF5KHb1edYOZ4bsRAguWAJ98bTRu4pYCnS/MJxNORVNhntFqhQCfXZIb
y0hbH18uaRvvCYLc7SwxOcA=
=4l0O
-----END PGP SIGNATURE-----

--ENS8W0Tt0j5TmTCM--
