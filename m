Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262134AbTERQg0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 May 2003 12:36:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262131AbTERQg0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 May 2003 12:36:26 -0400
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:33008 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S262134AbTERQgZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 May 2003 12:36:25 -0400
Subject: Re: recursive spinlocks. Shoot.
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: William Lee Irwin III <wli@holomorphy.com>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, ptb@it.uc3m.es,
       linux-kernel@vger.kernel.org
In-Reply-To: <20030518163537.GZ8978@holomorphy.com>
References: <200305180921.h4I9LdD13274@oboe.it.uc3m.es>
	 <19930000.1053275409@[10.10.2.4]>  <20030518163537.GZ8978@holomorphy.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-fCBw45pgk2c8u7ilb37f"
Organization: Red Hat, Inc.
Message-Id: <1053276543.1300.10.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 (1.2.4-2) 
Date: 18 May 2003 18:49:04 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-fCBw45pgk2c8u7ilb37f
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2003-05-18 at 18:35, William Lee Irwin III wrote:
> At some point in the past, Peter Breuer's attribution was removed from:
> >> Here's a before-breakfast implementation of a recursive spinlock. That
> >> is, the same thread can "take" the spinlock repeatedly.=20
>=20
> On Sun, May 18, 2003 at 09:30:17AM -0700, Martin J. Bligh wrote:
> > Why?
>=20
> netconsole.

not really.
the netconsole issue is tricky and recursive, but recursive locks aren't
the solution; that would require a rewrite of the network drivers. It's
far easier to solve it by moving the debug printk's instead.

--=-fCBw45pgk2c8u7ilb37f
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA+x7l/xULwo51rQBIRAhDgAJ9jh2eJRHmAN9HljzmgNIkkfapyOACdGQ81
ckoyGP2zkGqF2CubQJKd1Qw=
=pP5V
-----END PGP SIGNATURE-----

--=-fCBw45pgk2c8u7ilb37f--
