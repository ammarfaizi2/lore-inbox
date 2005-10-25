Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932133AbVJYLwQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932133AbVJYLwQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 07:52:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932134AbVJYLwQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 07:52:16 -0400
Received: from kokytos.rz.ifi.lmu.de ([141.84.214.13]:53911 "EHLO
	kokytos.rz.ifi.lmu.de") by vger.kernel.org with ESMTP
	id S932133AbVJYLwQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 07:52:16 -0400
From: Michael Brade <brade@informatik.uni-muenchen.de>
Organization: =?iso-8859-15?q?Universit=E4t?= =?iso-8859-15?q?_M=FCnchen?=, Institut =?iso-8859-15?q?f=FCr?= Informatik
To: "John Stoffel" <john@stoffel.org>
Subject: Re: ieee1394: sbp2: sbp2util_node_write_no_wait failed
Date: Tue, 25 Oct 2005 13:52:45 +0200
User-Agent: KMail/1.8.90
Cc: linux-kernel@vger.kernel.org
References: <200510241451.27320.brade@informatik.uni-muenchen.de> <200510241834.03948.brade@informatik.uni-muenchen.de> <17245.14997.891283.954480@smtp.charter.net>
In-Reply-To: <17245.14997.891283.954480@smtp.charter.net>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1939258.peuZhPZM5c";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200510251352.51418.brade@informatik.uni-muenchen.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1939258.peuZhPZM5c
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 24 October 2005 21:48, John Stoffel wrote:
> It works with USB, I don't know about firewire since I've just chucked
> that for now.  Which is why I got the dual input setup, USB/Firewire.
> Haven't tried the firewire on a Windows box either since the upgrade,
> might one of these days, but I'm in no rush.
Ok, just a little update as it might be interesting for others, too: yester=
day=20
a friend came surprisingly to my place because his server didn't work=20
properly (we worked till 4am...) and he brought a windows laptop! So I=20
searched a bit more and found a new firmware for the PL3507, dated Septembe=
r=20
2005, and flashed it.

But, alas, to no avail. The problem persists, when writing to the HD I get =
the=20
above error and the hd/kernel hangs for some time until it resumes. So my=20
guess is, this might really be a bug in our kernel and not the firmware?

And I haven't even mentioned yet that I have a DVD writer in an icybox as=20
well, I flashed this one too but still can't even *read* from any CD/DVD.=20
There the kernel hangs itself for a while and prints

kernel: ieee1394: sbp2: aborting sbp2 command
kernel: scsi3 : destination target 0, lun 0
kernel:         command: cdb[0]=3D0x28: 28 00 00 00 10 6f 00 00 01 00
kernel: ieee1394: sbp2: aborting sbp2 command
kernel: scsi3 : destination target 0, lun 0
kernel:         command: cdb[0]=3D0x0: 00 00 00 00 00 00
kernel: ieee1394: sbp2: reset requested
kernel: ieee1394: sbp2: Generating sbp2 fetch agent reset
kernel: ieee1394: sbp2: aborting sbp2 command
kernel: scsi3 : destination target 0, lun 0
kernel:         command: cdb[0]=3D0x0: 00 00 00 00 00 00
kernel: ieee1394: sbp2: reset requested
kernel: ieee1394: sbp2: Generating sbp2 fetch agent reset
kernel: ieee1394: sbp2: aborting sbp2 command
kernel: scsi3 : destination target 0, lun 0
kernel:         command: cdb[0]=3D0x0: 00 00 00 00 00 00
kernel: ieee1394: sbp2: reset requested
kernel: ieee1394: sbp2: Generating sbp2 fetch agent reset
kernel: ieee1394: sbp2: aborting sbp2 command
kernel: scsi3 : destination target 0, lun 0
kernel:         command: cdb[0]=3D0x0: 00 00 00 00 00 00
kernel: scsi: Device offlined - not ready after error recovery: host 3 chan=
nel=20
0 id 0 lun 0
kernel: sr 3:0:0:0: SCSI error: return code =3D 0x50000
kernel: end_request: I/O error, dev sr0, sector 16828
kernel: Buffer I/O error on device sr0, logical block 4207
kernel: scsi3 (0:0): rejecting I/O to offline device

Oh well. For now I most definitely have to look for the USB alternative.

Cheers,
=2D-=20
Michael Brade;                 KDE Developer, Student of Computer Science
  |-mail: echo brade !#|tr -d "c oh"|s\e\d 's/e/\@/2;s/$/.org/;s/bra/k/2'
  =B0--web: http://www.kde.org/people/michaelb.html

KDE 3: The Next Generation in Desktop Experience

--nextPart1939258.peuZhPZM5c
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBDXhyTdK2tAWD5bo0RAi6WAJ0TS2KcVxzLZf+7YSzrry3LIzHp0wCfRwBc
rh8Ozu0sz4NQkiDnFJTzqpI=
=vBVF
-----END PGP SIGNATURE-----

--nextPart1939258.peuZhPZM5c--
