Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263142AbUDEGZS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 02:25:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263143AbUDEGZS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 02:25:18 -0400
Received: from smtp1.adl2.internode.on.net ([203.16.214.181]:61445 "EHLO
	smtp1.adl2.internode.on.net") by vger.kernel.org with ESMTP
	id S263142AbUDEGZM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 02:25:12 -0400
Subject: 2.6.5-as1, and ck staircase5.2 seperatly
From: Antony Suter <suterant@users.sourceforge.net>
To: List LKML <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-LRzLQt0pjr8Xr2pHVwIp"
Message-Id: <1081146303.9127.44.camel@hikaru.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 05 Apr 2004 16:25:03 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-LRzLQt0pjr8Xr2pHVwIp
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Resyncing for 2.6.5. An update here is AA rounding off some very nice VM
work.

One of my aims is to keep CK's new staircase cpu scheduler in sync with
the current kernel, for people to play with more easily, while he is
away for 2 months. So it is here as a seperate download as well.

Patches applied on a base of linux-2.6.5:
- Con Kolivas' alternate staircase cpu scheduler 5.2
- Jens Axboe's cfq io scheduler
- Andrea Archangeli's 2.6.5-aa1.bz2
- William Lee Irwin III's patches from linux-2.6.0-test11-wli-1 {
    - #17 convert copy_strings() to use kmap_atomic() instead of kmap()
    - #19 node-local i386 per_cpu areas
    - #22 increase static vfs hashtable and VM array sizes
    - #24 /proc/ BKL gunk plus page wait hashtable sizing adjustment
    - #25 invalidate_inodes() speedup
}

Linqs:
http://www.users.on.net/sutera/2.6.5-as1.patch.gz
http://www.users.on.net/sutera/2.6.5-as1.patch.gz.sign
http://www.users.on.net/sutera/ck-2.6.5-staircase5.2.patch.gz
http://www.users.on.net/sutera/ck-2.6.5-staircase5.2.patch.gz.sign

For best desktop performance, compile with PREEMPT on, and run with
"elevator=3Dcfq" on your kernel command line.

--=20
- Antony Suter  (suterant users sourceforge net)  "Bonta"
- "...through shadows falling, out of memory and time..."

--=-LRzLQt0pjr8Xr2pHVwIp
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAcPu/Zu6XKGV+xxoRAmDNAJ9j+h3tmraPR5MngOd5J/KuSYIg7wCfXUo3
VZL10RMSM24+QT00DkMa0JA=
=bFrc
-----END PGP SIGNATURE-----

--=-LRzLQt0pjr8Xr2pHVwIp--

