Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261493AbULYGbN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261493AbULYGbN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Dec 2004 01:31:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261494AbULYGbN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Dec 2004 01:31:13 -0500
Received: from mail21.syd.optusnet.com.au ([211.29.133.158]:47296 "EHLO
	mail21.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261493AbULYGbD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Dec 2004 01:31:03 -0500
Message-ID: <41CD091E.7070107@kolivas.org>
Date: Sat, 25 Dec 2004 17:30:54 +1100
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux <linux-kernel@vger.kernel.org>, CK Kernel <ck@vds.kolivas.org>
Subject: 2.6.10-ck1
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig36AA2FD07B1450EC36C5860C"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig36AA2FD07B1450EC36C5860C
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

These are patches designed to improve system responsiveness. It is 
configurable to any workload but the default ck1 patch is aimed at the 
desktop and ck1-server is available with more emphasis on serverspace.

http://ck.kolivas.org/patches/2.6/2.6.10/2.6.10-ck1/

web:
http://kernel.kolivas.org
all patches:
http://ck.kolivas.org/patches/


Full patchlist and descriptions:
.2.6.10_to_staircase9.2.diff
This is the latest version of the staircase cpu scheduler.

.schedrange.diff
.schedbatch2.6.diff
.schediso2.8.diff
Add batch scheduling (idle only scheduling) and low latency non 
privileged (isochronous) scheduling

.mwII.diff
(mapped watermark v2). Modify the virtual memory system to start 
clearing ram at a less full state and do so only lightly. This causes 
less system load while loading applications and ends up using swap much 
less.
	
.1g_lowmem1_i386.diff
Allow 1Gb of ram to be used without the overhead of enabling highmem 
support.

.defaultcfq.diff
Use the complete fair queueing I/O scheduler by default

.2.6.10-mingoll.diff
The low latency modifications currently in the -mm tree by Ingo Molnar

.cddvd-cmdfilter-drop.patch
Allow unprivileged users to burn cds/dvds until userspace applications 
catch up. Note your cd burning software must not be suid root for this 
to work.

.2.6.10-nvidia-fix.diff
A small compatibility change to allow the current version of the nvidia 
graphics card driver (6629) to work

.vm-pageout-throttling.patch
.inc_total_scanned.diff
Decrease the system cpu usage of heavy memory usage conditions

.fix_noswap.diff
Build fix for config without swap

.2610ck1-version.diff
version

and available as an addon:
.supermount-ng208-10ck1.diff
simplest way to have automounting removable media.


For those following the ck development, the time sliced cfq patch is 
currently not included in the so-called "official" ck release but will 
be available in the ckdev version until it's development stabilises.


Merry Xmas Cheers,
Con Kolivas


--------------enig36AA2FD07B1450EC36C5860C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBzQkgZUg7+tp6mRURAgKnAJ9LNCzPo77NRQOTZPbOIGdcZPVn9ACfdAHQ
Ue7LX5cA/fsWYAuV4baNepk=
=3ouV
-----END PGP SIGNATURE-----

--------------enig36AA2FD07B1450EC36C5860C--
