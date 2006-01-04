Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751519AbWADBAK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751519AbWADBAK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 20:00:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751521AbWADBAK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 20:00:10 -0500
Received: from mail15.syd.optusnet.com.au ([211.29.132.196]:48019 "EHLO
	mail15.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751519AbWADBAH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 20:00:07 -0500
From: Con Kolivas <kernel@kolivas.org>
To: ck list <ck@vds.kolivas.org>
Subject: 2.6.15-ck1
Date: Wed, 4 Jan 2006 12:00:00 +1100
User-Agent: KMail/1.8.3
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <200601041200.03593.kernel@kolivas.org>
X-Length: 2379
Content-Type: multipart/signed;
  boundary="nextPart3348092.8N2JVDs3SW";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart3348092.8N2JVDs3SW
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

These are patches designed to improve system responsiveness and interactivi=
ty.=20
It is configurable to any workload but the default ck patch is aimed at the=
=20
desktop and cks is available with more emphasis on serverspace.


Apply to 2.6.15
http://ck.kolivas.org/patches/2.6/2.6.15/2.6.15-ck1/patch-2.6.15-ck1.bz2

or server version
http://ck.kolivas.org/patches/cks/patch-2.6.15-cks1.bz2

web:
http://kernel.kolivas.org
all patches:
http://ck.kolivas.org/patches/
Split patches available.


Changes from 2.6.14-ck8

Added:
 +2.6.15-dynticks-060101.patch
 +dynticks-disable_smp_config.patch
Latest version of the dynticks patch. This is proving stable and effective =
on=20
virtually all uniprocessor machines and will benefit systems that desire=20
power savings. SMP kernels (even on UP machines) still misbehave so this=20
config option is not available by default for this stable kernel.


Removed:
 -smp-nice-support7.diff
SMP Nice support is now merged in the mainline kernel

 -patch-2.6.14.5.bz2
Merged


Modified:
 -2.6.14_to_staircase12.1.diff
 -sched-staircase12.1_12.2.patch
 -sched-staircase12.2_13.patch
 +sched-staircase13.2.patch
Rolled up the staircase changes and added microoptimisations

 -schedbatch2.9.diff
 +schedbatch2.10.diff
Microoptimisation

 -2614ck8-version.diff
 +2615ck1-version.patch
Version


=46ull patchlist:

sched-staircase13.2.patch
schedrange.diff
schedbatch2.10.diff
sched-iso3.2.patch
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
mm-kswapd_inherit_prio.patch
mm-prio_dependant_scan.patch
mm-batch_prio.patch
2.6.15-dynticks-060101.patch
dynticks-disable_smp_config.patch
2615ck1-version.patch


Cheers,
Con

--nextPart3348092.8N2JVDs3SW
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDux4TZUg7+tp6mRURAmDXAJ49Vda7NvBiGLiEBB8xOLd1M2m1fACcC9O1
XCv2JUTdj+GHz3n9LFGUAxM=
=pHvK
-----END PGP SIGNATURE-----

--nextPart3348092.8N2JVDs3SW--
