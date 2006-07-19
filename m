Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964850AbWGSO3t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964850AbWGSO3t (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jul 2006 10:29:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964851AbWGSO3t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jul 2006 10:29:49 -0400
Received: from ctb-mesg5.saix.net ([196.25.240.75]:38637 "EHLO
	ctb-mesg5.saix.net") by vger.kernel.org with ESMTP id S964850AbWGSO3t
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jul 2006 10:29:49 -0400
Subject: Re: Linux v2.6.18-rc2 - syslog(0x8,,) seems broken
From: Martin Schlemmer <azarah@nosferatu.za.org>
Reply-To: azarah@nosferatu.za.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0607151523180.5623@g5.osdl.org>
References: <Pine.LNX.4.64.0607151523180.5623@g5.osdl.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Jv2VFDra03Bzfr6PD7Eu"
Date: Wed, 19 Jul 2006 16:32:02 +0200
Message-Id: <1153319522.9722.6.camel@lycan.lan>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Jv2VFDra03Bzfr6PD7Eu
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2006-07-15 at 15:27 -0700, Linus Torvalds wrote:
> Ok, there it is, in all the usual places.
>=20

Currently using the latest git version, and it seems like 'dmesg -n
1' (ie 'syslog(0x8, 0, 0x1)') is broken.  IE, kernel messages after
initscripts and 'dmesg -n1' is called goes to console (mostly when newer
udev does its coldplug thing).

If nobody have a hunch what it can be, I'll try to track it later on if
I get time.  It still worked shortly with -git checkouts shortly before
2.6.18-rc1 was release.  Unfortunately I did not have time to test newer
kernels until now.


Regards,

--=20
Martin Schlemmer


--=-Jv2VFDra03Bzfr6PD7Eu
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)

iD8DBQBEvkJiqburzKaJYLYRAoChAKCC0ouptpL4AdMBf1INc9NsEad5MQCdG3of
DBPukwidLECCKzomp2MdOxE=
=vDog
-----END PGP SIGNATURE-----

--=-Jv2VFDra03Bzfr6PD7Eu--

