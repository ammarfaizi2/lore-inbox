Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261269AbUCANuW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 08:50:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261271AbUCANuW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 08:50:22 -0500
Received: from node-d-1fcf.a2000.nl ([62.195.31.207]:21123 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S261269AbUCANuR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 08:50:17 -0500
Subject: Re: [Swsusp-devel] Re: Dropping CONFIG_PM_DISK?
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Michael Frank <mhf@linuxmail.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Micha Feigin <michf@post.tau.ac.il>,
       Software suspend <swsusp-devel@lists.sourceforge.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <opr36ojxik4evsfm@smtp.pacific.net.th>
References: <1ulUA-33w-3@gated-at.bofh.it>
	 <20040229161721.GA16688@hell.org.pl> <20040229162317.GC283@elf.ucw.cz>
	 <yw1x4qt93i6y.fsf@kth.se> <opr348q7yi4evsfm@smtp.pacific.net.th>
	 <20040229213302.GA23719@luna.mooo.com>
	 <opr35wvvrw4evsfm@smtp.pacific.net.th> <1078139361.21578.65.camel@gaston>
	 <opr36ljbsu4evsfm@smtp.pacific.net.th> <1078141191.28288.83.camel@gaston>
	 <opr36ojxik4evsfm@smtp.pacific.net.th>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-HFaTlLEA5zUqEaN3sQ+q"
Organization: Red Hat, Inc.
Message-Id: <1078148843.4443.2.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Mon, 01 Mar 2004 14:47:23 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-HFaTlLEA5zUqEaN3sQ+q
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> Then one could just drop in a driver from 2.4 and use it.
>=20
> People having time to make new "pretty" drivers could
> also use this facility for cross checking.

I'm sorry but this is a load of bull ;)
New kernel revisions come with a new API. If we keep the old one around
forever that achieves two things
1) The kernel bloats up=20
2) Nobody puts effort into using the new (better) API

A proof of 2 is the scsi error handling; the old one was kept around as
compat for the last 5 years and only 2 or 3 drivers bothered to use the
new one.


--=-HFaTlLEA5zUqEaN3sQ+q
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBAQz7rxULwo51rQBIRAu5VAJ9SYVDFgiEut1nD/77c/tBzwTq7XACePy86
DL3q4iqfK1yKhFWl1ZvdGmA=
=UJUd
-----END PGP SIGNATURE-----

--=-HFaTlLEA5zUqEaN3sQ+q--
