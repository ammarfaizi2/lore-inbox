Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270439AbTHQRTG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 13:19:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270416AbTHQRTG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 13:19:06 -0400
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:51136 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S270383AbTHQRSv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 13:18:51 -0400
Subject: Re: Scheduler activations (IIRC) question
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Jamie Lokier <jamie@shareable.org>
Cc: Mike Galbraith <efault@gmx.de>, Con Kolivas <kernel@kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       gaxt <gaxt@rogers.com>
In-Reply-To: <20030817171224.GA2822@mail.jlokier.co.uk>
References: <5.2.1.1.2.20030817072115.0198f398@pop.gmx.net>
	 <5.2.1.1.2.20030816080614.01a0e418@pop.gmx.net>
	 <20030815235431.GT1027@matchmail.com>
	 <200308160149.29834.kernel@kolivas.org>
	 <20030815230312.GD19707@mail.jlokier.co.uk>
	 <20030815235431.GT1027@matchmail.com>
	 <5.2.1.1.2.20030816080614.01a0e418@pop.gmx.net>
	 <5.2.1.1.2.20030817072115.0198f398@pop.gmx.net>
	 <5.2.1.1.2.20030817100457.019d0c70@pop.gmx.net>
	 <20030817171224.GA2822@mail.jlokier.co.uk>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-1BnS8fl3V0O4YJN+pelq"
Organization: Red Hat, Inc.
Message-Id: <1061140547.29559.2.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-2) 
Date: Sun, 17 Aug 2003 13:15:48 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-1BnS8fl3V0O4YJN+pelq
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2003-08-17 at 13:12, Jamie Lokier wrote:

> > Oh.  You just want to dispatch N syscalls from one entry to the kernel?
>=20
> No, not at all.  I want to schedule cooperative state machines in
> userspace, in the classical select-loop style, but without idling the
> CPU when there's unpredictable blocking on disk I/O.

eg you want AIO stat().....


--=-1BnS8fl3V0O4YJN+pelq
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/P7hDxULwo51rQBIRAnQWAJ90bRMJX0jcwm8aJT7WXU6X9pO+dQCeOzf2
hE4IBR2TQk1ex98s81adT/c=
=tisC
-----END PGP SIGNATURE-----

--=-1BnS8fl3V0O4YJN+pelq--
