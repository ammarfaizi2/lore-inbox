Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276439AbRJGQlh>; Sun, 7 Oct 2001 12:41:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276434AbRJGQl1>; Sun, 7 Oct 2001 12:41:27 -0400
Received: from front1.mail.megapathdsl.net ([66.80.60.31]:22284 "EHLO
	front1.mail.megapathdsl.net") by vger.kernel.org with ESMTP
	id <S276408AbRJGQlN>; Sun, 7 Oct 2001 12:41:13 -0400
Subject: System log is filling up with "VFS: Disk change detected on device
	sr(11,1)" messages
From: Miles Lane <miles@megapathdsl.net>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-A52eU6efFxixnx95ujnk"
X-Mailer: Evolution/0.15.99 (Preview Release)
Date: 07 Oct 2001 09:33:21 -0700
Message-Id: <1002472401.1660.45.camel@stomata.megapathdsl.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-A52eU6efFxixnx95ujnk
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

My /var/log/messages is getting consistently flooded with these
messages:

   VFS: Disk change detected on device sr(11,1)
   VFS: Disk change detected on device sr(11,1)
   VFS: Disk change detected on device sr(11,0)
   VFS: Disk change detected on device sr(11,0)

Any idea why this is happening and what I can do to make it
shut up?  There is no CD in either drive.

SCSI storage controller: Adaptec AHA-2930CU (rev 03)

scsibus0:
   0,0,0   0) PIONEER  DVD-ROM DVD-114 1.17  Removable CD-ROM
   0,1,0   1) IDE-CD   R/RW 4x4x24     1.08  Removable CD-ROM

Module                  Size  Used by
sg                     25860   0  (autoclean)
sr_mod                 14232   0  (autoclean)
cdrom                  28032   0  (autoclean) [sr_mod]
ide-scsi                8512   0=20
scsi_mod               94596   3  [sg sr_mod ide-scsi]

Thanks,
	Miles

--=-A52eU6efFxixnx95ujnk
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA7wIPRGA0upctnsdQRAgBhAJ9aV6I9yjyeBlYnMT48yM3L8uaqZQCfRV3e
keDRwoGi9NetYV+KZBuHRWs=
=nE0Q
-----END PGP SIGNATURE-----

--=-A52eU6efFxixnx95ujnk--

