Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264446AbUAYQPy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 11:15:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264450AbUAYQPy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 11:15:54 -0500
Received: from null.rsn.bth.se ([194.47.142.3]:18902 "EHLO null.rsn.bth.se")
	by vger.kernel.org with ESMTP id S264446AbUAYQPx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 11:15:53 -0500
Subject: Re: More on i/o wait problems ->
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: Jaakko Helminen <haukkari@ihme.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040125153352.GA23360@ihme.org>
References: <20040125153352.GA23360@ihme.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-JmW20HQEzVNQXKAl5cpD"
Message-Id: <1075047349.394.5.camel@tux.rsn.bth.se>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 25 Jan 2004 17:15:50 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-JmW20HQEzVNQXKAl5cpD
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2004-01-25 at 16:33, Jaakko Helminen wrote:
> I switched back to 2.6.0 and it works like a charm, 10,8MBps over 100M LA=
N
> with http. Something's definitely broken in 2.6.1.

Yes a hardly tested readahead patch somehow got integrated.
I/O sucks bigtime in 2.6.1
Try the latest -mm or -bk kernels, it should be fixed there.

--=20
/Martin

--=-JmW20HQEzVNQXKAl5cpD
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAE+u1Wm2vlfa207ERAjTzAJsEocLdY0J5LAGUAItuHoSy3WsSWACggDvI
hZdOHFr5+3JxXS6a49lX+O0=
=KdsR
-----END PGP SIGNATURE-----

--=-JmW20HQEzVNQXKAl5cpD--
