Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261342AbUK0Vib@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261342AbUK0Vib (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 16:38:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261343AbUK0Via
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Nov 2004 16:38:30 -0500
Received: from ctb-mesg2.saix.net ([196.25.240.74]:25084 "EHLO
	ctb-mesg2.saix.net") by vger.kernel.org with ESMTP id S261342AbUK0ViL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Nov 2004 16:38:11 -0500
Subject: Re: ub: oops with preempt ("Sahara Workshop") [u]
From: "Martin Schlemmer [c]" <azarah@nosferatu.za.org>
Reply-To: Martin Schlemmer <azarah@nosferatu.za.org>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: greg@kroah.com, linux-kernel@vger.kernel.org
In-Reply-To: <20041123100247.2ea47e2d@lembas.zaitcev.lan>
References: <20041123100247.2ea47e2d@lembas.zaitcev.lan>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-8QFnljjOnsrpvpgeU1S+"
Date: Sat, 27 Nov 2004 23:38:15 +0200
Message-Id: <1101591495.11949.42.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-8QFnljjOnsrpvpgeU1S+
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2004-11-23 at 10:02 -0800, Pete Zaitcev wrote:

Hi,

> I admit that the code should be locked properly instead, but the global p=
lan
> is to drop all P3 tagged printks anyway. So let it be guarded for the mom=
ent.
>=20

Sorry for the delay, but I have not had any time to really test this
again.  I did some minor testing, and only after really working it,
I could get an oops, but not nearly the same (think it was deeper into
the scsi layer or maybe kobject stuff).

Will see when I can get some time to try and generate some consistent
traces if any.


Thanks,

--=20
Martin Schlemmer


--=-8QFnljjOnsrpvpgeU1S+
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBqPPHqburzKaJYLYRAukpAJ9eW2OYhW5Wk0YL/58BequpfUmQZACeJnxL
s0/G1DWDonnfsMTVJ9VqLSw=
=2Q5c
-----END PGP SIGNATURE-----

--=-8QFnljjOnsrpvpgeU1S+--

