Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261244AbUCZUt4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 15:49:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264128AbUCZUt4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 15:49:56 -0500
Received: from mx1.redhat.com ([66.187.233.31]:8090 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261244AbUCZUtt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 15:49:49 -0500
Subject: Re: Fw: potential /dev/urandom scalability improvement
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Andrew Morton <akpm@osdl.org>
Cc: davidm@hpl.hp.com, davidm@napali.hpl.hp.com, davej@redhat.com,
       mpm@selenic.com, linux-kernel@vger.kernel.org
In-Reply-To: <20040326123303.7a775b02.akpm@osdl.org>
References: <20040325141923.7080c6f0.akpm@osdl.org>
	 <20040325224726.GB8366@waste.org>
	 <16483.35656.864787.827149@napali.hpl.hp.com>
	 <20040325180014.29e40b65.akpm@osdl.org> <20040326110619.GA25210@redhat.com>
	 <16484.29095.842735.102236@napali.hpl.hp.com>
	 <20040326104904.59f7a156.akpm@osdl.org>
	 <16484.37279.839961.375027@napali.hpl.hp.com>
	 <20040326123303.7a775b02.akpm@osdl.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-XAWaaF3hjxHz6oEfpvG7"
Organization: Red Hat, Inc.
Message-Id: <1080333938.7033.0.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Fri, 26 Mar 2004 21:45:38 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-XAWaaF3hjxHz6oEfpvG7
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> a) execute a prefetch at addresses which are not PREFETCH_STRIDE-aligned
>    and, as a consequence,
>=20
> b) prefetch data from the next page, outside the range of the user's
>    (addr,len).

well if you assume that cachelines (and prefetch stride) are proper
divisors of PAGE_SIZE is that still true ?

--=-XAWaaF3hjxHz6oEfpvG7
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBAZJZxxULwo51rQBIRAnnrAJwJ2lnrZMogBQC7emol4+GEaqs7PgCfYkKA
itbLHMZb7SdjjmPyaGnNC+k=
=M6qC
-----END PGP SIGNATURE-----

--=-XAWaaF3hjxHz6oEfpvG7--

