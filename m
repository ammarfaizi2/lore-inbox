Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272459AbTGaL0I (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 07:26:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272982AbTGaL0I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 07:26:08 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:53644 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S272459AbTGaL0D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 07:26:03 -0400
Date: Thu, 31 Jul 2003 13:26:02 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Emulating i486+ insn on i386 (was: TSCs are a no-no on i386)
Message-ID: <20030731112601.GT1873@lug-owl.de>
Mail-Followup-To: lkml <linux-kernel@vger.kernel.org>
References: <20030730135623.GA1873@lug-owl.de> <20030730181006.GB21734@fs.tum.de> <20030730183033.GA970@matchmail.com> <20030730184529.GE21734@fs.tum.de> <1059595260.10447.6.camel@dhcp22.swansea.linux.org.uk> <20030730203318.GH1873@lug-owl.de> <1059606259.10505.20.camel@dhcp22.swansea.linux.org.uk> <Pine.LNX.4.53.0307310709150.3917@chaos>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lQZUhpxrYmQgHmHV"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0307310709150.3917@chaos>
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--lQZUhpxrYmQgHmHV
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 2003-07-31 07:11:42 -0400, Richard B. Johnson <root@chaos.analogic.=
com>
wrote in message <Pine.LNX.4.53.0307310709150.3917@chaos>:
> On Wed, 31 Jul 2003, Alan Cox wrote:
>=20
> > On Mer, 2003-07-30 at 21:33, Jan-Benedict Glaw wrote:
> > > Well... For sure, I can write a LD_PRELOAD lib dealing with SIGILL, b=
ut
> > > how do I enable it for the whole system. That is, I'd need to give
> > > LD_PRELOAD=3Dxxx at the kernel's boot prompt to have it as en environ=
ment
> > > variable for each and every process?
> >
> > /etc/ld.preload
> >
> > > That sounds a tad inelegant to me. Really, I'd prefer to see libstdc++
> > > be compiled for i386 ...
>=20
> What is a runtime library doing with a TSC? That's the basic problem.
> These things are for operating systems and, last time I checked, the
> 'C' runtime libraries weren't (but maybe GNU changed that definition, no?)

Oh, sorry:) One problem is that TSCs may be enabled on i386. They crash
upon boot-up. While I sent the patch, I ranted about i486 optimized
libstdc++5 Debian is shipping, which (also, but in a different way)
break i386. A thread has started about the later issue. Maybe someone
should have switched subject, though...

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
      ret =3D do_actions((curr | FREE_SPEECH) & ~(IRAQ_WAR_2 | DRM | TCPA));

--lQZUhpxrYmQgHmHV
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/KPzJHb1edYOZ4bsRAqRqAJ0WTuFirMdkAYNGXD1ivm86Neu4rACffm47
OanKfb3FopoDyUfVwy75ymw=
=MjQY
-----END PGP SIGNATURE-----

--lQZUhpxrYmQgHmHV--
