Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750974AbWDVTTD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750974AbWDVTTD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Apr 2006 15:19:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750989AbWDVTTC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Apr 2006 15:19:02 -0400
Received: from moeglingen.blank.eu.org ([82.139.201.30]:56999 "EHLO
	wavehammer.waldi.eu.org") by vger.kernel.org with ESMTP
	id S1750974AbWDVTTA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Apr 2006 15:19:00 -0400
Date: Sat, 22 Apr 2006 21:18:58 +0200
From: Bastian Blank <bastian@waldi.eu.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: [PATCH] s390 - make qeth buildable
Message-ID: <20060422191858.GA17564@wavehammer.waldi.eu.org>
Mail-Followup-To: Bastian Blank <bastian@waldi.eu.org>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7gGkHNMELEOhSGF6"
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--7gGkHNMELEOhSGF6
Content-Type: multipart/mixed; boundary="DBIVS5p969aUjpLe"
Content-Disposition: inline


--DBIVS5p969aUjpLe
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The attached patch makes qeth buildable again in 2.6.17-rc2.

Signed-off-by: Bastian Blank <bastian@waldi.eu.org>

Bastian

--=20
Men will always be men -- no matter where they are.
		-- Harry Mudd, "Mudd's Women", stardate 1329.8

--DBIVS5p969aUjpLe
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename=diff
Content-Transfer-Encoding: quoted-printable

diff --git a/drivers/s390/net/qeth_main.c b/drivers/s390/net/qeth_main.c
index b3c6e79..cb14642 100644
--- a/drivers/s390/net/qeth_main.c
+++ b/drivers/s390/net/qeth_main.c
@@ -8014,7 +8014,6 @@ static int (*qeth_old_arp_constructor) (
=20
 static struct neigh_ops arp_direct_ops_template =3D {
 	.family =3D AF_INET,
-	.destructor =3D NULL,
 	.solicit =3D NULL,
 	.error_report =3D NULL,
 	.output =3D dev_queue_xmit,

--DBIVS5p969aUjpLe--

--7gGkHNMELEOhSGF6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iEYEARECAAYFAkRKgaIACgkQnw66O/MvCNFWcwCgiEtCleVgeqI8Y4g4gYSMpsiM
9CkAmgNXZ/0dTttdMybxI8xiGYphJYxf
=e4Xg
-----END PGP SIGNATURE-----

--7gGkHNMELEOhSGF6--
