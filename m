Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266926AbSKOW5Q>; Fri, 15 Nov 2002 17:57:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266924AbSKOW5Q>; Fri, 15 Nov 2002 17:57:16 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:51165 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S266915AbSKOW5P>; Fri, 15 Nov 2002 17:57:15 -0500
Subject: writing to sysfs appears to hang
From: Paul Larson <plars@linuxtestproject.org>
To: lkml <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-qh3F/6QYoJlTjtATfsbY"
X-Mailer: Ximian Evolution 1.0.5 
Date: 15 Nov 2002 17:00:16 -0600
Message-Id: <1037401217.11295.145.camel@plars>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-qh3F/6QYoJlTjtATfsbY
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

I've been playing with sysfs and notices something odd.  If I do this:
echo 1 > /sys/devices/sys/name
the process appears to be hung.  ^c won't return control to me.  If I
log in on another console though, I can't find it running in the process
list.  All I can do is kill the login process.  No kernel errors when I
do this, just the hung terminal.

-Paul Larson

--=-qh3F/6QYoJlTjtATfsbY
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEABECAAYFAj3VfIAACgkQbkpggQiFDqdm2wCfadY+aVvGU2+vNthEw2/uSTr/
KeIAniD9cZuWsvOKgyDCRtF5dK/6fsC7
=y2Sy
-----END PGP SIGNATURE-----

--=-qh3F/6QYoJlTjtATfsbY--

