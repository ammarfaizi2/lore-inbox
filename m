Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267793AbUIJEDK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267793AbUIJEDK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 00:03:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267999AbUIJEDK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 00:03:10 -0400
Received: from mail01.syd.optusnet.com.au ([211.29.132.182]:29160 "EHLO
	mail01.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S267793AbUIJEC7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 00:02:59 -0400
Message-ID: <41412765.4010005@kolivas.org>
Date: Fri, 10 Sep 2004 14:02:45 +1000
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       ck kernel mailing list <ck@vds.kolivas.org>
Subject: 2.6.8.1-ck7
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig039FE8B8ABC1D6D288F07AED"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig039FE8B8ABC1D6D288F07AED
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

These are patches designed to improve system responsiveness with 
specific emphasis on the desktop, but configurable to any workload.

http://ck.kolivas.org/patches/2.6/2.6.8.1/2.6.8.1-ck7/patch-2.6.8.1-ck7.bz2

web:
http://kernel.kolivas.org
all patches:
http://ck.kolivas.org/patches/
Split patches and a server specific patch available.


Added since ck5 (last announced release):
-change_reiser4_config.diff
Make default reiser 4 off and not configurable if 4k stacks is on

-lenient_uw.diff
Mapped watermark was too aggressive with freeing ram. Balance is just 
about right with this being a watermark just above "high" used by kswapd

-s8.1_test1
-s8.1test1_test2
-s8.1_smtfix
Numerous small fixes for the staircase code to not fool the "burst" 
mechanism. This helps simulated hardware (wine, mame, zsnes) a lot.

-write-barriers.patch
File system write barriers added for cfq2

-cfq_iosched_v2.patch
Updated Completely Fair Queueing I/O scheduler by Jens Axboe

-vesafb-tng-0.9-rc4-r2-2.6.8.1.patch
New vesa framebuffer for more modes at console and changing resolution 
on the fly
-vesafb_change_config.diff
Make the default off for compatibility purposes.

-back_journal_clean_checkpoint_list-latency-fix.patch
A small latency hack by akpm was found to be questionable; back it out.
-2.6.8.1-ck7-version.diff


Changed:
-supermount-ng205.diff
Compile fixes for gcc3.4+


Full patch list:

from_2.6.8.1_to_staircase8.0
schedrange.diff
schedbatch2.4.diff
schediso2.5.diff
sched-adjust-p4gain
mapped_watermark.diff
defaultcfq.diff
config_hz.diff
1g_lowmem_i386.diff
akpm-latency-fix.patch
9000-SuSE-117-writeback-lat.patch
cddvd-cmdfilter-drop.patch
cool-spinlocks-i386.diff
bio_uncopy_user-mem-leak.patch
bio_uncopy_user2.diff
ioport-latency-fix-2.6.8.1.patch
supermount-ng205.diff
fbsplash-0.9-r5-2.6.8-rc3.patch
make-tree_lock-an-rwlock.patch
invalidate_inodes-speedup.patch
2.6.8.1-mm2-reiser4.diff
change_reiser4_config.diff
s8.0_s8.1
mapped_watermark_fix.diff
sc_mw.diff
1g_change_config.diff
lenient_uw.diff
s8.1_test1
s8.1test1_test2
s8.1_smtfix
write-barriers.patch
cfq_iosched_v2.patch
vesafb-tng-0.9-rc4-r2-2.6.8.1.patch
vesafb_change_config.diff
back_journal_clean_checkpoint_list-latency-fix.patch
2.6.8.1-ck7-version.diff


Cheers,
Con Kolivas

--------------enig039FE8B8ABC1D6D288F07AED
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBQSdrZUg7+tp6mRURAkGuAJsHclDlDK5GHg8iMc8onx4RqrkW9QCdH4sI
ddd+rMVKe8FDsDKqi2EjZlU=
=Nx4X
-----END PGP SIGNATURE-----

--------------enig039FE8B8ABC1D6D288F07AED--
