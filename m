Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267566AbUIHNJN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267566AbUIHNJN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 09:09:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267700AbUIHNG3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 09:06:29 -0400
Received: from mx1.redhat.com ([66.187.233.31]:31902 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267238AbUIHNDf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 09:03:35 -0400
Subject: Re: [patch] generic-hardirqs.patch, 2.6.9-rc1-bk14
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Ingo Molnar <mingo@elte.hu>
Cc: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Scott Wood <scott@timesys.com>
In-Reply-To: <20040908124547.GA19231@elte.hu>
References: <20040908120613.GA16916@elte.hu>
	 <20040908133445.A31267@infradead.org>  <20040908124547.GA19231@elte.hu>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-jfK7iwFdaEhMj1cjMEKb"
Organization: Red Hat UK
Message-Id: <1094648591.2800.10.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 08 Sep 2004 15:03:12 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-jfK7iwFdaEhMj1cjMEKb
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> wrt. unused generic functions - why dont we drop them link-time?

actually if nothing uses ANY function of a .o file then yes the entire
.o gets dropped.

(we should make the kernel use -ffunction-sections some day to make it
on a per function instead of on a per .o file basis)

--=-jfK7iwFdaEhMj1cjMEKb
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBPwMPxULwo51rQBIRAq5MAJ9rgXjKmKnLWcvOIzLtoTGi1TrITACdEKeu
HUZ08zTUOoHYf5uh/rF/NZ8=
=IASB
-----END PGP SIGNATURE-----

--=-jfK7iwFdaEhMj1cjMEKb--

