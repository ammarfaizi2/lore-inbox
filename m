Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932252AbVIENoR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932252AbVIENoR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 09:44:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932278AbVIENoR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 09:44:17 -0400
Received: from mail04.syd.optusnet.com.au ([211.29.132.185]:8858 "EHLO
	mail04.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932252AbVIENoQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 09:44:16 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: 2.6.13-ck2
Date: Mon, 5 Sep 2005 23:44:08 +1000
User-Agent: KMail/1.8.2
Cc: ck list <ck@vds.kolivas.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1214396.p9S88tSLBG";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200509052344.11665.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1214396.p9S88tSLBG
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

These are patches designed to improve system responsiveness and interactivi=
ty.=20
It is configurable to any workload but the default ck* patch is aimed at th=
e=20
desktop and ck*-server is available with more emphasis on serverspace.


Apply to 2.6.13
http://ck.kolivas.org/patches/2.6/2.6.13/2.6.13-ck2/patch-2.6.13-ck2.bz2

or server version (no new version this release):
http://ck.kolivas.org/patches/2.6/2.6.13/2.6.13-ck1/patch-2.6.13-ck1-server=
=2Ebz2


web:
http://kernel.kolivas.org
all patches:
http://ck.kolivas.org/patches/
Split patches available.


Changes:

Added:
 +vm-swap_prefetch-2.patch
As mentioned many times already, this code prefetches ram that has been=20
swapped out during idle periods. This is the latest version of the patch an=
d=20
is a config option.

 +sched-staircase12_tweak.patch
The interactivity tweak which was isolated to the developmental 2.6.13-ck1+=
=20
patch seemed not to bring problems with the changes bringing staircase up t=
o=20
v12 so it has been incorporated.


Cheers,
Con

--nextPart1214396.p9S88tSLBG
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDHEurZUg7+tp6mRURAh3gAJ477wfXHZmPAADRlPdk6E7GBYkFMACfU9VL
Bx5zlq+bUeCi4NhbdLuhw7I=
=7dO5
-----END PGP SIGNATURE-----

--nextPart1214396.p9S88tSLBG--
