Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261305AbSJYIUV>; Fri, 25 Oct 2002 04:20:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261306AbSJYIUV>; Fri, 25 Oct 2002 04:20:21 -0400
Received: from host217-36-81-41.in-addr.btopenworld.com ([217.36.81.41]:50921
	"EHLO mail.dark.lan") by vger.kernel.org with ESMTP
	id <S261305AbSJYIUU>; Fri, 25 Oct 2002 04:20:20 -0400
Subject: Re: How to get number of physical CPU in linux from user space?
From: Gianni Tedesco <gianni@ecsc.co.uk>
To: chrisl@vmware.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20021024230229.GA1841@vmware.com>
References: <20021024230229.GA1841@vmware.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-rvU5oGnMuYTN24f/J6Ag"
Organization: 
Message-Id: <1035534399.8301.1.camel@lemsip>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.1.1.99 (Preview Release)
Date: 25 Oct 2002 09:26:39 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-rvU5oGnMuYTN24f/J6Ag
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2002-10-25 at 00:02, chrisl@vmware.com wrote:
> It seems that /proc/cpuinfo will return the number of logical CPU.
> If the machine has Intel Hyper-Thread enabled, that number is bigger
> than physical CPU number. Usually twice as big.
>=20
> My question is, what is the reliable way for user space program
> to detect the number of physical CPU in the current machine?

I believe there was talk about representing the CPUs in driverfs
somehow. Not sure of the details though...

--=20
// Gianni Tedesco (gianni at ecsc dot co dot uk)
lynx --source www.scaramanga.co.uk/gianni-at-ecsc.asc | gpg --import
8646BE7D: 6D9F 2287 870E A2C9 8F60 3A3C 91B5 7669 8646 BE7D

--=-rvU5oGnMuYTN24f/J6Ag
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA9uQA/kbV2aYZGvn0RAvX0AJ9kQkgXRmppb7XvinzrAe/ky9RbQwCggWqL
XfoRqwGzk3URR7uD8CRkLe8=
=B+Wj
-----END PGP SIGNATURE-----

--=-rvU5oGnMuYTN24f/J6Ag--

