Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267629AbUIFIHM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267629AbUIFIHM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 04:07:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267624AbUIFIHL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 04:07:11 -0400
Received: from pauli.thundrix.ch ([213.239.201.101]:26281 "EHLO
	pauli.thundrix.ch") by vger.kernel.org with ESMTP id S267614AbUIFIFv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 04:05:51 -0400
Date: Mon, 6 Sep 2004 10:04:24 +0200
From: Tonnerre <tonnerre@thundrix.ch>
To: Frank van Maarseveen <frankvm@xs4all.nl>
Cc: viro@parcelfarce.linux.theplanet.co.uk,
       Dave Kleikamp <shaggy@austin.ibm.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Linus Torvalds <torvalds@osdl.org>,
       Jamie Lokier <jamie@shareable.org>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, Adrian Bunk <bunk@fs.tum.de>,
       Hans Reiser <reiser@namesys.com>, Christoph Hellwig <hch@lst.de>,
       fsdevel <linux-fsdevel@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: The argument for fs assistance in handling archives (was: silent semantic changes with reiser4)
Message-ID: <20040906080424.GC28697@thundrix.ch>
References: <1094118362.4847.23.camel@localhost.localdomain> <20040902203854.GA4801@janus> <1094160994.31499.19.camel@shaggy.austin.ibm.com> <20040902214806.GA5272@janus> <20040902220027.GD23987@parcelfarce.linux.theplanet.co.uk> <20040902220242.GA5414@janus> <20040902220640.GE23987@parcelfarce.linux.theplanet.co.uk> <20040902221133.GB5414@janus> <20040902221722.GF23987@parcelfarce.linux.theplanet.co.uk> <20040902222650.GA5523@janus>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bAmEntskrkuBymla"
Content-Disposition: inline
In-Reply-To: <20040902222650.GA5523@janus>
X-GPG-KeyID: 0x8BE1C38D
X-GPG-Fingerprint: 1AB0 9AD6 D0C8 B9D5 C5C9  9C2A FF86 CBEE 8BE1 C38D
X-GPG-KeyURL: http://users.thundrix.ch/~tonnerre/tonnerre.asc
User-Agent: Mutt/1.5.6+20040803i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--bAmEntskrkuBymla
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Salut,

On Fri, Sep 03, 2004 at 12:26:50AM +0200, Frank van Maarseveen wrote:
> Try a "make tags;grep SUPER_MAGIC tags".
> Or is it there for a different purpose?

Problem is:

There are  cool superblock magics  for reiserfs. And for  ext[23]. And
even for good old Minix. Cool.

However,  there  are   also  ugly  file  systems,  such   as  fat  for
example. Fat has been defined as  "something that can be read by a fat
driver", which  can be pretty  much anything. You can't  really detect
whether it is fat. Even Microsoft only guess whether some FS is fat or
not.

And don't  say detect it  via a partition  table.  There are a  lot of
cases where you get absolutely no  or wrong information out of it, and
there are also lots of cases where you plainly have none.

			    Tonnerre

--bAmEntskrkuBymla
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.9.2 (GNU/Linux)

iD8DBQFBPBoI/4bL7ovhw40RAgPmAJ0eM6NfPMARRJhHfd+vIXP+6+UAQgCgpUl/
5tX5B0VUa6gBMKZKdIjycec=
=KbEr
-----END PGP SIGNATURE-----

--bAmEntskrkuBymla--
