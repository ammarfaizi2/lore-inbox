Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264266AbUEDI2J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264266AbUEDI2J (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 04:28:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264267AbUEDI2J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 04:28:09 -0400
Received: from mx1.redhat.com ([66.187.233.31]:40327 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264266AbUEDI2G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 04:28:06 -0400
Subject: Re: Random file I/O regressions in 2.6
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Andrew Morton <akpm@osdl.org>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, peter@mysql.com,
       linuxram@us.ibm.com, alexeyk@mysql.com, linux-kernel@vger.kernel.org,
       axboe@suse.de
In-Reply-To: <20040503171005.1e63a745.akpm@osdl.org>
References: <200405022357.59415.alexeyk@mysql.com>
	 <409629A5.8070201@yahoo.com.au> <20040503110854.5abcdc7e.akpm@osdl.org>
	 <1083615727.7949.40.camel@localhost.localdomain>
	 <20040503135719.423ded06.akpm@osdl.org>
	 <1083620245.23042.107.camel@abyss.local>
	 <20040503145922.5a7dee73.akpm@osdl.org> <4096DC89.5020300@yahoo.com.au>
	 <20040503171005.1e63a745.akpm@osdl.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-CPY4T9kMWK9U+02Dlh4/"
Organization: Red Hat UK
Message-Id: <1083659274.3844.2.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Tue, 04 May 2004 10:27:54 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-CPY4T9kMWK9U+02Dlh4/
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


>=20
> That would cause the kernel to perform lots of pointless pagecache lookup=
s
> when the file is already 100% cached.

well surely the read itself will do those AGAIN anyway, so in the fully
cached case this is just warming up the cpu cache ;)  (and thus really
cheap as nett cost I suspect)


--=-CPY4T9kMWK9U+02Dlh4/
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBAl1QKxULwo51rQBIRApreAJ964thZ1kKOIyTedLoJgc/lBMWomgCgm3ts
/7GFLtKyBdFZdQoBEdcu2VU=
=qK1R
-----END PGP SIGNATURE-----

--=-CPY4T9kMWK9U+02Dlh4/--

