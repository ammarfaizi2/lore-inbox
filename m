Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965116AbWJXIiZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965116AbWJXIiZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 04:38:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965114AbWJXIiY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 04:38:24 -0400
Received: from lug-owl.de ([195.71.106.12]:27323 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S965117AbWJXIiX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 04:38:23 -0400
Date: Tue, 24 Oct 2006 10:38:21 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Panagiotis Issaris <panagiotis@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PC speaker listed as input device
Message-ID: <20061024083821.GY26271@lug-owl.de>
Mail-Followup-To: Panagiotis Issaris <panagiotis@gmail.com>,
	linux-kernel@vger.kernel.org
References: <ae7121c60610231132w4e8b13c8y30865682e815b00c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1hAU+gb7eAuiw2fm"
Content-Disposition: inline
In-Reply-To: <ae7121c60610231132w4e8b13c8y30865682e815b00c@mail.gmail.com>
X-Operating-System: Linux mail 2.6.12.3lug-owl 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--1hAU+gb7eAuiw2fm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, 2006-10-23 20:32:55 +0200, Panagiotis Issaris <panagiotis@gmail.com=
> wrote:
> While trying to get my Hauppauge's remote control working, I noticed that=
 my
> PC speaker is getting recognized as an input device. This seems very weird
> to me, is there some logic behind this?
>=20
> takis@aether:~$ cat /proc/bus/input/devices
> I: Bus=3D0010 Vendor=3D001f Product=3D0001 Version=3D0100
> N: Name=3D"PC Speaker"
> P: Phys=3Disa0061/input0
> S: Sysfs=3D/class/input/input0
> H: Handlers=3Dkbd event0
> B: EV=3D40001
> B: SND=3D6
> ...

The Input subsystem also covers simple beeps, because real keyboards
beep.  So it was only straight-forward to also put the PC speaker into
the Input subsystem to be able to emulate real keyboard's beeps as
good as possible :)

MfG, JBG

--=20
      Jan-Benedict Glaw      jbglaw@lug-owl.de              +49-172-7608481
  Signature of:                        Lauf nicht vor Deinem Gl=C3=BCck dav=
on:
  the second  :                             Es k=C3=B6nnte hinter Dir stehe=
n!

--1hAU+gb7eAuiw2fm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFFPdD9Hb1edYOZ4bsRAmUXAJ0c6u+HhYjIj7n3pc63RWrjWa2qtgCfajFG
fQlS1Yx/8hmYGf6mJzZ1Us8=
=LhvD
-----END PGP SIGNATURE-----

--1hAU+gb7eAuiw2fm--
