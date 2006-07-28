Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751079AbWG1Lqq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751079AbWG1Lqq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 07:46:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751182AbWG1Lqq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 07:46:46 -0400
Received: from kagl.donpac.ru ([80.254.111.32]:64484 "EHLO donpac.ru")
	by vger.kernel.org with ESMTP id S1751079AbWG1Lqp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 07:46:45 -0400
Date: Fri, 28 Jul 2006 15:46:45 +0400
To: Alex Dubov <oakad@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Support for TI FlashMedia (pci id 104c:8033, 104c:803b) flash card readers
Message-ID: <20060728114645.GC16961@pazke.donpac.ru>
Mail-Followup-To: Alex Dubov <oakad@yahoo.com>,
	linux-kernel@vger.kernel.org
References: <20060728033406.40478.qmail@web36712.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ABTtc+pdwF7KHXCz"
Content-Disposition: inline
In-Reply-To: <20060728033406.40478.qmail@web36712.mail.mud.yahoo.com>
X-Uname: Linux 2.6.8-12-amd64-k8 x86_64
User-Agent: Mutt/1.5.12-2006-07-14
From: Andrey Panin <pazke@donpac.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ABTtc+pdwF7KHXCz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 208, 07 27, 2006 at 08:34:06PM -0700, Alex Dubov wrote:

What this strange line (in tifm_7xx1_isr function) is supposed to do:

        if(irq_status && (~irq_status))

check for nonzero irq_status in most obfuscated way ?
Please replace it with something readable.

> I would like to announce the availability of the
> driver for TI FlashMedia flash card readers. Currently
> supported pci ids:
> 1. 104c:8033.3
> 2. 104c:803b.2
>=20
> Device with id 8033 also features sdhci interface (as
> subfunction 4). However, sdhci is disabled on many
> laptops (notably Acer's), while FlashMedia interface
> is available.
>=20
> The driver is called tifmxx and available from:
> http://developer.berlios.de/projects/tifmxx/
>=20
> Only mmc/sd cards are supported at present, via mmc
> subsystem. Provisions for other card types (Sony MS,
> xD and such) are in place, but no support is available
> due to lack of hardware and interest.
>=20
>=20
> __________________________________________________
> Do You Yahoo!?
> Tired of spam?  Yahoo! Mail has the best spam protection around=20
> http://mail.yahoo.com=20
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>=20

--=20
Andrey Panin		| Linux and UNIX system administrator
pazke@donpac.ru		| PGP key: wwwkeys.pgp.net

--ABTtc+pdwF7KHXCz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQFEyfklPjHNUy6paxMRAt1+AKDDrApT7mvtGBz4pqtOZ44/Ll6R2gCfT/yw
5gE0SEt2i/IJ/HE9/msfJno=
=6rH2
-----END PGP SIGNATURE-----

--ABTtc+pdwF7KHXCz--
