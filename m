Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751069AbWINTZY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751069AbWINTZY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 15:25:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751074AbWINTZY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 15:25:24 -0400
Received: from mail.isohunt.com ([69.64.61.20]:61420 "EHLO mail.isohunt.com")
	by vger.kernel.org with ESMTP id S1751068AbWINTZX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 15:25:23 -0400
X-Spam-Check-By: mail.isohunt.com
Date: Thu, 14 Sep 2006 13:50:50 -0700
From: "Robin H. Johnson" <robbat2@gentoo.org>
To: Jeff Garzik <jeff@garzik.org>
Cc: "Robin H. Johnson" <robbat2@gentoo.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc7-git1: AHCI not seeing devices on ICH8 mobo (DG965RY)
Message-ID: <20060914205050.GE27531@curie-int.orbis-terrarum.net>
References: <20060914200500.GD27531@curie-int.orbis-terrarum.net> <4509AB2E.1030800@garzik.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bi5JUZtvcfApsciF"
Content-Disposition: inline
In-Reply-To: <4509AB2E.1030800@garzik.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--bi5JUZtvcfApsciF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 14, 2006 at 03:19:10PM -0400, Jeff Garzik wrote:
> Robin H. Johnson wrote:
> >[Please CC me, I'm not subscribed.]
> >
> >Recently picked up some new hardware (without sufficiently researching
> >it), and I have found that the AHCI driver does NOT see my SATA optical
> >device at all.
>=20
> >scsi1 : ahci
> >ata1: SATA link down (SStatus 0 SControl 300)
> >scsi2 : ahci
> >ata2: SATA link down (SStatus 0 SControl 300)
> >scsi3 : ahci
> >ata3: SATA link down (SStatus 0 SControl 0)
> >scsi4 : ahci
> >ata4: SATA link down (SStatus 0 SControl 0)
> Unfortunately the SATA phy isn't showing that a SATA device (hd or cdrom=
=20
> or anything) is connected.  So can't do anything much at all, if that is=
=20
> the case.
>=20
> Perhaps re-check all the power connections, cables, etc.
I neglected to say, that the BIOS sees it perfectly fine, and the
initial boot sequence perfectly with ISOLINUX (everything just falls
over later when the initrd tries to load up a squashfs image from the
CD).

--=20
Robin Hugh Johnson
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85

--bi5JUZtvcfApsciF
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Robbat2 @ Orbis-Terrarum Networks

iD8DBQFFCcCqPpIsIjIzwiwRAvVPAJ9UvNlr5Cekj5cDqc2L/VjZakjCJgCg+rDv
I6Wn88c9eBvDk2gJoh5h97o=
=l+YK
-----END PGP SIGNATURE-----

--bi5JUZtvcfApsciF--
