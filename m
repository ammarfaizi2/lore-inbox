Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932155AbVHRKBz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932155AbVHRKBz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 06:01:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932159AbVHRKBy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 06:01:54 -0400
Received: from keetweej.xs4all.nl ([213.84.46.114]:42217 "EHLO
	keetweej.vanheusden.com") by vger.kernel.org with ESMTP
	id S932155AbVHRKBy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 06:01:54 -0400
Date: Thu, 18 Aug 2005 12:01:52 +0200
From: Folkert van Heusden <folkert@vanheusden.com>
To: linux-kernel@vger.kernel.org
Subject: zero-copy read() interface
Message-ID: <20050818100151.GF12313@vanheusden.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="d6Gm4EdcadzBjdND"
Content-Disposition: inline
Organization: www.unixexpert.nl
X-Chameleon-Return-To: folkert@vanheusden.com
X-Xfmail-Return-To: folkert@vanheusden.com
X-Phonenumber: +31-6-41278122
X-URL: http://www.vanheusden.com/
X-PGP-KeyID: 1F28D8AE
X-GPG-fingerprint: AC89 09CE 41F2 00B4 FCF2  B174 3019 0E8C 1F28 D8AE
X-Key: http://pgp.surfnet.nl:11371/pks/lookup?op=get&search=0x1F28D8AE
Read-Receipt-To: <folkert@vanheusden.com>
Reply-By: Tue Aug 16 15:30:48 CEST 2005
X-MSMail-Priority: High
X-Message-Flag: www.vanheusden.com
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

What about a zero-copy read-interface?
An ioctl (or something) which enables the kernel to do dma directly to
the userspace. Of course this should be limited to the root-user or a
user with special capabilities (rights) since if a drive screws up, data
=66rom a different sector (or so) might end up in the proces' memory. Of
course copying a sector from kernel- to userspace can be done pretty
fast but i.m.h.o. all possible speedimprovements should be made unless
unclean.


Folkert van Heusden

--=20
Auto te koop, zie: http://www.vanheusden.com/daihatsu.php
----------------------------------------------------------------------
Get your PGP/GPG key signed at www.biglumber.com!
----------------------------------------------------------------------
Phone: +31-6-41278122, PGP-key: 1F28D8AE, www.vanheusden.com

--d6Gm4EdcadzBjdND
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iIMEARECAEMFAkMEXI88Gmh0dHA6Ly93d3cudmFuaGV1c2Rlbi5jb20vZGF0YS1z
aWduaW5nLXdpdGgtcGdwLXBvbGljeS5odG1sAAoJEDAZDowfKNiuDfoAn0ezwFfk
/n8MgNBB5HksmE+4COm2AKCZEdQWyYk3slWx+JjImvq+AX5pBQ==
=gVNn
-----END PGP SIGNATURE-----

--d6Gm4EdcadzBjdND--
