Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750739AbVLTRnQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750739AbVLTRnQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 12:43:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750744AbVLTRnP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 12:43:15 -0500
Received: from mx1.redhat.com ([66.187.233.31]:44944 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750739AbVLTRnP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 12:43:15 -0500
Subject: 2.6.15-rc5-rt4 x86 patch
From: Clark Williams <williams@redhat.com>
To: lkml <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-CeAYsKjkSYEMwoYBInC9"
Date: Tue, 20 Dec 2005 11:43:03 -0600
Message-Id: <1135100583.3415.16.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-CeAYsKjkSYEMwoYBInC9
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

I still need the following to compile with PREEMPT_RT on an x86:

--- ./arch/i386/Kconfig.cpu.orig        2005-12-20 11:26:34.000000000 -0600
+++ ./arch/i386/Kconfig.cpu     2005-12-20 11:33:23.000000000 -0600
@@ -229,11 +229,6 @@
        depends on M386
        default y

-config RWSEM_XCHGADD_ALGORITHM
-       bool
-       depends on !M386
-       default y
-
 config GENERIC_CALIBRATE_DELAY
        bool
        default y

--=20
Clark Williams <williams@redhat.com>

--=-CeAYsKjkSYEMwoYBInC9
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDqEKnHyuj/+TTEp0RAi1JAKCv9pRvdm5XILaI7okPgKT/1SLliwCfWMwg
4HWvH0+ddN8O9Kp8hAVXHbA=
=Blzr
-----END PGP SIGNATURE-----

--=-CeAYsKjkSYEMwoYBInC9--

