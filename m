Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268633AbUHZLxR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268633AbUHZLxR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 07:53:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268825AbUHZLvT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 07:51:19 -0400
Received: from websrv2.werbeagentur-aufwind.de ([213.239.197.240]:31887 "EHLO
	websrv2.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S268779AbUHZLpL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 07:45:11 -0400
Subject: Re: silent semantic changes with reiser4
From: Christophe Saout <christophe@saout.de>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Hans Reiser <reiser@namesys.com>, viro@parcelfarce.linux.theplanet.co.uk,
       Linus Torvalds <torvalds@osdl.org>, Christoph Hellwig <hch@lst.de>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
In-Reply-To: <20040826112818.GL5618@nocona.random>
References: <20040824202521.GA26705@lst.de> <412CEE38.1080707@namesys.com>
	 <20040825200859.GA16345@lst.de>
	 <Pine.LNX.4.58.0408251314260.17766@ppc970.osdl.org>
	 <20040825204240.GI21964@parcelfarce.linux.theplanet.co.uk>
	 <1093467601.9749.14.camel@leto.cs.pocnet.net>
	 <20040825225933.GD5618@nocona.random> <412DA0B5.3030301@namesys.com>
	 <20040826112818.GL5618@nocona.random>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-3o/X0P83FpY+EEiSgBeq"
Date: Thu, 26 Aug 2004 13:44:59 +0200
Message-Id: <1093520699.9004.11.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.92.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-3o/X0P83FpY+EEiSgBeq
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Am Donnerstag, den 26.08.2004, 13:28 +0200 schrieb Andrea Arcangeli:

> then what's the difference in having the plugin fixed in stone into
> reiserfs? That's my whole point.

I think you're not exactly understanding what a reiser4 "plugin" is.

Currently plugins are not modules. It just means that there's a defined
interface between the reiser4 core and the plugins. Just like you could
see filesystems as "VFS plugins".

In fact, reiser4 plugins are
- users of the reiser4 core API
- some of them are implementing Linux VFS methods (thus being some sort
of glue code between the Reiser4 storage tree and the Linux VFS)


--=-3o/X0P83FpY+EEiSgBeq
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBBLc06ZCYBcts5dM0RAqmEAKCjJESdMq2LaHs42lDP4ePeYdtv/ACfaRLi
OhTM+T+ZOXDAS6nlQTZhjKk=
=AQlw
-----END PGP SIGNATURE-----

--=-3o/X0P83FpY+EEiSgBeq--

