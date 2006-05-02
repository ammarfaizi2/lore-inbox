Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964814AbWEBNiY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964814AbWEBNiY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 09:38:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964816AbWEBNiY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 09:38:24 -0400
Received: from mail04.syd.optusnet.com.au ([211.29.132.185]:22199 "EHLO
	mail04.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S964814AbWEBNiX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 09:38:23 -0400
From: Con Kolivas <kernel@kolivas.org>
To: ck list <ck@vds.kolivas.org>, linux list <linux-kernel@vger.kernel.org>
Subject: 2.6.16-ck9
Date: Tue, 2 May 2006 23:38:16 +1000
User-Agent: KMail/1.9.1
MIME-Version: 1.0
Message-Id: <200605022338.20534.kernel@kolivas.org>
X-Length: 1983
Content-Type: multipart/signed;
  boundary="nextPart16636820.yGrfFDxt1E";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart16636820.yGrfFDxt1E
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

These are patches designed to improve system responsiveness and interactivi=
ty.=20
It is configurable to any workload but the default ck patch is aimed at the=
=20
desktop and cks is available with more emphasis on serverspace.

THESE INCLUDE THE PATCHES FROM 2.6.16.12 SO START WITH 2.6.16 AS YOUR BASE

Apply to 2.6.16
http://www.kernel.org/pub/linux/kernel/people/ck/patches/2.6/2.6.16/2.6.16-=
ck9/patch-2.6.16-ck9.bz2

or server version
http://www.kernel.org/pub/linux/kernel/people/ck/patches/cks/patch-2.6.16-c=
ks9.bz2

web:
http://kernel.kolivas.org

all patches:
http://www.kernel.org/pub/linux/kernel/people/ck/patches/

Split patches available.


Changes since 2.6.16-ck8:

Added:
 +sched-fix_idleprio.patch
A small bug crept in that prevented SCHED_IDLEPRIO tasks from being schedul=
ed=20
normally when they held a semaphore making it possible to livelock. This=20
fixes it.


Modified:
 -patch-2.6.16.11
 +patch-2.6.16.12
Resync with mainline

 -2.6.16-ck8-version.patch
 +2.6.16-ck9-version.patch
Version update

=2D-=20
=2Dck

--nextPart16636820.yGrfFDxt1E
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEV2DMZUg7+tp6mRURApRcAJ4z34UZLgvWUdvDdUHGEVEulF467QCglOPh
PPSclFZ53hH/FRzZmkhas2E=
=agUU
-----END PGP SIGNATURE-----

--nextPart16636820.yGrfFDxt1E--
