Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264044AbTKSMzr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Nov 2003 07:55:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264045AbTKSMzr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Nov 2003 07:55:47 -0500
Received: from 24-216-225-143.charter.com ([24.216.225.143]:37520 "EHLO
	wally.rdlg.net") by vger.kernel.org with ESMTP id S264044AbTKSMzm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Nov 2003 07:55:42 -0500
Date: Wed, 19 Nov 2003 07:55:34 -0500
From: "Robert L. Harris" <Robert.L.Harris@rdlg.net>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Missing /dev/pts?
Message-ID: <20031119125533.GN3351@rdlg.net>
Mail-Followup-To: Linux-Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="07FIeBX8hApXX6Bi"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--07FIeBX8hApXX6Bi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline



  Had to rebuild a machine due to a dead deathstar.  It's 99% there at
this point I think except I can't log in via xterm, eterm or ssh.
Poking around, the most obvious factor is that /dev/pts is empty.

I can see that /dev and /dev/pts mounted by using "df -k /dev /dev/pts"
which returns:

Filesystem	1K-blocks	Used	Available	Use%	Mounted on
-		0		0	0		-	/dev
devpts		0		0	0		-	/dev/pts

whish is identicle to the machine I'm currently logged into and is
working fine.  /dev and /dev/pts are both compiled into the kernel and
are reported by "cat /proc/filesystms".  Devfsd is up and running with a
command line of "/sbin/devfsd /dev".

Anyone have any idea why this is malfunctioning?

Robert

:wq!
---------------------------------------------------------------------------
Robert L. Harris                     | GPG Key ID: E344DA3B
                                         @ x-hkp://pgp.mit.edu
DISCLAIMER:
      These are MY OPINIONS ALONE.  I speak for no-one else.

Life is not a destination, it's a journey.
  Microsoft produces 15 car pileups on the highway.
    Don't stop traffic to stand and gawk at the tragedy.

--07FIeBX8hApXX6Bi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/u2hF8+1vMONE2jsRAn9aAJ45UYbX1ivEF9h+tR4cXs3JNTTUPQCdGiO4
bj7GjlrChhozIM5SPvMOp3o=
=VLI9
-----END PGP SIGNATURE-----

--07FIeBX8hApXX6Bi--
