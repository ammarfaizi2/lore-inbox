Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266615AbTB0Tiy>; Thu, 27 Feb 2003 14:38:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266622AbTB0Tiy>; Thu, 27 Feb 2003 14:38:54 -0500
Received: from lmail.actcom.co.il ([192.114.47.13]:58542 "EHLO
	lmail.actcom.co.il") by vger.kernel.org with ESMTP
	id <S266615AbTB0Tit>; Thu, 27 Feb 2003 14:38:49 -0500
Date: Thu, 27 Feb 2003 21:39:44 +0200
From: Muli Ben-Yehuda <mulix@mulix.org>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: doublefault debugging (was Re: Linux v2.5.62 --- spontaneous reboots)
Message-ID: <20030227193943.GA28379@actcom.co.il>
References: <39710000.1045757490@[10.10.2.4]> <Pine.LNX.4.44.0302200847060.2493-100000@home.transmeta.com> <20030227105056.3fd76ac6.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AqsLC8rIMeq19msA"
Content-Disposition: inline
In-Reply-To: <20030227105056.3fd76ac6.rddunlap@osdl.org>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2003 at 10:50:56AM -0800, Randy.Dunlap wrote:
> On Thu, 20 Feb 2003 08:54:55 -0800 (PST)
> Linus Torvalds <torvalds@transmeta.com> wrote:

[snipped]=20

> | A sorted list of bad stack users (more than 256 bytes) in my default bu=
ild
> | follows. Anybody can create their own with something like
> |=20
> | 	objdump -d linux/vmlinux |
> | 		grep 'sub.*$0x...,.*esp' |
> | 		awk '{ print $9,$1 }' |
> | 		sort > bigstack
> |=20
> | and a script to look up the addresses.

[snipped]=20

> I don't get a nice listing from this script like you did.
> Example of mine is below.  Do I just have a tools issue?

See the part where Linus said "...and a script to look up the
addresses.". You can use 'ksymoops -v vmlinux -m System.map --no-ksyms
--no-lsmod -A 0xcodebabe' to translate address to symbol.=20
--=20
Muli Ben-Yehuda
http://www.mulix.org


--AqsLC8rIMeq19msA
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+Xml/KRs727/VN8sRApt6AJoDjPSj+7t4STylfcV2CtkR3KYUfACfbrtP
2U9RyOX/45tDMugXMm2k5M0=
=onPY
-----END PGP SIGNATURE-----

--AqsLC8rIMeq19msA--
