Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266310AbUIELYP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266310AbUIELYP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 07:24:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266304AbUIELYP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 07:24:15 -0400
Received: from pauli.thundrix.ch ([213.239.201.101]:7847 "EHLO
	pauli.thundrix.ch") by vger.kernel.org with ESMTP id S266189AbUIELYJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 07:24:09 -0400
Date: Sun, 5 Sep 2004 13:22:47 +0200
From: Tonnerre <tonnerre@thundrix.ch>
To: Christer Weinigel <christer@weinigel.se>
Cc: Pavel Machek <pavel@ucw.cz>, Linus Torvalds <torvalds@osdl.org>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       David Masover <ninja@slaphack.com>, Jamie Lokier <jamie@shareable.org>,
       Chris Wedgwood <cw@f00f.org>, viro@parcelfarce.linux.theplanet.co.uk,
       Christoph Hellwig <hch@lst.de>, Hans Reiser <reiser@namesys.com>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040905112247.GD26560@thundrix.ch>
References: <200408311931.i7VJV8kt028102@laptop11.inf.utfsm.cl> <Pine.LNX.4.58.0408311252150.2295@ppc970.osdl.org> <20040831203226.GB16110@elf.ucw.cz> <Pine.LNX.4.58.0408311336580.2295@ppc970.osdl.org> <20040831205422.GD16110@elf.ucw.cz> <Pine.LNX.4.58.0408311357550.2295@ppc970.osdl.org> <20040831220726.GB16428@elf.ucw.cz> <m3acwa99qz.fsf@zoo.weinigel.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/unnNtmY43mpUSKx"
Content-Disposition: inline
In-Reply-To: <m3acwa99qz.fsf@zoo.weinigel.se>
X-GPG-KeyID: 0x8BE1C38D
X-GPG-Fingerprint: 1AB0 9AD6 D0C8 B9D5 C5C9  9C2A FF86 CBEE 8BE1 C38D
X-GPG-KeyURL: http://users.thundrix.ch/~tonnerre/tonnerre.asc
User-Agent: Mutt/1.5.6+20040803i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--/unnNtmY43mpUSKx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Salut,

On Wed, Sep 01, 2004 at 01:19:00AM +0200, Christer Weinigel wrote:
> To see if the original file is newer than the cached file, good old
> mtime can be used. =20

I'd not use a daemon or any  mtime for it. I'd just put it into xattrs
and let  it up  to the applications  to poke  the values in  case they
changed. And copy them on cp, since it would have to be changed either
way.

			    Tonnerre

--/unnNtmY43mpUSKx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.9.2 (GNU/Linux)

iD8DBQFBOvcG/4bL7ovhw40RAkoKAJ0U0fSMgumeX9eP9SUlbvMTdT61RgCfapSN
bLBk3UvV4YdXw0VRYkbd0Zo=
=vgc5
-----END PGP SIGNATURE-----

--/unnNtmY43mpUSKx--
