Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266684AbUIENtA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266684AbUIENtA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 09:49:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266705AbUIENs7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 09:48:59 -0400
Received: from pauli.thundrix.ch ([213.239.201.101]:51111 "EHLO
	pauli.thundrix.ch") by vger.kernel.org with ESMTP id S266684AbUIENsz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 09:48:55 -0400
Date: Sun, 5 Sep 2004 15:44:28 +0200
From: Tonnerre <tonnerre@thundrix.ch>
To: Helge Hafting <helge.hafting@hist.no>
Cc: Oliver Hunt <oliverhunt@gmail.com>, Hans Reiser <reiser@namesys.com>,
       Linus Torvalds <torvalds@osdl.org>, David Masover <ninja@slaphack.com>,
       Jamie Lokier <jamie@shareable.org>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, Adrian Bunk <bunk@fs.tum.de>,
       viro@parcelfarce.linux.theplanet.co.uk, Christoph Hellwig <hch@lst.de>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: The argument for fs assistance in handling archives
Message-ID: <20040905134428.GN26560@thundrix.ch>
References: <Pine.LNX.4.58.0409012037300.2295@ppc970.osdl.org> <4136A14E.9010303@slaphack.com> <Pine.LNX.4.58.0409012259340.2295@ppc970.osdl.org> <4136C876.5010806@namesys.com> <Pine.LNX.4.58.0409020030220.2295@ppc970.osdl.org> <4136E0B6.4000705@namesys.com> <4699bb7b04090202121119a57b@mail.gmail.com> <4136E756.8020105@hist.no> <4699bb7b0409020245250922f9@mail.gmail.com> <413829DF.8010305@hist.no>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cs5saTBZh7UZl2eX"
Content-Disposition: inline
In-Reply-To: <413829DF.8010305@hist.no>
X-GPG-KeyID: 0x8BE1C38D
X-GPG-Fingerprint: 1AB0 9AD6 D0C8 B9D5 C5C9  9C2A FF86 CBEE 8BE1 C38D
X-GPG-KeyURL: http://users.thundrix.ch/~tonnerre/tonnerre.asc
User-Agent: Mutt/1.5.6+20040803i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--cs5saTBZh7UZl2eX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Salut,

On Fri, Sep 03, 2004 at 10:22:55AM +0200, Helge Hafting wrote:
> Requiring another syscall to open forks other than the primary
> breaks _all_ existing software because it obviously don't use that
> syscall yet.  And then it doesn't provide any advantages over the
> file-as-plain-directory way. . .

Actually...

We might tune the sys_open()  call to take an additional argument (the
stream ID),  and introduce a compatibility interface  into *libc which
chooses strid=0 by default if the plain old open call is being used.

Maybe this can be handled transparently by cpp..

				Tonnerre

--cs5saTBZh7UZl2eX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.9.2 (GNU/Linux)

iD8DBQFBOxg7/4bL7ovhw40RArEkAKCGugmKqnEyIyYQHkVjSqDHPLxNygCfU9Ht
5UBGJMH5EqX+IOlE9L7BQm4=
=Kqz5
-----END PGP SIGNATURE-----

--cs5saTBZh7UZl2eX--
