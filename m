Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262470AbUCWKfg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 05:35:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262468AbUCWKff
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 05:35:35 -0500
Received: from mx1.redhat.com ([66.187.233.31]:1243 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262465AbUCWKfT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 05:35:19 -0500
Subject: Re: [PATCH] RCU for low latency (experimental)
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: dipankar@in.ibm.com
Cc: tiwai@suse.de, Andrea Arcangeli <andrea@suse.de>,
       Robert Love <rml@ximian.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20040323101755.GC3676@in.ibm.com>
References: <20040323101755.GC3676@in.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-QvlsG1iiGspZoLjxZnEc"
Organization: Red Hat, Inc.
Message-Id: <1080038105.5296.8.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Tue, 23 Mar 2004 11:35:06 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-QvlsG1iiGspZoLjxZnEc
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> Reduce bh processing time of rcu callbacks by using tunable per-cpu
> krcud daemeons.

why not just use work queues ?


--=-QvlsG1iiGspZoLjxZnEc
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBAYBLZxULwo51rQBIRAvLMAJ9clz7HQNBgkHDwVbr0JrJFtGTGvACgh4Gj
/IkO4xt1LHkMZICBvpBpc7U=
=OWe0
-----END PGP SIGNATURE-----

--=-QvlsG1iiGspZoLjxZnEc--

