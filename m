Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932459AbVJaSpS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932459AbVJaSpS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 13:45:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932480AbVJaSpS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 13:45:18 -0500
Received: from mail.satronet.sk ([217.144.16.198]:14208 "EHLO mail.satronet.sk")
	by vger.kernel.org with ESMTP id S932459AbVJaSpQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 13:45:16 -0500
From: Michal Vanco <michal.vanco@satro.sk>
Organization: Satro, s.r.o.
To: linux-kernel@vger.kernel.org
Subject: HDD LED on 82801FBM
Date: Mon, 31 Oct 2005 19:44:42 +0100
User-Agent: KMail/1.8.2
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart4028472.gZTvF8JLnF";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200510311944.45295.michal.vanco@satro.sk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart4028472.gZTvF8JLnF
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi all,

HDD LED on my Laptop (Fujitsu-Siemens LB E8020) never goes off when 2.6 ker=
nel=20
is running (tested with 2.6.10-2.6.13.4).=20

My controller is:
$ lspci | grep SATA
0000:00:1f.2 0106: Intel Corporation 82801FBM (ICH6M) SATA Controller (rev =
04)

This is from my dmesg:

ahci(0000:00:1f.2) AHCI 0001.0000 32 slots 4 ports 1.5 Gbps 0x5 impl SATA m=
ode
ahci(0000:00:1f.2) flags: 64bit ncq pm led slum part
ata1: SATA max UDMA/133 cmd 0xE0820D00 ctl 0x0 bmdma 0x0 irq 225
ata2: SATA max UDMA/133 cmd 0xE0820D80 ctl 0x0 bmdma 0x0 irq 225
ata3: SATA max UDMA/133 cmd 0xE0820E00 ctl 0x0 bmdma 0x0 irq 225
ata4: SATA max UDMA/133 cmd 0xE0820E80 ctl 0x0 bmdma 0x0 irq 225
ata1: dev 0 cfg 49:2f00 82:346b 83:7f09 84:6063 85:3469 86:3f09 87:6063=20
88:203f
ata1: dev 0 ATA, max UDMA/100, 156301488 sectors: lba48
ata1: dev 0 configured for UDMA/100
scsi0 : ahci
ata2: no device found (phy stat 00000000)
scsi1 : ahci
ata3: no device found (phy stat 00000000)
scsi2 : ahci
ata4: no device found (phy stat 00000000)
scsi3 : ahci
  Vendor: ATA       Model: FUJITSU MHT2080B  Rev: 0000
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0

Is this common problem?

thanx
=2Dmichal

--nextPart4028472.gZTvF8JLnF
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBDZmYdcNQdtX6Dm/0RAr+CAKCimQMfM2y+jX6HAgKLOMZoEcsHdQCeJEP9
rWRYJncX46qrzL0epPmwZ20=
=ASsx
-----END PGP SIGNATURE-----

--nextPart4028472.gZTvF8JLnF--
