Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266166AbTGDUqQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jul 2003 16:46:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266175AbTGDUqQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jul 2003 16:46:16 -0400
Received: from ziggy.one-eyed-alien.net ([64.169.228.100]:53255 "EHLO
	ziggy.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id S266166AbTGDUqL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jul 2003 16:46:11 -0400
Date: Fri, 4 Jul 2003 14:00:38 -0700
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: Andries.Brouwer@cwi.nl
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       torvalds@osdl.org
Subject: Re: scsi mode sense broken again
Message-ID: <20030704140038.A18450@one-eyed-alien.net>
Mail-Followup-To: Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org, torvalds@osdl.org
References: <UTC200307042052.h64KqLA16451.aeb@smtp.cwi.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="dDRMvlgZJXvWKvBx"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <UTC200307042052.h64KqLA16451.aeb@smtp.cwi.nl>; from Andries.Brouwer@cwi.nl on Fri, Jul 04, 2003 at 10:52:21PM +0200
Organization: One Eyed Alien Networks
X-Copyright: (C) 2003 Matthew Dharm, all rights reserved.
X-Message-Flag: Get a real e-mail client.  http://www.mutt.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

IMM?  So this is the parallel-port version?

Do you still get the proper INQUIRY from 2.5.74?  What about the device
size?

Matt

On Fri, Jul 04, 2003 at 10:52:21PM +0200, Andries.Brouwer@cwi.nl wrote:
> > I just did some re-testing, and my self-powered Zip250 and Zip750 work.
> > The 750 takes a few seconds to initialize, but nothing really bad.
> > What Zip do you have that doesn't work?
>=20
> 2.5.72 or patched 2.5.74:
>=20
> <4>imm: Version 2.05 (for Linux 2.4.0)
> <4>imm: Found device at ID 6, Attempting to use EPP 32 bit
> <4>imm: Found device at ID 6, Attempting to use SPP
> <4>imm: Communication established at 0x378 with ID 6 using SPP
> <6>scsi1 : Iomega VPI2 (imm) interface
> <5>  Vendor: IOMEGA    Model: ZIP 100           Rev: P.05
> <5>  Type:   Direct-Access                      ANSI SCSI revision: 02
> <5>SCSI device sda: 196608 512-byte hdwr sectors (101 MB)
> <5>sda: Write Protect is off
> <5>sda: cache data unavailable
> <6> sda: sda4
> <5>Attached scsi removable disk sda at scsi1, channel 0, id 6, lun 0
>=20
> An unpatched 2.5.74 says
>=20
> <4>IMM: returned SCSI status b8
> <4>sda: test WP failed, assume Write Enabled
> <3>sda: asking for cache data failed
> <5>sda : READ CAPACITY failed.
> <4>sda: test WP failed, assume Write Enabled
> <3>Buffer I/O error on device sda, logical block 0
> <6> sda: unable to read partition table
>=20
> and no I/O is possible.
>=20
> Andries

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

Department of Justice agent.  I have come to purify the flock.
					-- DOJ agent
User Friendly, 5/22/1998

--dDRMvlgZJXvWKvBx
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE/Ber2IjReC7bSPZARAkg4AKDB2FcdgHDTmKjO3ayC6yfveuMHswCfRlCt
Efp2xa/KqeMz6FmtAborm3g=
=UllJ
-----END PGP SIGNATURE-----

--dDRMvlgZJXvWKvBx--
