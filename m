Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261705AbTCZOeQ>; Wed, 26 Mar 2003 09:34:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261707AbTCZOeQ>; Wed, 26 Mar 2003 09:34:16 -0500
Received: from 24-216-225-11.charter.com ([24.216.225.11]:18306 "EHLO
	wally.rdlg.net") by vger.kernel.org with ESMTP id <S261705AbTCZOeP>;
	Wed, 26 Mar 2003 09:34:15 -0500
Date: Wed, 26 Mar 2003 09:45:26 -0500
From: "Robert L. Harris" <Robert.L.Harris@rdlg.net>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: fixing module autoload stacking
Message-ID: <20030326144526.GD2328@rdlg.net>
Mail-Followup-To: Linux-Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jCrbxBqMcLqd4mOl"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--jCrbxBqMcLqd4mOl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable



Ok, bringing this here because it's bugging a few of us.

Scenario:
  Linux 2.4.X kernel with scsi-generic, usb-storage, fat and vfat compiled=
=20
as modules.  I plug in my usb drive (archos jukebox or sandisk
thumbdrive) and it won't autoload the sg and usb-storage drivers.  If I
modprobe sg, modprobe usb-drive it will autoload fat and vfat.

  What the heck do I need to change on my Debian system (I can try and
convert redhat directions) to get this chain working properly?

Thanks,
  Robert

(I'll forward out to the other list in question)


:wq!
---------------------------------------------------------------------------
Robert L. Harris                     | PGP Key ID: E344DA3B
                                         @ x-hkp://pgp.mit.edu=20
DISCLAIMER:
      These are MY OPINIONS ALONE.  I speak for no-one else.

Diagnosis: witzelsucht  =09

IPv6 =3D robert@ipv6.rdlg.net	http://ipv6.rdlg.net
IPv4 =3D robert@mail.rdlg.net	http://www.rdlg.net

--jCrbxBqMcLqd4mOl
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+gb0F8+1vMONE2jsRAqLfAJ9EhHnmHvH4aD6wmyd5XpC43Qj22gCdGNJ4
gPZzy4i5DyvvUihNOnAn0lQ=
=87iK
-----END PGP SIGNATURE-----

--jCrbxBqMcLqd4mOl--
