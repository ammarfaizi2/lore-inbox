Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267515AbUG3Bt6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267515AbUG3Bt6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 21:49:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267571AbUG3Bt6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 21:49:58 -0400
Received: from mail010.syd.optusnet.com.au ([211.29.132.56]:35560 "EHLO
	mail010.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S267515AbUG3Btv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 21:49:51 -0400
Message-ID: <4109A933.60203@kolivas.org>
Date: Fri, 30 Jul 2004 11:49:39 +1000
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: ck kernel mailing list <ck@vds.kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: 2.6.7-ck6
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig80BA160AE4F2259E3E577B4F"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig80BA160AE4F2259E3E577B4F
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Patchset update:

http://kernel.kolivas.org

These are patches designed to improve system responsiveness with 
specific emphasis on the desktop, but suitable/configurable to any 
workload. Read details and FAQ on my web page or feel free to email my 
mailing list with queries.

This version is a recommended performance and bugfix update for those 
already running ck5. It does not include any of the newer latency hacks 
etc in 2.6.8-rc* as this version (2.6.7-ck6) is to retain the stability 
already present in -ck5.

Added:
-cfq1.fix
-cfq2.fix
-cfq3.fix
-crq-fixes.diff
cfq io scheduler bugfixes
-hard_swappiness.diff
Make swappiness simpler and a hard limit

Updated:
-from_2.6.7_to_staircase7.E
Cpu scheduler policy rewrite updated with micro-optimisations and one 
bugfix which ensures new tasks wake up in the "foreground".
-schedbatch2.4.diff
Idle scheduling now supports cpu distribution between batch tasks 
according to nice and is safe with I/O and held semaphores.
-schediso2.4.diff
resync

Deleted:
-autoswap.diff
-vm_autoregulate2.diff
not necessary with hard swappiness


Complete list:
-from_2.6.7_to_staircase7.E
-schedrange.diff
-schedbatch2.4.diff
-schediso2.4.diff
-hard_swappiness.diff
-supermount-ng204.diff
-defaultcfq.diff
-config_hz.diff
-cfq1.fix
-cfq2.fix
-cfq3.fix
-cfq-bad-allocation2.fix
-crq-fixes.diff
-1100_ip_tables.patch
-1105_CAN-2004-0497.patch
-1110_proc.patch
-bootsplash-3.1.4-sp3-2.6.7.diff
-ck6version.diff


As always, please feel free to send comments, queries, suggestions, patches.

Cheers,
Con

--------------enig80BA160AE4F2259E3E577B4F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBCak1ZUg7+tp6mRURAmOEAJ41rfv6MLouvOLclsr9N1BfxNbxHACfZaiP
ncbY27H/sRe6EsdAzuwEoRo=
=1LvL
-----END PGP SIGNATURE-----

--------------enig80BA160AE4F2259E3E577B4F--
