Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262459AbUEKJeZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262459AbUEKJeZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 05:34:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261723AbUEKJeZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 05:34:25 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:53975 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S262459AbUEKJeW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 05:34:22 -0400
Date: Tue, 11 May 2004 11:34:21 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Paul Eggert <eggert@CS.UCLA.EDU>, Jon Oberheide <jon@focalhost.com>,
       linux-kernel@vger.kernel.org, akpm@osdl.org, bug-patch@gnu.org,
       bug-gnu-utils@gnu.org
Subject: Re: [PATCH] [RFC] adding support for .patches and /proc/patches.gz
Message-ID: <20040511093421.GK1912@lug-owl.de>
Mail-Followup-To: viro@parcelfarce.linux.theplanet.co.uk,
	Paul Eggert <eggert@CS.UCLA.EDU>, Jon Oberheide <jon@focalhost.com>,
	linux-kernel@vger.kernel.org, akpm@osdl.org, bug-patch@gnu.org,
	bug-gnu-utils@gnu.org
References: <1084157289.7867.0.camel@latitude> <87oeowb029.fsf@penguin.cs.ucla.edu> <20040510185107.GD17014@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="g4MvFqI7wmANiPDo"
Content-Disposition: inline
In-Reply-To: <20040510185107.GD17014@parcelfarce.linux.theplanet.co.uk>
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--g4MvFqI7wmANiPDo
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, 2004-05-10 19:51:07 +0100, viro@parcelfarce.linux.theplanet.co.uk <=
viro@parcelfarce.linux.theplanet.co.uk>
wrote in message <20040510185107.GD17014@parcelfarce.linux.theplanet.co.uk>:
> On Mon, May 10, 2004 at 11:37:34AM -0700, Paul Eggert wrote:
> > Jon Oberheide <jon@focalhost.com> writes:
> > > I'm CC'ing this to the GNU patch maintainers.  Hopefully they will ha=
ve
> > > some input.
> > then 'patch' could log all the changes into the named file.  This
> > would conform to POSIX.
>=20
> will do just fine.  Remember that patch(1) can handle at least some ed
> scripts.

Another way would be to have a ./linux/patches/ directory and ask every
patch to place a file down there. Then, just list all the file names
with their contents in /proc/patches.gz ...

Of course, one could even place the actual patches there and display
everything in /proc/patches.gz that's not an actual patch chunk. This
way, you can have nice patches with proper documentation (think quilt
series) and even (another CONFIG_XXX option) the full patch file inside
the kernel! For custom built kernels, *this* would be a *real*
advantage! For vanilla kernel, you wouldn't loose anything.

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
   ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TC=
PA));

--g4MvFqI7wmANiPDo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAoJ4dHb1edYOZ4bsRAs3BAJ9Pm0C46v2I4LfbbHAwZpZKxZA2nQCfTF5K
6dPfpE72GRrC28Rq5s2xDp8=
=HFPT
-----END PGP SIGNATURE-----

--g4MvFqI7wmANiPDo--
