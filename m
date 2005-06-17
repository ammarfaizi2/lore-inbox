Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261983AbVFQOha@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261983AbVFQOha (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 10:37:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261984AbVFQOha
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 10:37:30 -0400
Received: from [213.69.232.60] ([213.69.232.60]:1543 "HELO ei.schottelius.org")
	by vger.kernel.org with SMTP id S261983AbVFQOhU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 10:37:20 -0400
Date: Fri, 17 Jun 2005 16:36:42 +0200
From: Nico Schottelius <nico-kernel@schottelius.org>
To: linux-kernel@vger.kernel.org
Subject: Kernel eats argument=
Message-ID: <20050617143642.GB17910@schottelius.org>
Mail-Followup-To: Nico Schottelius <nico-kernel@schottelius.org>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LyciRD1jyfeSSjG0"
Content-Disposition: inline
User-Agent: echo $message | gpg -e $sender  -s | netcat mailhost 25
X-Linux-Info: http://linux.schottelius.org/
X-Operating-System: Linux 2.6.11.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--LyciRD1jyfeSSjG0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello!

I wanted to have 'cprofile=3Da_profile" specified to my init
system. Now after some hours of debugging I see that
everything that is in the form of
  =20
      bla=3Dblub

is eaten by the kernel and _not_ given to init.
Is that how it should be or is that a bug?

If it's how it should be, I'll switch to "cprofile:a_profile"
or will Linux eat that, too?

The most mysterious thing (for me) is that /proc/cmdline
contains that stuff again.


Nico, somehow confused

--=20
Keep it simple & stupid, use what's available.
Please use pgp encryption: 8D0E 27A4 is my id.
http://nico.schotteli.us | http://linux.schottelius.org

--LyciRD1jyfeSSjG0
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iQIVAwUBQrLf+bOTBMvCUbrlAQJKYw/9Hths48PaVzn61MeGWVNl5/WRjm/TQsai
XdwT5ArTYk1fFIsgn/4cQHILggmLHAUhQz7DMLAQJQB8r9MNCL1SixIr2x4EC0eY
ps7v5tEWmSzCmGNLOCTwQQ6wMCtHetdAtNxSsDK2qZzvBfGxbo87O6QlPJx83P7c
WFIp1LBMS1EDNqNkO4im48KAqZgHuOTnXot5BSJjj3CIbEsLyxZUijkISo/+fPas
jqNDmUHIDFffrKV8jMRIG8eULCcBQB4NJs1IPDmQOh21IjG41JwpAbempONPALne
Ag4dM7HyNuAzbotYUJf8ceacNGPqdBgcnU/z+/gRnJNiGJ3LtJRW+3YefGEGL1xp
xFkYmxFTirY7ml07IK5F2M1z2D5ck0owAApR+Aft2izZ9AcEsMCUPaGfWputL+KD
sDNb+oFCAzE8HAUbUpiq5CQ+GNBy5yVxcxvwEYhv3HWZByYQNG/86JCM8Jh2soYY
yEvFbl0+1gw8QuDMxzukj7TXPaVK750Ts8bWTQCriyHIYnxKZmQ34NNB5Ya3Yh9w
Uxe9LyQQ5SlkkLSW5/4U0HftdNtCQtzqidLDH8sn5Uz5MME1XA+NDOMlgKJOmvYs
lj1Y/QEDeDMJkyw76IbODKktnRQ4eB2NmLYlrgC/VIaBOnlbn9hHzHMXBwZlOAyz
g1kl1SSeGsc=
=3j5e
-----END PGP SIGNATURE-----

--LyciRD1jyfeSSjG0--
