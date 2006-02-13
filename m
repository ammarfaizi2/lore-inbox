Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932287AbWBMRSe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932287AbWBMRSe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 12:18:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932293AbWBMRSd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 12:18:33 -0500
Received: from nef2.ens.fr ([129.199.96.40]:55058 "EHLO nef2.ens.fr")
	by vger.kernel.org with ESMTP id S932287AbWBMRSc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 12:18:32 -0500
Date: Mon, 13 Feb 2006 18:18:14 +0100
From: Nicolas George <nicolas.george@ens.fr>
To: Phillip Susi <psusi@cfl.rr.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Filesystem for mobile hard drive
Message-ID: <20060213171814.GA22068@clipper.ens.fr>
References: <20060212150331.GA22442@clipper.ens.fr> <43EFD6E4.60601@cfl.rr.com> <20060213010701.GA8430@clipper.ens.fr> <43EFEE57.7070009@cfl.rr.com> <20060213103512.GA5157@clipper.ens.fr> <43F0AC38.9090409@cfl.rr.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xHFwDpU9dbj6ez1V"
Content-Disposition: inline
In-Reply-To: <43F0AC38.9090409@cfl.rr.com>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.5.10 (nef2.ens.fr [129.199.96.32]); Mon, 13 Feb 2006 18:18:15 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Le quintidi 25 pluvi=F4se, an CCXIV, Phillip Susi a =E9crit=A0:
> Ahh, I see.  I've never seen anyone use it in conjunction with an si=20
> prefix.  I also think that they use it in RFCs because at the time they=
=20
> started writing them, bytes were not always 8 bits on all machines. =20
> Today it is a pretty safe assumption that a byte is 8 bits, so most=20
> people use the two terms interchangeably ;)

They continue using more octet than bytes even in recent RFCs. I have read I
do not remember where that the goal was to avoid byte/bit confusion.

I am sorry, I did not intend to start an off-topic subthread. I think I
should stick with kB/MB/GB unless I already used the full word earlier.

> I had that same thought a few weeks ago so I gave it a try.  I formatted=
=20
> a partition with UDF, put some files on it, then booted windows to see=20
> if it would take it.  It didn't :(

So bad... Perhaps it was asking too much...

> Hrm... interesting, I wonder how complete it is and what it's license=20
> is?

The man page (<URL:
http://docs.sun.com/app/docs/doc/816-5166/6mbb1kq22?a=3Dview > for Solaris =
10,
I believe OpenSolaris is based on it) tells briefly that the checked
inconsistencies are (I quote):

- Blocks claimed by more than one file or the free list
- Blocks claimed by a file or the free list outside the range of the file s=
ystem
- Incorrect link counts in file entries
- Incorrect directory sizes
- Bad file entry format
- Blocks not accounted for anywhere
- Directory checks, file pointing to unallocated file entry and absence of a
  parent directory entry
- Descriptor checks, more blocks for files than there are in the file system
- Bad free block list format
- Total free block count incorrect

I do not know UDF at all, so I can not tell if this is enough or not.

As for the licence, it is the one of OpenSolaris <URL:
http://www.opensolaris.org/os/licensing/opensolaris_license/ >, which is
free enough for the FSF to make efforts to have GPL3 compatible with it.


Regards,

--=20
  Nicolas George

--xHFwDpU9dbj6ez1V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (SunOS)

iD8DBQFD8L9WsGPZlzblTJMRAhxlAKCu5SFP60iiBRiFs8ju0AJNX66TbwCgpUeM
HuYSxd0zye15iHh8ypbfxS4=
=eKs/
-----END PGP SIGNATURE-----

--xHFwDpU9dbj6ez1V--
