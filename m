Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264292AbTH1Vsx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 17:48:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264295AbTH1Vsx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 17:48:53 -0400
Received: from chello080108023209.34.11.vie.surfer.at ([80.108.23.209]:25728
	"HELO leto2.endorphin.org") by vger.kernel.org with SMTP
	id S264292AbTH1Vst (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 17:48:49 -0400
Date: Thu, 28 Aug 2003 23:48:36 +0200
To: cryptoapi-devel@kerneli.org
Cc: linux-kernel@vger.kernel.org, linux-crypto@nl.linux.org
Subject: Twofish i586/i686 assembler implementation
Message-ID: <20030828214836.GA4565@leto2.endorphin.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J/dobhs11T7y2rNN"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: Fruhwirth Clemens <clemens-dated-1062971317.4e1b@endorphin.org>
X-Delivery-Agent: TMDA/0.51 (Python 2.1.3 on Linux/i686)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,=20

Twofish is now available as assembler implementation for Pentium/PentiumPro.

I've ported the assembler sources of the public domain Twofish
implementation of Counterpane to cryptoapi. Everyone how has ever locked at
2fish_86.asm will for sure admit that it's next to impossible to change it's
assembler: masm. Instead of rewriting everything in nasm or gas, I've
decided to take a shortcut. I used masm to compile it.

That's for sure a sin and I will burn in free software hell, but don't
worry. You don't have to touch masm. I supplied precompiled binaries for you
and as you won't need to port it to another architecture precompiled
binaries are just fine.

http://clemens.endorphin.org/twofish-i586/

However, the first test looks promissing. It's almost twice as fast as the C
implementation. So I think it's worth trying.

FYI in case you'd like to play with the source: It's possible to work
without a Windows environment. Wine runs masm perfectly and masm is
available through some special tricks for free (as in beer). Just have a
look at INSTALL.Linux.

Regards, Clemens

--J/dobhs11T7y2rNN
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE/Tni0W7sr9DEJLk4RAmjCAJ9zfslFCoREo+wU4LdCaZeFMHcfoACfWlho
a1GEzXwiXqHYEYTpOov3/mg=
=twiS
-----END PGP SIGNATURE-----

--J/dobhs11T7y2rNN--
