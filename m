Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263081AbTKPSgm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Nov 2003 13:36:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263106AbTKPSgm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Nov 2003 13:36:42 -0500
Received: from [213.228.189.86] ([213.228.189.86]:64969 "EHLO tuxslare.org")
	by vger.kernel.org with ESMTP id S263081AbTKPSgj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Nov 2003 13:36:39 -0500
Subject: mass-storage borks on 2.6.0-test9/mm3
From: =?ISO-8859-1?Q?Andr=E9?= Ventura Lemos <tux@tuxslare.org>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-JTFO2QyNCcRjM9Ori0Qv"
Message-Id: <1069007797.5294.4.camel@lapy.tuxslare.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 16 Nov 2003 18:36:37 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-JTFO2QyNCcRjM9Ori0Qv
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

This happens when connecting a Fujifilm FinePix 2400 to the USB port to
read the SmartMedia card.=20

This method works with 2.4.22, but not with 2.6.0-test9 nor
2.6.0-test9-mm3.


Any thoughts?



(please CC me)

messages from the kernel follows:

hub 2-0:1.0: new USB device on port 2, assigned address 4
scsi2 : SCSI emulation for USB Mass Storage devices
  Vendor: Fujifilm  Model: FinePix 1400Zoom  Rev: 1000
  Type:   Direct-Access                      ANSI SCSI revision: 02
sda : READ CAPACITY failed.
sda : status=3D0, message=3D00, host=3D7, driver=3D00
sda : sense not available.
sda: Write Protect is off
sda: Mode Sense: 00 00 00 00
sda: assuming drive cache: write through
sda : READ CAPACITY failed.
sda : status=3D0, message=3D00, host=3D7, driver=3D00
sda : sense not available.
sda: Write Protect is off
sda: Mode Sense: 00 00 00 00
sda: assuming drive cache: write through
sda : READ CAPACITY failed.
sda : status=3D0, message=3D00, host=3D7, driver=3D00
sda : sense not available.
sda: Write Protect is off
sda: Mode Sense: 00 00 00 00
sda: assuming drive cache: write through
 /dev/scsi/host2/bus0/target0/lun0:<3>Buffer I/O error on device sda,
logical block 0
Buffer I/O error on device sda, logical block 0
 unable to read partition table
 /dev/scsi/host2/bus0/target0/lun0:<3>Buffer I/O error on device sda,
logical block 0
 unable to read partition table
Attached scsi removable disk sda at scsi2, channel 0, id 0, lun 0
Attached scsi generic sg1 at scsi2, channel 0, id 0, lun 0,  type 0
WARNING: USB Mass Storage data integrity not assured
USB Mass Storage device found at 4



--=20
Lego my ego, and I'll lego your knowledge


--=-JTFO2QyNCcRjM9Ori0Qv
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/t8O1duWuN7ka4fkRAlcUAJ9HF9/nt/aFrUGPRvHsWc476jZp2wCgsUyy
Kk4YUelDhiY3TDZMqI5Ii1o=
=6Gal
-----END PGP SIGNATURE-----

--=-JTFO2QyNCcRjM9Ori0Qv--

