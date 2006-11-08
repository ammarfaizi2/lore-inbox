Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422795AbWKHUO7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422795AbWKHUO7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 15:14:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422829AbWKHUO6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 15:14:58 -0500
Received: from lug-owl.de ([195.71.106.12]:55271 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S1422795AbWKHUO5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 15:14:57 -0500
Date: Wed, 8 Nov 2006 21:14:56 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Joakim Tjernlund <joakim.tjernlund@transmode.se>,
       linux-kernel@vger.kernel.org
Subject: Re: How to compile module params into kernel?
Message-ID: <20061108201456.GD21485@lug-owl.de>
Mail-Followup-To: Jesper Juhl <jesper.juhl@gmail.com>,
	Joakim Tjernlund <joakim.tjernlund@transmode.se>,
	linux-kernel@vger.kernel.org
References: <9a8748490611081105j5ca1d24ahd49c6d9ea7d980d3@mail.gmail.com> <02fd01c70370$d9af6700$020120ac@Jocke> <9a8748490611081209s37e5bfa7m2ddb49a23288ffbd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="o5hfEDzsoqw8wJwC"
Content-Disposition: inline
In-Reply-To: <9a8748490611081209s37e5bfa7m2ddb49a23288ffbd@mail.gmail.com>
X-Operating-System: Linux mail 2.6.12.3lug-owl 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--o5hfEDzsoqw8wJwC
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 2006-11-08 21:09:04 +0100, Jesper Juhl <jesper.juhl@gmail.com> wrot=
e:
> On 08/11/06, Joakim Tjernlund <joakim.tjernlund@transmode.se> wrote:
> > > -----Original Message-----
> > > From: Jesper Juhl [mailto:jesper.juhl@gmail.com]
> > > On 08/11/06, Joakim Tjernlund <joakim.tjernlund@transmode.se> wrote:
> > > > Instead of passing a module param on the cmdline I want to compile =
that
> > > > into the kernel, but I can't figure out how.
> > > You could edit the module source and hardcode default values.
> > Yes, but I don't want to do that since it makes maintance
> > harder.
> Well, as far as I know, there's no way to specify default module
> options at compile time. The defaults are set in the module source and
> are modifiable at module load time or by setting options on the kernel
> command line at boot tiem. So, if that's no good for you I don't see
> any other way except modifying the source to hardcode new defaults.

However, that could probably be hacked in easily. We use a similar
approach for VAX, since we're not yet regularly booting off a local
harddisk, but commonly via MOP off the network.

MfG, JBG

--=20
      Jan-Benedict Glaw      jbglaw@lug-owl.de              +49-172-7608481
Signature of:           Ich hatte in letzter Zeit ein bi=C3=9Fchen viel Rea=
litycheck.
the second  :               Langsam m=C3=B6chte ich mal wieder weitertr=C3=
=A4umen k=C3=B6nnen.

--o5hfEDzsoqw8wJwC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFFUjrAHb1edYOZ4bsRArbMAJ9VE7ejdnqGFMwgE+xeFFIJiBsc7ACfZ8Av
duF2bsWt7Bmf5yP+lPbwEbw=
=DOOj
-----END PGP SIGNATURE-----

--o5hfEDzsoqw8wJwC--
