Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262238AbUE1Ett@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262238AbUE1Ett (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 00:49:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265794AbUE1Ett
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 00:49:49 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:23861 "EHLO
	pd4mo1so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S262238AbUE1Etr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 00:49:47 -0400
Date: Thu, 27 May 2004 21:45:08 -0700
From: "Robin H. Johnson" <robbat2@orbis-terrarum.net>
Subject: scsihosts kernel param broken?
To: linux-kernel@vger.kernel.org
Message-id: <20040528044508.GB28009@curie-int.orbis-terrarum.net>
MIME-version: 1.0
Content-type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary=rJwd6BRFiFCcLxzm
Content-disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--rJwd6BRFiFCcLxzm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

After tweaking my kernel today and moving my SCSI controller drivers
into the kernel instead of using them as modules, I wanted to use the
scsihosts kernel parameter as described in filesystems/devfs/README, to
tweak the order of my 3ware (3w-xxxx) and Adaptec (aic79xx) [two
controllers] drives.

I'd like:
scsihosts=3Daic79xx:3w-xxxx:aic79xx
But the aic79xx code is running first, and leaving all my 3ware stuff to
last.

What's broken here?

Please CC me with responses, as I usually just lurk via the mail
archives.

--=20
Robin Hugh Johnson
E-Mail     : robbat2@orbis-terrarum.net
Home Page  : http://www.orbis-terrarum.net/?l=3Dpeople.robbat2
ICQ#       : 30269588 or 41961639
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85

--rJwd6BRFiFCcLxzm
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Robbat2 @ Orbis-Terrarum Networks

iD8DBQFAtsPUsnuUTjSIToURApl9AJ42kHsq3RGas1PWU8z0K9EbZX/ZDACfSm5F
UzYelhhT8i/Vpkv3ubJx/TM=
=y9XE
-----END PGP SIGNATURE-----

--rJwd6BRFiFCcLxzm--
