Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265486AbSJXPZX>; Thu, 24 Oct 2002 11:25:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265488AbSJXPZX>; Thu, 24 Oct 2002 11:25:23 -0400
Received: from [63.204.6.12] ([63.204.6.12]:50320 "EHLO mail.somanetworks.com")
	by vger.kernel.org with ESMTP id <S265486AbSJXPZW>;
	Thu, 24 Oct 2002 11:25:22 -0400
Message-Id: <200210241531.g9OFVTGT011071@localhost.localdomain>
Date: Thu, 24 Oct 2002 11:31:29 -0400
From: "Georg Nikodym" <georgn@somanetworks.com>
To: Andrey Panin <pazke@orbita1.ru>
Cc: fyou@dsguardian.com, linux-kernel@vger.kernel.org
Subject: Re: pls help me
In-Reply-To: <20021024123940.GA304@pazke.ipt>
References: <1035441048.727.3.camel@yf.dsguardian.com>
	<20021024123940.GA304@pazke.ipt>
Organization: SOMA Networks
X-Mailer: Sylpheed version 0.8.5 (GTK+ 1.2.10; i386-redhat-linux)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1"; boundary="=.jhYJ94in5yARss"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.jhYJ94in5yARss
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Oct 2002 16:39:40 +0400
Andrey Panin <pazke@orbita1.ru> wrote:

> > <== vvfs_read_inode()c67fb000 
> > Unable to handle kernel paging request at virtual address fffffffc 
> 
> Address fffffffc looks like negative error code assigned to a pointer.

It looks more like the result of a:

	foo = list_entry(bar, ...);

	(where bar == NULL)

to me.  But that's just a guess based on a recent debugging session...

-g

--=.jhYJ94in5yARss
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9uBJRoJNnikTddkMRAtVyAJ4ixUuZExmkCP7eEOZxFmpAP9hgzwCdGdSo
bLIdeyVKGn80TKiG2Rsu2S8=
=bzLM
-----END PGP SIGNATURE-----

--=.jhYJ94in5yARss--
