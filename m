Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266234AbUAGRqT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 12:46:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266235AbUAGRqT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 12:46:19 -0500
Received: from absinthe.ifi.unizh.ch ([130.60.75.58]:64141 "EHLO
	diamond.madduck.net") by vger.kernel.org with ESMTP id S266234AbUAGRqI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 12:46:08 -0500
Date: Wed, 7 Jan 2004 18:46:06 +0100
From: martin f krafft <madduck@madduck.net>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: scheduling problems in X with 2.6.0
Message-ID: <20040107174606.GA25307@piper.madduck.net>
Mail-Followup-To: martin f krafft <madduck@madduck.net>,
	Nick Piggin <piggin@cyberone.com.au>,
	linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <20040107102352.GA2954@piper.madduck.net> <3FFC2621.7060808@cyberone.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xHFwDpU9dbj6ez1V"
Content-Disposition: inline
In-Reply-To: <3FFC2621.7060808@cyberone.com.au>
y-OS: Debian GNU/Linux testing/unstable kernel 2.6.0-diamond i686
X-Mailer: Mutt 1.5.4i (2003-03-19)
X-Motto: Keep the good times rollin'
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Nick Piggin <piggin@cyberone.com.au> [2004.01.07.1630 +0100]:
> Can you post 20 or so lines of 'vmstat 1' captured while the problem is
> happening? See if you can see which lines correspond to X freezing (ie.
> watch the xterm), but that might be impossible if everything freezes.

procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu-=
---
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id=
 wa
 2  2      0 1137424 235064 456972    0    0   736   712 4303  8686 15  6 1=
7 62
 0  3      0 1135696 236116 457008    0    0  1000   688 4321  8004 11 15 1=
4 61
 2  2      0 1132336 237724 457304    0    0  1508    40 4475 10604 25 12 1=
9 44
 1  2      0 1129008 238852 457400    0    0  1036  1616 4476  9232 17 11 1=
3 59
 1  2      0 1125488 240740 457552    0    0  1836  1408 4509  9179 15 10  =
4 72
 0  3      0 1121328 243212 457732    0    0  2340   988 4634 11376 27 14 1=
2 47
 2  5      0 1117744 245336 457920    0    0  2040    44 4538  9344 17 17 1=
6 51
 1  1      0 1115632 246228 458116    0    0   776   784 4339  9230 22  9  =
5 63
 0  3      0 1112624 247448 458256    0    0  1108  1424 4456  9141 22 10 2=
2 46
 1  5      0 1110896 248104 458416    0    0   576   536 4294  8767 18  8  =
6 68
 3  1      0 1107728 250068 458492    0    0  1876   792 4626  9652 20 10 2=
3 47
 1  2      0 1105872 251028 458620    0    0   916  1236 4399  8839 16 17 1=
9 48
 0  2      0 1102224 253096 458864    0    0  1956   500 4583  9880 29 11 1=
3 49
 2  1      0 1098896 255128 459008    0    0  1972   464 4628  9729 18  8 2=
3 51
 0  2      0 1096448 256500 459132    0    0  1316   920 4476  9485 18 10  =
3 71
 0  3      0 1094016 257884 459244    0    0  1280  1004 4467  9896 23  9  =
8 59
 0  3      0 1091328 258800 459416    0    0   848   824 4316  8754 17 17 1=
2 53
 1  2      0 1087744 260236 459476    0    0  1392    28 4447  9077 13  8 1=
6 62
 0  2      0 1086096 261028 459704    0    0   692   788 4226  8918 24  8 1=
2 56
 0  3      0 1085776 261284 459652    0    0   256   760 4200  7934  6  4 2=
9 63
 4  2      0 1083632 262220 459872    0    0   796   504 4321  9680 29 10 1=
0 51
 0  3      0 1082800 262924 459848    0    0   704   456 4227  7885  6 13 1=
7 64
 2  2      0 1081824 263500 460020    0    0   512    28 4228  9024 19  6 1=
3 62
 1  2      0 1080608 264360 460044    0    0   824   388 4238  9320 14  7 1=
3 66
 2  2      0 1079648 264964 460188    0    0   544   388 4260  8962 19  7 1=
3 60
 0  2      0 1078160 265800 460304    0    0   808   360 4264  8831 15  9 2=
8 48

Although I can't see a clear pattern of when exactly it froze, it
definitely froze everytime right before outputting a line with
r > 1. Sometimes, it also froze when r =3D=3D 1 and sometimes even with
r =3D=3D 0.

Thanks!

--=20
martin;              (greetings from the heart of the sun.)
  \____ echo mailto: !#^."<*>"|tr "<*> mailto:" net@madduck
=20
invalid/expired pgp subkeys? use subkeys.pgp.net as keyserver!
=20
"wer ein warum hat, dem ist kein wie zu schwer."
                                                 - friedrich nietzsche

--xHFwDpU9dbj6ez1V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE//EXeIgvIgzMMSnURAtKYAJ4gkAKUE/RtfCL73MYcCDI365DsSQCfRiuj
uAd/L1n4utvbSWwtbR3fQYI=
=3OPu
-----END PGP SIGNATURE-----

--xHFwDpU9dbj6ez1V--
