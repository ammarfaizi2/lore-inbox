Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262065AbUK3NPP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262065AbUK3NPP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 08:15:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262067AbUK3NPP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 08:15:15 -0500
Received: from baloney.puettmann.net ([194.97.54.34]:36527 "EHLO
	baloney.puettmann.net") by vger.kernel.org with ESMTP
	id S262065AbUK3NPH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 08:15:07 -0500
Date: Tue, 30 Nov 2004 14:10:42 +0100
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, ganesh.venkatesan@intel.com
Subject: 2.6.10-rc2-bk13 freeze on boot with e100 in HP DL360G1
Message-ID: <20041130131041.GG4465@puettmann.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Hf61M2y+wYpnELGG"
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040722i
From: Ruben Puettmann <ruben@puettmann.net>
X-Scanner: exiscan *1CZ7mE-00047d-00*p5BmysC7EkQ* (Puettmann.NeT, Germany)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Hf61M2y+wYpnELGG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable



                        hello,

I try to boot the fresh 2.6.10-rc2-bk13 on an HP/Compaq DL360G1.=20
(Config attached.) Boot parameter "elevator=3Dcfq pci=3Dnoacpi" or
"elevator=3Dcfq" only.=20

Last message on boot is :

e100: Intel(R) PRO/100 Network Driver 3.2.3-k2-NAPI
e100: Copyright(c) 1999-2004 Intel Corporation.

System freezed.


I have take a look in the last Changelog and found this Change:

ChangeSet@1.2223.1.1, 2004-11-24 14:53:50-05:00, akpm@osdl.org
  [PATCH] e100: early reset fix

I will try to boot an bk without this patch.=20

                        Ruben


--=20
Ruben Puettmann
ruben@puettmann.net
http://www.puettmann.net

--Hf61M2y+wYpnELGG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBrHFRgHHssbUmOEIRAjbYAKCZ08iJzuWqG70q0mfBRK+cKy2aawCgmraa
or06lpsiKE/HV0xPvbuU15Y=
=ZpDD
-----END PGP SIGNATURE-----

--Hf61M2y+wYpnELGG--
