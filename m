Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262447AbSJaPeN>; Thu, 31 Oct 2002 10:34:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262604AbSJaPeM>; Thu, 31 Oct 2002 10:34:12 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:16231 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S262447AbSJaP0h>; Thu, 31 Oct 2002 10:26:37 -0500
Subject: Re: [PATCH,RFC] faster kmalloc lookup
From: Arjan van de Ven <arjanv@redhat.com>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3DBAEB64.1090109@colorfullife.com>
References: <3DBAEB64.1090109@colorfullife.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-5Jp+sKlSDzneG+qpHV7Z"
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 31 Oct 2002 10:35:16 +0100
Message-Id: <1036056917.2872.0.camel@dhcp59-228.rdu.redhat.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-5Jp+sKlSDzneG+qpHV7Z
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2002-10-26 at 21:22, Manfred Spraul wrote:
> kmalloc spends a large part of the total execution time trying to find=20
> the cache for the passed in size.

would it be possible for fixed size kmalloc's to have the compiler
precalculate this ?



--=-5Jp+sKlSDzneG+qpHV7Z
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA9wPlUxULwo51rQBIRAvXFAJ94lPJK6Y6c72dg3+b8HLgIdF9VYQCfflfy
iWRKK0cG1lK9G2LeW+ZkdzY=
=fhqG
-----END PGP SIGNATURE-----

--=-5Jp+sKlSDzneG+qpHV7Z--

