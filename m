Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750837AbVIQDGt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750837AbVIQDGt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 23:06:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750838AbVIQDGt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 23:06:49 -0400
Received: from mail08.syd.optusnet.com.au ([211.29.132.189]:51864 "EHLO
	mail08.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1750837AbVIQDGs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 23:06:48 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: 2.6.13-ck5
Date: Sat, 17 Sep 2005 13:06:42 +1000
User-Agent: KMail/1.8.2
Cc: ck list <ck@vds.kolivas.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3067336.5MgLaX2Rba";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200509171306.44248.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart3067336.5MgLaX2Rba
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

These are patches designed to improve system responsiveness and interactivi=
ty.=20
It is configurable to any workload but the default ck* patch is aimed at th=
e=20
desktop and ck*-server is available with more emphasis on serverspace.


THIS INCLUDES ALL THE PATCHES IN 2.6.13.2 SO YOU SHOULD START WITH 2.6.13 T=
O=20
USE THESE PATCHES

Apply to 2.6.13
http://ck.kolivas.org/patches/2.6/2.6.13/2.6.13-ck5/patch-2.6.13-ck5.bz2

or server version
http://ck.kolivas.org/patches/2.6/2.6.13/2.6.13-ck5/patch-2.6.13-ck5-server=
=2Ebz2

*prefetching should still be considered experimental*
I appreciate the extensive testing it is receiving!

web:
http://kernel.kolivas.org
all patches:
http://ck.kolivas.org/patches/
Split patches available.


Changes:

Added:
+vm-sp6_sp7.2.patch
Swap prefetching update. Locking problems caused bizarre slowdowns on smp, =
smt=20
or preempt configurations. Locking has been extensively revised and hopeful=
ly=20
all fixed. Very frequent testing of free memory is now also done as=20
kprefetchd runs at low priority (nice 19) and it may be a while between eac=
h=20
page prefetched.

+per-task-predictive-write-throttling-1.patch
Andrea's write throttling patch


Updated:
=2Dpatch-2.6.13.1.bz2
+patch-2.6.13.2.bz2
Latest stable patch

=2D2613ck4-version.diff
+2613ck5-version.diff
Version


Cheers,
Con

--nextPart3067336.5MgLaX2Rba
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDK4hEZUg7+tp6mRURAuYHAJ45QOXXKSEbYIzTq5NJ8YGLUSGacQCffHTN
AJyy2zjNeWw5aT0SXGiV9aQ=
=BlGD
-----END PGP SIGNATURE-----

--nextPart3067336.5MgLaX2Rba--
