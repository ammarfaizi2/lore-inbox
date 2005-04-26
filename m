Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261440AbVDZJuf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261440AbVDZJuf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 05:50:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261439AbVDZJuf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 05:50:35 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:51554 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S261440AbVDZJqa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 05:46:30 -0400
From: "Tais M. Hansen" <tais.hansen@osd.dk>
Organization: OSD
To: linux-kernel@vger.kernel.org
Subject: Re: SATA/ATAPI
Date: Tue, 26 Apr 2005 11:46:04 +0200
User-Agent: KMail/1.8
Cc: Jeff Garzik <jgarzik@pobox.com>, andystewart@comcast.net
References: <200504211941.43889.tais.hansen@osd.dk> <200504240008.58326.tais.hansen@osd.dk> <426BCF6E.2000000@pobox.com>
In-Reply-To: <426BCF6E.2000000@pobox.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart6674978.YHeDXeD2c6";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200504261146.15301.tais.hansen@osd.dk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart6674978.YHeDXeD2c6
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Sunday 24 April 2005 18:55, Jeff Garzik wrote:
> > I've been unable to figure out what is supposed to tie sr to the devices
> > probed by sata_via. Also, littering sr with printk's gave me the idea
> > that sr is not even looking for cdrom devices. It loads, does the basic
> > module __init stuff and then silence. Should sr find devices itself or =
is
> > the kernel supposed to inform sr via some callback hook? I could really
> > be barking up the wrong tree here, and not even see it.
> Did you turn on ATA_ENABLE_ATAPI in include/linux/libata.h?

Seems like there's another guy reporting pretty much the same problem. Also=
=20
sata_via and the Plextor 712SA SATA DVD drive. Different motherboard though.

http://lkml.org/lkml/2005/3/25/259

=2D-=20
Regards,
Tais M. Hansen
OSD

___________________________________________________________
"If people had understood how patents would be granted when most of today's=
=20
ideas were invented and had taken out patents, the industry would be at a=20
complete standstill today." -Bill Gates (1991)

--nextPart6674978.YHeDXeD2c6
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBCbg3nLf7B7mQNLngRAo7qAKCRwh1Pfb5CGIccd9LNVShMgrmc1ACfbqUf
Q7kZkCNWYWKY6xlsqTTI9fo=
=izvY
-----END PGP SIGNATURE-----

--nextPart6674978.YHeDXeD2c6--
