Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261509AbTJ1WIi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 17:08:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261754AbTJ1WIi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 17:08:38 -0500
Received: from [192.153.219.146] ([192.153.219.146]:40456 "EHLO
	manly.caddr.com") by vger.kernel.org with ESMTP id S261509AbTJ1WIg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 17:08:36 -0500
Subject: problem with ide dvd-rom in 2.6.0 test
From: Miles Egan <miles@caddr.com>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-vlcZxhcp60jLB9eMp4Sd"
Message-Id: <1067378907.5399.9.camel@car>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 28 Oct 2003 14:08:35 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-vlcZxhcp60jLB9eMp4Sd
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

I consistently get errors reading dvd-r disks under 2.6.0 test on
hardware that performs fine under 2.4.x.

Specs are Dell Pentium 4 desktop machine running Debian unstable with a
Samsung DVD/CDRW ide drive.

The errors are reported as follows:
Oct 28 13:26:31 car kernel: attempt to access beyond end of device
Oct 28 13:26:31 car kernel: hdc: rw=3D0, want=3D8320756, limit=3D8308032

The kernel recognizes the drive as follows:
hdc: attached ide-scsi driver.
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: SAMSUNG   Model: CDRW/DVD SM-332B  Rev: T408
  Type:   CD-ROM                             ANSI SCSI revision: 02

The problem occurs consistently whether I mount the drive using the
ide-scsi driver or as a plain ide disk.  It occurs with every 2.6.0 test
kernel I've tried (test2 and on).

It sounds similar to a problem reported by Jakub Bogusz with 2.6.0 test3
in August:

http://www.ussg.iu.edu/hypermail/linux/kernel/0308.1/1989.html

Any ideas?  Any more information I can provide or anything I should try
to narrow it down?

Thanks.

--=20
Miles Egan <miles@caddr.com>

--=-vlcZxhcp60jLB9eMp4Sd
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/nujbU4Jq/wH1PVERAmzkAKDi9tjFf2+/gNvHMJeOY4kwf/2fiACfcN+/
l7uLWN3fWfC3tNj7PnfsAlA=
=htVw
-----END PGP SIGNATURE-----

--=-vlcZxhcp60jLB9eMp4Sd--

