Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262111AbVDWWKH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262111AbVDWWKH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Apr 2005 18:10:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262112AbVDWWKG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Apr 2005 18:10:06 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:64404 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S262111AbVDWWJG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Apr 2005 18:09:06 -0400
From: "Tais M. Hansen" <tais.hansen@osd.dk>
Organization: OSD
To: linux-kernel@vger.kernel.org
Subject: Re: SATA/ATAPI
Date: Sun, 24 Apr 2005 00:08:53 +0200
User-Agent: KMail/1.8
References: <200504211941.43889.tais.hansen@osd.dk>
In-Reply-To: <200504211941.43889.tais.hansen@osd.dk>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1249752.eN1OhQzhgo";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200504240008.58326.tais.hansen@osd.dk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1249752.eN1OhQzhgo
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Thursday 21 April 2005 19:41, Tais M. Hansen wrote:
> One of my linux boxes has a Plextor DVD-RW drive with a SATA interface. T=
he
> kernel sees this drive (ata3) but apparently doesn't tie it to a sdx
> device. The box also have a SATA harddisk, which is working just fine. The
> relevant dmesg output is pasted below.

I've been digging through sr, scsi, sata_via, libata-scsi and libata-core,=
=20
littering the code with printk's.

My lack of knowledge on how the kernel handles devices, is really showing n=
ow.=20

I've been unable to figure out what is supposed to tie sr to the devices=20
probed by sata_via. Also, littering sr with printk's gave me the idea that =
sr=20
is not even looking for cdrom devices. It loads, does the basic module __in=
it=20
stuff and then silence. Should sr find devices itself or is the kernel=20
supposed to inform sr via some callback hook? I could really be barking up=
=20
the wrong tree here, and not even see it.

Enabling SCSI logging and kernel debug didn't really give me anything usefu=
l.

=2D-=20
Regards,
Tais M. Hansen
OSD

___________________________________________________________
"If people had understood how patents would be granted when most of today's=
=20
ideas were invented and had taken out patents, the industry would be at a=20
complete standstill today." -Bill Gates (1991)

--nextPart1249752.eN1OhQzhgo
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBCasd6Lf7B7mQNLngRAnE6AJ0UJmr/+/56jBzJGZ+pfrwgTwjR3gCcCfKx
LW039dGkYC1Bu4OCNP2l/24=
=oBVN
-----END PGP SIGNATURE-----

--nextPart1249752.eN1OhQzhgo--
