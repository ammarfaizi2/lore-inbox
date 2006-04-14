Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751266AbWDNRIh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751266AbWDNRIh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 13:08:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751290AbWDNRIh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 13:08:37 -0400
Received: from threatwall.zlynx.org ([199.45.143.218]:42133 "EHLO zlynx.org")
	by vger.kernel.org with ESMTP id S1751266AbWDNRIh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 13:08:37 -0400
Subject: Re: Where to call L2 cache enabling code from?
From: Zan Lynx <zlynx@acm.org>
To: Dave Jones <davej@redhat.com>
Cc: Steve Snyder <swsnyder@insightbb.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20060414170052.GA22463@redhat.com>
References: <200604141105.43216.swsnyder@insightbb.com>
	 <1145029574.17531.26.camel@localhost.localdomain>
	 <200604141249.49366.swsnyder@insightbb.com>
	 <20060414170052.GA22463@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-jPjSPtJLA7FHUOiHEzRC"
Date: Fri, 14 Apr 2006 11:08:26 -0600
Message-Id: <1145034507.9218.4.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
X-Envelope-From: zlynx@acm.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-jPjSPtJLA7FHUOiHEzRC
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2006-04-14 at 12:00 -0500, Dave Jones wrote:
[snip]
> arch/i386/kernel/cpu/intel.c has a bunch of workarounds for various
> issues.  Is there a valid use-case for ever booting with cache disabled
> though? If so, this should probably be a boot-time option to enable it.

Yes, disabling the cache is useful to debug bad hardware.  If the CPU
cache is bad, then disabling it might make things work again and you
know what needs to be replaced.
--=20
Zan Lynx <zlynx@acm.org>

--=-jPjSPtJLA7FHUOiHEzRC
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBEP9cJG8fHaOLTWwgRAmwGAJ4hYvUo7alf+eFGbSXfJXxgIx1G1wCgnV4H
rvVgI5pbwAf2KogbeUMR140=
=Y95u
-----END PGP SIGNATURE-----

--=-jPjSPtJLA7FHUOiHEzRC--

