Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266510AbUAIK04 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 05:26:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266514AbUAIK04
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 05:26:56 -0500
Received: from debian4.unizh.ch ([130.60.73.144]:12709 "EHLO
	albatross.madduck.net") by vger.kernel.org with ESMTP
	id S266510AbUAIK0y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 05:26:54 -0500
Date: Fri, 9 Jan 2004 11:26:49 +0100
From: martin f krafft <madduck@madduck.net>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: stability problems with 2.4.24/Software RAID/ext3
Message-ID: <20040109102649.GB32552@albatross.madduck.net>
Mail-Followup-To: martin f krafft <madduck@madduck.net>,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	linux kernel mailing list <linux-kernel@vger.kernel.org>,
	Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
References: <20040108151225.GA11740@piper.madduck.net> <Pine.LNX.4.58L.0401081452490.30956@logos.cnet> <Pine.LNX.4.58L.0401081508290.30956@logos.cnet>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="H+4ONPRPur6+Ovig"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58L.0401081508290.30956@logos.cnet>
X-OS: Debian GNU/Linux 3.0 kernel 2.4.19-grsec+freeswan+reiserquota-albatross i686
X-Mailer: Mutt 1.5.4i (2003-03-19)
X-Motto: Keep the good times rollin'
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--H+4ONPRPur6+Ovig
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Marcelo Tosatti <marcelo.tosatti@cyclades.com> [2004.01.08.1810=
 +0100]:
> More information (/proc/mtrr, /proc/interrupts, dmesg, etc) is helpful.

It is currently running 2.6.1-rc3, but the problems exist for 2.4
and 2.6, although not as gravely for 2.6. I hope this information is
still enough, or do you need me to boot 2.4?

gaia:~# cat /proc/mtrr
reg00: base=3D0x00000000 (   0MB), size=3D1024MB: write-back, count=3D1
reg01: base=3D0xec000000 (3776MB), size=3D  64MB: write-combining, count=3D1
reg07: base=3D0xf0000000 (3840MB), size=3D 128MB: write-combining, count=3D1
gaia:~# cat /proc/interrupts
           CPU0      =20
  0:    2481339          XT-PIC  timer
  1:          8          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  5:     140986          XT-PIC  ide2, ide3
  8:          3          XT-PIC  rtc
 12:      70179          XT-PIC  aic7xxx, eth0
 14:     142086          XT-PIC  ide0
 15:     152040          XT-PIC  ide1
NMI:          0=20
ERR:          0

And let me know what you want from dmesg. A bootlog?

--=20
martin;              (greetings from the heart of the sun.)
  \____ echo mailto: !#^."<*>"|tr "<*> mailto:" net@madduck
=20
invalid/expired pgp subkeys? use subkeys.pgp.net as keyserver!
=20
weapon, n.:
  an index of the lack of development of a culture.

--H+4ONPRPur6+Ovig
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE//oHpIgvIgzMMSnURAl+7AKDA0WfgM5YgxBxhw97fgWrJHU7vJACg7QY5
x5o81t0rWYDHKROsLZ16JZ0=
=abfI
-----END PGP SIGNATURE-----

--H+4ONPRPur6+Ovig--
