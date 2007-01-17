Return-Path: <linux-kernel-owner+w=401wt.eu-S932522AbXAQQgS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932522AbXAQQgS (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 11:36:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932539AbXAQQgS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 11:36:18 -0500
Received: from posthamster.phnxsoft.com ([195.227.45.4]:1899 "EHLO
	posthamster.phnxsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932522AbXAQQgR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 11:36:17 -0500
Message-ID: <45AE507E.3040601@imap.cc>
Date: Wed, 17 Jan 2007 17:36:14 +0100
From: Tilman Schmidt <tilman@imap.cc>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de-AT; rv:1.8.0.9) Gecko/20061211 SeaMonkey/1.0.7 Mnenhy/0.7.4.666
MIME-Version: 1.0
To: Linux Kernel mailing List <linux-kernel@vger.kernel.org>
Subject: where to maintain userspace daemon for line discipline
X-Enigmail-Version: 0.94.1.2
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigD25758D451BBD1C2C0FF8658"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD25758D451BBD1C2C0FF8658
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

The recent discussion on LKML convinced me that a line discipline
is the correct way to layer a driver over a serial interface.
This means, however, that I'll need a (trivial) userspace daemon
which will hold the serial interface open after pushing the line
discipline onto it.

Which raises the question: Where can I drop the source for that
daemon so that it is
a) maintained together with the line discipline in case a kernel
developer feels the need to change something and
b) picked up by distributions so that they don't end up shipping
the line discipline without the necessary daemon?

Is there an appropriate place in or near the kernel tree for
stuff like that?

Thanks
Tilman

--=20
Tilman Schmidt                    E-Mail: tilman@imap.cc
Bonn, Germany
Diese Nachricht besteht zu 100% aus wiederverwerteten Bits.
Unge=F6ffnet mindestens haltbar bis: (siehe R=FCckseite)


--------------enigD25758D451BBD1C2C0FF8658
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFrlB+MdB4Whm86/kRAqPrAJwPv7HjHMthsBs1DZNMG3BlBeeahACdH/hW
ryEO7Hc00U298n7TclLNNxs=
=tap8
-----END PGP SIGNATURE-----

--------------enigD25758D451BBD1C2C0FF8658--
