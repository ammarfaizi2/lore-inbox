Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319509AbSH3ARo>; Thu, 29 Aug 2002 20:17:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319532AbSH3ARo>; Thu, 29 Aug 2002 20:17:44 -0400
Received: from ppp-217-133-223-7.dialup.tiscali.it ([217.133.223.7]:28035 "EHLO
	home.ldb.ods.org") by vger.kernel.org with ESMTP id <S319509AbSH3ARm>;
	Thu, 29 Aug 2002 20:17:42 -0400
Subject: Re: [PATCH 1 / ...] i386 dynamic fixup/self modifying code
From: Luca Barbieri <ldb@ldb.ods.org>
To: "David S. Miller" <davem@redhat.com>
Cc: pavel@suse.cz, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux-Kernel ML <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
In-Reply-To: <20020829.170551.98069822.davem@redhat.com>
References: <20020828121129.A35@toy.ucw.cz>
	<1030663192.1326.20.camel@irongate.swansea.linux.org.uk>
	<20020829232233.GA18573@atrey.karlin.mff.cuni.cz> 
	<20020829.170551.98069822.davem@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-IeL/SZTtPAMZVNSMOqxc"
X-Mailer: Ximian Evolution 1.0.5 
Date: 30 Aug 2002 02:21:27 +0200
Message-Id: <1030666887.1490.147.camel@ldb>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-IeL/SZTtPAMZVNSMOqxc
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

> 2) patch them more simply, the .subsection entries would
>    be "kern_addr, insn" __u32 pairs on x86 for example.
This can be made a single u32 by using the MSB for the insn and doing
this with additions so that it works with relocations.
It might not be possible for modules, though.


--=-IeL/SZTtPAMZVNSMOqxc
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA9brqHdjkty3ft5+cRArlWAJ4vOvMoo15s3LTyx0TR/T9/Leo2CwCcCec3
6NcQBREqK3UBb825pSwqXu4=
=QSGJ
-----END PGP SIGNATURE-----

--=-IeL/SZTtPAMZVNSMOqxc--
