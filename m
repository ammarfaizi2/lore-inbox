Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262316AbUKDRkM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262316AbUKDRkM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 12:40:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262319AbUKDRkM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 12:40:12 -0500
Received: from moutng.kundenserver.de ([212.227.126.190]:15606 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S262312AbUKDRji (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 12:39:38 -0500
Date: Thu, 4 Nov 2004 18:39:29 +0100
From: Sven Schuster <schuster.sven@gmx.de>
To: foo@porto.bmb.uga.edu
Cc: linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Bad UDP checksums with 2.6.9
Message-ID: <20041104173929.GA24782@zion.homelinux.com>
References: <20041104054838.GC12763@porto.bmb.uga.edu> <20041104062834.GE12763@porto.bmb.uga.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XsQoSWH+UP9D9v3l"
Content-Disposition: inline
In-Reply-To: <20041104062834.GE12763@porto.bmb.uga.edu>
User-Agent: Mutt/1.5.6i
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:38b5f051b8cd178556c5593940405c4a
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hi,

On Thu, Nov 04, 2004 at 01:28:34AM -0500, foo@porto.bmb.uga.edu told us:
> -CONFIG_IP_NF_AMANDA=3Dy

did you see today's postings from Matthias Andree on this topic??
It turned out that ip_conntrack_amanda changed some packets and
that's why the UDP checksum was wrong. It seems like ip_conntrack_amanda
is build into the kernel on one of your machines.

See
http://marc.theaimsgroup.com/?l=3Dlinux-net&m=3D109957086306388&w=3D2
http://marc.theaimsgroup.com/?l=3Dlinux-net&m=3D109957086416037&w=3D2


Hope this helps

Sven


--=20
Linux zion 2.6.9-rc1-mm4 #1 Tue Sep 7 12:57:19 CEST 2004 i686 athlon i386 G=
NU/Linux
 18:36:22 up 22:04,  2 users,  load average: 0.12, 0.08, 0.02

--XsQoSWH+UP9D9v3l
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFBimlRo4FAdB2PneQRAk6XAJ4lkEEAt+H+381JVWWUXSPLrMI3ZQCeJ0uZ
6KCd/VmqPYTtbpCPur2qGrk=
=HVNd
-----END PGP SIGNATURE-----

--XsQoSWH+UP9D9v3l--
