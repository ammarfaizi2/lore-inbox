Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262356AbUE1Ize@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262356AbUE1Ize (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 04:55:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262381AbUE1Ize
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 04:55:34 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:64203 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S262356AbUE1IzZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 04:55:25 -0400
Date: Fri, 28 May 2004 10:55:23 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Linux Kernel Mail List <linux-kernel@vger.kernel.org>
Subject: Re: ftp.kernel.org
Message-ID: <20040528085523.GP1912@lug-owl.de>
Mail-Followup-To: Linux Kernel Mail List <linux-kernel@vger.kernel.org>
References: <Pine.GSO.4.33.0405280018250.14297-100000@sweetums.bluetronic.net> <200405280941.38784.m.watts@eris.qinetiq.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1ic3dgwa48mUU+0C"
Content-Disposition: inline
In-Reply-To: <200405280941.38784.m.watts@eris.qinetiq.com>
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--1ic3dgwa48mUU+0C
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 2004-05-28 09:41:38 +0100, Mark Watts <m.watts@eris.qinetiq.com>
wrote in message <200405280941.38784.m.watts@eris.qinetiq.com>:
> > On Thu, 27 May 2004, Martin J. Bligh wrote:
> > That would explain it.  The default is to turn it off.
> > >Why would you mirror via ftp, instead of rsync anyway?
> > I have more control with mirror.  And I've been using mirror for
> > *ahem* a decade.  I've been using rsync for mirroring debian, but
> > it's slow and often fails to complete.  Mirror has never let me
> > down ('tho it has deleted entire archives before *grin*)
> Agreed - fmirror is so much more reliable than rsync (imho) that it makes=
=20
> rsync into a worst-case option for retrieving files.

Disagree! Mirroring with ftp is possibly quite a waste of bandwidth (at
least in case partial file transfers etc.), and IIRC you can't reliably
mirror symlinks (IIRC the "ls"/"dir" output is only ment to be
human-readable), hardlinks and the like.

If you see aborts, properly set the timeout parameter...

MfG, JBG (a happy rsync user)

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
   ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TC=
PA));

--1ic3dgwa48mUU+0C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAtv57Hb1edYOZ4bsRAqHpAKCS2d6tV6rAVy+z8AF5+C/y+u0a9gCcCGEh
lOYdFkS3nOFHrhFCHWKl7G4=
=FY4Z
-----END PGP SIGNATURE-----

--1ic3dgwa48mUU+0C--
