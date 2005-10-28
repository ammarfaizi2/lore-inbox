Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965209AbVJ1LSf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965209AbVJ1LSf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 07:18:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965211AbVJ1LSf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 07:18:35 -0400
Received: from mail06.syd.optusnet.com.au ([211.29.132.187]:24223 "EHLO
	mail06.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S965209AbVJ1LSe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 07:18:34 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: 2.6.14-ck1
Date: Fri, 28 Oct 2005 21:18:09 +1000
User-Agent: KMail/1.8.3
Cc: ck@vds.kolivas.org, WU Fengguang <wfg@mail.ustc.edu.cn>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1399525.6Xh3GMeBY4";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200510282118.11704.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1399525.6Xh3GMeBY4
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

These are patches designed to improve system responsiveness and interactivi=
ty.=20
It is configurable to any workload but the default ck* patch is aimed at th=
e=20
desktop and ck*-server is available with more emphasis on serverspace.

Apply to 2.6.14
http://ck.kolivas.org/patches/2.6/2.6.14/2.6.14-ck1/patch-2.6.14-ck1.bz2

or server version
http://ck.kolivas.org/patches/2.6/2.6.14/2.6.14-ck1/patch-2.6.14-ck1-server=
=2Ebz2

web:
http://kernel.kolivas.org
all patches:
http://ck.kolivas.org/patches/
Split patches available.


Changes:

Added:
+adaptive-readahead-4.patch
We Fengguang's adaptive readahead patch. Please test and report experiences=
 -=20
Wu has been cc'ed on this email, please keep him cc'ed for reports.

+set_workqueue_nice-1.patch
Add a function to set workqueue nice levels

+dm-drop_kcryptd_prio.patch
Use the above function to set kcryptd priority to nice 0 since kcryptd=20
consumes massive amounts of cpu. This code is safe but I don't even know if=
=20
it's successfully changing priority yet.


Updated:
~2.6.14_to_staircase12.1.diff
Rolled up staircase tweaks

~mm-swap_prefetch-18.patch
Current version of swap prefetching. Stable!


=46ull patchlist:
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
vm-mapped.diff
vm-lots_watermark.diff
vm-background_scan-1.diff
mm-swap_prefetch-18.patch
set_workqueue_nice-1.patch
dm-drop_kcryptd_prio.patch
adaptive-readahead-4.patch
2614ck1-version.diff


Cheers,
Con

--nextPart1399525.6Xh3GMeBY4
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDYgjzZUg7+tp6mRURAvigAJ9YfX5vv3duUYiSI08rML4G8KYAEgCdGTk8
xq6HyX/elpepja1OdodfkbE=
=cnWF
-----END PGP SIGNATURE-----

--nextPart1399525.6Xh3GMeBY4--
