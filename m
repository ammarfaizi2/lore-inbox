Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272115AbTGYOGN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 10:06:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272116AbTGYOGN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 10:06:13 -0400
Received: from D71aa.pppool.de ([80.184.113.170]:11180 "EHLO
	nicole.de.interearth.com") by vger.kernel.org with ESMTP
	id S272115AbTGYOGM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 10:06:12 -0400
Subject: Re: Reiser4 status: benchmarked vs. V3 (and ext3)
From: Daniel Egger <degger@fhm.edu>
To: Nikita Danilov <Nikita@Namesys.COM>
Cc: Hans Reiser <reiser@namesys.com>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
       reiserfs mailing list <reiserfs-list@namesys.com>
In-Reply-To: <16161.10863.793737.229170@laputa.namesys.com>
References: <3F1EF7DB.2010805@namesys.com>
	 <1059062380.29238.260.camel@sonja>
	 <16160.4704.102110.352311@laputa.namesys.com>
	 <1059093594.29239.314.camel@sonja>
	 <16161.10863.793737.229170@laputa.namesys.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-zZxwTz4+4qIfWF1DwMQj"
Message-Id: <1059142851.6962.18.camel@sonja>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 25 Jul 2003 16:20:52 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-zZxwTz4+4qIfWF1DwMQj
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Am Fre, 2003-07-25 um 15.02 schrieb Nikita Danilov:

> No special measures are taken to level block allocation. Wandered blocks
> are allocated to improve packing i.e., place blocks of the same file
> close to each other. Actually, it tries to place tree nodes in the
> parent-first order.

So the new blocks are created as close as possible to the old blocks
instead of say spreading them as far as possible. This is pretty bad for
usage in the embedded world but I guess this is not the market you're
aiming at. :(

--=20
Servus,
       Daniel

--=-zZxwTz4+4qIfWF1DwMQj
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/ITzDchlzsq9KoIYRAjCkAJ9NgpQRLL498Zy+8OW4MSxcmwNIbwCglW/L
8aA88cOOibNYjlaCVcGV2Ic=
=oIIy
-----END PGP SIGNATURE-----

--=-zZxwTz4+4qIfWF1DwMQj--

