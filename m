Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291246AbSBNJ62>; Thu, 14 Feb 2002 04:58:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291298AbSBNJ6Q>; Thu, 14 Feb 2002 04:58:16 -0500
Received: from point41.gts.donpac.ru ([213.59.116.41]:44810 "EHLO orbita1.ru")
	by vger.kernel.org with ESMTP id <S291246AbSBNJ57>;
	Thu, 14 Feb 2002 04:57:59 -0500
Date: Thu, 14 Feb 2002 13:01:50 +0300
From: Andrey Panin <pazke@orbita1.ru>
To: Pavel Machek <pavel@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: sys & legacy buses plus interrupt controller and IDE support
Message-ID: <20020214100150.GA4171@pazke.ipt>
Mail-Followup-To: Pavel Machek <pavel@suse.cz>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020212085954.GA618@elf.ucw.cz> <20020214080645.GA281@pazke.ipt> <20020214093547.GA31253@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jI8keyz6grp/JLjh"
Content-Disposition: inline
In-Reply-To: <20020214093547.GA31253@atrey.karlin.mff.cuni.cz>
User-Agent: Mutt/1.3.27i
X-Uname: Linux pazke 2.5.2-dj6 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On =D0=A7=D1=82=D0=B2, =D0=A4=D0=B5=D0=B2 14, 2002 at 10:35:47 +0100, Pavel=
 Machek wrote:
> Hi!
>=20
> > > Here it goes. For now I only put one device on each bus (sys &
> > > legacy), but I'll quickly expand it once merged. Please apply,
> >=20
> > please take a quick look at attached patch. It's your patch with
> > minor modification, hwif->pci_dev used as parent for ide interface.
>=20
> Looks good...
>=20
> > I made it because it was strange to see HPT370 IDE interface
> > under legacy bus :))
>=20
> Are you sure? I mean, that device is southbridge-integrated?=20
> Are you sure it is really on PCI? Does it use PCI interrupt?

I'm absolutely sure. HPT370 is a separate IDE controller chip=20
connected to PCI bus. Can't provide /proc/pci right now,=20
it's my home machine.

> Anyway, it is probably less confusing to put the device onto PCI,
> because people expect it there, and it was simple enough change. I'll
> merge in into my local tree.
>=20

Best regards.
--=20
Andrey Panin            | Embedded systems software engineer
pazke@orbita1.ru        | PGP key: wwwkeys.eu.pgp.net
--jI8keyz6grp/JLjh
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8a4sOBm4rlNOo3YgRAhBXAJ9rc9X9sgEK2FBGYedS0lneWsnRRgCghmeJ
CMyrYaSimIaJ+cDiybd/3SM=
=6zoJ
-----END PGP SIGNATURE-----

--jI8keyz6grp/JLjh--
