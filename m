Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261343AbUK0V4T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261343AbUK0V4T (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 16:56:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261345AbUK0V4T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Nov 2004 16:56:19 -0500
Received: from ctb-mesg1.saix.net ([196.25.240.73]:12780 "EHLO
	ctb-mesg1.saix.net") by vger.kernel.org with ESMTP id S261343AbUK0V4N
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Nov 2004 16:56:13 -0500
Subject: Re: *** Announcement: dmraid 1.0.0-rc5f *** [u]
From: "Martin Schlemmer [c]" <azarah@nosferatu.za.org>
Reply-To: Martin Schlemmer <azarah@nosferatu.za.org>
To: mauelshagen@redhat.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20041124142633.GA16708@redhat.com>
References: <20041124142633.GA16708@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-zUq0wMHWVBGJEizDpMgC"
Date: Sat, 27 Nov 2004 23:56:21 +0200
Message-Id: <1101592581.11949.50.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-zUq0wMHWVBGJEizDpMgC
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2004-11-24 at 15:26 +0100, Heinz Mauelshagen wrote:
>                *** Announcement: dmraid 1.0.0-rc5f ***
>=20

Hi,

Firstly, it seems my 'make loops forever' issue have been solved
somewhere along the line (sorry, have not checked much after rc3 I
think, so not sure when).

Then, I tried to build it against klibc, but eventually ended up
hacking configure.in, some Makefiles, some more source files, and
generally butchered it to submission, followed by manual linking
to actually get a working binary.  Is this a known issue, or does
it currently only work against some special (RH?) version of klibc?
Also, what about including klibc/libdevmapper trees like udev, etc
to make this a bit more painless?

Lastly, is it planned to enable the user to specify his own dm
volume names ?


Thanks,

--=20
Martin Schlemmer


--=-zUq0wMHWVBGJEizDpMgC
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBqPgFqburzKaJYLYRAl0uAJwPSPWsn82+6tC4+oOjiN2cTYj1HgCeIx6c
P2R3sws1by0jmnVo9AksWm4=
=ULJH
-----END PGP SIGNATURE-----

--=-zUq0wMHWVBGJEizDpMgC--

