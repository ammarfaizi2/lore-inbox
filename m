Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262176AbVC2EDw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262176AbVC2EDw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 23:03:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262177AbVC2EDw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 23:03:52 -0500
Received: from zlynx.org ([199.45.143.209]:57610 "EHLO 199.45.143.209")
	by vger.kernel.org with ESMTP id S262176AbVC2EDt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 23:03:49 -0500
Subject: Re: Can't use SYSFS for "Proprietry" driver modules !!!.
From: Zan Lynx <zlynx@acm.org>
To: Greg KH <greg@kroah.com>
Cc: Aaron Gyes <floam@sh.nu>, Kyle Moffett <mrmacman_g4@mac.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050329033350.GA6990@kroah.com>
References: <1111886147.1495.3.camel@localhost>
	 <490243b66dc7c3f592df7a7d0769dcb7@mac.com>
	 <20050327181221.GB14502@kroah.com> <1112058277.14563.4.camel@localhost>
	 <20050329033350.GA6990@kroah.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-at+seTySqK58JuA0bFYj"
Date: Mon, 28 Mar 2005 21:03:29 -0700
Message-Id: <1112069010.12853.52.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-at+seTySqK58JuA0bFYj
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2005-03-28 at 19:33 -0800, Greg KH wrote:
> Also, the code has undergone a rewrite, fixing many issues, and changing
> the way things work to tie more closely into the main driver core code.
> As such, the class_simple code is now just gone, there is no such need
> for it.  And as such, the new code contains the _GPL markings, as I do
> not think that _anyone_ can try to claim that their code would not be a
> derived work of Linux who wants to use it (as no other OS has such a
> driver model interface.)

That does not really make sense, as the driver model code could be used
for ndiswrapper, for example.  That would not make the Windows net
drivers derived code of the Linux kernel.  ndiswrapper, yes it would be.
Binary driver blobs, no.

ndiswrapper is a perfect example, in fact.  It is GPL, and implements an
_interface_ to binary code that is not GPL. =20

It seems to me that any author has the right to create a public
interface into the kernel. =20

If that interface is well-defined and public, implementing it from the
other side in binary code does not create a derived work.  It is
especially obvious if there are multiple interface implementations.
Hard to argue that the same binary that links unchanged into Windows,
BSD and Linux is Linux-derived.
--=20
Zan Lynx <zlynx@acm.org>

--=-at+seTySqK58JuA0bFYj
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCSNORG8fHaOLTWwgRAmA5AJ99xJRwQA2rVkBgiHkUi25OEprrQQCdGNXh
yCPodMvceB5oJZRL6aFvEFY=
=mIRi
-----END PGP SIGNATURE-----

--=-at+seTySqK58JuA0bFYj--

