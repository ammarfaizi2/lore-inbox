Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261684AbTICIOX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 04:14:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261682AbTICIOX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 04:14:23 -0400
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:52718 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S261686AbTICINs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 04:13:48 -0400
Subject: Re: 2.6.0-test4(-mmX) via-rhine ethernet onboard C3 mini-itx
	doesn't work
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Damian Kolkowski <deimos@deimos.one.pl>
Cc: Danny ter Haar <dth@ncc1701.cistron.net>, linux-kernel@vger.kernel.org
In-Reply-To: <20030903074902.GA1786@deimos.one.pl>
References: <bj447c$el6$1@news.cistron.nl>
	 <20030903074902.GA1786@deimos.one.pl>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-kdGl8FvSU92hyhZXTck1"
Organization: Red Hat, Inc.
Message-Id: <1062576819.5058.2.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-4) 
Date: Wed, 03 Sep 2003 10:13:39 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-kdGl8FvSU92hyhZXTck1
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2003-09-03 at 09:49, Damian Kolkowski wrote:
> On Wed, Sep 03, 2003 at 07:11:40AM +0000, Danny ter Haar wrote:
> > vanilla 2.6.0-test4 & test4-mm[45] & the onboard ethernet doesn't seem =
to work.
> > No kernel panics, it just doesn't work :-(
>=20
> It's standard APIC bug that no one care!

if you enable APIC (and not ACPI) then you start using a different BIOS
table for IRQ routing. Several BIOSes have bugs in this table since it's
not a table that is generally used by Windows on UP boxes. Saying that
it's the kernel's fault is rather unfair; most (if not all) distros for
example ship with APIC disabled for this reason. It's nice if it works
for you but there's quite a few boxes out there that just can't work....
Don't configure it if you have such a box.

--=-kdGl8FvSU92hyhZXTck1
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/VaKzxULwo51rQBIRAo/kAJ43wQSldpC1zZKifCvjdAiOs2PuxgCfc3P1
xh6dv5HNhgnkNTG5oJrhJd4=
=+8nm
-----END PGP SIGNATURE-----

--=-kdGl8FvSU92hyhZXTck1--
