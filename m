Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265964AbUFTWQr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265964AbUFTWQr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 18:16:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265965AbUFTWQq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 18:16:46 -0400
Received: from wblv-235-33.telkomadsl.co.za ([165.165.235.33]:21175 "EHLO
	gateway.lan") by vger.kernel.org with ESMTP id S265964AbUFTWQl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 18:16:41 -0400
Subject: Re: [PATCH 0/2] kbuild updates
From: Martin Schlemmer <azarah@nosferatu.za.org>
Reply-To: Martin Schlemmer <azarah@nosferatu.za.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>,
       Andreas Gruenbacher <agruen@suse.de>,
       Geert Uytterhoeven <geert@linux-m68k.org>,
       Kai Germaschewski <kai@germaschewski.name>
In-Reply-To: <20040620220319.GA10407@mars.ravnborg.org>
References: <20040620211905.GA10189@mars.ravnborg.org>
	 <1087767034.14794.42.camel@nosferatu.lan>
	 <20040620220319.GA10407@mars.ravnborg.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-TpQ3/RKmP1nnKiYcttLg"
Message-Id: <1087769761.14794.69.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 21 Jun 2004 00:16:02 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-TpQ3/RKmP1nnKiYcttLg
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2004-06-21 at 00:03, Sam Ravnborg wrote:
> On Sun, Jun 20, 2004 at 11:30:34PM +0200, Martin Schlemmer wrote:
> >=20
> > I know Sam's mta blocks my mail at least (lame isp), but for the rest,
> > please reconsider using this.
> Hmm, got your mail.
>=20
> > Many external modules, libs, etc use
> > /lib/modules/`uname -r`/build to locate the _source_, and this will
> > break them all.
> Examples please. What I have seen so far is modules that was not
> adapted to use kbuild when being build.
> If they fail to do so they are inherently broken.
>=20

Well, glibc use it for instance as an fall-through if you do not specify
it via ./configure arguments, or environment (yes, glibc should not use
it, etc, etc, no flames please =3D).  So as well does alsa-driver,
nvidia's drivers (gah, puke, yes, its got some binary-only stuff in
there ;), ati's drivers and a lot of other stuff (if you really need
them all I can try to find time to look for more).

I am not sure about ati's drivers and alsa, but nvidia uses kbuild.


Thanks,

--=20
Martin Schlemmer

--=-TpQ3/RKmP1nnKiYcttLg
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBA1gyhqburzKaJYLYRAuiRAJ9AGCtlaldgdCOdxwRfzyZAPI2mkACfR9/V
q/vLq/eTOG8wRJEpavuQh8E=
=5zpW
-----END PGP SIGNATURE-----

--=-TpQ3/RKmP1nnKiYcttLg--

