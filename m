Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266316AbUGOTxP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266316AbUGOTxP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jul 2004 15:53:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266319AbUGOTxP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jul 2004 15:53:15 -0400
Received: from mx1.redhat.com ([66.187.233.31]:52097 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266316AbUGOTxN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jul 2004 15:53:13 -0400
Subject: Re: Dumb question about Voluntary Kernel Preemption Patch
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Timothy Miller <miller@techsource.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <40F6E504.1@techsource.com>
References: <40F6E504.1@techsource.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-469pUkF7LRL/NdwMfeld"
Organization: Red Hat UK
Message-Id: <1089921188.2710.31.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 15 Jul 2004 21:53:08 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-469pUkF7LRL/NdwMfeld
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> My question is this:  Do your reschedule points (might_sleep or whatever
> you end up using) ALWAYS reschedule, or do they only reschedule after a
> certain period of time (timer interrupt increments counter, and
> reschedule point does nothing if it's too early)?

they only reschedule when there is a higher priority task is waiting to
be run. In all other cases the current code just keeps running.


--=-469pUkF7LRL/NdwMfeld
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBA9uCjxULwo51rQBIRAp61AJ9QZvnJHc5FosCqVPzOgBWcGAwKMQCfbGR4
Qe0x9l2/udd6QU5M0pHL3+Y=
=Do3U
-----END PGP SIGNATURE-----

--=-469pUkF7LRL/NdwMfeld--

