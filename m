Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965041AbWCULTZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965041AbWCULTZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 06:19:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965044AbWCULTZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 06:19:25 -0500
Received: from hs-grafik.net ([80.237.205.72]:32267 "EHLO hs-grafik.net")
	by vger.kernel.org with ESMTP id S965043AbWCULTY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 06:19:24 -0500
From: Alexander Gran <alex@zodiac.dnsalias.org>
To: Andrew Morton <akpm@osdl.org>
Subject: Bug on unmounting in 2.6.16-rc6-mm2
Date: Tue, 21 Mar 2006 12:19:09 +0100
User-Agent: KMail/1.9.1
X-Face: ){635DT*1Z+Z}$~Bf[[i"X:f2i+:Za[:Q0<UzyJPoAm(;y"@=?utf-8?q?LwMhWM4=5D=60x1bDaQDpet=3B=3Be=0A=09N=5CBIb8o=5BF!fdHrI-=7E=24?=
 =?utf-8?q?ctS=3F!?=,U+0}](xD}_b]awZrK=>753Wk;RwhCU`Bt(I^/Jxl~5zIH<
 =?utf-8?q?=0A=09XplI=3A9GKEcr/JPqzW=3BR=5FqDQe*=23CE=7E70=3Bj=25Hg8CNh*4?=<
Cc: linux-kernel@vger.kernel.org, reiserfs@namesys.com
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3366424.ZRJJqBo9yM";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200603211219.14115@zodiac.zodiac.dnsalias.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart3366424.ZRJJqBo9yM
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

when I shutdown (and umount) my system, I got a kernel bug:
Screenshots:
http://zodiac.dnsalias.org/misc/2.6.16-rc6-mm2/Foto_032106_001.jpg
http://zodiac.dnsalias.org/misc/2.6.16-rc6-mm2/Foto_032106_002.jpg
http://zodiac.dnsalias.org/misc/2.6.16-rc6-mm2/Foto_032106_003.jpg
http://zodiac.dnsalias.org/misc/2.6.16-rc6-mm2/Foto_032106_004.jpg
http://zodiac.dnsalias.org/misc/2.6.16-rc6-mm2/Foto_032106_005.jpg
dmesg:
http://zodiac.dnsalias.org/misc/2.6.16-rc6-mm2/dmesg
config:
http://zodiac.dnsalias.org/misc/2.6.16-rc6-mm2/config
mount:
moalex@t40:~$ mount
/dev/hda6 on / type reiser4 (rw,noatime)
proc on /proc type proc (rw)
sysfs on /sys type sysfs (rw)
usbfs on /proc/bus/usb type usbfs (rw)
tmpfs on /dev/shm type tmpfs (rw)
devpts on /dev/pts type devpts (rw,gid=3D5,mode=3D620)
/dev/hda2 on /boot type ext3 (ro,noatime)
/dev/hda4 on /home type reiser4 (rw,noatime)
/dev/hda7 on /files type ext3 (rw,noatime,commit=3D600)
tmpfs on /dev type tmpfs (rw,size=3D10M,mode=3D0755)

Sorry for the inconvenience, but I've got no OCR at hand ;)

regards
Alex
=2D-=20
Encrypted Mails welcome.
PGP-Key at http://zodiac.dnsalias.org/misc/pgpkey.asc | Key-ID: 0x6D7DD291

--nextPart3366424.ZRJJqBo9yM
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBEH+Ey/aHb+2190pERAtnQAJ94MXummb50asRXSVH/ll+r7I8pcACfQUl9
NW4Dso2Z9dJNASEZ1UQCxRk=
=gD9H
-----END PGP SIGNATURE-----

--nextPart3366424.ZRJJqBo9yM--
