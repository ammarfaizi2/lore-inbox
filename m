Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265501AbUFOOlb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265501AbUFOOlb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 10:41:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265541AbUFOOlb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 10:41:31 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:6876 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S265501AbUFOOl2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 10:41:28 -0400
Date: Tue, 15 Jun 2004 16:41:27 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Helge Hafting vs. make menuconfig help
Message-ID: <20040615144127.GG20632@lug-owl.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20040615140206.A6153@beton.cybernet.src> <20040615141039.GF20632@lug-owl.de> <20040615142040.B6241@beton.cybernet.src>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Chc1+IABo9omxMFx"
Content-Disposition: inline
In-Reply-To: <20040615142040.B6241@beton.cybernet.src>
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Chc1+IABo9omxMFx
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 2004-06-15 14:20:40 +0000, Karel Kulhav=FD <clock@twibright.com>
wrote in message <20040615142040.B6241@beton.cybernet.src>:
> On Tue, Jun 15, 2004 at 04:10:39PM +0200, Jan-Benedict Glaw wrote:
> > On Tue, 2004-06-15 14:02:06 +0000, Karel Kulhav=FD <clock@twibright.com>
> > wrote in message <20040615140206.A6153@beton.cybernet.src>:

> > CONFIG_INPUT only gives you an API where you can process input events
> > with. For instance, look at the atkbd.c, sunkbd.c or lkkbd.c drivers.
> > They all send key strokes into the Input API (activated by
> > CONFIG_INPUT), but none of them actually uses USB (but the PS/2 keyboard
> > port or normal serial ports with non-standard plugs).
>=20
> Is it correct what <Help> for CONFIG_INPUT in 2.4.25 says or no?

At least, it's not really wrong. You need CONFIG_INPUT to be able to do
something with the HID stuff. However, to have an uniform interface, you
may also use the CONFIG_INPUT stuff to access your "normal" (AT / PS/2
style) keyboard.

In 2.6.x, that's cleaned up a bit. (Nearly?) all keyboards now push
their key strokes into the CONFIG_INPUT API, so you really want to have
CONFIG_INPUT (as long as this isn't some kind of embedded system).

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
   ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TC=
PA));

--Chc1+IABo9omxMFx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAzwqXHb1edYOZ4bsRAhPVAKCKjgkVmz16YIDgcOkUXMvp0B6EOwCghWP7
IEbl2iNg0zvpZQT2rmEnJT4=
=eDGg
-----END PGP SIGNATURE-----

--Chc1+IABo9omxMFx--
