Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261437AbVAXQ3F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261437AbVAXQ3F (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 11:29:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261514AbVAXQ3E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 11:29:04 -0500
Received: from hydra.gt.owl.de ([195.71.99.218]:4766 "EHLO hydra.gt.owl.de")
	by vger.kernel.org with ESMTP id S261437AbVAXQ3A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 11:29:00 -0500
Date: Mon, 24 Jan 2005 17:28:54 +0100
From: Florian Lohoff <flo@rfc822.org>
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at fs/sysfs/symlink.c:87
Message-ID: <20050124162854.GA4556@paradigm.rfc822.org>
References: <20050124155100.GA2583@paradigm.rfc822.org> <20050124160811.GA19232@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2fHTh5uZTiUOsy+g"
Content-Disposition: inline
In-Reply-To: <20050124160811.GA19232@wohnheim.fh-wedel.de>
Organization: rfc822 - pure communication
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 24, 2005 at 05:08:11PM +0100, J=F6rn Engel wrote:
> > Linux zmgr1.wstk.mediaways.net 2.6.10-zmgr-p3cel #1 Mon Jan 24 16:15:39=
 CET 2005 i686 GNU/Linux
>                                         ^^^^^^^^^^
> Would be interesting to see if this shows up with a plain 2.6.10 as
> well.  Do you have time to check that?

Debian - make-kpkg --append-to-version=3D-zmgr-p3cel=20

I am very shure this is vanilla - I compiled it myself just an hour ago.

> Looks like br_sysfs_addif() forgot to add a dentry to the kobj passed
> to sysfs_create_link(), but I'm not too familiar with that code.

Flo
--=20
Florian Lohoff                  flo@rfc822.org             +49-171-2280134
                        Heisenberg may have been here.

--2fHTh5uZTiUOsy+g
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFB9SJFUaz2rXW+gJcRAqbOAKCWoBStXUEcn965MVUrLAeb1U8SDACfSG56
mDFUIZtWBOAbnkrbR3yNQRk=
=qgn+
-----END PGP SIGNATURE-----

--2fHTh5uZTiUOsy+g--
