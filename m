Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268877AbUIHGWH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268877AbUIHGWH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 02:22:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268878AbUIHGWH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 02:22:07 -0400
Received: from pauli.thundrix.ch ([213.239.201.101]:25006 "EHLO
	pauli.thundrix.ch") by vger.kernel.org with ESMTP id S268875AbUIHGWA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 02:22:00 -0400
Date: Wed, 8 Sep 2004 08:20:10 +0200
From: Tonnerre <tonnerre@thundrix.ch>
To: David Masover <ninja@slaphack.com>
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>, Spam <spam@tnonline.net>,
       Christer Weinigel <christer@weinigel.se>,
       Linus Torvalds <torvalds@osdl.org>, Pavel Machek <pavel@ucw.cz>,
       Jamie Lokier <jamie@shareable.org>, Chris Wedgwood <cw@f00f.org>,
       viro@parcelfarce.linux.theplanet.co.uk, Christoph Hellwig <hch@lst.de>,
       Hans Reiser <reiser@namesys.com>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040908062010.GD1630@thundrix.ch>
References: <200409070206.i8726vrG006493@localhost.localdomain> <413D4C18.6090501@slaphack.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LKTjZJSUETSlgu2t"
Content-Disposition: inline
In-Reply-To: <413D4C18.6090501@slaphack.com>
X-GPG-KeyID: 0x8BE1C38D
X-GPG-Fingerprint: 1AB0 9AD6 D0C8 B9D5 C5C9  9C2A FF86 CBEE 8BE1 C38D
X-GPG-KeyURL: http://users.thundrix.ch/~tonnerre/tonnerre.asc
User-Agent: Mutt/1.5.6+20040803i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--LKTjZJSUETSlgu2t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Salut,

On Tue, Sep 07, 2004 at 12:50:16AM -0500, David Masover wrote:
> Transparently?
>=20
> It _works_ to do
> 	zcat file.gz > /tmp/file
> 	vim /tmp/file
> 	gzip -c /tmp/file > file.gz
> 	rm /tmp/file
> You can even do that as a script, call it zvim.  You could even do it as
> a generic script, where "vim" is replaced with "$1".  But is it as
> elegent as transparently compressed files?

=2E..or   you    get   yourself    a   sane   editor    which   supports
gzopen/gzread/gzwrite/gzclose. You can do  that in userland, no kernel
implementation needed.

			    Tonnerre

--LKTjZJSUETSlgu2t
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.9.2 (GNU/Linux)

iD8DBQFBPqSZ/4bL7ovhw40RAnRSAKCjvxdu9VLt5aJKGbXn4R4/RHnJaACdEEdV
TYR9eYHwO62vBMiClfwbiOI=
=DfqP
-----END PGP SIGNATURE-----

--LKTjZJSUETSlgu2t--
