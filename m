Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262944AbTCSIEz>; Wed, 19 Mar 2003 03:04:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262945AbTCSIEz>; Wed, 19 Mar 2003 03:04:55 -0500
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:19950 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP
	id <S262944AbTCSIEy>; Wed, 19 Mar 2003 03:04:54 -0500
Subject: Re: writting kernel modules on redhat 7.3 linux kernel 2.4.18-3
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Hemanshu "Kanji Bhadra, Noida" <hemanshub@noida.hcltech.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E04CF3F88ACBD5119EFE00508BBB2121082D8201@exch-01.noida.hcltech.com>
References: <E04CF3F88ACBD5119EFE00508BBB2121082D8201@exch-01.noida.hcltech.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-KcKZz9THr6hLKNOPnje6"
Organization: Red Hat, Inc.
Message-Id: <1048061712.1493.2.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 19 Mar 2003 09:15:12 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-KcKZz9THr6hLKNOPnje6
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2003-03-19 at 08:07, Hemanshu Kanji Bhadra, Noida wrote:

> gcc -O2 -D__KERNEL__ -DMODULE -I/usr/src/linux/include -c
> helloworld_proc_module.c -o helloworld_proc_module.o

You are using the glibc headers to compile kernel modules, that's not
going to work. You need more than that; you could check the makefile at
http://people.redhat.com/arjanv/xircom_cb/Makefile for more info.

--=-KcKZz9THr6hLKNOPnje6
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+eCcQxULwo51rQBIRAlK0AKCY6n1N2ZTGmkwCXWh9kbHt+o5fpgCdF5/3
0nxR/EVEF/5+RpzPi2ui9Zk=
=Ha57
-----END PGP SIGNATURE-----

--=-KcKZz9THr6hLKNOPnje6--
