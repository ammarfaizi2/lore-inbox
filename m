Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267595AbSLSKQO>; Thu, 19 Dec 2002 05:16:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267597AbSLSKQO>; Thu, 19 Dec 2002 05:16:14 -0500
Received: from host217-36-81-41.in-addr.btopenworld.com ([217.36.81.41]:26343
	"EHLO mail.dark.lan") by vger.kernel.org with ESMTP
	id <S267595AbSLSKQN>; Thu, 19 Dec 2002 05:16:13 -0500
Subject: NMI: IOCK error (debug interrupt?) - nope
From: Gianni Tedesco <gianni@ecsc.co.uk>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-tqv+OxIwApaHi/NtAaRE"
Organization: 
Message-Id: <1040293420.12106.13.camel@lemsip>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.1.1.99 (Preview Release)
Date: 19 Dec 2002 10:23:40 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-tqv+OxIwApaHi/NtAaRE
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hello,

A firewall of ours recently went tits up (2.4.19). It was still routing
traffic but when I connected to SSH for example the SSH banner would not
appear, it looked like all userspace was dead.

When we looked in the logs there was this. Presumably the hardware is
broken. But I wonder if anyone can confirm this? Thanks!

NMI: IOCK error (debug interrupt?)
CPU:    0
EIP:    0010:[default_idle+34/48] Not tainted
EIP:    0010:[<c0106e12>] Not tainted
EFLAGS: 00000246
eax: 00000000   ebx: c0106df0   ecx: 00000032   edx: 00000019
esi: c02f6000   edi: c02f6000   ebp: c0106df0   esp: c02f7fcc
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, stackpage=3Dc02f7000)
Stack: c0106e92 00000002 00098700 c0105000 0008e000 c02f8759 c028e6c0
0001ffc0
0001ffc0 0001ffc0 0001ffc0 c03404c0 c0100191
Call Trace:    [cpu_idle+82/112] [_stext+0/48]
Call Trace:    [<c0106e92>] [<c0105000>]

Code: f4 c3 fb c3 8d 76 00 8d bc 27 00 00 00 00 fb b8 ff ff ff ff

--=20
// Gianni Tedesco (gianni at ecsc dot co dot uk)
lynx --source www.scaramanga.co.uk/gianni-at-ecsc.asc | gpg --import
8646BE7D: 6D9F 2287 870E A2C9 8F60 3A3C 91B5 7669 8646 BE7D

--=-tqv+OxIwApaHi/NtAaRE
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA+AZ4rkbV2aYZGvn0RAja0AKCDxDCwaZWcLTh7W/Rwv895FZWXgACeL7bD
QK4TPJJXXcCXfEFAoSEM0BY=
=rT05
-----END PGP SIGNATURE-----

--=-tqv+OxIwApaHi/NtAaRE--

