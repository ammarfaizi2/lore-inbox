Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261604AbVAXT5r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261604AbVAXT5r (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 14:57:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261603AbVAXT5r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 14:57:47 -0500
Received: from hydra.gt.owl.de ([195.71.99.218]:61086 "EHLO hydra.gt.owl.de")
	by vger.kernel.org with ESMTP id S261604AbVAXT4O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 14:56:14 -0500
Date: Mon, 24 Jan 2005 18:04:45 +0100
From: Florian Lohoff <flo@rfc822.org>
To: linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at fs/sysfs/symlink.c:87
Message-ID: <20050124170445.GB4556@paradigm.rfc822.org>
References: <20050124155100.GA2583@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="s/l3CgOIzMHHjg/5"
Content-Disposition: inline
In-Reply-To: <20050124155100.GA2583@paradigm.rfc822.org>
Organization: rfc822 - pure communication
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--s/l3CgOIzMHHjg/5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 24, 2005 at 04:51:00PM +0100, Florian Lohoff wrote:
> Hi,
> while using the bridging code between a tap0 and a real eth1 i got this:
>=20
> Linux zmgr1.wstk.mediaways.net 2.6.10-zmgr-p3cel #1 Mon Jan 24 16:15:39 C=
ET 2005 i686 GNU/Linux
>=20
> UP, P3 Celeron, Non-Preempt, Vanilla Kernel

brctl addbr br0
brctl addif br0 tap0
brctl addif br0 eth0
ifconfig br0 up

Oops

In this order it works

brctl addbr br0
ifconfig br0 up
brctl addif br0 tap0
brctl addif br0 eth0

Flo
--=20
Florian Lohoff                  flo@rfc822.org             +49-171-2280134
                        Heisenberg may have been here.

--s/l3CgOIzMHHjg/5
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFB9SqtUaz2rXW+gJcRAoqDAJ9gx5v7/fQ9tWu7uYB3OUa5wSpxggCfTwAe
K9jPCCabUUwkDSw2lmWkSrI=
=NYQq
-----END PGP SIGNATURE-----

--s/l3CgOIzMHHjg/5--
