Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261858AbTEUItS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 May 2003 04:49:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262011AbTEUItS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 May 2003 04:49:18 -0400
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:62190 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S261858AbTEUItR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 May 2003 04:49:17 -0400
Subject: Re: web page on O(1) scheduler
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: davidm@hpl.hp.com
Cc: linux-kernel@vger.kernel.org, linux-ia64@linuxia64.org
In-Reply-To: <16075.8557.309002.866895@napali.hpl.hp.com>
References: <16075.8557.309002.866895@napali.hpl.hp.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-jdn4kkStXG9zAFTHIY0R"
Organization: Red Hat, Inc.
Message-Id: <1053507692.1301.1.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 (1.2.4-2) 
Date: 21 May 2003 11:01:33 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-jdn4kkStXG9zAFTHIY0R
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2003-05-21 at 08:49, David Mosberger wrote:

>=20
> I think the web pages should be most relevant to the HPTC (high
> performance technical computing) community, since this is the
> community that is most likely affected by some of the performance
> oddities of the O(1) scheduler.  Certainly anyone using OpenMP on
> Intel platforms (x86 and ia64) may want to take a look.

oh you mean the OpenMP broken behavior of calling sched_yield() in a
tight loop to implement spinlocks ?

I'd guess that instead of second guessing the runtime, they should use
the pthreads primitives which are the fastest for the platform one would
hope.. (eg futexes nowadays)

--=-jdn4kkStXG9zAFTHIY0R
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA+y0BsxULwo51rQBIRArOMAJ9yAk3Z9IroEHYebopZJURFBSCi6ACgny4i
qyZcXObrE3j3F9UpJ3B1uEo=
=l5W7
-----END PGP SIGNATURE-----

--=-jdn4kkStXG9zAFTHIY0R--
