Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263748AbUDFMXU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 08:23:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263787AbUDFMXU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 08:23:20 -0400
Received: from mx1.redhat.com ([66.187.233.31]:48858 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263748AbUDFMXS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 08:23:18 -0400
Subject: [Fwd: [PATCH] jiffies must be unsigned long]
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: linux-kernel@vger.kernel.org
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-R+FYJzSqwKZqevkik+LU"
Organization: Red Hat UK
Message-Id: <1081254194.4680.3.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Tue, 06 Apr 2004 14:23:14 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-R+FYJzSqwKZqevkik+LU
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> -			for(i=3Djiffies+HZ/100;time_before(jiffies, i););
> +			for(t=3Djiffies+HZ/100;time_before(jiffies, t););

how nice... but ehm... if you fix it why not really fix it ???

--=-R+FYJzSqwKZqevkik+LU
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBAcqEyxULwo51rQBIRArfkAKCVX3LOj1c10xCQeWt/iHN/GQOsAACeLn5o
cY1HT1csb2IYVQH5ODZgfD8=
=jwYe
-----END PGP SIGNATURE-----

--=-R+FYJzSqwKZqevkik+LU--

