Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263771AbTDDPav (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 10:30:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263758AbTDDPW2 (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 10:22:28 -0500
Received: from B50de.pppool.de ([213.7.80.222]:42685 "EHLO
	nicole.de.interearth.com") by vger.kernel.org with ESMTP
	id S263761AbTDDPUZ (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 4 Apr 2003 10:20:25 -0500
Subject: Re: Gentoo Linux BUG 18612 - cfdisk
From: Daniel Egger <degger@fhm.edu>
To: Brandon Low <lostlogic@gentoo.org>
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <20030403171148.GI26830@lostlogicx.com>
References: <20030403171148.GI26830@lostlogicx.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-WwB0E8sROFFbo1dD24Bb"
Organization: 
Message-Id: <1049469362.30185.49.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 04 Apr 2003 17:16:02 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-WwB0E8sROFFbo1dD24Bb
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Am Don, 2003-04-03 um 19.11 schrieb Brandon Low:

> This bug appears to be caused by using cfdisk's default allocation on
> the last partition on a drive.  From the looks of it on the user's LBA
> mapped drive, cfdisk allocated a bunch of non-existant sectors when
> the user allowed it to pick the default size for that last partition.

Actually I've seen several CFs fail when used in LBA mode, not just=20
those partitioned with cfdisk. I claim there's either a problem of
the manufacturers taking commands with LBAs or some driver problem
on the linux to address the CFs correctly.

Anyway, I see this as rather minor; drop down to CHS in BIOS and
everything works fine (here at least).

--=20
Servus,
       Daniel

--=-WwB0E8sROFFbo1dD24Bb
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+jaGychlzsq9KoIYRAnGuAKDfOmZWvV/les4z1RPmdxwKDNnLpgCdEouy
vap8ZfW0ztYXZmF0sO1R3G4=
=YBXF
-----END PGP SIGNATURE-----

--=-WwB0E8sROFFbo1dD24Bb--

