Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262373AbUKKW1M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262373AbUKKW1M (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 17:27:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262374AbUKKW1L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 17:27:11 -0500
Received: from mail.il.fontys.nl ([145.85.127.32]:46035 "EHLO
	mordor.il.fontys.nl") by vger.kernel.org with ESMTP id S262373AbUKKW1G
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 17:27:06 -0500
From: "Ed Schouten" <ed@il.fontys.nl>
Date: Thu, 11 Nov 2004 23:23:21 +0100
To: Florian Heinz <heinz@cronon-ag.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: a.out issue
Message-ID: <20041111222321.GE15081@il.fontys.nl>
References: <20041111220906.GA1670@dereference.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hTiIB9CRvBOLTyqY"
Content-Disposition: inline
In-Reply-To: <20041111220906.GA1670@dereference.de>
X-Message-Flag: Please upgrade your mailreader to Mozilla Thunderbird at http://www.mozilla.org/
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--hTiIB9CRvBOLTyqY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Florian,

On Thu 11 Nov 2004 11:09 PM, Florian Heinz wrote:
> try executing this binary:
> perl -e'print"\x07\x01".("\x00"x13)."\xc0".("\x00"x16)'>eout
> (it may be neccessary to turn memory overcommit on before)
>=20
> This should result in a kernel-oops.
> Doing this in a loop will eat fd's and memory.

No oops over here:

Linux penguin 2.6.9 #1 SMP Wed Oct 20 16:11:52 CEST 2004 i686 AMD Athlon(tm=
) MP 2200+ AuthenticAMD GNU/Linux

Yours sincerely,
--=20
 Ed Schouten <ed@il.fontys.nl>
 Website: http://g-rave.nl/
 GPG key: finger ed@il.fontys.nl

--hTiIB9CRvBOLTyqY
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFBk+ZZyx16ydahrz4RAr8MAKCoD8hlkt52nssm4utj9gilwO9FMgCgrM0I
e+dLPDO5topQY5Tnj++wuls=
=2ZCj
-----END PGP SIGNATURE-----

--hTiIB9CRvBOLTyqY--
