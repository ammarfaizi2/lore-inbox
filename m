Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263793AbTICQAS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 12:00:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263930AbTICP6l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 11:58:41 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:25778 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S263898AbTICP6Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 11:58:16 -0400
Date: Wed, 3 Sep 2003 17:58:14 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Binary modules for 2.6
Message-ID: <20030903155814.GI14376@lug-owl.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <123-216863213.20030903054040@ecommerce.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GVLQrlG8+/jMfW4X"
Content-Disposition: inline
In-Reply-To: <123-216863213.20030903054040@ecommerce.com>
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--GVLQrlG8+/jMfW4X
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 2003-09-03 05:40:40 +0200, Dumitru Stama <dics@ecommerce.com>
wrote in message <123-216863213.20030903054040@ecommerce.com>:
> With the current layout of the kernel modules there will be no way of
> distributing binary kernel modules anymore. Considering the structures

No? If it were like this, I'd say I'd really like that:)

> that combine to describe the way module works and the alignement of
> those depending on the processor type even if that processor is i386
> compatible. Personally i think this is a good move for open source

Well, Linux aims towards source compatibility. If you want to ship
binary modules, you've got to do *lots* of compilation.

You've to compile for all and any large distributions, and additionally,
some people will ask you to compile with their very personal kernel tree
(thay might have added loads of patches) and their .config file.

> community but what are we gona do with the proprietary drivers that do
> not have the sources available ?

If it's like that, vendors of binary modules may face a lot of
recompilation then...

However, such things are usually done in another way. If you encounter
such situations, you'll write a binrary-only core module plus some glue
code which will compiled on the client's system. You hardcode your
binary interface, the customer compiles Linux' source-comparible
interface. That'll resolve the problem.

However, you see that it's a PITA to live with binary-only modules. It's
easier to release sources:)

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
      ret =3D do_actions((curr | FREE_SPEECH) & ~(IRAQ_WAR_2 | DRM | TCPA));

--GVLQrlG8+/jMfW4X
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/Vg+WHb1edYOZ4bsRAiDEAJ9rOlw8uH6uhrMbYg/PP1V5XWYLMwCfYqjx
seRIUL3qKrqGtPZfpu8xolQ=
=IeKg
-----END PGP SIGNATURE-----

--GVLQrlG8+/jMfW4X--
