Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261943AbTIZF4K (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Sep 2003 01:56:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261946AbTIZF4K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Sep 2003 01:56:10 -0400
Received: from switch-ats62.donpac.ru ([195.161.172.146]:13063 "EHLO
	switch-ats62.donpac.ru") by vger.kernel.org with ESMTP
	id S261943AbTIZF4F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Sep 2003 01:56:05 -0400
Date: Fri, 26 Sep 2003 09:56:02 +0400
From: pazke@donpac.ru
To: linux-kernel@vger.kernel.org
Cc: Jes Sorensen <jes@trained-monkey.org>
Subject: [boor@unix-ag.org: visws linux-2.6.0-test5 qla1280 isues]
Message-ID: <20030926055602.GB1407@pazke>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Jes Sorensen <jes@trained-monkey.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qlTNgmc+xy1dBmNv"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--qlTNgmc+xy1dBmNv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

----- Forwarded message from Florian Boor <boor@unix-ag.org> -----

Subject: visws linux-2.6.0-test5 qla1280 isues
=46rom: Florian Boor <boor@unix-ag.org>
To: pazke@donpac.ru
X-Mailer: Ximian Evolution 1.4.4=20

Hi Andrey!

Greetings from kernel hacker meeting in Oldenburg :-)

My first task for today was war compiling a kernel
with qla1280 debug support. It still hangs... here the output:

qla1x160: Supported Device Found VID=3D1077 DID=3D1080 SSVID=3D1077 SSDID=
=3D1
qla1280: QLA1080 found on PCI bus 1, dev 0
Configure PCI space for adapter...
scsi(0): Reading NVRAM
qla1280_read_nvram: Completed Reading NVRAM
scsi(0): Determining if RISC is loaded
qla1280: NVRAM configured to load RISC load.
scsi(0): Verifying chip
qla1280_chip_diag: Checking mailboxes of chip
scsi(0): Setup chip
qla1280_setup_chip: DMA RISC code (15675) words
qla1280_setup_chip: Verifying checksum of loaded RISC code.
qla1280_setup_chip: start firmware running.
scsi(0): Configure NVRAM parameters
qla1280 : initiator scsi id bus[0]=3D7
qla1280 : initiator scsi id bus[1]=3D0
qla1280 : bus reset delay[0]=3D5
qla1280 : bus reset delay[1]=3D0
qla1280 : retry count[0]=3D0
qla1280 : retry delay[0]=3D0
qla1280 : retry count[1]=3D0
qla1280 : retry delay[1]=3D0
qla1280 : async data setup time[0]=3D9
qla1280 : async data setup time[1]=3D0
qla1280 : req/ack active negation[0]=3D1
qla1280 : req/ack active negation[1]=3D0
qla1280 : data line active negation[0]=3D1
qla1280 : data line active negation[1]=3D0
qla1280 : disable loading risc code=3D0
qla1280 : enable 64bit addressing=3D0
qla1280 : selection timeout limit[0]=3D250
qla1280 : selection timeout limit[1]=3D0
qla1280 : max queue depth[0]=3D256
qla1280 : max queue depth[1]=3D0
scsi(0:0): Resetting SCSI BUS
scsi0 : QLogic QLA1080 PCI to SCSI Host Adapter: bus 1 device 0 irq 16
       Firmware version:  8.15.00, Driver version 3.23.35
Any
idea?                                                                      =
         =20
I'll be here working on SGI320 and iPaq for the next two days, maybe
i'm able to port the monitor detection code from 2.2.x. :-)

Greetings

Florian

--=20
The dream of yesterday                     Florian Boor
is the hope of today                       Tel: 0271-7411487=20
and the reality of tomorrow.               boor@unix-ag.org
[Robert Hutchings Goddard, 1904]           florian.boor@bsystems.de

6C 44 30 4C 43 20 6B 61 16 07 0F AA E6 97 70 A8


----- End forwarded message -----

--=20
Andrey Panin		| Linux and UNIX system administrator
pazke@donpac.ru		| PGP key: wwwkeys.pgp.net

--qlTNgmc+xy1dBmNv
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/c9Tyby9O0+A2ZecRAlyWAKCYmfFWi+Q9JfbXDUhhhgO/dOP2SQCeKSff
cgSJiZZ8n9Ak2EyEKG6uRCM=
=Rb1j
-----END PGP SIGNATURE-----

--qlTNgmc+xy1dBmNv--
