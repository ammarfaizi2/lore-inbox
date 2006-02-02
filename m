Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422678AbWBBBa6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422678AbWBBBa6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 20:30:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422690AbWBBBa5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 20:30:57 -0500
Received: from smtp04.auna.com ([62.81.186.14]:58836 "EHLO smtp04.retemail.es")
	by vger.kernel.org with ESMTP id S1422678AbWBBBa5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 20:30:57 -0500
Date: Thu, 2 Feb 2006 02:35:50 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Neil Brown <neilb@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc1-mm4 i386 atomic operations broken on SMP (in modules
 at least)
Message-ID: <20060202023550.46f06ee1@werewolf.auna.net>
In-Reply-To: <17377.24090.486443.865483@cse.unsw.edu.au>
References: <17377.24090.486443.865483@cse.unsw.edu.au>
X-Mailer: Sylpheed-Claws 2.0.0cvs2 (GTK+ 2.8.11; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; boundary=Sig_iMHob5u_3.Jd395ISkim74q;
 protocol="application/pgp-signature"; micalg=PGP-SHA1
X-Auth-Info: Auth:LOGIN IP:[83.138.209.184] Login:jamagallon@able.es Fecha:Thu, 2 Feb 2006 02:30:53 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_iMHob5u_3.Jd395ISkim74q
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 2 Feb 2006 12:19:22 +1100, Neil Brown <neilb@suse.de> wrote:

>=20
> I've been testing md/raid in 2.6.16-rc1-mm4 on a dual Xeon with most
> of the md personalities compiled as modules, and weird stuff if
> happening.
>=20
> In particular I'm getting lots of=20
>=20
>     BUG: atomic counter underflow at:
>=20
> reports in raid10 and raid5, which are modules.
>=20
>

I also run this kernel (plus a couple patches) on a SATA raid5 setup, and
had no problems. People throws and gets files via SMB/AFP, mainly.

My box is dual PIII@933.

--
J.A. Magallon <jamagallon()able!es>     \               Software is like se=
x:
werewolf!able!es                         \         It's better when it's fr=
ee
Mandriva Linux release 2006.1 (Cooker) for i586
Linux 2.6.15-jam7 (gcc 4.0.2 (4.0.2-1mdk for Mandriva Linux release 2006.1))

--Sig_iMHob5u_3.Jd395ISkim74q
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFD4WH2RlIHNEGnKMMRAniqAKCLOEP1Oq8IAfGqT5wGEkfOuv9NEwCfdHV+
bP49C9UxeYKLA+2YP7Gb33Q=
=YWKf
-----END PGP SIGNATURE-----

--Sig_iMHob5u_3.Jd395ISkim74q--
