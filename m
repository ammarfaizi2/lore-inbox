Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291194AbSBLVWM>; Tue, 12 Feb 2002 16:22:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291205AbSBLVV6>; Tue, 12 Feb 2002 16:21:58 -0500
Received: from monster.nni.com ([216.107.0.51]:32268 "EHLO admin.nni.com")
	by vger.kernel.org with ESMTP id <S291194AbSBLVQX>;
	Tue, 12 Feb 2002 16:16:23 -0500
Date: Tue, 12 Feb 2002 16:11:20 -0500
From: Andrew Rodland <arodland@noln.com>
To: linux-kernel@vger.kernel.org
Cc: Rik van Riel <riel@conectiva.com.br>
Subject: memory.c:100: bad pmd
Message-Id: <20020212161120.5bc5f51b.arodland@noln.com>
X-Mailer: Sylpheed version 0.7.0claws44 (GTK+ 1.2.10; i386-debian-linux-gnu)
X-Face: yuSM.z0$PasG_!+)P;ugu5P+@#JEocHIpArGcQZ^hcGos8:DBJ-tfTQYWyf`$2r0vfaoo7F|h.;Agl'@x8v]?{#ZLQDqSB:L^6RXGfF_fD+G9$c:)p<yycF[Da]*=*
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 boundary="=.6:hZ:SFQe)2J.m"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.6:hZ:SFQe)2J.m
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

I got these messages just a few minutes ago, while nothing else
interesting was happening. Hardware: Toshiba Satellite 2595CDS (it's a
Celeron, based on the 440BX and PIIX and all that), and my kernel is
2.4.17+O(1)k3+rmap12e. Dunno who this involves, or if it was just a
random thing, but I Cc'd rik considering that it's in mm/ and I've got
rmap in. :)

Feb 12 15:54:19 localhost kernel: memory.c:100: bad pmd 0000f3c1.
Feb 12 15:54:19 localhost kernel: memory.c:100: bad pmd 0000011e.
Feb 12 15:54:19 localhost kernel: memory.c:100: bad pmd 4023011c.
Feb 12 15:54:19 localhost kernel: memory.c:100: bad pmd 401b0fff.
Feb 12 15:54:19 localhost kernel: memory.c:100: bad pmd ffffffff.
Feb 12 15:54:19 localhost kernel: memory.c:100: bad pmd bffffb98.

I'll try to supply more info if it's needed, but as nothing locked up
(in fact, the system seems normal so far, I'm still sending my mail on
it), I don't have any backtrace info or anything like that. 
--=.6:hZ:SFQe)2J.m
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)

iD8DBQE8aYT6k/Qfd5whuDYRAosdAJ9+sYD8vJxmXVnMe9IfZhr7mi7euwCeKOr4
gtNrX8NYZGzoTrJZSR2E2yg=
=jNZT
-----END PGP SIGNATURE-----

--=.6:hZ:SFQe)2J.m--

