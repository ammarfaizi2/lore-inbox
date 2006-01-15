Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751892AbWAOKGc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751892AbWAOKGc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 05:06:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751894AbWAOKGc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 05:06:32 -0500
Received: from mail07.syd.optusnet.com.au ([211.29.132.188]:54935 "EHLO
	mail07.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751892AbWAOKGb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 05:06:31 -0500
From: Con Kolivas <kernel@kolivas.org>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: 2.6.15-ck2
Date: Sun, 15 Jan 2006 21:06:20 +1100
User-Agent: KMail/1.9
Cc: ck list <ck@vds.kolivas.org>
MIME-Version: 1.0
X-Length: 1152
Content-Type: multipart/signed;
  boundary="nextPart1743625.cOTkqz8chW";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200601152106.22498.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1743625.cOTkqz8chW
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
http://ck.kolivas.org/patches/2.6/2.6.15/2.6.15-ck2/patch-2.6.15-ck2.bz2

or server version
http://ck.kolivas.org/patches/cks/patch-2.6.15-cks2.bz2

web:
http://kernel.kolivas.org
all patches:
http://ck.kolivas.org/patches/
Split patches available.

*NOTE*
If you're looking for the 1GB lowmem option it has been replaced and you=20
should choose the following in menuconfig for the same effect:
( ) 3G/1G user/kernel split
(X) 3G/1G user/kernel split (for full 1G low memory)
( ) 2G/2G user/kernel split
( ) 1G/3G user/kernel split


Changes
Added:
 +sched-staircase13.2_13.3.patch
Microoptimisations (thanks Andreas Mohr) and patch merge typofix.

 +vmsplit-config_options.patch
Added the variable memory split config option which is going to be part of=
=20
mainline. This allows up to 3GB lowmem without enabling highmem depending o=
n=20
the split you choose.

 +dynticks-i386_only_config.patch
CONFIG_NO_IDLE_HZ should only exist for x86_32

 +patch-2.6.15.1.bz2
Latest stable bug and security fixes


Modified:
 -schedrange.diff
 -schedbatch2.10.diff
 -sched-iso3.2.patch
 +schedrange-1.diff
 +schedbatch-2.11.diff
 +sched-iso3.3.patch
Patch merge typofix and microoptimisation


 -2615ck1-version.patch
 +2615ck2-version.patch
Version


Removed:
 -1g_lowmem1_i386.diff
No longer needed with multiple vmsplit configs


Cheers,
Con

--nextPart1743625.cOTkqz8chW
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDyh6eZUg7+tp6mRURAtXMAJ0R0HoV8lHxbfeTzYkr1KFAIJDZvQCeItke
tkY+Tsv2yW8mm+HBV7jh/mg=
=zY7r
-----END PGP SIGNATURE-----

--nextPart1743625.cOTkqz8chW--
