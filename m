Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266170AbUH0Paq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266170AbUH0Paq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 11:30:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266006AbUH0P25
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 11:28:57 -0400
Received: from mail19.syd.optusnet.com.au ([211.29.132.200]:17105 "EHLO
	mail19.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S266188AbUH0P0r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 11:26:47 -0400
Message-ID: <412F52B1.6030008@kolivas.org>
Date: Sat, 28 Aug 2004 01:26:41 +1000
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       ck kernel mailing list <ck@vds.kolivas.org>
Subject: 2.6.8.1-ck5
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigCDEC123BF066C5392AA32C84"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigCDEC123BF066C5392AA32C84
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Patchset update. These are patches designed to improve system 
responsiveness with specific emphasis on the desktop, but configurable 
to any workload.

Web site with faq:
http://kernel.kolivas.org
Patches (with split-out also):
http://ck.kolivas.org/patches/2.6/2.6.8.1/2.6.8.1-ck5/


Added since ck4:
+s8.0_s8.1
Sync with latest staircase patch. Tiny fix affecting very short running 
tasks that use a lot of cpu (like xmame).

+mapped_watermark_fix.diff
+sc_mw.diff
Mapped watermark was released a touch too early and was too aggressive 
leading to an oom easily. These fix that, make it more efficient and 
make it possible to properly inactivate it by setting mapped to 0.

+1g_change_config.diff
Change the 1Gb lowmem so that the default is off (thanks for suggestion 
Michael Buesch)


Full patchlist:
from_2.6.8.1_to_staircase8.0.bz2
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
supermount-ng204.diff.bz2
fbsplash-0.9-r5-2.6.8-rc3.patch.bz2
make-tree_lock-an-rwlock.patch.bz2
invalidate_inodes-speedup.patch
2.6.8.1-mm2-reiser4.diff.bz2
s8.0_s8.1
mapped_watermark_fix.diff
sc_mw.diff
1g_change_config.diff
2.6.8.1-ck5-version.diff


Cheers,
Con

--------------enigCDEC123BF066C5392AA32C84
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBL1KxZUg7+tp6mRURAtZyAJ0cHT8cyx5+v2ZQnpL9GO2JkNMnTwCfRyhk
0c4zrLKHdY8zcR3yaUajRaU=
=depM
-----END PGP SIGNATURE-----

--------------enigCDEC123BF066C5392AA32C84--
