Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317427AbSGDPTd>; Thu, 4 Jul 2002 11:19:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317430AbSGDPTc>; Thu, 4 Jul 2002 11:19:32 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:58890 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id <S317427AbSGDPTb>;
	Thu, 4 Jul 2002 11:19:31 -0400
Date: Thu, 4 Jul 2002 17:22:03 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org
Subject: Re: writing to serial console
Message-ID: <20020704152203.GI31342@lug-owl.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20020704151450.75171.qmail@mail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lqaZmxkhekPBfBzr"
Content-Disposition: inline
In-Reply-To: <20020704151450.75171.qmail@mail.com>
User-Agent: Mutt/1.4i
X-Operating-System: Linux mail 2.4.18 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--lqaZmxkhekPBfBzr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 2002-07-04 10:14:50 -0500, Lee Chin <leechin@mail.com>
wrote in message <20020704151450.75171.qmail@mail.com>:
> Hi,
> I'm trying to write status messages to the serial console as the kernel b=
oots up.  I tried writing to ttyS0 in main.c, but the kernel crashes with a=
 paging violation.  Is there an easy way to do this?

Simply use printk() and boot up your kernel with "console=3DttyS0" or like
that. See ./linux/Documentation/serial-console.txt .

MfG, JBG

--=20
Jan-Benedict Glaw   .   jbglaw@lug-owl.de   .   +49-172-7608481
	 -- New APT-Proxy written in shell script --
	   http://lug-owl.de/~jbglaw/software/ap2/

--lqaZmxkhekPBfBzr
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9JGgbHb1edYOZ4bsRArMdAJ4kRABNxXQQdJOihBJaEfvNZwCApgCbBqT1
tn0ncSUYfSvsnelZ3JgyKl4=
=ROBE
-----END PGP SIGNATURE-----

--lqaZmxkhekPBfBzr--
