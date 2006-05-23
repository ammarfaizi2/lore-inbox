Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751005AbWEWRX4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751005AbWEWRX4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 13:23:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751037AbWEWRXy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 13:23:54 -0400
Received: from adsl-67-113-118-6.dsl.sndg02.pacbell.net ([67.113.118.6]:59560
	"EHLO multivac.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id S1750986AbWEWRXx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 13:23:53 -0400
Date: Tue, 23 May 2006 10:23:52 -0700
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: Russell McConnachie <russell.mcconnachie@guest-tek.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Compact Flash Serial ATA patch
Message-ID: <20060523172352.GD9528@one-eyed-alien.net>
Mail-Followup-To: Russell McConnachie <russell.mcconnachie@guest-tek.com>,
	linux-kernel@vger.kernel.org
References: <1148379397.1182.4.camel@gt-alphapbx2>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8w3uRX/HFJGApMzv"
Content-Disposition: inline
In-Reply-To: <1148379397.1182.4.camel@gt-alphapbx2>
User-Agent: Mutt/1.4.1i
Organization: One Eyed Alien Networks
X-Copyright: (C) 2006 Matthew Dharm, all rights reserved.
X-Message-Flag: Get a real e-mail client.  http://www.mutt.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--8w3uRX/HFJGApMzv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 23, 2006 at 04:16:37AM -0600, Russell McConnachie wrote:
> I was having some trouble with a serial ATA compact flash adapter with
> libata. I wrote a small patch for the kernel to work around the sanity
> check, dma blacklisting and device ID detections in ata_dev_classify().=
=20

I've had this problem, too.  Apparently, my CF/SATA bridge doesn't support
DMA, but libata requires it.

I don't know if this is the right fix (if nothing else the patch needs to
be sent in unified diff format), but it's certainly something that needs
fixing.

Matt

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

Somebody call an exorcist!
					-- Dust Puppy
User Friendly, 5/16/1998

--8w3uRX/HFJGApMzv
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFEc0UoHL9iwnUZqnkRAjZmAJ9ZhCc78nmyNuDEJ/oKTyVDegGWegCdGcOj
u+MZzC+4NpbdCpzXc7FrE7s=
=V2ZX
-----END PGP SIGNATURE-----

--8w3uRX/HFJGApMzv--
