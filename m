Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263635AbUCULfO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 06:35:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263636AbUCULfO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 06:35:14 -0500
Received: from mx1.redhat.com ([66.187.233.31]:42400 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263635AbUCULfI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 06:35:08 -0500
Subject: Re: locking user space memory in kernel
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Eli Cohen <mlxk@mellanox.co.il>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <405D7A0A.2000408@mellanox.co.il>
References: <405D7A0A.2000408@mellanox.co.il>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-c27JKOSJFxH/ThMtQ8o1"
Organization: Red Hat, Inc.
Message-Id: <1079868902.5295.8.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Sun, 21 Mar 2004 12:35:02 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-c27JKOSJFxH/ThMtQ8o1
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2004-03-21 at 12:18, Eli Cohen wrote:
> Hi,
> I need to be able to lock memory allocated in user space and passed to=20
> my driver, in order to pass it to a dma controller that can maintain a=20
> translation table for each process. The obvious thing is to use=20

the linux way is to do it the other way around, provide a device that
userspace then can mmap......


--=-c27JKOSJFxH/ThMtQ8o1
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBAXX3mxULwo51rQBIRAjOmAJ9CLfbHNC/8KOpT9PSVLKGY0jNuQwCeOIDj
QeqF3WwPv8QbKwQwaAfc138=
=DJkx
-----END PGP SIGNATURE-----

--=-c27JKOSJFxH/ThMtQ8o1--

