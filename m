Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263162AbTJONWy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 09:22:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263166AbTJONWy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 09:22:54 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:35285 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S263162AbTJONWv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 09:22:51 -0400
Date: Wed, 15 Oct 2003 15:22:50 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Unbloating the kernel, was: :mem=16MB laptop testing
Message-ID: <20031015132250.GH20846@lug-owl.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20031014143047.GA6332@ncsu.edu> <Pine.LNX.4.44.0310141813320.1776-100000@gaia.cela.pl> <20031015114514.GC20846@lug-owl.de> <20031015130645.GJ765@holomorphy.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HNNtJsP7AmKg7nRJ"
Content-Disposition: inline
In-Reply-To: <20031015130645.GJ765@holomorphy.com>
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--HNNtJsP7AmKg7nRJ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 2003-10-15 06:06:45 -0700, William Lee Irwin III <wli@holomorphy.co=
m>
wrote in message <20031015130645.GJ765@holomorphy.com>:
> On Tue, 2003-10-14 18:27:05 +0200, Maciej Zenczykowski <maze@cela.pl>
> > wrote in message <Pine.LNX.4.44.0310141813320.1776-100000@gaia.cela.pl>:
> On Wed, Oct 15, 2003 at 01:45:14PM +0200, Jan-Benedict Glaw wrote:
> > Right. For a real lowmem system (4MB RAM) I defined printk to a no-op
> > and gained 90K at the compressed image IIRC. This was 2.2.x, though.
> > MfG, JBG
>=20
> The compressed image is hard to predict a runtime effect from; what did
> it do to reserved memory at boot-time?

I'm not sure since this it's quite long ago (TM), but the effect was of
about 210K IIRC. The apps we had running on that box (think embedded)
*really* liked that 200K extra RAM. It made the difference between "swap
to death" and "nearly not swapping"...

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
   ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TC=
PA));

--HNNtJsP7AmKg7nRJ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/jUoqHb1edYOZ4bsRAuZ7AJ9LXj1c8T+bkt28Me3rZ0HsVJqV6wCfXATi
P8CZQ9k0F98jV+QqM1ryFjQ=
=IBvM
-----END PGP SIGNATURE-----

--HNNtJsP7AmKg7nRJ--
