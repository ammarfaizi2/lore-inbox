Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265757AbUA0TQf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 14:16:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265755AbUA0TQe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 14:16:34 -0500
Received: from mail-in.m-online.net ([62.245.150.237]:47839 "EHLO
	mail-in.m-online.net") by vger.kernel.org with ESMTP
	id S265757AbUA0TPd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 14:15:33 -0500
Subject: md raid + jfs + jfs_fsck
From: Florian Huber <florian.huber@mnet-online.de>
To: linux-kernel@vger.kernel.org
Cc: jfs-discussion@www-124.ibm.com
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-/j6+hTGgQ+pqtu3Mamc1"
Message-Id: <1075230933.11207.84.camel@suprafluid>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 27 Jan 2004 20:15:33 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-/j6+hTGgQ+pqtu3Mamc1
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hello MLs,
today I switched from no-raid to linux kernel software raid 1 on a jfs
and a ext3 partition. Both are working fine, but jfs_fsck reports an
error on the jfs md device (md2 <-- hda3+hdc3):

Superblock is corrupt and cannot be repaired=20
since both primary and secondary copies are corrupt.=20

Did I miss something? jfs_fsck runs without any error on hda3 and hdc3,
but fails on md2.

I'm using the 2.6.2-rc2 kernel with raid autodetection.

TIA
	Florian


--=20
Florian Huber

Key ID: D9D50EA2
Fingerprint: 0241 C329 E355 9B94 8D34 F637 4EB9 1B1D D9D5 0EA2

BOFH Excuse #413:
Cow-tippers tipped a cow onto the server.

--=-/j6+hTGgQ+pqtu3Mamc1
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBAFrjVTrkbHdnVDqIRAtoCAJ99GhUjZ4OZ2IIln7gamm+VFLGWWwCbBYLp
uGp62fsAppHw0Jv102c0dJE=
=qIoc
-----END PGP SIGNATURE-----

--=-/j6+hTGgQ+pqtu3Mamc1--

