Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750700AbWGBT40@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750700AbWGBT40 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jul 2006 15:56:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750701AbWGBT4Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jul 2006 15:56:24 -0400
Received: from mail.gmx.de ([213.165.64.21]:26085 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750700AbWGBT4W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jul 2006 15:56:22 -0400
X-Authenticated: #5082238
From: "Carsten Otto" <c-otto@gmx.de>
Date: Sun, 2 Jul 2006 21:56:19 +0200
To: linux-kernel@vger.kernel.org
Subject: Re: Huge problem with XFS/iCH7R
Message-ID: <20060702195619.GB4098@localhost.halifax.rwth-aachen.de>
Reply-To: c-otto@gmx.de
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20060702195145.GA4098@localhost.halifax.rwth-aachen.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eAbsdosE1cNLO4uF"
Content-Disposition: inline
In-Reply-To: <20060702195145.GA4098@localhost.halifax.rwth-aachen.de>
X-GnuGP-Key: http://c-otto.de/pubkey.asc
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--eAbsdosE1cNLO4uF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 02, 2006 at 09:51:45PM +0200, Carsten Otto wrote:
> If I do a soft reset (using Magic Key u, then b) the BIOS does not detect
> exactly one drive (which is the one shown in the error message I guess).
> After a hard reset all drives are found, but I have to do a raid resync a=
nd
> xfs_repair (at least, sometimes the raid needs to be tricked into startin=
g).

I forgot to add:
Even after a xfs_repair sometimes another directly following run of
xfs_check or xfs_repair finds errors.
Currently I have problems deleting files from lost+found:
rm: cannot remove directory `lost+found//2171932973': Directory not
empty
I ran xfs_check only a few hours ago and it did not show any output
(which is good).
--=20
Carsten Otto
c-otto@gmx.de
www.c-otto.de

--eAbsdosE1cNLO4uF
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFEqCTjjUF4jpCSQBQRAr9MAJ9NDXea4YGKUyxGK9kjyKal0apP9wCgk2Ph
r9LtYTGXTAMjjhr+/p3PGho=
=vOwY
-----END PGP SIGNATURE-----

--eAbsdosE1cNLO4uF--
