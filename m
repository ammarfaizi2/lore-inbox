Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261225AbUKEWOO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261225AbUKEWOO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 17:14:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261235AbUKEWOO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 17:14:14 -0500
Received: from mail08.syd.optusnet.com.au ([211.29.132.189]:8884 "EHLO
	mail08.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261225AbUKEWNz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 17:13:55 -0500
Message-ID: <418BFB1B.3040306@kolivas.org>
Date: Sat, 06 Nov 2004 09:13:47 +1100
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux <linux-kernel@vger.kernel.org>, CK Kernel <ck@vds.kolivas.org>
Subject: 2.6.9-ck3
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig941352069305138161615C08"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig941352069305138161615C08
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

These are patches designed to improve system responsiveness with
specific emphasis on the desktop, but configurable to any workload.

http://ck.kolivas.org/patches/2.6/2.6.9/2.6.9-ck3/patch-2.6.9-ck3.bz2

web:
http://kernel.kolivas.org
all patches:
http://ck.kolivas.org/patches/


Added:
  +buildfix.diff
This was accidentally removed from ck2 so it has been readded. Prevents 
"internal compiler error" with certain versions of gcc.

  +s9.0_s9.1.diff
An update to the staircase cpu scheduler for a long standing bug I 
recently discovered whereby tasks could drop to low priority for long 
periods and have sustained periods of high latency and low cpu usage.

  +2.6.9-oom-kill-fix.patch
A fix for the trigger happy out-of-memory killer that seemed to go mad 
in 2.6.9

  +2.6.9-aic7xxx-fix.patch
  +2.6.9-net-DOS-fix.patch
  +2.6.9-smbfs-leak-fix.patch
  +2.6.9-cpia-deadlock-fix.patch
  +2.6.9-usb-visor-fix.patch
  +2.6.9-hpt366-fix.patch
  +2.6.9-parport_pc-unload-fix.patch
  +2.6.9-i8xx_tco-reboot-fix.patch
  +2.6.9-ppp-fix.patch
Miscellaneous fixes from the -ac patchset.


Full Patchlist:

2.6.9_to_staircase9.0.diff
schedrange.diff
schedbatch2.5.diff
schediso2.8.diff
mwII.diff
mwII-oc.diff
1g_lowmem1_i386.diff
cfq2-20041019.patch
block_fix.diff
defaultcfq.diff
269rc4-mingo_ll.diff
back-sched-net-fix-scheduling-latencies-in-__release_sock.patch
269rc4-mingo-bkl.diff
ll-config1.diff
cddvd-cmdfilter-drop.patch
nvidia_compat.diff
fix-bad-segment-coalescing-in-blk_recalc_rq_segments.patch
vm-pages_scanned-active_list.patch
buildfix.diff
s9.0_s9.1.diff
2.6.9-oom-kill-fix.patch
2.6.9-aic7xxx-fix.patch
2.6.9-net-DOS-fix.patch
2.6.9-smbfs-leak-fix.patch
2.6.9-cpia-deadlock-fix.patch
2.6.9-usb-visor-fix.patch
2.6.9-hpt366-fix.patch
2.6.9-parport_pc-unload-fix.patch
2.6.9-i8xx_tco-reboot-fix.patch
2.6.9-ppp-fix.patch
269ck3-version.diff


Cheers,
Con


--------------enig941352069305138161615C08
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBi/sbZUg7+tp6mRURAijXAJ9S/IBNyHqVgOOzQ94T+PIjhJCStwCgi/o1
o54/MecrwYTOo3te/4Kb8xw=
=IwWC
-----END PGP SIGNATURE-----

--------------enig941352069305138161615C08--
