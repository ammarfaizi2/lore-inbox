Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261326AbUC1MBZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 07:01:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261426AbUC1MBY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 07:01:24 -0500
Received: from maximus.kcore.de ([213.133.102.235]:30619 "EHLO
	maximus.kcore.de") by vger.kernel.org with ESMTP id S261326AbUC1MBU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 07:01:20 -0500
From: Oliver Feiler <kiza@gmx.net>
To: linux-kernel@vger.kernel.org
Subject: CONFIG_ATALK cannot be compiled as a module (2.4.24)
Date: Sun, 28 Mar 2004 14:01:11 +0200
User-Agent: KMail/1.5
X-PGP-Key-Fingerprint: E9DD 32F1 FA8A 0945 6A74  07DE 3A98 9F65 561D 4FD2
X-PGP-Key: http://kiza.kcore.de/pgpkey
X-Species: Snow Leopard
X-Operating-System: Linux
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_O6rZA1jMGsUeJQQ";
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200403281401.18489.kiza@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_O6rZA1jMGsUeJQQ
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Description: signed data
Content-Disposition: inline

Hi,

when selecting CONFIG_ATALK as a module the symbols register_snap_client an=
d=20
unregister_snap_client will be unresolved. As I understand it they are in=20
net/802/psnap.c which does not get compiled when Appletalk is selected as a=
=20
module. Compiling into the kernel works fine.

I found this posting from 1996 which seems to mention the same problem:=20
http://www.ussg.iu.edu/hypermail/linux/net/9603.1/0087.html

Does anyone know if the mentioned problems were ever fixed? Maybe CONFIg_AT=
ALK=20
should not allow the module option if it's not supposed to work anyway.

	Oliver

--Boundary-02=_O6rZA1jMGsUeJQQ
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQBAZr6OOpifZVYdT9IRAsOnAKCOAHuHbidD9S5V5vVfLlCYmSBnBQCgo931
BsmTbnm/ERvmtZSJTYNygL0=
=fgQW
-----END PGP SIGNATURE-----

--Boundary-02=_O6rZA1jMGsUeJQQ--

