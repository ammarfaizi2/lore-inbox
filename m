Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265193AbUAGHzO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 02:55:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265196AbUAGHzO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 02:55:14 -0500
Received: from resin.csoft.net ([63.111.22.86]:4375 "HELO mail231.csoft.net")
	by vger.kernel.org with SMTP id S265193AbUAGHzJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 02:55:09 -0500
Subject: 2.4.24-ck1
From: Eric Hustvedt <lkml@plumlocosoft.com>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-uC4t6KW2qrDYYR2oV5/l"
Message-Id: <1073462109.1734.16.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 07 Jan 2004 02:55:09 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-uC4t6KW2qrDYYR2oV5/l
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Updated the ck patchset.

http://www.plumlocosoft.com/kernel/

Includes:
O(1) scheduler with batch scheduling, interactivity
Preemptible kernel
Low Latency
Read Latency2
Variable Hz
64bit jiffies
Supermount-NG v1.2.11
Bootsplash v3.0.7
POSIX ACL/xattr v0.8.65
XFS file system v1.3.1

Added:
- POSIX ACLs and extended attribute support for ext2/ext3.

Updated:
- Resynced with the upstream patches, which picked up various fixes.
- Supermount-NG updated to latest version.

Pending:
- GRsec update
- Support for non-x86 architectures. I figure that I will need to
backport the low-level support for the O1 scheduler. If anyone can point
me towards existing patches, that would be very appreciated.

Notes:
- XFS and ACLs are compile tested only. Please test carefully before
using in production environment.

--=20
Eric Hustvedt <lkml@plumlocosoft.com>

--=-uC4t6KW2qrDYYR2oV5/l
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/+7tY8O0ZDXGTPEIRAihQAJ43vZCdZBClXHXzTZAFTQrtgTxUNACfdVHl
dQAGoGRqXe5kCEpkMjqQ9aY=
=DRP/
-----END PGP SIGNATURE-----

--=-uC4t6KW2qrDYYR2oV5/l--

