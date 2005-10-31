Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964789AbVJaSwz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964789AbVJaSwz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 13:52:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932484AbVJaSwz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 13:52:55 -0500
Received: from kokytos.rz.ifi.lmu.de ([141.84.214.13]:39912 "EHLO
	kokytos.rz.ifi.lmu.de") by vger.kernel.org with ESMTP
	id S932482AbVJaSwz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 13:52:55 -0500
From: Michael Brade <brade@informatik.uni-muenchen.de>
Organization: =?iso-8859-15?q?Universit=E4t?= =?iso-8859-15?q?_M=FCnchen?=, Institut =?iso-8859-15?q?f=FCr?= Informatik
To: "John Stoffel" <john@stoffel.org>
Subject: Re: ieee1394: sbp2: sbp2util_node_write_no_wait failed
Date: Mon, 31 Oct 2005 19:52:45 +0100
User-Agent: KMail/1.8.90
Cc: linux-kernel@vger.kernel.org
References: <200510241451.27320.brade@informatik.uni-muenchen.de> <200510241834.03948.brade@informatik.uni-muenchen.de> <17245.14997.891283.954480@smtp.charter.net>
In-Reply-To: <17245.14997.891283.954480@smtp.charter.net>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1234537.C2vXMBAkM0";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200510311952.49129.brade@informatik.uni-muenchen.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1234537.C2vXMBAkM0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Alright, very bad news:

On Monday 24 October 2005 21:48, John Stoffel wrote:
> Yeah, from what I've been reading, the Prolific chipset sucked even
> for Windows users, at least until the latest firmware.
Because of this I gave my prolific stuff back (they actually took it back,=
=20
great) and got an Oxford 911. I *STILL* get the same kind of errors though!=
=20
Here's what the syslog says again:

kernel: ieee1394: The root node is not cycle master capable; selecting a ne=
w=20
root node and resetting.
kernel: ieee1394: Error parsing configrom for node 0-00:1023
kernel: ieee1394: Node changed: 0-00:1023 -> 0-01:1023
kernel: ieee1394: Node added: ID:BUS[0-00:1023]  GUID[0030e001e0454647]
kernel: SCSI subsystem initialized
kernel: sbp2: $Rev: 1306 $ Ben Collins <bcollins@debian.org>
kernel: ieee1394: sbp2: Driver forced to serialize I/O (serialize_io=3D1)
kernel: ieee1394: sbp2: Try serialize_io=3D0 for better performance
kernel: scsi0 : SCSI emulation for IEEE-1394 SBP-2 Devices
kernel: ieee1394: sbp2: Logged into SBP-2 device
kernel: ieee1394: Node 0-00:1023: Max speed [S400] - Max payload [2048]
kernel:   Vendor: WDC WD20  Model: 00JB-00GVC0       Rev: 08.0
kernel:   Type:   Direct-Access-RBC                  ANSI SCSI revision: 04
kernel: SCSI device sda: 390721968 512-byte hdwr sectors (200050 MB)
kernel: sda: asking for cache data failed
kernel: sda: assuming drive cache: write through
kernel: SCSI device sda: 390721968 512-byte hdwr sectors (200050 MB)
kernel: sda: asking for cache data failed
kernel: sda: assuming drive cache: write through
kernel:  sda: sda1 sda2 sda3 sda4
kernel: Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
kernel: XFS mounting filesystem sda1
kernel: Ending clean XFS mount for filesystem: sda1
kernel: XFS mounting filesystem sda2
kernel: Ending clean XFS mount for filesystem: sda2
kernel: ieee1394: sbp2: sbp2util_node_write_no_wait failed.
kernel:
kernel: ieee1394: sbp2: aborting sbp2 command
kernel: scsi0 : destination target 0, lun 0
kernel:         command: cdb[0]=3D0x2a: 2a 00 06 48 37 51 00 00 01 00
kernel: ieee1394: sbp2: sbp2util_node_write_no_wait failed.
kernel:
kernel: ieee1394: sbp2: aborting sbp2 command
kernel: scsi0 : destination target 0, lun 0
kernel:         command: cdb[0]=3D0x2a: 2a 00 06 95 d7 31 00 00 01 00
kernel: ieee1394: sbp2: sbp2util_node_write_no_wait failed.
kernel:
kernel: ieee1394: sbp2: aborting sbp2 command
kernel: scsi0 : destination target 0, lun 0
kernel:         command: cdb[0]=3D0x2a: 2a 00 06 9b 52 c1 00 00 01 00
kernel: ieee1394: sbp2: sbp2util_node_write_no_wait failed.
kernel:
kernel: ieee1394: sbp2: aborting sbp2 command
kernel: scsi0 : destination target 0, lun 0
kernel:         command: cdb[0]=3D0x2a: 2a 00 06 9c 3a a1 00 00 01 00
kernel: ieee1394: sbp2: sbp2util_node_write_no_wait failed.
kernel:
kernel: ieee1394: sbp2: aborting sbp2 command
kernel: scsi0 : destination target 0, lun 0
kernel:         command: cdb[0]=3D0x2a: 2a 00 06 3f 17 80 00 00 01 00

I'm running kernel 2.6.14-rc5. Does anyone have any ideas about how to fix=
=20
this? Is anybody actually using a harddisk on ieee1394 without problems?=20
Please CC me on replies, thanks.

Thanks,
=2D-=20
Michael Brade;                 KDE Developer, Student of Computer Science
  |-mail: echo brade !#|tr -d "c oh"|s\e\d 's/e/\@/2;s/$/.org/;s/bra/k/2'
  =B0--web: http://www.kde.org/people/michaelb.html

KDE 3: The Next Generation in Desktop Experience

--nextPart1234537.C2vXMBAkM0
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBDZmgBdK2tAWD5bo0RAsLWAKDWDVlZ1+P4cbFwiTA5K3SrlOEwmgCgkrJq
qbPvBtAs1yEPEgynbCbW1Kc=
=yG8F
-----END PGP SIGNATURE-----

--nextPart1234537.C2vXMBAkM0--
