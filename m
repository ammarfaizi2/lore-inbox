Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751029AbVHLM3k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751029AbVHLM3k (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 08:29:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751153AbVHLM3k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 08:29:40 -0400
Received: from lug-owl.de ([195.71.106.12]:55012 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S1751029AbVHLM3j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 08:29:39 -0400
Date: Fri, 12 Aug 2005 14:29:35 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [2.6 patch] remove support for gcc < 3.2
Message-ID: <20050812122935.GA25012@lug-owl.de>
Mail-Followup-To: Geert Uytterhoeven <geert@linux-m68k.org>,
	Linux Kernel Development <linux-kernel@vger.kernel.org>
References: <20050731222606.GL3608@stusta.de> <21d7e99705080318347d6b58d5@mail.gmail.com> <20050804065447.GB25606@lug-owl.de> <Pine.LNX.4.62.0508120938560.18366@numbat.sonytel.be>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mP3DRpeJDSE+ciuQ"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0508120938560.18366@numbat.sonytel.be>
X-Operating-System: Linux mail 2.6.12.3lug-owl 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 2005-08-12 09:40:18 +0200, Geert Uytterhoeven <geert@linux-m68k.org=
> wrote:
> On Thu, 4 Aug 2005, Jan-Benedict Glaw wrote:
> > -sh-3.00# cat cpuinfo
> > cpu             : VAX
> > cpu type        : KA43
> > cpu sid         : 0x0b000006
> > cpu sidex       : 0x04010002
> > page size       : 4096
> > BogoMIPS        : 10.08
> > -sh-3.00# cat version
> > Linux version 2.6.12 (jbglaw@d2) (gcc version 4.1.0 20050803 (experimen=
tal)) #2 Wed Aug 3 23:42:11 CEST 2005
>=20
> Any change we will see this code in mainline?

That's the plan. We haven't publically talked about it yet, but we'd
probably like to present the code for review once we

	- have enough hardware supported. At least local SCSI drivers
	  for the most common machines should be available, as well as
	  network drivers. That's not yet the case.

	- have userspace working again. Currently, a very old gcc is
	  used. I'm working on uClibc (and thereafter GNU libc) in
	  conjunction with gcc-HEAD as time allows.

So yes, we want to show off the code, but we don't want to do that
publically and right now. There are still to many places where the code
needs some tidy-up (and be it whitespace and comment fixes), but
everybody is welcome to peek at our CVS repo
(http://sourceforge.net/cvs/?group_id=3D2626) or to join the mailing list
(at http://www.pergamentum.com/mailman/listinfo/linux-vax).

So if *you* are looking for some beginner's task to start with kernel
development, here you go! Oh, and SMP fun will hopefully start soon. A
machine is on the way and I hope it'll survive shipping :-)

VAX is also an interesting platform because it's another platform
offering TurboChannel slots. So if you're interested in those old Alphas
or DECstations, VAX is for you, too.

MfG, JBG

--=20
Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481             =
_ O _
"Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg  =
_ _ O
 fuer einen Freien Staat voll Freier B=C3=BCrger" | im Internet! |   im Ira=
k!   O O O
ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TCPA)=
);

--mP3DRpeJDSE+ciuQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFC/JYvHb1edYOZ4bsRAtJ6AJ4irHHY4OFcnhAU0LSAEFJQQWbFFQCfcyd/
h1DLJ19T+x5Kxv63Ospm/pk=
=GO4+
-----END PGP SIGNATURE-----

--mP3DRpeJDSE+ciuQ--
