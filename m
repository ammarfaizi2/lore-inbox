Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262323AbTD3Pik (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 11:38:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262324AbTD3Pik
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 11:38:40 -0400
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:19440 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S262323AbTD3Pij
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 11:38:39 -0400
Subject: Re: [PATCH] add a stub by which a module can bind to the AFS
	syscall
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: chas williams <chas@locutus.cmf.nrl.navy.mil>
Cc: Christoph Hellwig <hch@infradead.org>, David Howells <dhowells@redhat.com>,
       torvalds@transmeta.com, linux-kernel@vger.kernel.org
In-Reply-To: <200304301533.h3UFXvGi023489@locutus.cmf.nrl.navy.mil>
References: <200304301533.h3UFXvGi023489@locutus.cmf.nrl.navy.mil>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-4RANHtqwxo4xhZnodTG5"
Organization: Red Hat, Inc.
Message-Id: <1051717845.1403.16.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 (1.2.4-2) 
Date: 30 Apr 2003 17:50:45 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-4RANHtqwxo4xhZnodTG5
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2003-04-30 at 17:33, chas williams wrote:
> In message <20030430162739.A9255@infradead.org>,Christoph Hellwig writes:
> >So fix the AFS code up to use a routine for each subcall that
> >can still map to pioctl for !linux.  After that we can continue the
> >discussion on how these calls are best implemented on linux.
>=20
> because time is precious its quite a bit easier to fix one spot in=20
> the linux kernel than to fix a hundred or so in the afs code.

ehm no.
There is no valid AFS code using this since there is no syscall yet ;)

And it IS more work for linux, since 32 bit emulation on 64 bit machines
will be a MAJOR pain if everything is this opaque.

--=-4RANHtqwxo4xhZnodTG5
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+r/DVxULwo51rQBIRAjdzAKCp7qiNRF6VCcJ+ZspI6X0KOGlKngCeOHsv
GgimMQJ9jlFRx7tMu6/Jta0=
=04af
-----END PGP SIGNATURE-----

--=-4RANHtqwxo4xhZnodTG5--
