Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262296AbVCSA2C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262296AbVCSA2C (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 19:28:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262298AbVCSA2C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 19:28:02 -0500
Received: from hs-grafik.net ([80.237.205.72]:41489 "EHLO hs-grafik.net")
	by vger.kernel.org with ESMTP id S262296AbVCSA16 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 19:27:58 -0500
From: Alexander Gran <alex@zodiac.dnsalias.org>
To: linux-kernel@vger.kernel.org
Subject: [2.6.11-mm3] umount: Scheduling while atomic
Date: Sat, 19 Mar 2005 01:27:52 +0100
User-Agent: KMail/1.7.2
X-Need-Girlfriend: always
X-Ignorant-User: yes
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart4070415.JKGCU2XvVs";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200503190127.54669@zodiac.zodiac.dnsalias.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart4070415.JKGCU2XvVs
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

while umounting an ext2 partition on a usb hdd I'm getting:
scheduling while atomic: umount/0x10000001/14941
 [<c0451392>] schedule+0x5f2/0x600
 [<c0451cc7>] cond_resched+0x27/0x40
 [<c0140af1>] invalidate_mapping_pages+0x81/0xe0
 [<c015b27d>] kill_bdev+0xd/0x20
 [<c015b315>] __set_blocksize+0x85/0xa0
 [<c015bba0>] __bd_release+0x70/0x80
 [<c015c458>] __close_bdev_excl+0x8/0x10
 [<c015a100>] deactivate_super+0x50/0x80
 [<c016f82b>] sys_umount+0x3b/0x90
 [<c0148c20>] do_munmap+0x120/0x150
 [<c016f895>] sys_oldumount+0x15/0x20
 [<c010300b>] sysenter_past_esp+0x54/0x75

regards
Alex
=2D-=20
Encrypted Mails welcome.
PGP-Key at http://zodiac.dnsalias.org/misc/pgpkey.asc | Key-ID: 0x6D7DD291

--nextPart4070415.JKGCU2XvVs
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBCO3IK/aHb+2190pERAo2+AKCpyi6Q6ExwxlMqt+YfWWpco6Q82ACdFXzT
zpzYBuxNCLDl4EnJNsLoEhY=
=V3+E
-----END PGP SIGNATURE-----

--nextPart4070415.JKGCU2XvVs--
