Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268552AbTGSSmm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jul 2003 14:42:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270466AbTGSSmm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jul 2003 14:42:42 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:15881 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S268552AbTGSSmk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jul 2003 14:42:40 -0400
Date: Sat, 19 Jul 2003 20:57:37 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Larry McVoy <lm@work.bitmover.com>
Subject: Re: Bitkeeper
Message-ID: <20030719185737.GG7452@lug-owl.de>
Mail-Followup-To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Larry McVoy <lm@work.bitmover.com>
References: <Pine.LNX.4.44.0307181603340.21716-100000@chimarrao.boston.redhat.com> <1058560325.2662.31.camel@localhost> <20030719184246.GF7452@lug-owl.de> <20030719184944.GC24197@work.bitmover.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lHGcFxmlz1yfXmOs"
Content-Disposition: inline
In-Reply-To: <20030719184944.GC24197@work.bitmover.com>
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--lHGcFxmlz1yfXmOs
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, 2003-07-19 11:49:44 -0700, Larry McVoy <lm@bitmover.com>
wrote in message <20030719184944.GC24197@work.bitmover.com>:
> On Sat, Jul 19, 2003 at 08:42:46PM +0200, Jan-Benedict Glaw wrote:
> > Have you ever used eg. cvsps with the BK->CVS gateway? I tried this and
> > failed because of 4 issues:
> >=20
> > 	- I couldn't get the initial import patchset (2)
> > 	- I couldn't get two other patchsets
> > 	- One patchset added a file which already existed (11504)
>=20
> Work with Ben Collins on that.  I don't know what cvsps is so I can't
> help you there.  If you can figure out what is wrong with the tree and=20
> explain what we should do to fix it, we'll give it a tree.

Thanks fot hint'n'offer!

Basically, cvsps sucks off the rlog messages and compares any check-in
texts / times of any files to find out what has been checked-in with a
single check-in. That is then called a patchset (cvs_ps_). With some
command line arguments, it'll then output the check-in text as well as a
unified diff.

This information can then be used to feed it to other SCMs or for simple
review tasks. While doing consistency checks, I discivered the mentioned
inconsistency (at patchset 11504 IIRC) as well as some minor glitches (I
had one patchset where the check-in comment changed after I re-fetched
the patchset some days later...).

However, I'm working at spare time on it, so it'll take some time:(

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
      ret =3D do_actions((curr | FREE_SPEECH) & ~(IRAQ_WAR_2 | DRM | TCPA));

--lHGcFxmlz1yfXmOs
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/GZSgHb1edYOZ4bsRAlKYAJwK5bD1YY/xLp+8vWioWR/mN6tL5QCfVcnI
VA5r6dmzEGdbV1G5Vtt8neI=
=KD4K
-----END PGP SIGNATURE-----

--lHGcFxmlz1yfXmOs--
