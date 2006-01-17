Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932489AbWAQNsR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932489AbWAQNsR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 08:48:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932490AbWAQNsR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 08:48:17 -0500
Received: from moutng.kundenserver.de ([212.227.126.183]:1253 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S932489AbWAQNsQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 08:48:16 -0500
From: Prakash Punnoor <prakash@punnoor.de>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Linux 2.6.16-rc1
Date: Tue, 17 Jan 2006 14:49:32 +0100
User-Agent: KMail/1.9
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.64.0601170001530.13339@g5.osdl.org> <200601171416.13119.prakash@punnoor.de> <43CCF2F7.4070205@pobox.com>
In-Reply-To: <43CCF2F7.4070205@pobox.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1249386.599gbbzhZE";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200601171449.32868.prakash@punnoor.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:cec1af1025af73746bdd9be3587eb485
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1249386.599gbbzhZE
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Am Dienstag Januar 17 2006 14:36 schrieb Jeff Garzik:
> Prakash Punnoor wrote:
> > Compiling libata SIL breaks with Linux 2.6.16-rc1:
> >
> >
> >   CC      drivers/scsi/sata_sil.o
> > drivers/scsi/sata_sil.c: In function 'sil_port_irq':
> > drivers/scsi/sata_sil.c:393: error: too many arguments to function
> > 'ata_qc_complete'
> > drivers/scsi/sata_sil.c:400: error: too many arguments to function
> > 'ata_qc_complete'
>
> I don't know what source code you're compiling, but it's certainly not
> 2.6.16-rc1:
>
> [jgarzik@pretzel linux-2.6]$ grep -w ata_qc_complete
> drivers/scsi/sata_sil.c
> [jgarzik@pretzel linux-2.6]$

Ah sorry, you are right. I still had the experimental patch inside you once=
=20
posted...need to back that out...

=2D-=20
(=B0=3D                 =3D=B0)
//\ Prakash Punnoor /\\
V_/                 \_V

--nextPart1249386.599gbbzhZE
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD4DBQBDzPXsxU2n/+9+t5gRAoi3AJQJOC20gm4KSWejqR6oI08swmEqAJ9qb5WR
0imE8k2lrjdXEKIPzJK29g==
=WPc3
-----END PGP SIGNATURE-----

--nextPart1249386.599gbbzhZE--
