Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266646AbUIEN3c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266646AbUIEN3c (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 09:29:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266669AbUIEN3c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 09:29:32 -0400
Received: from pauli.thundrix.ch ([213.239.201.101]:45991 "EHLO
	pauli.thundrix.ch") by vger.kernel.org with ESMTP id S266646AbUIEN32
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 09:29:28 -0400
Date: Sun, 5 Sep 2004 15:28:10 +0200
From: Tonnerre <tonnerre@thundrix.ch>
To: Oliver Hunt <oliverhunt@gmail.com>
Cc: Hans Reiser <reiser@namesys.com>, Linus Torvalds <torvalds@osdl.org>,
       David Masover <ninja@slaphack.com>, Jamie Lokier <jamie@shareable.org>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, Adrian Bunk <bunk@fs.tum.de>,
       viro@parcelfarce.linux.theplanet.co.uk, Christoph Hellwig <hch@lst.de>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: The argument for fs assistance in handling archives
Message-ID: <20040905132810.GM26560@thundrix.ch>
References: <Pine.LNX.4.58.0409011311150.2295@ppc970.osdl.org> <20040902002431.GN31934@mail.shareable.org> <413694E6.7010606@slaphack.com> <Pine.LNX.4.58.0409012037300.2295@ppc970.osdl.org> <4136A14E.9010303@slaphack.com> <Pine.LNX.4.58.0409012259340.2295@ppc970.osdl.org> <4136C876.5010806@namesys.com> <Pine.LNX.4.58.0409020030220.2295@ppc970.osdl.org> <4136E0B6.4000705@namesys.com> <4699bb7b04090202121119a57b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kunpHVz1op/+13PW"
Content-Disposition: inline
In-Reply-To: <4699bb7b04090202121119a57b@mail.gmail.com>
X-GPG-KeyID: 0x8BE1C38D
X-GPG-Fingerprint: 1AB0 9AD6 D0C8 B9D5 C5C9  9C2A FF86 CBEE 8BE1 C38D
X-GPG-KeyURL: http://users.thundrix.ch/~tonnerre/tonnerre.asc
User-Agent: Mutt/1.5.6+20040803i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--kunpHVz1op/+13PW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Salut,

On Thu, Sep 02, 2004 at 09:12:56PM +1200, Oliver Hunt wrote:
> getNumForks(fileref){ return 1;}=20

Actually it might be even cooler  to have a generic function which you
can apply to any file on a file system (or whatever) and which returns
you the  file system's capabilities  (can write, has xattrs,  has acl,
has multiple  streams, *not* has btree  lookups etc, as  that is *not*
interesting to userland anyway.)

				Tonnerre

--kunpHVz1op/+13PW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.9.2 (GNU/Linux)

iD8DBQFBOxRp/4bL7ovhw40RAtm6AKCVXu2FPURiqaOdSxCYJX4NiV+JrACdG0+Z
p2Jm8Y5p07XEv2tESDGiyUo=
=VoxE
-----END PGP SIGNATURE-----

--kunpHVz1op/+13PW--
