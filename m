Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264538AbTGKReM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 13:34:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264539AbTGKReM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 13:34:12 -0400
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:55281 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S264538AbTGKReL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 13:34:11 -0400
Subject: Re: [RFC] KBUILD 2.5 issues/regressions
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Alistair J Strachan <alistair@devzero.co.uk>
Cc: linux-kernel@vger.kernel.org, sam@ravnborg.org, kai@tp1.ruhr-uni-bochum.de
In-Reply-To: <200307111840.31225.alistair@devzero.co.uk>
References: <200307111840.31225.alistair@devzero.co.uk>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-T5uK3nMl4hJGel9UkSGp"
Organization: Red Hat, Inc.
Message-Id: <1057945659.5806.8.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 (1.4.0-2) 
Date: 11 Jul 2003 19:47:39 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-T5uK3nMl4hJGel9UkSGp
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2003-07-11 at 19:40, Alistair J Strachan wrote:

> o The state of kbuild in shipped (distribution) kernels must be such that=
 the
>    construction of external modules can be done without having to modify =
the
>    shipped kernel-source package.

that is actually not hard; I just did this in a RH rpm like way last
week.=20
> So far, this matches the behaviour in 2.4. However, in 2.4 you need only =
do a
> "make dep" (and, I believe, some distros also touch a couple of other fil=
es).

you never ever should need to do make dep in distro trees for building
external modules.



--=-T5uK3nMl4hJGel9UkSGp
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/Dvg7xULwo51rQBIRAnqyAKCRzj24wj0+vFyLrtz6Ckq+1QDXlACfQJGw
ELI+Zd/hj21ybOOCwwRgCcA=
=xxAr
-----END PGP SIGNATURE-----

--=-T5uK3nMl4hJGel9UkSGp--
