Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266687AbUHONf1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266687AbUHONf1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 09:35:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266686AbUHONf1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 09:35:27 -0400
Received: from mail015.syd.optusnet.com.au ([211.29.132.161]:37049 "EHLO
	mail015.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S266687AbUHONfD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 09:35:03 -0400
Message-ID: <411F6679.5080008@kolivas.org>
Date: Sun, 15 Aug 2004 23:34:49 +1000
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       ck kernel mailing list <ck@vds.kolivas.org>
Subject: 2.6.8.1-ck1
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigEDF1A3A8D57B6152D33D4684"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigEDF1A3A8D57B6152D33D4684
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Patchset update.

These are patches designed to improve system responsiveness with 
specific emphasis on the desktop, but configurable to any workload.

Web site with faq:
http://kernel.kolivas.org
Patches:
http://ck.kolivas.org/patches/2.6/2.6.8.1/2.6.8.1-ck1/


Added since 2.6.7-ck6:

+sched-adjust-p4gain
tiny p4HT nice handling optimisation
+1g_lowmem_i386.diff
Allows 1Gb of ram to be used without enabling highmem
+kiflush1.diff
A slow cache clearing memory defragmenter for desktop (see web page 
faq); *Rather unorthodox and orthogonal thing to do but is beneficial on 
the desktop*.
+token-thrashing-control.patch
Rik's swap-thrash control patches
+*latency*
A number of low latency hacks from Andrew Morton


Changed:
~from_2.6.8.1_to_staircase7.I
Staircase scheduler updated to latest
~schediso2.5.diff
Tiny sched_iso change for optimal compatibility with s7.I
~hard_swappiness1.diff
A tiny relaxation of the "hard swappiness" algorithm to allow mapped 
pages to swap out below the vm_swappiness watermark if extreme memory 
pressure is occurring (prevents oom).


Merged:
~cfq1.fix
~cfq2.fix
~cfq3.fix
~cfq-bad-allocation2.fix
~crq-fixes.diff
~1100_ip_tables.patch
~1105_CAN-2004-0497.patch
~1110_proc.patch


Removed:
-bootsplash-3.1.4-sp3-2.6.7.diff
Framebuffer code changed too dramatically and code getting difficult (ie 
a lot of work) to merge safely in current state.


Full Patches:
from_2.6.8.1_to_staircase7.I
schedrange.diff
schedbatch2.4.diff
schediso2.5.diff
sched-adjust-p4gain
hard_swappiness1.diff
supermount-ng204.diff.bz2
defaultcfq.diff
config_hz.diff
1g_lowmem_i386.diff
kiflush1.diff
token-thrashing-control.patch
__cleanup_transaction-latency-fix.patch
filemap_sync-latency-fix.patch
jbd-recovery-latency-fix.patch
journal_clean_checkpoint_list-latency-fix.patch
kjournald-smp-latency-fix.patch
prune_dcache-latency-fix.patch
slab-latency-fix.patch
truncate_inode_pages-latency-fix.patch
unmap_vmas-smp-latency-fix.patch
9000-SuSE-117-writeback-lat.patch
2.6.8.1-ck1-version.diff


Cheers,
Con

--------------enigEDF1A3A8D57B6152D33D4684
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBH2Z8ZUg7+tp6mRURAqa7AJwINAXA9aK4x/nrNnaFH3nc8xf3awCeMqo2
ifbrWHA0QIAHOhgacQ9HVEI=
=kV2c
-----END PGP SIGNATURE-----

--------------enigEDF1A3A8D57B6152D33D4684--
