Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263432AbTEITqO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 15:46:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263435AbTEITqO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 15:46:14 -0400
Received: from 24-216-225-11.charter.com ([24.216.225.11]:53381 "EHLO
	wally.rdlg.net") by vger.kernel.org with ESMTP id S263432AbTEITqN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 15:46:13 -0400
Date: Fri, 9 May 2003 15:58:50 -0400
From: "Robert L. Harris" <Robert.L.Harris@rdlg.net>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: removing a single device?
Message-ID: <20030509195850.GQ27064@rdlg.net>
Mail-Followup-To: Linux-Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="b/Q3JWIUAuLE0ZFy"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--b/Q3JWIUAuLE0ZFy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable



A long time ago I used to be able to do:

echo "scsi add-single-device 0 0 11 0" > /proc/scsi/scsi
echo "scsi remove-single-device 0 0 11 0" > /proc/scsi/scsi


When I wanted to unplug a SCA scsi drive for replacement.  I tried this
recently on my 2.4.20 kernel and nothing happened.  No errors, no change
to /proc/scsi/scsi, no entry in dmsg, it just ignored it.  Has this been
deprecated for a new way of removing hotswap drives?

Thanks,
  Robert

:wq!
---------------------------------------------------------------------------
Robert L. Harris                     | PGP Key ID: E344DA3B
                                         @ x-hkp://pgp.mit.edu=20
DISCLAIMER:
      These are MY OPINIONS ALONE.  I speak for no-one else.

Diagnosis: witzelsucht  =09

IPv6 =3D robert@ipv6.rdlg.net	http://ipv6.rdlg.net
IPv4 =3D robert@mail.rdlg.net	http://www.rdlg.net

--b/Q3JWIUAuLE0ZFy
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE+vAh68+1vMONE2jsRArmVAJ4qyQ5fjclsax3AsEe4iC2IJUiIhgCeIY5l
0Slvb9ARnsSWsNFlO1Za1MA=
=+ZUY
-----END PGP SIGNATURE-----

--b/Q3JWIUAuLE0ZFy--
