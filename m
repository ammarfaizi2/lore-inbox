Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270511AbTGSTr5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jul 2003 15:47:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270502AbTGSTr4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jul 2003 15:47:56 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:48137 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S270481AbTGSTrz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jul 2003 15:47:55 -0400
Date: Sat, 19 Jul 2003 22:02:53 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Larry McVoy <lm@work.bitmover.com>
Subject: Re: Bitkeeper
Message-ID: <20030719200252.GH7452@lug-owl.de>
Mail-Followup-To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Larry McVoy <lm@work.bitmover.com>
References: <Pine.LNX.4.44.0307181603340.21716-100000@chimarrao.boston.redhat.com> <1058560325.2662.31.camel@localhost> <20030719184246.GF7452@lug-owl.de> <20030719184944.GC24197@work.bitmover.com> <20030719185737.GG7452@lug-owl.de> <20030719190531.GB24698@work.bitmover.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nFBW6CQlri5Qm8JQ"
Content-Disposition: inline
In-Reply-To: <20030719190531.GB24698@work.bitmover.com>
X-Operating-System: Linux mail 2.4.18
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--nFBW6CQlri5Qm8JQ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, 2003-07-19 12:05:31 -0700, Larry McVoy <lm@bitmover.com>
wrote in message <20030719190531.GB24698@work.bitmover.com>:
> > Basically, cvsps sucks off the rlog messages and compares any check-in
>=20
> Hmm.  I would guess that makes rlog very happy.  And sleepy :)

Well, it's not exactly fast and it takes quite some CPU cycles on my
side. However, that's a spare box (HP-PARISC B132L+, 132 MHz) which
doesn't have to do anything else:)

>=20
>     wget http://linux.bkbits.net/linux-2.5/gnupatch@1.5234
>=20
> and get something like the following.  I suspect this is better than
> cvsps and it will work for all repositories on bkbits.net, not just=20
> the mainline one.  Is that good enough for what you want?  The format
> below repeats for each file in the changeset.

That's quite good:) Are file renames also represented as patches (ie.
one file gets removed, another one is added)?

To draw the line, that's exactly what one could wish. It someone isn't
happy with the format, it seems to be easily Perl'ed/sed'ed/...

I've not yet looked at any other trees than the linux-2.5^H6 tree, but
I'm currently spending some time to work on merging some trees to one
(read: I want to merge all the non-i386 linux ports) and that involves
quite some scripting / SCMing and up to now, I've not found the
Super-SCM to achieve that:) Tasks are to get all ports to current 2.6.x,
distribute their patches among them and pushing it (separated in small
pieces) to Linus at some far future...

If I could get perfect patches like that out of bkbits.net (at least for
the projects hosted there), that could potentially ease the task a lot:)

MfG, JBG
PS: http://lug-owl.de/~jbglaw/linux-ports/
PPS: I'm missing quite a lot of informations there - if you're a port
maintainer, please get in contact with me:)

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
      ret =3D do_actions((curr | FREE_SPEECH) & ~(IRAQ_WAR_2 | DRM | TCPA));

--nFBW6CQlri5Qm8JQ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/GaPsHb1edYOZ4bsRArQyAJ0fOgkOzbJK2IMx68iLGL7LuHexggCfSeiR
BQyoPs/69zpULdxl5Y+OzAk=
=MA33
-----END PGP SIGNATURE-----

--nFBW6CQlri5Qm8JQ--
