Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262050AbTEEIPT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 04:15:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262057AbTEEIPT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 04:15:19 -0400
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:59630 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S262050AbTEEIPR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 04:15:17 -0400
Subject: Re: The disappearing sys_call_table export.
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Terje Eggestad <terje.eggestad@scali.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1052122784.2821.4.camel@pc-16.office.scali.no>
References: <1052122784.2821.4.camel@pc-16.office.scali.no>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-i5uWIOS8WTB/UdHNBPEB"
Organization: Red Hat, Inc.
Message-Id: <1052123263.1459.0.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 (1.2.4-2) 
Date: 05 May 2003 10:27:44 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-i5uWIOS8WTB/UdHNBPEB
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2003-05-05 at 10:19, Terje Eggestad wrote:
> Now that it seem that all are in agreement that the sys_call_table
> symbol shall not be exported to modules, are there any work in progress
> to allow modules to get an event/notification whenever a specific
> syscall is being called?
>=20
> We have a specific need to trace mmap() and sbrk() calls.=20

such trace hooks surely can be put in the mmap and sbrk calls themselves
by means of a patch for your systems ?

--=-i5uWIOS8WTB/UdHNBPEB
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+tiB/xULwo51rQBIRAlBKAJ44YLDvHG/VeDK0JKST9Hz9KOIf5QCfVW/s
CRspQZnaOUNAjW0Lqz539Dg=
=SedH
-----END PGP SIGNATURE-----

--=-i5uWIOS8WTB/UdHNBPEB--
