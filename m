Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261322AbUKCBvD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261322AbUKCBvD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 20:51:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261320AbUKCBvD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 20:51:03 -0500
Received: from ctb-mesg6.saix.net ([196.25.240.78]:3243 "EHLO
	ctb-mesg6.saix.net") by vger.kernel.org with ESMTP id S261322AbUKCBuh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 20:50:37 -0500
Subject: Re: XMMS (or some other audio player) 'hang' issues with intel8x0
	and dmix plugin [u]
From: "Martin Schlemmer [c]" <azarah@nosferatu.za.org>
Reply-To: Martin Schlemmer <azarah@nosferatu.za.org>
To: Christophe Saout <christophe@saout.de>
Cc: Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>,
       Takashi Iwai <tiwai@suse.de>, alsa-user@lists.sourceforge.net
In-Reply-To: <1099385872.21422.10.camel@leto.cs.pocnet.net>
References: <1099284142.11924.17.camel@nosferatu.lan>
	 <1099385872.21422.10.camel@leto.cs.pocnet.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-egssin46ZTbS+Ol1oN/K"
Date: Wed, 03 Nov 2004 03:50:31 +0200
Message-Id: <1099446631.11924.29.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-egssin46ZTbS+Ol1oN/K
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2004-11-02 at 09:57 +0100, Christophe Saout wrote:
> Am Montag, den 01.11.2004, 06:42 +0200 schrieb Martin Schlemmer [c]:
>=20
> > I have mailed below to alsa-user a time or two already, but no
> > response as of yet, so I am wondering if anybody here have had
> > similar issues.  Not much has changed, but I have also tried
> > BMP, and alsa-player, with similar results.
>=20
> I've tracked this down to what seems to be a bug in the libalsa dmix
> code with mmap emulation. If the sound output was stopped for some
> reason (stream paused or underrun) the library will accept more data
> until the buffer is full but never restart the output.
>=20
> https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3D209
>=20

I will be honest that I cannot remember the outcome when I tried without
mmap support - was some time back.  I will try now again.

I also had a look at the bug, and it seems like it could be if it must
do conversion - any way to disable it, or some other workaround ?  Or
anybody to bug/help to patch this ? =3D)


Thanks,

--=20
Martin Schlemmer


--=-egssin46ZTbS+Ol1oN/K
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBiDlnqburzKaJYLYRAm/bAJ4gHvtHNseQW659uhjwiCZ7V+A3HACfXP8J
gypBO4OLN8P75ap8m3d0bvQ=
=DTRZ
-----END PGP SIGNATURE-----

--=-egssin46ZTbS+Ol1oN/K--

