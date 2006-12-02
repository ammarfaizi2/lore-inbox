Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424169AbWLBVjp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424169AbWLBVjp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 16:39:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424170AbWLBVjp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 16:39:45 -0500
Received: from static-ip-217-172-177-14.inaddr.intergenia.de ([217.172.177.14]:64683
	"EHLO minden014.server4you.de") by vger.kernel.org with ESMTP
	id S1424169AbWLBVjo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 16:39:44 -0500
From: Christian Parpart <trapni@gentoo.org>
Organization: Gentoo Foundation
To: linux-kernel@vger.kernel.org
Subject: x86-64 dual core: oops'ing alot, "null pointer deref, ..."
Date: Sat, 2 Dec 2006 22:39:38 +0100
User-Agent: KMail/1.9.5
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1291786.pN6A9Bh9GN";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200612022239.42275.trapni@gentoo.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1291786.pN6A9Bh9GN
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi all,

(nearly?) just like bart trojanowski's problem, I get tons of oops'es when=
=20
booting into the kernel using SMP activated.

noapic cmdline does not help either.

However, I made lots some screenshots of my oops times as it sometimes even=
=20
happens before init got spawned:

http://mylair.de/~trapni/crashes/30112006067.jpg
http://mylair.de/~trapni/crashes/30112006069.jpg
http://mylair.de/~trapni/crashes/01122006070.jpg
http://mylair.de/~trapni/crashes/02122006071.jpg
http://mylair.de/~trapni/crashes/02122006072.jpg
http://mylair.de/~trapni/crashes/02122006074.jpg
http://mylair.de/~trapni/crashes/02122006076.jpg

all with smp enabled, and with KV from 2.6.16 to 2.6.19.

I am currently playing with kexec/kdump to get more out of it, but don't=20
expect me to get it running well (yet) ;)

However, I'd be really pleased when someone could help me out here as I'm n=
ot=20
really willing to run in non-smp mode when having a second core in the box.

Many thanks in advance,
Christian Parpart.

--nextPart1291786.pN6A9Bh9GN
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFcfKePpa2GmDVhK0RAk95AJ4k39QG/3ZESiOWD7yqg0TeV13HLQCdHC2e
jwTnCojc9oPVQxiNGPcHo2k=
=eNFV
-----END PGP SIGNATURE-----

--nextPart1291786.pN6A9Bh9GN--
