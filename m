Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263857AbTLJSh3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 13:37:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263868AbTLJSh3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 13:37:29 -0500
Received: from dvmwest.gt.owl.de ([62.52.24.140]:48013 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S263857AbTLJSh1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 13:37:27 -0500
Date: Wed, 10 Dec 2003 19:37:23 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux GPL and binary module exception clause?
Message-ID: <20031210183723.GK29648@lug-owl.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.10.10312100550500.3805-100000@master.linux-ide.org> <Pine.LNX.4.58.0312100714390.29676@home.osdl.org> <20031210153254.GC6896@work.bitmover.com> <Pine.LNX.4.58.0312100809150.29676@home.osdl.org> <20031210163425.GF6896@work.bitmover.com> <Pine.LNX.4.58.0312100852210.29676@home.osdl.org> <20031210175614.GH6896@work.bitmover.com> <Pine.LNX.4.58.0312100959180.29676@home.osdl.org> <20031210180822.GI6896@work.bitmover.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="arYKMy5bKB/hcRo6"
Content-Disposition: inline
In-Reply-To: <20031210180822.GI6896@work.bitmover.com>
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--arYKMy5bKB/hcRo6
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 2003-12-10 10:08:22 -0800, Larry McVoy <lm@bitmover.com>
wrote in message <20031210180822.GI6896@work.bitmover.com>:
> On Wed, Dec 10, 2003 at 10:02:47AM -0800, Linus Torvalds wrote:
> > On Wed, 10 Dec 2003, Larry McVoy wrote:

> Technicality.  Which, by your own reasoning, doesn't count.  Linux does
> indeed have a binary interface, many people download drivers from some
> website (I've done it a pile of times) and stuck them in and they worked.
> I did that with the modem on my thinkpad across more than 10 kernel
> versions in the 2.2 or 2.4 timeframe.

But guess - that can fire back, too. Just had it these days: I've build
a Linux kernel with, erm, some strange GCC options (hey, I like playing)
and inserted AVM's binars ISDN driver. Guess what had happened then:)

That is, just let's stop to prattle about binary modules. We praddle
(all the time) that there's no thing called an "ABI" in Linux for
modules, but in The Real World, the ABIs of two kernel images are
quasi-identical (except in some instances which can easily be caught by
a wrapper module).

So it's all about *really* changing ABI things here and there. Yes, an
obnoxious pig I am:) I'd start thinking about who I could achieve that
in a working manner...

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
   ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TC=
PA));

--arYKMy5bKB/hcRo6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/12fjHb1edYOZ4bsRAkBCAJ95VoU/4pc+BdJPkylRIpzAViAHzQCfVNex
izgbfDeSr44aerVq/Byk9Ik=
=rHYp
-----END PGP SIGNATURE-----

--arYKMy5bKB/hcRo6--
