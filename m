Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265275AbUFSIbI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265275AbUFSIbI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 04:31:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262190AbUFSIbI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 04:31:08 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:63460 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S265275AbUFSIbD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 04:31:03 -0400
Date: Sat, 19 Jun 2004 10:31:02 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Stop printk printing non-printable chars
Message-ID: <20040619083102.GW20632@lug-owl.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20040618205355.GA5286@newtoncomputing.co.uk> <20040618213252.GS20632@lug-owl.de> <20040619000330.GC5286@newtoncomputing.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dMkI/qROo9ELDG6P"
Content-Disposition: inline
In-Reply-To: <20040619000330.GC5286@newtoncomputing.co.uk>
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--dMkI/qROo9ELDG6P
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, 2004-06-19 01:03:30 +0100, matthew-lkml@newtoncomputing.co.uk <matt=
hew-lkml@newtoncomputing.co.uk>
wrote in message <20040619000330.GC5286@newtoncomputing.co.uk>:
> On Fri, Jun 18, 2004 at 11:32:52PM +0200, Jan-Benedict Glaw wrote:
> > On Fri, 2004-06-18 21:53:55 +0100, matthew-lkml@newtoncomputing.co.uk <=
matthew-lkml@newtoncomputing.co.uk>
> > wrote in message <20040618205355.GA5286@newtoncomputing.co.uk>:

> > It's dandy if you pump out some data via serial link.
>=20
> Is printk ever used to send anything out via a serial link? I assumed it
> was only kernel log messages (that should really be fairly sane). Log
> messages sent to serial printer, etc, don't want dodgy chars in them
> that may mess up the printer, do they?

printk() is a printf() like interface to the log buffer. From there, all
console drivers are fed, and in development (not for office or private
use), you often attach a seruak cibsike to capture Oops messages and the
like.

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
   ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TC=
PA));

--dMkI/qROo9ELDG6P
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA0/nGHb1edYOZ4bsRApDiAJ95a9HJnQPNguT0S7Frmbj3t1cDvwCeIRSQ
gfNuuDTwooJxfEmynJzJ9sg=
=QaPp
-----END PGP SIGNATURE-----

--dMkI/qROo9ELDG6P--
