Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270178AbRIJJft>; Mon, 10 Sep 2001 05:35:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270165AbRIJJfk>; Mon, 10 Sep 2001 05:35:40 -0400
Received: from bartender.antefacto.net ([193.120.245.19]:25005 "EHLO
	bartender.internal.antefacto.com") by vger.kernel.org with ESMTP
	id <S269779AbRIJJf3>; Mon, 10 Sep 2001 05:35:29 -0400
Date: Mon, 10 Sep 2001 10:35:49 +0100
From: "John P. Looney" <john@antefacto.com>
To: linux-kernel@vger.kernel.org
Subject: Re: COW fs (Re: Editing-in-place of a large file)
Message-ID: <20010910103549.E6058@antefacto.com>
Reply-To: john@antefacto.com
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20010902152137.L23180@draal.physics.wisc.edu> <318476047.20010903002818@port.imtp.ilyichevsk.odessa.ua> <3B9B80E2.C9D5B947@riohome.com> <8015001541.20010910122851@port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+SfteS7bOf3dGlBC"
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
In-Reply-To: <8015001541.20010910122851@port.imtp.ilyichevsk.odessa.ua>; from VDA@port.imtp.ilyichevsk.odessa.ua on Mon, Sep 10, 2001 at 12:28:51PM +0300
X-OS: Red Hat Linux 7.1/Linux 2.4.9
X-URL: http://www.redbrick.dcu.ie/~valen
X-GnuPG-publickey: http://www.redbrick.dcu.ie/~valen/public.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--+SfteS7bOf3dGlBC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 10, 2001 at 12:28:51PM +0300, VDA mentioned:
> Now, sometimes we use hardlinks as "poor man's COW fs", but
> I bet it's error prone. Every now and then you forget it's a
> hardlinked kernel tree and start happily hacking in it... :-(

 And of course hardlinks don't work on directories...

> A "compressor" which hunts and merges duplicate blocks is a bonus,
> not a primary tool.

 Checkout http://freshmeat.net/projects/fslint/ - it's an excellent tool
for hunting down duplicate files, dangling links etc.

Kate

--=20
_______________________________________
John Looney             Chief Scientist
a n t e f a c t o     t: +353 1 8586004
www.antefacto.com     f: +353 1 8586014


--+SfteS7bOf3dGlBC
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7nIl1YBVPvqzGrWgRArRbAKCl6Tb+SuPXmD/Y/jTK08bspI2hEQCfUlB6
drC2bBr/oAb0RdUMFUBzaaE=
=bce4
-----END PGP SIGNATURE-----

--+SfteS7bOf3dGlBC--
