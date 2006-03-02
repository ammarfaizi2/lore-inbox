Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932190AbWCBDf0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932190AbWCBDf0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 22:35:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932202AbWCBDf0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 22:35:26 -0500
Received: from mail14.syd.optusnet.com.au ([211.29.132.195]:65432 "EHLO
	mail14.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932190AbWCBDfZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 22:35:25 -0500
From: Con Kolivas <kernel@kolivas.org>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       ck list <ck@vds.kolivas.org>
Subject: 2.6.15-ck5
Date: Thu, 2 Mar 2006 14:35:57 +1100
User-Agent: KMail/1.9
MIME-Version: 1.0
X-Length: 2932
Message-Id: <200603021435.58041.kernel@kolivas.org>
Content-Type: multipart/signed;
  boundary="nextPart2021555.9QLidMVvyk";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2021555.9QLidMVvyk
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

These are patches designed to improve system responsiveness and interactivi=
ty.=20
It is configurable to any workload but the default ck patch is aimed at the=
=20
desktop and cks is available with more emphasis on serverspace.

This includes all patches from 2.6.15.5 so use 2.6.15 as your base.

Apply to 2.6.15
http://ck.kolivas.org/patches/2.6/2.6.15/2.6.15-ck5/patch-2.6.15-ck5.bz2

or server version
http://ck.kolivas.org/patches/cks/patch-2.6.15-cks5.bz2

web:
http://kernel.kolivas.org

all patches:
http://ck.kolivas.org/patches/

Split patches available.


Changes
=2D------
Added:
 +mm-highmem_fix_background_scan.patch
The background scanning when used with a very small amount of highmem (eg 1=
GB)=20
was continually clearing out page cache inappropriately. This patch correct=
s=20
it by not background scanning if highmem is below watermarks.

 +sched-staircase13.4_13.5.patch
Increase rr intervals to 6ms for slightly better cache utilisation while st=
ill=20
staying below human perceptible jitter levels.

 +nfs-fix_build.patch
The 2.6.15.5 stable patch includes a build error; this fixes it.


Modified:
 -mm-swap_prefetch-19.patch
 +mm-swap_prefetch-28.patch
Update to the latest prefetch as included in 2.6.15-rc5-mm1

 -2.6.15-dynticks-060101.patch
 +2.6.15-dynticks-060227.patch
Update to the latest dynticks code which fixes some bugs

 -patch-2.6.15.4.bz2
 +patch-2.6.15.5.bz2
Update to the latest stable patch

 -2615ck4-version.patch
 +2615ck5-version.patch
Version update


Removed:
 -dynticks-i386_only_config.patch
Part of the latest dynticks patch already so unnecessary.


=46ull patchlist:
sched-staircase13.2.patch
sched-staircase13.2_13.3.patch
schedrange-1.diff
schedbatch-2.11.diff
sched-iso3.3.patch
vmsplit-config_options.patch
defaultcfq.diff
isobatch_ionice2.diff
rt_ionice.diff
pdflush-tweaks.patch
hz-default_values.patch
hz-no_default_250.patch
mm-swap_prefetch-28.patch
vm-mapped.diff
vm-lots_watermark.diff
vm-background_scan-1.diff
mm-highmem_fix_background_scan.patch
mm-kswapd_inherit_prio-1.patch
mm-prio_dependant_scan.patch
mm-batch_prio.patch
2.6.15-dynticks-060227.patch
dynticks-disable_smp_config.patch
sched-staircase13.3_13.4.patch
sched-staircase13.4_13.5.patch
patch-2.6.15.5.bz2
nfs-fix_build.patch
2615ck5-version.patch


Cheers,
Con

--nextPart2021555.9QLidMVvyk
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBEBmgeZUg7+tp6mRURAoO0AJ9Xahmr/BhwWqNT17D/ThQZ48lQwACgiHiS
O2EOzHxAAptqcHCduioMYWA=
=kqrg
-----END PGP SIGNATURE-----

--nextPart2021555.9QLidMVvyk--
