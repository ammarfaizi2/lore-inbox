Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750760AbWGFToW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750760AbWGFToW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 15:44:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750771AbWGFToV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 15:44:21 -0400
Received: from ns01.unsolicited.net ([69.10.132.115]:33806 "EHLO
	ns01.unsolicited.net") by vger.kernel.org with ESMTP
	id S1750760AbWGFToV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 15:44:21 -0400
Message-ID: <44AD680B.9090603@unsolicited.net>
Date: Thu, 06 Jul 2006 20:44:11 +0100
From: David R <david@unsolicited.net>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.6.18-rc1
References: <Pine.LNX.4.64.0607052115210.12404@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0607052115210.12404@g5.osdl.org>
X-Enigmail-Version: 0.94.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigE6238BF2FCE9D48EBD167441"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE6238BF2FCE9D48EBD167441
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Linus Torvalds wrote:
> Ok,
>  the merge window for 2.6.18 is closed, and -rc1 is out there (git tree=
s=20

Most things seem fine here with rc1, but I do see a permissions issue wit=
h my
USB scanner.

In 2.6.17

david@davidux:/dev/bus/usb/001 # l
total 0
drwxr-xr-x 2 root  root    100 2006-07-06 20:19 ./
drwxr-xr-x 4 root  root     80 2006-07-06 20:19 ../
crw-r--r-- 1 root  root 189, 0 2006-07-06 20:19 001
crw-r--r-- 1 david root 189, 1 2006-07-06 20:19 002
crw-r--r-- 1 root  root 189, 4 2006-07-06 20:19 005

but with 2.6.18

david@davidux:/dev/bus/usb/001> l
total 0
drwxr-xr-x 2 root root    100 2006-07-06 20:24 ./
drwxr-xr-x 4 root root     80 2006-07-06 20:24 ../
crw-r--r-- 1 root root 189, 0 2006-07-06 20:24 001
crw-r--r-- 1 root root 189, 1 2006-07-06 20:24 002
crw-r--r-- 1 root root 189, 4 2006-07-06 20:24 005

Does something need tweaking with udev scripts maybe? This is a SuSE 10.1=
 system.

Cheers
David


--------------enigE6238BF2FCE9D48EBD167441
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFErWgR2qx5JuSvnlQRAvgOAJ9tpcz0ABIJI5eBdSt0Xj8N/W3aHACeJxn7
0zsvaETAHRD7wuEoQhzXYxA=
=GaaJ
-----END PGP SIGNATURE-----

--------------enigE6238BF2FCE9D48EBD167441--
