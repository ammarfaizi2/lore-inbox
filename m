Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270377AbTGSS2F (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jul 2003 14:28:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270449AbTGSS2E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jul 2003 14:28:04 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:38920 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S270377AbTGSS1u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jul 2003 14:27:50 -0400
Date: Sat, 19 Jul 2003 20:42:46 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Bitkeeper
Message-ID: <20030719184246.GF7452@lug-owl.de>
Mail-Followup-To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0307181603340.21716-100000@chimarrao.boston.redhat.com> <1058560325.2662.31.camel@localhost>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="l+goss899txtYvYf"
Content-Disposition: inline
In-Reply-To: <1058560325.2662.31.camel@localhost>
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--l+goss899txtYvYf
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 2003-07-18 15:32:06 -0500, Shawn <core@enodev.com>
wrote in message <1058560325.2662.31.camel@localhost>:
> To add to this, why?
>=20
> I don't mean to jump on anyone, but so long as someone can pull all the
> BK data out if Larry gets unreasonable (via the active and existing SVN
> or CVS gateways) who the frig cares if there's a BK clone??? If things
> got nasty, pull the data and switch unceremoniously switch to SVN or
> whatever.

Have you ever used eg. cvsps with the BK->CVS gateway? I tried this and
failed because of 4 issues:

	- I couldn't get the initial import patchset (2)
	- I couldn't get two other patchsets
	- One patchset added a file which already existed (11504)

Trying cvsps with the BKCVS gateway, you won't be able to automagically
import all these patchsets into some other SCM. I got the BKCVS->SVN
script and I'm still looking at it. Other than that, I'm to have a deep
look at cvsps if there's some hidden bug which lets it fail on mentioned
four patchsets...

However, I want to thank Larry for the BC->CVS gateway. Eventually, some
customers could make some use out of it, but it definitively tells us
that Larry is willing to do more than giving BK away (in most cases for
free (as in beer)) - he's investing in it as well as tryin' to keep us
using it (for what he offers some small presents from time to time such
as hosting service and BK->CVS).

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
      ret =3D do_actions((curr | FREE_SPEECH) & ~(IRAQ_WAR_2 | DRM | TCPA));

--l+goss899txtYvYf
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/GZElHb1edYOZ4bsRAnJRAJ0TsuVdijlxU0m213gAJrOzIVBnHACfYjG1
m+eYv+R4+vPnl/9JGhNRM5M=
=Yogy
-----END PGP SIGNATURE-----

--l+goss899txtYvYf--
