Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266498AbUIEMJb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266498AbUIEMJb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 08:09:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266526AbUIEMJb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 08:09:31 -0400
Received: from pauli.thundrix.ch ([213.239.201.101]:29095 "EHLO
	pauli.thundrix.ch") by vger.kernel.org with ESMTP id S266498AbUIEMJ0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 08:09:26 -0400
Date: Sun, 5 Sep 2004 14:07:58 +0200
From: Tonnerre <tonnerre@thundrix.ch>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Lee Revell <rlrevell@joe-job.com>, Pavel Machek <pavel@ucw.cz>,
       Spam <spam@tnonline.net>, Horst von Brand <vonbrand@inf.utfsm.cl>,
       Jamie Lokier <jamie@shareable.org>, David Masover <ninja@slaphack.com>,
       Chris Wedgwood <cw@f00f.org>, viro@parcelfarce.linux.theplanet.co.uk,
       Linus Torvalds <torvalds@osdl.org>, Christoph Hellwig <hch@lst.de>,
       Hans Reiser <reiser@namesys.com>, linux-fsdevel@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040905120758.GI26560@thundrix.ch>
References: <rlrevell@joe-job.com> <1094079071.1343.25.camel@krustophenia.net> <200409021425.i82EPn9i005192@laptop11.inf.utfsm.cl> <1535878866.20040902214144@tnonline.net> <20040902194909.GA8653@atrey.karlin.mff.cuni.cz> <1094155277.11364.92.camel@krustophenia.net> <1094152590.5726.37.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+PbGPm1eXpwOoWkI"
Content-Disposition: inline
In-Reply-To: <1094152590.5726.37.camel@localhost.localdomain>
X-GPG-KeyID: 0x8BE1C38D
X-GPG-Fingerprint: 1AB0 9AD6 D0C8 B9D5 C5C9  9C2A FF86 CBEE 8BE1 C38D
X-GPG-KeyURL: http://users.thundrix.ch/~tonnerre/tonnerre.asc
User-Agent: Mutt/1.5.6+20040803i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--+PbGPm1eXpwOoWkI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Salut,

On Thu, Sep 02, 2004 at 08:16:35PM +0100, Alan Cox wrote:
> Thats how you get yourself a non useful OS. Fix it in a library and
> share it between the apps that care. Like say.. gnome-vfs2

Even KIOslave has  it. They even support sftp and  stuff just by using
shared files  in /tmp in reality.  That's a much  saner interface than
doing it all in the kernel.

I  mean,  the  kernel  is  supposed  to support  access  to  the  disk
drives. Who says that it's got  to be the uppermost VFS level? You can
be perfectly happy to build your own  VFS on top of it (or use other's
implementations, that is.)

I can  already see people moving  to FreeBSD if  this gets implemented
into the kernel...

			    Tonnerre

--+PbGPm1eXpwOoWkI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.9.2 (GNU/Linux)

iD8DBQFBOwGd/4bL7ovhw40RArKAAJwLbiesUJguReikT0vDs3aPn50JSgCeLvkl
p/pryIgSXc2UnSYw1Mi1FH4=
=g3nq
-----END PGP SIGNATURE-----

--+PbGPm1eXpwOoWkI--
