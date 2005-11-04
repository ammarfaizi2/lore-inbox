Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161138AbVKDKmZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161138AbVKDKmZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 05:42:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161139AbVKDKmZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 05:42:25 -0500
Received: from mail27.syd.optusnet.com.au ([211.29.133.168]:23449 "EHLO
	mail27.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1161138AbVKDKmY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 05:42:24 -0500
From: Con Kolivas <kernel@kolivas.org>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: 2.6.14-ck3
Date: Fri, 4 Nov 2005 21:42:15 +1100
User-Agent: KMail/1.8.3
Cc: ck list <ck@vds.kolivas.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1503196.dLeeZ6GMQe";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200511042142.17863.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1503196.dLeeZ6GMQe
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

These are patches designed to improve system responsiveness and interactivi=
ty.=20
It is configurable to any workload but the default ck patch is aimed at the=
=20
desktop and cks is available with more emphasis on serverspace.

Apply to 2.6.14
http://ck.kolivas.org/patches/2.6/2.6.14/2.6.14-ck3/patch-2.6.14-ck3.bz2

or server version
http://ck.kolivas.org/patches/cks/patch-2.6.14-cks3.bz2

web:
http://kernel.kolivas.org
all patches:
http://ck.kolivas.org/patches/
Split patches available.


No new features in this one, new version is just to address problematic=20
behaviour due to adaptive readahead.


Changes:
Removed:
=2Dadaptive-readahead-6.patch
 Caused I/O related latencies and lag; needs more work

=2Dset_workqueue_nice-1.patch
=2Ddm-drop_kcryptd_prio.patch
 Broken, did nothing


Modified:
=2D2614ck2-version.diff
+2614ck3-version.diff
 Version


 Full patchlist:
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
hz-no250.patch
mm-swap_prefetch-18.patch
vm-mapped.diff
vm-lots_watermark.diff
vm-background_scan-1.diff
sched-staircase12.1_12.2.patch
mm-kswapd_inherit_prio.patch
mm-prio_dependant_scan.patch
mm-batch_prio.patch
2614ck3-version.diff


 also available in patches dir:
hz-extra_values.patch

 adds values 82 and 864 for good timer accuracy but not included by default=
=20
since some drivers break in weird and wonderful ways at these HZ values=20
(they're not supposed to but that's another story)


Cheers,
Con

--nextPart1503196.dLeeZ6GMQe
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDazsJZUg7+tp6mRURAmVvAJwK3tYUkipfECv+oVxVEwHJJWMhkgCfU3SA
K7MvmNiplkz2GDsZ2Wr1WNY=
=6wnP
-----END PGP SIGNATURE-----

--nextPart1503196.dLeeZ6GMQe--
