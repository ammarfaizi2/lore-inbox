Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264152AbTCXLWy>; Mon, 24 Mar 2003 06:22:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264154AbTCXLWy>; Mon, 24 Mar 2003 06:22:54 -0500
Received: from dvmwest.gt.owl.de ([62.52.24.140]:1035 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id <S264152AbTCXLWw>;
	Mon, 24 Mar 2003 06:22:52 -0500
Date: Mon, 24 Mar 2003 12:33:59 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Deprecating .gz format on kernel.org
Message-ID: <20030324113359.GF30613@lug-owl.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.33.0303201138000.29061-100000@router.windsormachine.com> <3E79FFAD.3040904@inet.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="p8PhoBjPxaQXD0vg"
Content-Disposition: inline
In-Reply-To: <3E79FFAD.3040904@inet.com>
User-Agent: Mutt/1.4i
X-Operating-System: Linux mail 2.4.18
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--p8PhoBjPxaQXD0vg
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 2003-03-20 11:51:41 -0600, Eli Carter <eli.carter@inet.com>
wrote in message <3E79FFAD.3040904@inet.com>:
> Mike Dresser wrote:
> >On Thu, 20 Mar 2003, Jan-Benedict Glaw wrote:
> >
> >>jbglaw@schnarchnase:/tmp$ cat /proc/cpuinfo
> >
> >
> >>bogomips        : 15.10
>=20
> So, who can beat his 15.10 bogomips?  Anyone run <1 bogomips?

I've tested an Intel i386SX, 16MHz these days. It reached 1.19 Bogomips
IIRC using 2.4.x.

As you may see, I'm currently collecting very different hardware (very
old ia32 based systems as well as anything !=3D ia32 capable of running
Linux). My goal is to build an (automated) compile & boot farm of
machines to detect major breakages _early_. In the past few years, we
had quite some ups (and some really hard downs...) which I want to see:

- Remember SCSI-eh changes? Some drivers still need to be ported (or am
  I wrong here?)
- module-init-tools took quite some time...
- sparc32 unfortunately is not yet really running 2.5.x. 2.4.x doesn't
  do SMP for me (Level 15 Interrupt). However, here I do know when this
  was introduced and I'll have a look. Somewhen...
- ...

Things are easier to sort out as long as the breakages are _new_. If
they're there for a year and nobody cares about fixing them, non-ia32
architectures might again be near being dropped (sun4?).

With some luck, I'll get some room (incl. power and IP connectivity)
near Halle/Westf. (Germany). If this fails, I'd be _really_ interested
in other offers here... "CRT - Compile and Run a Test"

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
      ret =3D do_actions((curr | FREE_SPEECH) & ~(IRAQ_WAR_2 | DRM | TCPA));

--p8PhoBjPxaQXD0vg
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+fu0nHb1edYOZ4bsRAo6WAJ9k0W725JvsPWAA84wzkcCj79Cq3wCePuvd
fnCGiAU8CUHN/RTTgC9FM/Y=
=qSNu
-----END PGP SIGNATURE-----

--p8PhoBjPxaQXD0vg--
