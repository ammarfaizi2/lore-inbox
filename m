Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261880AbUFCIr0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261880AbUFCIr0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 04:47:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261932AbUFCIr0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 04:47:26 -0400
Received: from mx1.redhat.com ([66.187.233.31]:5519 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261880AbUFCIrX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 04:47:23 -0400
Subject: Re: [PATCH] Use msleep in meye driver
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Stelian Pop <stelian@popies.net>
Cc: Daniel Drake <dsd@gentoo.org>, video4linux-list@redhat.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <20040603083848.GA3621@crusoe.alcove-fr>
References: <40BDF8E6.6040601@gentoo.org>
	 <20040603083848.GA3621@crusoe.alcove-fr>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-E8P2n4J9gS6GQov8QlpM"
Organization: Red Hat UK
Message-Id: <1086252437.2709.0.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 03 Jun 2004 10:47:18 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-E8P2n4J9gS6GQov8QlpM
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> >From what I see in kernel/timer.c, msleep() cannot be called in
> interrupt context, so the in_interrupt() test must stay.

mdelay in irq context is *EVIL* though, and will get all the low latency
and audio folks very upset...


--=-E8P2n4J9gS6GQov8QlpM
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAvuWVxULwo51rQBIRAklbAJ4jW2UOOCWpP5FHEwjqF316+gZ27QCgjiZi
MVMHqisYmFpGKt66T0LVrtU=
=eeTL
-----END PGP SIGNATURE-----

--=-E8P2n4J9gS6GQov8QlpM--

