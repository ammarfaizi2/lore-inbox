Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161040AbVLOEea@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161040AbVLOEea (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 23:34:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161039AbVLOEea
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 23:34:30 -0500
Received: from mail10.syd.optusnet.com.au ([211.29.132.191]:21646 "EHLO
	mail10.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1161040AbVLOEe3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 23:34:29 -0500
From: Con Kolivas <kernel@kolivas.org>
To: ck list <ck@vds.kolivas.org>
Subject: 2.6.14-ck7
Date: Thu, 15 Dec 2005 15:34:22 +1100
User-Agent: KMail/1.8.3
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <200512151534.25177.kernel@kolivas.org>
X-Length: 2375
Content-Type: multipart/signed;
  boundary="nextPart6308657.9VN5fWk2hI";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart6308657.9VN5fWk2hI
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

These are patches designed to improve system responsiveness and interactivi=
ty.=20
It is configurable to any workload but the default ck patch is aimed at the=
=20
desktop and cks is available with more emphasis on serverspace.


THIS INCLUDES ALL PATCHES FROM 2.6.14.4 SO START WITH 2.6.14

Apply to 2.6.14
http://ck.kolivas.org/patches/2.6/2.6.14/2.6.14-ck7/patch-2.6.14-ck7.bz2

or server version
http://ck.kolivas.org/patches/cks/patch-2.6.14-cks7.bz2

web:
http://kernel.kolivas.org
all patches:
http://ck.kolivas.org/patches/
Split patches available.


Changes:

Modified:
 -patch-2.6.14.3.bz2
 +patch-2.6.14.4.bz2

Resync with stable tree

 -mm-swap_prefetch-18.patch
 +mm-swap_prefetch-19.patch

Swap prefetching is being dropped from -mm so it will become another -ck on=
ly=20
patch. Here is an updated version wiht minor tweaks to prefetch a bit easie=
r=20
when there is lots of dirty ram (from writing files).

=2D2614ck6-version.diff
+2614ck7-version.diff

Version


=46ull patchlist:

2.6.14_to_staircase12.1.diff
schedrange.diff
schedbatch2.9.diff
sched-iso3.2.patch
smp-nice-support7.diff
1g_lowmem1_i386.diff
defaultcfq.diff
isobatch_ionice2.diff
rt_ionice.diff
pdflush-tweaks.patch
hz-default_values.patch
hz-no_default_250.patch
mm-swap_prefetch-19.patch
vm-mapped.diff
vm-lots_watermark.diff
vm-background_scan-1.diff
sched-staircase12.1_12.2.patch
mm-kswapd_inherit_prio.patch
mm-prio_dependant_scan.patch
mm-batch_prio.patch
sched-staircase12.2_13.patch
patch-2.6.14.4.bz2
2614ck7-version.diff


Cheers,
Con

--nextPart6308657.9VN5fWk2hI
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDoPJRZUg7+tp6mRURAgjGAKCOXtXdtEPQwWazQxVplIwUKid5jgCfY0Rk
cJJq0GmCCUYpxAsKsQSAUXs=
=2+ds
-----END PGP SIGNATURE-----

--nextPart6308657.9VN5fWk2hI--
