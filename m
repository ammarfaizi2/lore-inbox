Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262654AbVDHCqC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262654AbVDHCqC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 22:46:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262657AbVDHCqC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 22:46:02 -0400
Received: from mail16.syd.optusnet.com.au ([211.29.132.197]:39826 "EHLO
	mail16.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S262654AbVDHCpk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 22:45:40 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       ck@vds.kolivas.org
Subject: 2.6.11-ck4
Date: Fri, 8 Apr 2005 12:45:46 +1000
User-Agent: KMail/1.8
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1232059.0KEPQvUf3f";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200504081245.48577.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1232059.0KEPQvUf3f
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

These are patches designed to improve system responsiveness. It is=20
configurable to any workload but the default ck* patch is aimed at the=20
desktop and ck*-server is available with more emphasis on serverspace.

Apply to 2.6.11:
http://ck.kolivas.org/patches/2.6/2.6.11/2.6.11-ck4/patch-2.6.11-ck4.bz2
http://ck.kolivas.org/patches/2.6/2.6.11/2.6.11-ck4/patch-2.6.11-ck4-server=
=2Ebz2

web:
http://kernel.kolivas.org
all patches:
http://ck.kolivas.org/patches/
Split patches available.


Changes since 2.6.11-ck2 (last public announcement):

Changed:
~schediso2.12.diff
Small policy fix to ensure real time tasks without privileges get dropped t=
o=20
SCHED_ISO


Added:
+cfq-ts21-fix1.diff
+cfq-ts21-fix2.diff
Two small cfq bugfixes

+s10.6_s10.7.diff
Micro-optimisations for staircase cpu scheduler

+patch-2.6.11.7
Latest stable version

+2611ck4-version.diff
Version


Removed:
=2Dnvidia_6111-6629_compat2.diff
Nvidia compatibility no longer required with new nvidia driver

=2Dpatch-2.6.11.1
=2Dpatch-2.6.11.2
=2D2611ck2-version.diff
obvious


=46ull patchlist:
 2.6.11_to_staircase10.5.diff
 s10.5_s10.6.diff
 s10.6_s10.7.diff
Latest version of the staircase O(1) single priority array=20
foreground-background cpu scheduler

 schedrange.diff
Eases addition of scheduling policies

 schedbatch2.7.diff
Idle cpu scheduling

 schediso2.12.diff
Unprivileged low latency cpu scheduling

 mapped_watermark3.diff
Lighter memory scanning under light loads and far less swapping

 1g_lowmem1_i386.diff
Support 1GB of memory without enabling HIGHMEM

 cddvd-cmdfilter-drop.patch
Support normal user burning of cds

 cfq-ts-21.diff
 cfq-ts21-fix.diff
 cfq-ts21-fix1.diff
 cfq-ts21-fix2.diff
Complete fair queueing timeslice i/o scheduler v21

 defaultcfq.diff
Enable the cfq I/O scheduler by default (-ck)

default_deadline.diff=20
Enable the deadline I/O scheduler by default (-server)

 isobatch_ionice2.diff
Support for i/o priorities suitable for SCHED_ISO and SCHED_BATCH tasks

 rt_ionice.diff
Support for i/o priority suitable for real time tasks

 patch-2.6.11.7
The latest stable tree.

 2611ck4-version.diff
Version

and available separately in the patches/ dir as an addon:
 supermount-ng208-2611.diff
Simplest way to automount removable media


And don't forget to pour one of these before booting this kernel:
http://ck.kolivas.org/patches/2.6/2.6.11/cognac.JPG


Cheers,
Con
=20

--nextPart1232059.0KEPQvUf3f
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBCVfBcZUg7+tp6mRURAvJSAJ9HeeaW9y5hbtzF16aeASMjM5piIgCfaTZY
PEXBy1VnG7iHRQ1wlTfXsCo=
=1QJ/
-----END PGP SIGNATURE-----

--nextPart1232059.0KEPQvUf3f--
