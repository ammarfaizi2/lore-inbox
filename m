Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261308AbVAROW6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261308AbVAROW6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 09:22:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261307AbVAROWr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 09:22:47 -0500
Received: from mail12.syd.optusnet.com.au ([211.29.132.193]:35297 "EHLO
	mail12.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261309AbVAROVt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 09:21:49 -0500
Message-ID: <41ED1B74.8040008@kolivas.org>
Date: Wed, 19 Jan 2005 01:21:40 +1100
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux kernel <linux-kernel@vger.kernel.org>,
       ck kernel <ck@vds.kolivas.org>
Subject: 2.6.10-ck5
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig39527BBAA6F1C249330777A3"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig39527BBAA6F1C249330777A3
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

These are patches designed to improve system responsiveness. It is 
configurable to any workload but the default ck* patch is aimed at the 
desktop and ck*-server is available with more emphasis on serverspace.

http://ck.kolivas.org/patches/2.6/2.6.10/2.6.10-ck5/

web:
http://kernel.kolivas.org
all patches:
http://ck.kolivas.org/patches/

This is a maintenance release concentrating on getting a stable and 
hopefully last 2.6.10 release.

A lot of instability manifested by processes stuck in D was caused by 
the early adoption of cfq-timeslices with priority support. This project 
is very exciting, but is not yet suitable for a stable patchset.

Note that gamers are reporting very good audio performance with 
staircase10.3 and higher even on cedega/wineX games.


Removed:
-inc_total_scanned.diff
-2.6.10-capabilities_fix.diff
-linux-2.6.7-CAN-2004-1056.patch
-linux-2.6.9-smbfs.patch
-2.6.10-mm1-brk-locked.patch
-random-poolsize-int-overflow.diff
-rlimit-memlock-dos.diff
-scsi-int-overflow-information-leak.diff
-moxa-int-overflow.diff
All rolled up with -as patchset

-cfq-ts-20.diff
-isobatch_ionice.diff
-rt_ionice.diff
-cfq_writeprio_on.diff
The cfq timeslices patch and related changes


Added:
+patch-2.6.10-as2
The nifty -as patchset containing security and obvious fixes.

+s10.3_s10.4.diff
+s10.4_s10.5.diff
Updated staircase code.


Full patchlist:
patch-2.6.10-as2
2.6.10_to_staircase9.2.diff
schedrange.diff
schedbatch2.6.diff
schediso2.8.diff
mwII.diff
1g_lowmem1_i386.diff
defaultcfq.diff
2.6.10-mingoll.diff
cddvd-cmdfilter-drop.patch
vm-pageout-throttling.patch
nvidia_6111-6629_compat2.diff
fix-ll-resume.diff
s9.2_s9.3.diff
i2.8_i2.9.diff
s9.3_s9.4.diff
i2.9_i2.10.diff
b2.6_b2.7.diff
s9.4_s10.diff
s10_test1.diff
s10_s10.1.diff
s10.1_s10.2.diff
s10.2_s10.3.diff
1504_vmscan-writeback-pages.patch
s10.3_s10.4.diff
s10.4_s10.5.diff
2610ck5-version.diff

and available in patches/ separately:
supermount-ng208-10ck5.diff


Cheers,
Con

--------------enig39527BBAA6F1C249330777A3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB7Rt0ZUg7+tp6mRURAnCrAJ9gczdOh4KzTUleFZsDzki8bThjqwCgjrxn
WWukjT/hN08P+VZQR86yOaw=
=efyO
-----END PGP SIGNATURE-----

--------------enig39527BBAA6F1C249330777A3--
