Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265800AbUFORwR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265800AbUFORwR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 13:52:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265795AbUFORwR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 13:52:17 -0400
Received: from mx1.redhat.com ([66.187.233.31]:54656 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265800AbUFORt4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 13:49:56 -0400
Subject: Re: calling kthread_create() from interrupt thread
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Dean Nelson <dcn@sgi.com>
Cc: linux-kernel@vger.kernel.org, rusty@rustcorp.com.au
In-Reply-To: <40CF350B.mailxD2X1NPFBC@aqua.americas.sgi.com>
References: <40CF350B.mailxD2X1NPFBC@aqua.americas.sgi.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-3C3G67iXdXkfWrFNpJi8"
Organization: Red Hat UK
Message-Id: <1087321777.2710.43.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 15 Jun 2004 19:49:37 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-3C3G67iXdXkfWrFNpJi8
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2004-06-15 at 19:42, Dean Nelson wrote:
> I'm working on a driver that needs to create threads that can sleep/block
> for an indefinite period of time.
>=20
>     . Can kthread_create() be called from an interrupt handler?

no

>=20
>     . Is the cost of a kthread's creation/demise low enough so that one
>       can, as often as needed, create a kthread that performs a simple
>       function and exits?  Or is the cost too high for this?

for that we have keventd in 2.4, work queues in 2.6


--=-3C3G67iXdXkfWrFNpJi8
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAzzaxxULwo51rQBIRAp7cAJ9xIYAJf696o18kTdDjjskCRpmeKQCeNosB
SQkid6v+Eh7wAG6LC76wPcQ=
=yQQN
-----END PGP SIGNATURE-----

--=-3C3G67iXdXkfWrFNpJi8--

