Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262810AbUCWUs2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 15:48:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262817AbUCWUs2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 15:48:28 -0500
Received: from sccrmhc12.comcast.net ([204.127.202.56]:21932 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S262810AbUCWUsY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 15:48:24 -0500
From: John M Flinchbaugh <glynis@butterfly.hjsoft.com>
Date: Tue, 23 Mar 2004 15:48:22 -0500
To: linux-kernel@vger.kernel.org
Subject: 2.6.4 swsusp on 2 swap partitions?
Message-ID: <20040323204822.GB28214@butterfly.hjsoft.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TakKZr9L6Hm6aLOc"
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--TakKZr9L6Hm6aLOc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

i thought i had read that swsusp can now use more than one swap
partition, but my experience is proving otherwise.

when i suspend with 2 swap partitions enabled, it refuses to
resume complaining of a "wrong kernel version", then proceeds to
boot up from scratch.

i think it also may be trying to write suspend signatures on
both partitions because they're no longer usable as swap until i
mkswap them.

should i be able to suspend across 2 partitions?  i only
specify one of them in the resume=3D kernel parameter.
--=20
____________________}John Flinchbaugh{______________________
| glynis@hjsoft.com         http://www.hjsoft.com/~glynis/ |
~~Powered by Linux: Reboots are for hardware upgrades only~~

--TakKZr9L6Hm6aLOc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAYKKWCGPRljI8080RAvKMAJwIfSv4YmWeeFLr3KhyEKhxMrdGngCeLv38
Nz9TQ+iXmmt2z2d5RepIO5o=
=jasv
-----END PGP SIGNATURE-----

--TakKZr9L6Hm6aLOc--
