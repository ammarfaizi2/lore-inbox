Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261887AbUB1SAZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Feb 2004 13:00:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261894AbUB1SAZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Feb 2004 13:00:25 -0500
Received: from vhost-13-248.vhosts.internet1.de ([62.146.13.248]:28625 "EHLO
	spotnic.de") by vger.kernel.org with ESMTP id S261887AbUB1SAX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Feb 2004 13:00:23 -0500
Subject: Re: [PATCH] 2.4.25: Get rid of obsolete LMC driver
From: Daniel Egger <de@axiros.com>
Reply-To: de@axiros.com
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <4040C7CF.4020108@pobox.com>
References: <1077972033.24149.399.camel@sonja>  <4040C7CF.4020108@pobox.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-XDC4xHhXU32gtf1jPk4u"
Organization: Axiros GmbH
Message-Id: <1077990479.14706.408.camel@sonja>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 28 Feb 2004 19:01:27 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-XDC4xHhXU32gtf1jPk4u
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Am Sam, den 28.02.2004 schrieb Jeff Garzik um 17:54:

> > Their drivers can be retrieved from:
> > ftp://ftp.sbei.com/pub/OpenSource/Linux/sbe_driver/sbe_linux-4.0a.tgz

> Alan Cox vetoed a rename patch, so you want to rip out the driver=20
> instead???  For an unreviewed out-of-tree driver?

Indeed. However the unreviewed out-of-tree driver is based on the kernel
one. But since:
- it's close to impossible to compile tools to change the operation mode
  of the card
- SBE card owners will not notice that the LMC driver might work for
  them
- the LMC and the SBE driver will clash if both compiled

the best we can do for our users is to recommend using the SBE drivers
and complain to SBE about problems.

> Without a suitable replacement, I don't give a shit about what SBE=20
> recommends.

There is a suitable replacement: the SBE driver. But since there's no
volunteer to keep it updated in the kernel it'd be better to drop it.
I've spent several hours untangling the mess and I'd really like to help
other not getting hit by this.

--=20
Servus,
       Daniel

--=-XDC4xHhXU32gtf1jPk4u
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iQEVAwUAQEDUTzBkNMiD99JrAQK2Owf/Q7Vqsa+/Rspnn/Akcrft2qp47EzYkFfP
Pb8uzFQX1EAD9apMoohJxmHS4BXsIfFviXwWHwTnHWFHkVT3w2CuWenMr1V2YJdC
ugeTnG/OHpMy3bbMHYmykQFtNecOIrPLD/MxhNg9vZ4wWIn190EWpwCCR4uoisPH
JSAz5fo/S2b7b3vLrwJh56acRHLt/e5esELU44qW827FHKXovJt2SUrdyAEQ1sLg
ZJu3Z7NPQTDMVNJsP3D7UXfDQhBV6xUAbPHfIWAVTEL7NijNlUsEktED9u8ZlULb
woMwRAmLgFiF1HgWFSn7ZHH7YhD/S7tE73aONOmrmKkJ+iguFbQouw==
=C/1E
-----END PGP SIGNATURE-----

--=-XDC4xHhXU32gtf1jPk4u--

