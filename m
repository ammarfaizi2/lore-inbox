Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268172AbUIHP06@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268172AbUIHP06 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 11:26:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265222AbUIHP05
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 11:26:57 -0400
Received: from pauli.thundrix.ch ([213.239.201.101]:33711 "EHLO
	pauli.thundrix.ch") by vger.kernel.org with ESMTP id S268116AbUIHP0i
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 11:26:38 -0400
Date: Wed, 8 Sep 2004 17:25:12 +0200
From: Tonnerre <tonnerre@thundrix.ch>
To: Helge Hafting <helge.hafting@hist.no>
Cc: Grzegorz Ja??kiewicz <gryzman@gmail.com>, Greg KH <greg@kroah.com>,
       Jamie Lokier <jamie@shareable.org>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040908152512.GA2726@thundrix.ch>
References: <Pine.LNX.4.44.0408261607070.27909-100000@chimarrao.boston.redhat.com> <200408290004.i7T04DEO003646@localhost.localdomain> <20040901224513.GM31934@mail.shareable.org> <20040903082256.GA17629@kroah.com> <2f4958ff04090301326e7302c1@mail.gmail.com> <41383142.4080201@hist.no> <2f4958ff04090302141bc222e5@mail.gmail.com> <413ECC32.8070509@hist.no>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2fHTh5uZTiUOsy+g"
Content-Disposition: inline
In-Reply-To: <413ECC32.8070509@hist.no>
X-GPG-KeyID: 0x8BE1C38D
X-GPG-Fingerprint: 1AB0 9AD6 D0C8 B9D5 C5C9  9C2A FF86 CBEE 8BE1 C38D
X-GPG-KeyURL: http://users.thundrix.ch/~tonnerre/tonnerre.asc
User-Agent: Mutt/1.5.6+20040803i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Salut,

On Wed, Sep 08, 2004 at 11:09:06AM +0200, Helge Hafting wrote:
> >udef is a one big mistake, having need for userspace tool to use FS is
> >at least silly.
>=20
> Well, devfs had devfsd - a userspace tool . . .

devfsd was not a requirement, it was only a tool for people who wanted
their old device names for devfs devices. I was once doing a miniature
environment for  a package installation  system which used  pure devfs
(i.e.   no  old  dev names),  and  it  was  doing super  well  without
devfs. sysinstall  was the only  process running, and I  could install
Linux on any writeable device without using devfsd.

			   Tonnerre

--2fHTh5uZTiUOsy+g
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.9.2 (GNU/Linux)

iD8DBQFBPyRX/4bL7ovhw40RAvlnAJ9Fkrv0fPp+PIRH/e9ZDCBBhudX4wCgodJ0
Y7sxldd8kDTHKVKKX9gZEPI=
=iXdQ
-----END PGP SIGNATURE-----

--2fHTh5uZTiUOsy+g--
