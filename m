Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262029AbTFBITl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 04:19:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262031AbTFBITl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 04:19:41 -0400
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:7664 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S262029AbTFBITk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 04:19:40 -0400
Subject: Re: Always passing mm and vma down (was: [RFC][PATCH] Convert
	do_no_page() to a hook to avoid DFS race)
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: paulmck@us.ibm.com
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, akpm@digeo.com
In-Reply-To: <20030601200056.GA1471@us.ibm.com>
References: <20030530164150.A26766@us.ibm.com>
	 <20030531104617.J672@nightmaster.csn.tu-chemnitz.de>
	 <20030531234816.GB1408@us.ibm.com> <20030601122200.GB1455@x30.local>
	 <20030601200056.GA1471@us.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-5tTYBd1hBuLsexo8h+jz"
Organization: Red Hat, Inc.
Message-Id: <1054542770.5187.1.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.92 (1.3.92-1) (Preview Release)
Date: 02 Jun 2003 10:32:50 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-5tTYBd1hBuLsexo8h+jz
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2003-06-01 at 22:00, Paul E. McKenney wrote:
> The immediate motivation is to avoid the race with zap_page_range()
> when another node writes to the corresponding portion of the file,
> similar to the situation with vmtruncate().  The thought was to
> leverage locking within the distributed filesystem, but if the
> race is solved locally, then, as you say, perhaps this is not=20
> necessary.

is said distributed filesystem open source by chance ?

--=-5tTYBd1hBuLsexo8h+jz
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA+2wuxxULwo51rQBIRAoWcAKCR5pVUn9ke2BrsWvJkwu/M0dUw1wCgjeif
VJBEg55IRamoopAs9qNxUIU=
=/XzA
-----END PGP SIGNATURE-----

--=-5tTYBd1hBuLsexo8h+jz--
