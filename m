Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261593AbVDURpP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261593AbVDURpP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 13:45:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261584AbVDURn6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 13:43:58 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:62561 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S261576AbVDURls
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 13:41:48 -0400
From: "Tais M. Hansen" <tais.hansen@osd.dk>
Organization: OSD
To: linux-kernel@vger.kernel.org
Subject: SATA/ATAPI
Date: Thu, 21 Apr 2005 19:41:41 +0200
User-Agent: KMail/1.8
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2111534.kjmTHq01AQ";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200504211941.43889.tais.hansen@osd.dk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2111534.kjmTHq01AQ
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

I know there has been some talking about SATA/ATAPI being experimental and=
=20
might not work at all under kernel-2.6.x.

One of my linux boxes has a Plextor DVD-RW drive with a SATA interface. The=
=20
kernel sees this drive (ata3) but apparently doesn't tie it to a sdx device=
=2E=20
The box also have a SATA harddisk, which is working just fine. The relevant=
=20
dmesg output is pasted below.

Is there anything I can do to help the development of SATA/ATAPI devices?



libata version 1.10 loaded.
sata_promise version 1.01
ACPI: PCI interrupt 0000:00:08.0[A] -> GSI 18 (level, low) -> IRQ 18
ata1: SATA max UDMA/133 cmd 0xF8804200 ctl 0xF8804238 bmdma 0x0 irq 18
ata2: SATA max UDMA/133 cmd 0xF8804280 ctl 0xF88042B8 bmdma 0x0 irq 18
ata1: dev 0 cfg 49:2f00 82:7c6b 83:7b09 84:4003 85:7c69 86:3a01 87:4003=20
88:407f
ata1: dev 0 ATA, max UDMA/133, 240121728 sectors:
ata1: dev 0 configured for UDMA/133
scsi0 : sata_promise
ata2: no device found (phy stat 00000000)
scsi1 : sata_promise
  Vendor: ATA       Model: Maxtor 6Y120M0    Rev: YAR5
  Type:   Direct-Access                      ANSI SCSI revision: 05
sata_via version 1.1
ACPI: PCI interrupt 0000:00:0f.0[B] -> GSI 20 (level, low) -> IRQ 20
sata_via(0000:00:0f.0): routed to hard irq line 4
ata3: SATA max UDMA/133 cmd 0xE800 ctl 0xE402 bmdma 0xD400 irq 20
ata4: SATA max UDMA/133 cmd 0xE000 ctl 0xD802 bmdma 0xD408 irq 20
ata3: dev 0 cfg 49:0f00 82:0000 83:0000 84:0000 85:0000 86:0000 87:0000=20
88:0007
ata3: dev 0 ATAPI, max UDMA/33
ata3: dev 0 configured for UDMA/33
scsi2 : sata_via
ata4: no device found (phy stat 00000000)
scsi3 : sata_via
SCSI device sda: 240121728 512-byte hdwr sectors (122942 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 240121728 512-byte hdwr sectors (122942 MB)
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3 < sda5 sda6 sda7 >
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0

=2D-=20
Regards,
Tais M. Hansen
OSD

___________________________________________________________
"If people had understood how patents would be granted when most of today's=
=20
ideas were invented and had taken out patents, the industry would be at a=20
complete standstill today." -Bill Gates (1991)

--nextPart2111534.kjmTHq01AQ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBCZ+XXLf7B7mQNLngRAo95AJwM5i4iJr0LEOJc/bVge32TeoaD9gCfVD7y
/LoiTeQSUpYpUBkjlJvgVWU=
=Teg0
-----END PGP SIGNATURE-----

--nextPart2111534.kjmTHq01AQ--
