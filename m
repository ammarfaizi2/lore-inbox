Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263778AbUJESeS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263778AbUJESeS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 14:34:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264377AbUJESeS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 14:34:18 -0400
Received: from mx1.redhat.com ([66.187.233.31]:33179 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263778AbUJESeL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 14:34:11 -0400
Subject: Re: Linux-2.6.5-1.358 and Fedora
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: "Johnson, Richard" <rjohnson@analogic.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.53.0410051413520.3024@quark.analogic.com>
References: <Pine.LNX.4.53.0410051413520.3024@quark.analogic.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-/7knhqeN9WQNULWrRThA"
Organization: Red Hat UK
Message-Id: <1097001241.9975.17.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 05 Oct 2004 20:34:01 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-/7knhqeN9WQNULWrRThA
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2004-10-05 at 20:17, Johnson, Richard wrote:
> In order to use Linux version 2.6.x, I installed the
> stuff that came with the "Red Hat Fedora(tm) Linux 2"
> book. I even bought a new hard disk so that it wouldn't
> break anything I have on my other disks.
>=20
> It installed, but I needed to set up a module development

.... which is already shipped in /lib

> environment so I attempted to compile the kernel with
> the provided files.
>=20
> First I copied a .config file from /usr/src/linux-2.6.5-1.358/configs
> that came with the other software. Then I did:
>=20
> make oldconfig
> make bzImage
> make modules
> make modules_install

well the Makefile has "custom" added to the version so that you don't
overwrite the working kernel version but install a second one. Did you
by chance manually edit the Makefile to remove the "custom" ?

--=-/7knhqeN9WQNULWrRThA
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBYukZpv2rCoFn+CIRAlVwAJ9CvZ8NwcJTsgGrHgdqUudhHo4NtwCeINnG
KCN6Xz/GZzmUTvM4ZF8touA=
=jMbu
-----END PGP SIGNATURE-----

--=-/7knhqeN9WQNULWrRThA--

