Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266201AbTGLQta (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 12:49:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267775AbTGLQta
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 12:49:30 -0400
Received: from main.gmane.org ([80.91.224.249]:59606 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S266201AbTGLQt2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 12:49:28 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Jan Rychter <jan@rychter.com>
Subject: Re: Geode GX1, video acceleration -> crash
Date: Sat, 12 Jul 2003 10:04:57 -0700
Message-ID: <m2adbj7k1y.fsf@tnuctip.rychter.com>
References: <20030711181025.14633.qmail@web10001.mail.yahoo.com> <3F0F27B6.9B7DAAE2@engard.hu>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
X-Complaints-To: usenet@main.gmane.org
X-Spammers-Please: blackholeme@rychter.com
User-Agent: Gnus/5.1003 (Gnus v5.10.3) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:0HGJpBG7Gu7pqRmCGWKTp0kRFoM=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Transfer-Encoding: quoted-printable

>>>>> "Ferenc" =3D=3D Ferenc Engard <ferenc@engard.hu> writes:
 Ferenc> Keyser Soze wrote:
 >>
 > But the real problem is, that I wanted to benchmark the system while
 > the scrolling continues, and issued a dd if=3D/dev/mem of=3D/dev/null
 > bs=3D1024 count=3D32768 command. For the second go, the system freezed
 > like a good refrigerator. No kernel panic, nothing, just freezed.
 >>
 >> Try turning off ide dma and see if that helps.  You will lose very
 >> little by turning off udma on this system and I'll bet you end up
 >> being more stable.

 Ferenc> I will try it on Monday, as the eval board is in my
 Ferenc> workplace. What is the connection between ide dma, memory read
 Ferenc> and the hw video accel? The ide dma setting alters the way
 Ferenc> /dev/mem is read? :-O
[...]

It can have interesting things in common, but NS won't tell you about
them without NDAs, I'm afraid -- at least that's how it used to be.
I've had IDE DMA interfere with video input, for instance. So asking NS
is indeed the best answer in this thread.

=2D-J.

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/ED++Lth4/7/QhDoRAlO/AKDDg/+ZSze9/4186hbSwY86vsAoZwCeIjVH
Rn5ZRtHQmoiZqBzgsTwMj48=
=0dC6
-----END PGP SIGNATURE-----
--=-=-=--

