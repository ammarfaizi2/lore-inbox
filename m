Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261764AbUDDLRR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Apr 2004 07:17:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262311AbUDDLRR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Apr 2004 07:17:17 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:21730 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S261764AbUDDLRO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Apr 2004 07:17:14 -0400
Date: Sun, 4 Apr 2004 13:17:12 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Ralf Baechle <ralf@linux-mips.org>
Subject: Re: drivers/char/dz.[ch]: reason for keeping?
Message-ID: <20040404111712.GE27362@lug-owl.de>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>,
	Ralf Baechle <ralf@linux-mips.org>
References: <20040404101241.A10158@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DmkXRut7/t/4Uxw3"
Content-Disposition: inline
In-Reply-To: <20040404101241.A10158@flint.arm.linux.org.uk>
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--DmkXRut7/t/4Uxw3
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, 2004-04-04 10:12:41 +0100, Russell King <rmk+lkml@arm.linux.org.uk>
wrote in message <20040404101241.A10158@flint.arm.linux.org.uk>:
> Since we have drivers/serial/dz.[ch] now merged, is there a reason to
> keep drivers/char/dz.[ch] around any more?  I notice people keep doing
> cleanups, but this is wasted effort if the driver is superseded by the
> new drivers/serial/dz.[ch] driver.

The VAX port also (still) uses a modified version of the d/c/dz.[ch]
driver. Also, the MIPS guys may have some outstanding patches...

So, please let's do two things before throwing away the old driver:

	- The MIPS guys need to be happy; they might have some
	  outstanding changes...
	- The VAX guys need to start using the new driver, I'll just
	  start and try to port over our changes.

While at it, I've already implemented some SERIO changes. That'll allow
the dz.c driver to announce that it waits for LK-style keyboard on one
port and VSXXX-style mouse/digitizer on the 2nd port...

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
   ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TC=
PA));

--DmkXRut7/t/4Uxw3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAb+63Hb1edYOZ4bsRAoZeAJwKsMAljraAFQg3bPci/VnhH6dlTQCfWq4l
bYKAhYZvW1VTK1mFrd75W0U=
=adIU
-----END PGP SIGNATURE-----

--DmkXRut7/t/4Uxw3--
