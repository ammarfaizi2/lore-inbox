Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750779AbWAaMT1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750779AbWAaMT1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 07:19:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750781AbWAaMT1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 07:19:27 -0500
Received: from mail05.syd.optusnet.com.au ([211.29.132.186]:8411 "EHLO
	mail05.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1750779AbWAaMT0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 07:19:26 -0500
From: Con Kolivas <kernel@kolivas.org>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       ck list <ck@vds.kolivas.org>
Subject: 2.6.15-ck3
Date: Tue, 31 Jan 2006 23:19:17 +1100
User-Agent: KMail/1.9
MIME-Version: 1.0
X-Length: 2762
Message-Id: <200601312319.20403.kernel@kolivas.org>
Content-Type: multipart/signed;
  boundary="nextPart1227175.WKrW4cWGvA";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1227175.WKrW4cWGvA
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

These are patches designed to improve system responsiveness and interactivi=
ty.=20
It is configurable to any workload but the default ck patch is aimed at the=
=20
desktop and cks is available with more emphasis on serverspace.

This includes all patches from 2.6.15.2 so use 2.6.15 as your base.

Apply to 2.6.15
http://ck.kolivas.org/patches/2.6/2.6.15/2.6.15-ck3/patch-2.6.15-ck3.bz2

or server version
http://ck.kolivas.org/patches/cks/patch-2.6.15-cks3.bz2

web:
http://kernel.kolivas.org

all patches:
http://ck.kolivas.org/patches/

Split patches available.


Changes

Added:
 +sched-staircase13.3_13.4.patch
Staircase tweaks. Disable use of TASK_NONINTERACTIVE flag. It is not needed=
=20
with staircase and just slows down things waiting on pipes.

 +fix-scsi_cmd_cache_leak.patch
=46ix the scsi_cmd_cache slab leak


Modified:
 -mm-kswapd_inherit_prio.patch
 +mm-kswapd_inherit_prio-1.patch
A dud patch merge caused lousy performance once memory was full. This resto=
res=20
the patch to its proper state.

 -patch-2.6.15.1.bz2
 +patch-2.6.15.2.bz2
Latest stable patch

=2D2615ck2-version.patch
+2615ck3-version.patch
Version update


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
mm-swap_prefetch-19.patch
vm-mapped.diff
vm-lots_watermark.diff
vm-background_scan-1.diff
mm-kswapd_inherit_prio-1.patch
mm-prio_dependant_scan.patch
mm-batch_prio.patch
2.6.15-dynticks-060101.patch
dynticks-disable_smp_config.patch
dynticks-i386_only_config.patch
fix-scsi_cmd_cache_leak.patch
sched-staircase13.3_13.4.patch
patch-2.6.15.2.bz2
2615ck3-version.patch


Cheers,
Con

--nextPart1227175.WKrW4cWGvA
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBD31XIZUg7+tp6mRURAlGWAKCQXaMzOFqq3IQ4y3LlPorpBvMIEQCgioXD
5+4e+Vi0z+BVOtx8SenJKzc=
=yQLv
-----END PGP SIGNATURE-----

--nextPart1227175.WKrW4cWGvA--
