Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267582AbUIFH5k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267582AbUIFH5k (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 03:57:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267585AbUIFH5k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 03:57:40 -0400
Received: from pauli.thundrix.ch ([213.239.201.101]:21929 "EHLO
	pauli.thundrix.ch") by vger.kernel.org with ESMTP id S267582AbUIFH5S
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 03:57:18 -0400
Date: Mon, 6 Sep 2004 09:56:03 +0200
From: Tonnerre <tonnerre@thundrix.ch>
To: Frank van Maarseveen <frankvm@xs4all.nl>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Linus Torvalds <torvalds@osdl.org>,
       Jamie Lokier <jamie@shareable.org>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, Adrian Bunk <bunk@fs.tum.de>,
       Hans Reiser <reiser@namesys.com>,
       viro@parcelfarce.linux.theplanet.co.uk, Christoph Hellwig <hch@lst.de>,
       linux-fsdevel@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: The argument for fs assistance in handling archives (was: silent semantic changes with reiser4)
Message-ID: <20040906075603.GB28697@thundrix.ch>
References: <20040826150202.GE5733@mail.shareable.org> <200408282314.i7SNErYv003270@localhost.localdomain> <20040901200806.GC31934@mail.shareable.org> <Pine.LNX.4.58.0409011311150.2295@ppc970.osdl.org> <1094118362.4847.23.camel@localhost.localdomain> <20040902203854.GA4801@janus>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jho1yZJdad60DJr+"
Content-Disposition: inline
In-Reply-To: <20040902203854.GA4801@janus>
X-GPG-KeyID: 0x8BE1C38D
X-GPG-Fingerprint: 1AB0 9AD6 D0C8 B9D5 C5C9  9C2A FF86 CBEE 8BE1 C38D
X-GPG-KeyURL: http://users.thundrix.ch/~tonnerre/tonnerre.asc
User-Agent: Mutt/1.5.6+20040803i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--jho1yZJdad60DJr+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Salut,

On Thu, Sep 02, 2004 at 10:38:54PM +0200, Frank van Maarseveen wrote:
> Can it do this:
>=20
> 	cd FC2-i386-disc1.iso
> 	ls
>=20
> or this:
>=20
> 	cd /dev/sda1
> 	ls
> 	cd /dev/floppy
> 	ls
> 	cd /dev/cdrom
> 	ls
>=20
> ?

Actually                  I                  see                  some
small-security-hole-you-can-drive-a-big-yellow-truck-with-flashes-on-through
problem.

$ cat fs_header owner_root flags_with_suid evil_program > evil.iso
$ ls -l evil.iso/evil_program
-rwsr-xr-x    1 root     root           24 2003-11-09 16:41 evil.iso/evil_p=
rogram
$ evil.iso/evil_program
Mwahaha, I got root!
Copy-right violating IP... done.
Hijacking administrators wife... done.
Overwriting OS with Parachute 2010... done.

etc. pp.

			    Tonnerre

--jho1yZJdad60DJr+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.9.2 (GNU/Linux)

iD8DBQFBPBgS/4bL7ovhw40RArUPAKCY7/Bo0OfcjFc6hokYGvKhse9dkgCfU67o
AZrfoXYMvu4iwhL0APkiQ1E=
=e9Wv
-----END PGP SIGNATURE-----

--jho1yZJdad60DJr+--
