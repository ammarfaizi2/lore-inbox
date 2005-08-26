Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965034AbVHZB1I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965034AbVHZB1I (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 21:27:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965040AbVHZB1H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 21:27:07 -0400
Received: from wsip-68-14-232-151.ph.ph.cox.net ([68.14.232.151]:41193 "EHLO
	cantor.snitselaar.org") by vger.kernel.org with ESMTP
	id S965034AbVHZB1G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 21:27:06 -0400
Subject: Question regardings inodes and anon_hash_chain in 2.4/2.6
From: Gerard Snitselaar <snits@snitselaar.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-svC6ZDPkDrkH4M7A2TBz"
Date: Thu, 25 Aug 2005 18:26:24 -0700
Message-Id: <1125019584.4997.7.camel@cantor.snitselaar.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-svC6ZDPkDrkH4M7A2TBz
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

I know that anon_hash_chain has gone away in 2.6 because
the inodes for special filesystems like sockfs, pipefs,
etc are now associated with a superblock. Should these
inodes have i_hash linked into the inode hashtable then?
It appears in 2.4 now they are associated with superblocks
as well.

I have been working on a problem dealing with inodes on a 2.4 kernel,=20
and was walking inode_in_use and saw inodes that were unhashed. They
all are associated with superblocks for special types. My question
is, is this expected behavior or should they be getting hashed?

Thanks


--=-svC6ZDPkDrkH4M7A2TBz
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDDm/AvNXJUsWnPvMRAmomAJ4onsbiHl5+kwLb1ESaPPm9SxzPnQCfVL18
EQszJWQXFC3PQhd0JM0OBK8=
=JuYm
-----END PGP SIGNATURE-----

--=-svC6ZDPkDrkH4M7A2TBz--
