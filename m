Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265825AbUAKJtl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 04:49:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265829AbUAKJtl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 04:49:41 -0500
Received: from node-d-1fcf.a2000.nl ([62.195.31.207]:36224 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S265825AbUAKJtj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 04:49:39 -0500
Subject: Re: [PATCH] Increase recursive symlink limit from 5 to 8
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Steve Youngs <sryoungs@bigpond.net.au>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <microsoft-free.87isjj0y1e.fsf@eicq.dnsalias.org>
References: <E1AeMqJ-00022k-00@minerva.hungry.com>
	 <2flllofnvp6.fsf@saruman.uio.no>
	 <microsoft-free.87isjj0y1e.fsf@eicq.dnsalias.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-eRV9DSo3EHnrZXXj4yR2"
Organization: Red Hat, Inc.
Message-Id: <1073814570.4431.3.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Sun, 11 Jan 2004 10:49:30 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-eRV9DSo3EHnrZXXj4yR2
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> 6 does seem pretty low.  What was the reason for setting it there?  Is
> there a downside to increasing it?

It was reduced down from 8 because it can lead to stack overflows.
Recursive links like this usually point at a quite broken filesystem
setup too afaik.

--=-eRV9DSo3EHnrZXXj4yR2
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBAARwqxULwo51rQBIRAhVQAJ9I82t8vLfoGZmUkFb2dJsm6JAdHgCfSr39
c5TY6tO45AB19G9IksgMkp4=
=PKPz
-----END PGP SIGNATURE-----

--=-eRV9DSo3EHnrZXXj4yR2--
