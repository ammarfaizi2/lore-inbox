Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267602AbUIXBVM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267602AbUIXBVM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 21:21:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267598AbUIXBSF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 21:18:05 -0400
Received: from ctb-mesg2.saix.net ([196.25.240.74]:21996 "EHLO
	ctb-mesg2.saix.net") by vger.kernel.org with ESMTP id S267686AbUIXAyn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 20:54:43 -0400
Subject: Re: 2.6.9-rc2-mm2 [u]
From: "Martin Schlemmer [c]" <azarah@nosferatu.za.org>
Reply-To: azarah@nosferatu.za.org
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040922131210.6c08b94c.akpm@osdl.org>
References: <20040922131210.6c08b94c.akpm@osdl.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-rPYpLcGNrp4IG8baO312"
Date: Fri, 24 Sep 2004 02:53:58 +0200
Message-Id: <1095987238.11535.4.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.0 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-rPYpLcGNrp4IG8baO312
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2004-09-22 at 13:12 -0700, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc2/2=
.6.9-rc2-mm2/
>=20
> - Added Bart's bk-ide-dev tree to the -mm external tree lineup.
>=20
> - Added Peter Williams' Single Priority Array (SPA) O(1) CPU Scheduler, a=
ka
>   the "zaphod" cpu scheduler.
>=20
>   It has a number of tunables and lots of documentation - see the changel=
og
>   entry in zaphod-scheduler.patch for details.
>=20
> - This kernel doesn't work on ia64 (instant reboot).  But neither does
>   2.6.9-rc2, nor current Linus -bk.  Is it just me?
>=20
> - Added the kexec-based crashdump code.  This is the code which uses kexe=
c
>   to jump into a new mini-kernel when the main kernel crashes.  Userspace=
 code
>   in that mini-kernel then dumps the main kernel's memory to disk.  These=
 new
>   patches provide the bits and pieces which the mini-kernel needs to be a=
ble
>   to get at the main kernel's memory.
>=20
>   There seem to be no hints as to how to get all this working - that will
>   come.
>=20
> - Found (and fixed) the bug which was causing those
>   ext3-goes-readonly-under-load problems.  It was in the new wait/wakeup =
code.
>=20

I have a p4 ht box at home (smp kernel with smt enabled), and with this
I seem to get zombie processes (nautilus a few times now).

--=20
Martin Schlemmer

--=-rPYpLcGNrp4IG8baO312
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBU3AmqburzKaJYLYRAgFpAJ0YtHb4z8C45/ddH6TF++vY9YXzlQCghkR3
7545KjON0pW4vVm5WlctsPs=
=/5+W
-----END PGP SIGNATURE-----

--=-rPYpLcGNrp4IG8baO312--

