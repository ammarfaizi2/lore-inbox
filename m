Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264270AbTLBSpW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 13:45:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264278AbTLBSpW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 13:45:22 -0500
Received: from dvmwest.gt.owl.de ([62.52.24.140]:46726 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S264270AbTLBSpP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 13:45:15 -0500
Date: Tue, 2 Dec 2003 19:45:13 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4 future
Message-ID: <20031202184513.GU16507@lug-owl.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0312011212090.13692-100000@logos.cnet> <Pine.LNX.4.44.0312012302310.9674-100000@raven.themaw.net> <20031201153316.B3879@infradead.org> <200312020223.55505.snpe@snpe.co.yu> <20031202063912.GD16507@lug-owl.de> <Pine.LNX.4.58.0312020956120.1519@home.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bW7Nw90iaNQhVLQB"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0312020956120.1519@home.osdl.org>
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--bW7Nw90iaNQhVLQB
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 2003-12-02 10:04:24 -0800, Linus Torvalds <torvalds@osdl.org>
wrote in message <Pine.LNX.4.58.0312020956120.1519@home.osdl.org>:
> On Tue, 2 Dec 2003, Jan-Benedict Glaw wrote:
> >
> > On Tue, 2003-12-02 02:23:55 +0000, snpe <snpe@snpe.co.yu>
> > wrote in message <200312020223.55505.snpe@snpe.co.yu>:
> > > Is there linux-abi for 2.6 kernel ?
> >
> > Nobody really cares about ABI (at least, not enough to keep one stable)
> > while there's a good API. That requires sources, though, but that's a
> > good thing...

> You are, however, correct when it comes to internal kernel interfaces: we
> care not at all about ABI's, and even API's are fluid and are freely
> changed if there is a real technical reason for it. But that is only true
> for the internal kernel stuff (where source is obviously a requirement
> anyway).

Whenever The ABI Question (TM) comes up, it seems to be about claiming a
(binary compatible) interface - mostly for modules. But I think it's
widely accepted that there isn't much work done to have these truly (sp?)
binary compatible (eg. UP/SMP spinlocks et al.).

Of course, we want to have a somewhat stable interface for libc (->
userspace), but some struct (fb_info, ...) doesn't need to be binary
compatible - as long as a driver (given to be in source) still works
cleanly with it:)

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
   ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TC=
PA));

--bW7Nw90iaNQhVLQB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/zN25Hb1edYOZ4bsRAkKPAJ9YDk4zoHRdvmVlKezX/Suwib8yyACfcbdc
BLsVJvWrUey6pucErzWZVQg=
=5/nZ
-----END PGP SIGNATURE-----

--bW7Nw90iaNQhVLQB--
