Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263942AbTL2TSx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 14:18:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263953AbTL2TSx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 14:18:53 -0500
Received: from node-d-1fcf.a2000.nl ([62.195.31.207]:61319 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S263942AbTL2TSv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 14:18:51 -0500
Subject: Re: Add support for checking before-the-fact whether an IRQ is
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: torvalds@osdl.org
In-Reply-To: <200312291905.hBTJ56k1032326@hera.kernel.org>
References: <200312291905.hBTJ56k1032326@hera.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-NOhr6Su0v5KRyFuJNjpw"
Organization: Red Hat, Inc.
Message-Id: <1072725508.4233.11.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Mon, 29 Dec 2003 20:18:28 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-NOhr6Su0v5KRyFuJNjpw
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2003-12-29 at 19:18, Linux Kernel Mailing List wrote:
> ChangeSet 1.1552, 2003/12/29 10:18:11-08:00, torvalds@home.osdl.org
>=20
> 	Add support for checking before-the-fact whether an IRQ is
> 	already registered or not. The x86 PCI layer wants this for
> 	its availability testing.
> =09
> 	Doing a request_irq()/free_irq() pair to check this condition
> 	like we used to do can lock the machine if the irq happens to
> 	be screaming.


question; which lock prevents someone else claiming the irq and making
it unsharable/unclaimable between can_request_irq() and the eventual
request_irq() ????

--=-NOhr6Su0v5KRyFuJNjpw
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/8H4DxULwo51rQBIRAkvHAJ0dlmxi8R93hyE64A4MzKLNCUJvXgCcCZbD
QU0lIkEaJPESZW4puceUb8I=
=qib8
-----END PGP SIGNATURE-----

--=-NOhr6Su0v5KRyFuJNjpw--
