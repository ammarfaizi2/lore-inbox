Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267072AbSKMAkR>; Tue, 12 Nov 2002 19:40:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267073AbSKMAkR>; Tue, 12 Nov 2002 19:40:17 -0500
Received: from Hell.WH8.tu-dresden.de ([141.30.225.3]:3033 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S267072AbSKMAkQ>; Tue, 12 Nov 2002 19:40:16 -0500
Date: Wed, 13 Nov 2002 01:47:04 +0100
From: "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>
To: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: VFAT mount (bug or feature?)
Message-Id: <20021113014704.780a3e4a.us15@os.inf.tu-dresden.de>
Organization: Disorganized
X-Mailer: Sylpheed version 0.8.5claws135 (GTK+ 1.2.10; Linux 2.5.47)
X-GPG-Key: 1024D/233B9D29 (wwwkeys.pgp.net)
X-GPG-Fingerprint: CE1F 5FDD 3C01 BE51 2106 292E 9E14 735D 233B 9D29
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1"; boundary="=.(/fj(THGg_4M:g"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.(/fj(THGg_4M:g
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


Hello,

In my /etc/fstab I have the following entry:

/dev/hda1  /win   vfat   defaults,umask=022  1 1

Why does 2.5.47 have user/group restricted permissions on the mount
point and all its subdirectories, despite the umask setting?

uas@Corona:~> uname -a
Linux Corona 2.4.20-rc1 #1 Tue Oct 29 23:39:44 CET 2002 i686 unknown
uas@Corona:~> ls -lad /win
drwxr-xr-x   22 root     root        16384 Jan  1  1970 /win


uas@Corona:~> uname -a
Linux Corona 2.5.47 #3 Mon Nov 11 20:02:05 CET 2002 i686 unknown
uas@Corona:~> ls -lad /win
drwxr--r--   22 root     root        16384 Jan  1  1970 /win

uas@Corona:~> mount --version
mount: mount-2.11w


Regards,
-Udo.

--=.(/fj(THGg_4M:g
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE90aEKnhRzXSM7nSkRAtZkAJ44WSZxLyCu9xdyJhPspmUVlGw1nACfcACb
ujE3oX8vJdTRRgz2ILGgxBs=
=afci
-----END PGP SIGNATURE-----

--=.(/fj(THGg_4M:g--
