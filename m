Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289875AbSAKFA1>; Fri, 11 Jan 2002 00:00:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289876AbSAKFAS>; Fri, 11 Jan 2002 00:00:18 -0500
Received: from smtpsrv0.isis.unc.edu ([152.2.1.139]:426 "EHLO
	smtpsrv0.isis.unc.edu") by vger.kernel.org with ESMTP
	id <S289875AbSAKFAM>; Fri, 11 Jan 2002 00:00:12 -0500
Date: Thu, 10 Jan 2002 23:57:18 -0500
To: Justin Pryzby <pryzbyj@clarkson.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB UHCI compile error
Message-ID: <20020111045718.GB26644@opeth.ath.cx>
In-Reply-To: <Pine.GSO.4.10.10201102122080.28110-200000@crux.clarkson.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JP+T4n/bALQSJXh8"
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.10.10201102122080.28110-200000@crux.clarkson.edu>
User-Agent: Mutt/1.3.25i
From: Dan Chen <crimsun@email.unc.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--JP+T4n/bALQSJXh8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Compile in hotplug support as a workaround.

CONFIG_HOTPLUG=3Dy
CONFIG_HOTPLUG_PCI=3Dy

On Thu, Jan 10, 2002 at 09:28:01PM -0500, Justin Pryzby wrote:
> drivers/usb/usbdrv.o: In function `alloc_uhci':
> drivers/usb/usbdrv.o(.text.init+0x2e2): undefined reference to
> `uhci_pci_remove'make: *** [vmlinux] Error 1

--=20
Dan Chen                 crimsun@email.unc.edu
GPG key:   www.unc.edu/~crimsun/pubkey.gpg.asc

--JP+T4n/bALQSJXh8
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8PnCuMwVVFhIHlU4RAsI4AJ9+hvpMwjHwWMcUq8kLcIhPOaN6HgCdHnko
ZOUCFsGYAnyfc5VMefnCblE=
=qLJ1
-----END PGP SIGNATURE-----

--JP+T4n/bALQSJXh8--
