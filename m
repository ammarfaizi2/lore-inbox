Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751441AbWDBEBZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751441AbWDBEBZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Apr 2006 23:01:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751449AbWDBEBZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Apr 2006 23:01:25 -0500
Received: from mail26.syd.optusnet.com.au ([211.29.133.167]:17364 "EHLO
	mail26.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751441AbWDBEBY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Apr 2006 23:01:24 -0500
From: Con Kolivas <kernel@kolivas.org>
To: ck list <ck@vds.kolivas.org>
Subject: 2.6.16-ck3
Date: Sun, 2 Apr 2006 14:01:10 +1000
User-Agent: KMail/1.9.1
Cc: linux list <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <200604021401.13331.kernel@kolivas.org>
X-Length: 1910
Content-Type: multipart/signed;
  boundary="nextPart5949675.2MAPygeK1g";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart5949675.2MAPygeK1g
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

These are patches designed to improve system responsiveness and interactivi=
ty.=20
It is configurable to any workload but the default ck patch is aimed at the=
=20
desktop and cks is available with more emphasis on serverspace.

THESE INCLUDE THE PATCHES FROM 2.6.16.1 SO START WITH 2.6.16 AS YOUR BASE

Apply to 2.6.16
http://www.kernel.org/pub/linux/kernel/people/ck/patches/2.6/2.6.16/2.6.16-=
ck3/patch-2.6.16-ck3.bz2

or server version
http://www.kernel.org/pub/linux/kernel/people/ck/patches/cks/patch-2.6.16-c=
ks3.bz2

web:
http://kernel.kolivas.org

all patches:
http://www.kernel.org/pub/linux/kernel/people/ck/patches/

Split patches available.


Changes:

Added:
 +sched-staircase14.2_15.patch
A major improvement in the staircase code fixes low I/O under heavy cpu loa=
d,=20
makes it starvation resistant, improves behaviour under heavy "system" load=
s,=20
fixes a slowdown under "compute" mode and has numerous other=20
microoptimisations.


Modified:
 -swsusp-post_resume_aggressive_swap_prefetch.patch
 +swsusp-post_resume_aggressive_swap_prefetch-1.patch
A minor change in the code to perform aggressive swap prefetching on swsusp=
=20
resume slightly later should speed up resume time.

 -2.6.16-ck2-version.patch
 +2.6.16-ck3-version.patch
Version update


Cheers,
Con

--nextPart5949675.2MAPygeK1g
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEL0yJZUg7+tp6mRURAuAUAJ94LQ4D463y7sbSpHqWlawPcb/GnACdFucI
NCVaa+SbHe1vz1y8HHG6NfM=
=+nKV
-----END PGP SIGNATURE-----

--nextPart5949675.2MAPygeK1g--
