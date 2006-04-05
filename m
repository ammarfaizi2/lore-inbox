Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751170AbWDEQO3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751170AbWDEQO3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 12:14:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751191AbWDEQO3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 12:14:29 -0400
Received: from [80.251.174.142] ([80.251.174.142]:60375 "EHLO FAP-MSP.emfa.pt")
	by vger.kernel.org with ESMTP id S1751170AbWDEQO2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 12:14:28 -0400
Subject: Re: [2.6.16 PATCH] Filessytem Events Reporter V2
From: Carlos Silva <r3pek@r3pek.homelinux.org>
To: Yi Yang <yang.y.yi@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       Matt Helsley <matthltc@us.ibm.com>
In-Reply-To: <4433C456.7010708@gmail.com>
References: <4433C456.7010708@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-pU/ypI4EaOkicInteCzj"
Date: Wed, 05 Apr 2006 18:12:04 +0100
Message-Id: <1144257124.2075.10.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
X-FAP-MailScanner-Information: Please contact the ISP for more information
X-FAP-MailScanner: Found to be clean
X-FAP-MailScanner-From: r3pek@r3pek.homelinux.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-pU/ypI4EaOkicInteCzj
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2006-04-05 at 21:21 +0800, Yi Yang wrote:=0A=
> <snip>=0A=
> +static void cleanup_dead_listener(listener * x)=0A=
> +{=0A=
> +	pid_filter * p =3D NULL, * pq =3D NULL;=0A=
> +	uid_filter * u =3D NULL, * uq =3D NULL;=0A=
> +	gid_filter * g =3D NULL, * gq =3D NULL;=0A=
> +=0A=
> +	if (p =3D=3D NULL)=0A=
> +		return;=0A=
> <snip>=0A=
=0A=
I think you ment "if (x =3D=3D NULL)" here.  Otherwise, the condition will =
always be true.=0A=
btw, I'm not reviewing your code, just stumbled across this while reading i=
t.=0A=

--=-pU/ypI4EaOkicInteCzj
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2-ecc0.1.6 (GNU/Linux)

iD8DBQBEM/pkttk+BQds59QRAuEfAJ9D2Y4ANkPSMRrfYBuIIdSfj053VQCgirF1
UpQfXKnvZH3fFxqB53HbF2E=
=M5Qa
-----END PGP SIGNATURE-----

--=-pU/ypI4EaOkicInteCzj--

-- 
This message has been scanned for viruses and
dangerous content by MailScanner, and is
believed to be clean.
