Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264726AbTFEPvM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 11:51:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264727AbTFEPvL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 11:51:11 -0400
Received: from 24-216-225-11.charter.com ([24.216.225.11]:24218 "EHLO
	wally.rdlg.net") by vger.kernel.org with ESMTP id S264726AbTFEPvK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 11:51:10 -0400
Date: Thu, 5 Jun 2003 12:04:40 -0400
From: "Robert L. Harris" <Robert.L.Harris@rdlg.net>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: IDE CDRW and ide-scsi fun?
Message-ID: <20030605160440.GE8594@rdlg.net>
Mail-Followup-To: Linux-Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LKTjZJSUETSlgu2t"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--LKTjZJSUETSlgu2t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable



I have a DVD-CDRW:

'SONY    ' 'DVD RW DRU-510A ' '1.0a' Removable CD-ROM

If I compile ide-cd and ide-scsi into the kernel I can see the drives
but cdrecord doesn't recognize them, even if I specify the device (2,0,0).
If I compile either one in and modularize the other I get the same
thing.  If I modularize both and then load them:

modprobe ide-scsi
modprobe ide-cd


They load just fine.

I've currently got my burn script which sets my common options to load
and unload the modules but this strikes me as a rather hackish way
around the problem.

Kernel is 2.4.20 through 2.4.21-rc7-ac1.

Robert


:wq!
---------------------------------------------------------------------------
Robert L. Harris                     | GPG Key ID: E344DA3B
                                         @ x-hkp://pgp.mit.edu=20
DISCLAIMER:
      These are MY OPINIONS ALONE.  I speak for no-one else.

Diagnosis: witzelsucht  =09

IPv6 =3D robert@ipv6.rdlg.net	http://ipv6.rdlg.net
IPv4 =3D robert@mail.rdlg.net	http://www.rdlg.net

--LKTjZJSUETSlgu2t
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE+32oY8+1vMONE2jsRAnW1AKDm8axC2p+HNg2lGLvM7mBNmxGYkACeI5Ns
9EKQNr+YvjwmuXSJ+5czr8c=
=RjjM
-----END PGP SIGNATURE-----

--LKTjZJSUETSlgu2t--
