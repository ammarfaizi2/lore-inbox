Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274996AbTHFLs0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 07:48:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274997AbTHFLs0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 07:48:26 -0400
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:40431 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S274996AbTHFLsY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 07:48:24 -0400
Subject: Re: [Swsusp-devel] Re: [PATCH] Allow initrd_load() before
	software_resume() (version 2)
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Pavel Machek <pavel@ucw.cz>
Cc: Nigel Cunningham <ncunningham@clear.net.nz>,
       Pascal Brisset <pascal.brisset-ml@wanadoo.fr>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       swsusp-devel <swsusp-devel@lists.sourceforge.net>
In-Reply-To: <20030806113045.GB583@elf.ucw.cz>
References: <20030801002742.1033FE8003AE@mwinf0502.wanadoo.fr>
	 <1059700691.1750.1.camel@laptop-linux>
	 <20030801103054.9E75F30003B9@mwinf0201.wanadoo.fr>
	 <1059734493.11684.0.camel@laptop-linux>  <20030806113045.GB583@elf.ucw.cz>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-4bnnTn5a8ye7V7cOoJw6"
Organization: Red Hat, Inc.
Message-Id: <1060170451.5848.2.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 (1.4.3-3) 
Date: 06 Aug 2003 13:47:31 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-4bnnTn5a8ye7V7cOoJw6
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2003-08-06 at 13:30, Pavel Machek wrote:
> Hi!
>=20
> > Okay. I hadn't tried it yet. I'll happily take up the barrow for you an=
d
> > push it to Pavel and Linus with the rest, if you like.
>=20
> Don't even think about that.
>=20
> It is not safe to run userspace *before* doing resume. You don't want
> to see problems this would bring in. Forget it.
> 		=09
so how do you resume from a partition on a device mapper volume?

(and yes I basically agree with your sentiment though)

--=-4bnnTn5a8ye7V7cOoJw6
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/MOrQxULwo51rQBIRApdTAJ4hFUWiNahqqW3qC6qUsaU/Ndh9kwCeODQB
Hvg+XT2gKi458OBZoMgOceM=
=7NvU
-----END PGP SIGNATURE-----

--=-4bnnTn5a8ye7V7cOoJw6--
