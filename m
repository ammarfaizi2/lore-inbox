Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266341AbUIFJDI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266341AbUIFJDI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 05:03:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267668AbUIFJDI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 05:03:08 -0400
Received: from pauli.thundrix.ch ([213.239.201.101]:39337 "EHLO
	pauli.thundrix.ch") by vger.kernel.org with ESMTP id S266341AbUIFJDA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 05:03:00 -0400
Date: Mon, 6 Sep 2004 10:58:19 +0200
From: Tonnerre <tonnerre@thundrix.ch>
To: Spam <spam@tnonline.net>
Cc: John Stoffel <stoffel@lucent.com>, David Masover <ninja@slaphack.com>,
       viro@parcelfarce.linux.theplanet.co.uk,
       Frank van Maarseveen <frankvm@xs4all.nl>,
       Dave Kleikamp <shaggy@austin.ibm.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Linus Torvalds <torvalds@osdl.org>,
       Jamie Lokier <jamie@shareable.org>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, Adrian Bunk <bunk@fs.tum.de>,
       Hans Reiser <reiser@namesys.com>, Christoph Hellwig <hch@lst.de>,
       fsdevel <linux-fsdevel@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: The argument for fs assistance in handling archives
Message-ID: <20040906085819.GE28697@thundrix.ch>
References: <20040901200806.GC31934@mail.shareable.org> <Pine.LNX.4.58.0409011311150.2295@ppc970.osdl.org> <1094118362.4847.23.camel@localhost.localdomain> <20040902203854.GA4801@janus> <1094160994.31499.19.camel@shaggy.austin.ibm.com> <20040902214806.GA5272@janus> <20040902220027.GD23987@parcelfarce.linux.theplanet.co.uk> <4137B5F5.8000402@slaphack.com> <16696.30683.207905.803165@gargle.gargle.HOWL> <112181186.20040903160117@tnonline.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qOrJKOH36bD5yhNe"
Content-Disposition: inline
In-Reply-To: <112181186.20040903160117@tnonline.net>
X-GPG-KeyID: 0x8BE1C38D
X-GPG-Fingerprint: 1AB0 9AD6 D0C8 B9D5 C5C9  9C2A FF86 CBEE 8BE1 C38D
X-GPG-KeyURL: http://users.thundrix.ch/~tonnerre/tonnerre.asc
User-Agent: Mutt/1.5.6+20040803i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--qOrJKOH36bD5yhNe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Salut,

On Fri, Sep 03, 2004 at 04:01:17PM +0200, Spam wrote:
> >> mount -t tarfs /some/place/on/disk/foo.tar.gz /mnt/tar
> >> cp /var/tmp/img.gif .
> >> umount /mnt/tar
>=20
> > Oops!  Someone did a rm /some/place/on/disk/foo.tar.gz between steps
> > one and two.  Now what happens?  Please define those semantics...
>=20
>   Uhm, can you delete a file (loop) that is mounted?

"Text file busy"

But for files this isn't true.

Currently, we  have another method assuring data  coherency: we remove
the inode only when the last reference goes away.

				Tonnerre


--qOrJKOH36bD5yhNe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.9.2 (GNU/Linux)

iD8DBQFBPCar/4bL7ovhw40RAqtyAKCAFsbtNLGylo3gxPXoX5COOmLCxwCfU5+Z
hi8K34PIZbAzmL9Lr/EACGU=
=2KZi
-----END PGP SIGNATURE-----

--qOrJKOH36bD5yhNe--
