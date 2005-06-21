Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261924AbVFUFKK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261924AbVFUFKK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 01:10:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261908AbVFUFJY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 01:09:24 -0400
Received: from mail12.syd.optusnet.com.au ([211.29.132.193]:41895 "EHLO
	mail12.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261258AbVFUFBr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 01:01:47 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       ck list <ck@vds.kolivas.org>
Subject: 2.6.12-ck1
Date: Tue, 21 Jun 2005 15:01:41 +1000
User-Agent: KMail/1.8.1
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2766777.2A0Rjy7Xnj";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200506211501.43473.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2766777.2A0Rjy7Xnj
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

These are patches designed to improve system responsiveness and interactivi=
ty.=20
It is configurable to any workload but the default ck* patch is aimed at th=
e=20
desktop and ck*-server is available with more emphasis on serverspace.

Apply to 2.6.12:
http://ck.kolivas.org/patches/2.6/2.6.12/2.6.12-ck1/patch-2.6.12-ck1.bz2
or for server version:
http://ck.kolivas.org/patches/2.6/2.6.12/2.6.12-ck1/patch-2.6.12-ck1-server=
=2Ebz2

web:
http://kernel.kolivas.org
all patches:
http://ck.kolivas.org/patches/
Split patches available.


Changes since 2.6.11-ck10:
Added/rolled up/updated:
+sched-run_normal_with_rt_on_sibling.diff
A fix for the SMT (hyperthread) nice handling with real time tasks

+2.6.12_to_staircase11.3.diff
Rolled up latest staircase cpu scheduler

+schedbatch2.8.diff
Updated batch scheduling

+smp-nice-support6.diff
Latest version of nice support on SMP configurations

+cfq-2.6.12-mm1.patch
Latest version of the cfq-timeslice I/O scheduler from 2.6.12-mm1

+2612ck1-version.diff
Version


Dropped, rolled up or updated:
=2D2.6.11_to_staircase10.5.diff
=2Ds10.5_s10.6.diff
=2Ds10.6_s10.7.diff
=2D2.6.11-ck4_to_staircase11.diff
=2Ds11_s11.1.diff
=2Ds11.1_s11.2.diff
=2Ds11.2_s11.3.diff
Rolled up into latest staircase

=2Dschedbatch2.7.diff
Updated

=2Dcddvd-cmdfilter-drop.patch
No longer required with userspace tools updated to latest cd/dvd burning=20
software

=2Dcfq-ts-21.diff
=2Dcfq-ts21-fix.diff
=2Dcfq-ts21-fix1.diff
=2Dcfq-ts21-fix2.diff
Updated

=2D2.6.11-ck-scsifix.diff
Merged

=2D2611ck9-smpnice.diff
=2D2611ck9-smpnice-fix1.diff
Updated

=2Dpatch-2.6.11.12
Merged

=2D2611ck10-version.diff
Updated


=46ull patchlist:
sched-run_normal_with_rt_on_sibling.diff
2.6.12_to_staircase11.3.diff
schedrange.diff
schedbatch2.8.diff
schediso2.12.diff
smp-nice-support6.diff
mapped_watermark3.diff
1g_lowmem1_i386.diff
cfq-2.6.12-mm1.patch
defaultcfq.diff
isobatch_ionice2.diff
rt_ionice.diff
2612ck1-version.diff


This release is called "Baby Cigar" as this picture should explain:
http://ck.kolivas.org/patches/2.6/2.6.12/baby_cigar.JPG

Cheers,
Con

--nextPart2766777.2A0Rjy7Xnj
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCt583ZUg7+tp6mRURAtd8AJ90PWUOKFMqu4RFvUnxiJPrDX0fVACfSLEZ
9SMMcqEjP96sFQuWpdjaaZE=
=e48s
-----END PGP SIGNATURE-----

--nextPart2766777.2A0Rjy7Xnj--
