Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265878AbUAHSb3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 13:31:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265901AbUAHSb3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 13:31:29 -0500
Received: from wblv-238-222.telkomadsl.co.za ([165.165.238.222]:19589 "EHLO
	gateway.lan") by vger.kernel.org with ESMTP id S265878AbUAHSbY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 13:31:24 -0500
Subject: Re: removable media revalidation - udev vs. devfs or static /dev
From: Martin Schlemmer <azarah@nosferatu.za.org>
Reply-To: azarah@nosferatu.za.org
To: Greg KH <greg@kroah.com>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrey Borzenkov <arvidjaar@mail.ru>,
       linux-hotplug-devel@lists.sourceforge.net,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
In-Reply-To: <20040108011538.GA4002@kroah.com>
References: <200401012333.04930.arvidjaar@mail.ru>
	 <20040103055847.GC5306@kroah.com>
	 <Pine.LNX.4.58.0401071036560.12602@home.osdl.org>
	 <20040107185656.GB31827@kroah.com>
	 <Pine.LNX.4.58.0401071123490.12602@home.osdl.org>
	 <20040107195032.GB823@kroah.com> <14870000.1073521945@[10.10.2.4]>
	 <20040108004124.GA3388@kroah.com> <16970000.1073524052@[10.10.2.4]>
	 <20040108011538.GA4002@kroah.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-yqvXrTIRGvWurS6hz/7K"
Message-Id: <1073586854.6075.427.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 08 Jan 2004 20:34:14 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-yqvXrTIRGvWurS6hz/7K
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2004-01-08 at 03:15, Greg KH wrote:

> The problem is the following:
> 	- user plugs in their usb flash reader with no media in it
> 	- the main block device is create, no partitions
> 	- user plugs a flash stick/whatever into the reader
> 	- kernel gets no notification of this event
> 	- userspace gets no notification of this event
>=20
> How can userspace know to open the main block device now?  Require that
> we put a big "Rescan media now" button on the desktop?  That's one way,
> but users are used to having to not do that. =20
>=20

Stupid question - can't the kernel do the rescan?


--=20
Martin Schlemmer

--=-yqvXrTIRGvWurS6hz/7K
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQA//aKmqburzKaJYLYRAkMgAJ42Bm6pmQi47NPkfDOGgfCrUGGvGACfaR0J
I6CisOut6Mw8OlUEq3aYxMs=
=jUNQ
-----END PGP SIGNATURE-----

--=-yqvXrTIRGvWurS6hz/7K--

