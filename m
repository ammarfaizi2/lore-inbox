Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262934AbTDIJLL (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 05:11:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262939AbTDIJLL (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 05:11:11 -0400
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:9199 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S262934AbTDIJLK (for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Apr 2003 05:11:10 -0400
Subject: Re: bdflush flushing memory mapped pages.
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Keith Ansell <keitha@edp.fastfreenet.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <007601c2fecd$12209070$230110ac@kaws>
References: <007601c2fecd$12209070$230110ac@kaws>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-+h0eoWrXYgUJZ4yUCfa+"
Organization: Red Hat, Inc.
Message-Id: <1049880162.1424.2.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 (1.2.3-1) 
Date: 09 Apr 2003 11:22:43 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-+h0eoWrXYgUJZ4yUCfa+
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2003-04-09 at 21:20, Keith Ansell wrote:
> help
>=20
> My application uses SHARED memory mapping files for file I/O, and we have
> observed
> that Linux does not flush dirty pages to disk until munmap or msync are
> called.
>=20
> I would like to know are there any development plans which would address
> this issue or
> if there is a version of bdflush which flushes write required pages (dirt=
y
> pages) to disk?

The linux behavior is perfectly fine and conformant to the posix/sus
specifications, applications that break because of this are defective
and need fixing. This is a performance optimisation that the OS is
perfectly allowed to do.

--=-+h0eoWrXYgUJZ4yUCfa+
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+k+ZixULwo51rQBIRAkxyAJsGlOPoiqyQ2FBdEDWlwvFUO+KFyACfZqPK
Qkx17wWUCncM3fiDiTqmFFo=
=T9ia
-----END PGP SIGNATURE-----

--=-+h0eoWrXYgUJZ4yUCfa+--
