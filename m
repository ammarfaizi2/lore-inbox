Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265207AbTLKRA0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 12:00:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265211AbTLKRA0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 12:00:26 -0500
Received: from node-d-1fcf.a2000.nl ([62.195.31.207]:57991 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S265207AbTLKRAU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 12:00:20 -0500
Subject: Re: [2.4][PATCH] Xeon HT - SMT+SMP interrupt balancing
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Ken <ken@nova.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3FD89EF5.30101@nova.org>
References: <3FD89EF5.30101@nova.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-uMZt8P3zJSZ2Pz0AUUtt"
Organization: Red Hat, Inc.
Message-Id: <1071161984.5219.4.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 11 Dec 2003 17:59:44 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-uMZt8P3zJSZ2Pz0AUUtt
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2003-12-11 at 17:44, Ken wrote:

> I have attempted user space alternatives -- irq_balance-0.06 and=20
> smp_affinity via sysctrl.  The former seems to "blindly" affine an IRQ=20
> to a single logical CPU, which in my case, puts the timer and eth3 on=20
> CPU0 and it gets "overloaded" while the others are mostly idle.

1) This got fixed in version 0.07
2) You are talking a whopping 100 irq's per second, which is like about
no interrupts... I doubt you can find a scenario where 100 irq's per
second matter.... ;)

--=-uMZt8P3zJSZ2Pz0AUUtt
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/2KJ/xULwo51rQBIRAnJFAKCIJDC0j+PoBmp2784lqD/7KeubcgCeKUSo
a3qDYXB0CQ/Mk3hc91Zu0Rk=
=S/1S
-----END PGP SIGNATURE-----

--=-uMZt8P3zJSZ2Pz0AUUtt--
