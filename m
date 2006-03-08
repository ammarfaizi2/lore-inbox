Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932296AbWCHXs2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932296AbWCHXs2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 18:48:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932431AbWCHXs2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 18:48:28 -0500
Received: from threatwall.zlynx.org ([199.45.143.218]:23697 "EHLO zlynx.org")
	by vger.kernel.org with ESMTP id S932296AbWCHXs1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 18:48:27 -0500
Subject: Re: [PATCH] mm: yield during swap prefetching
From: Zan Lynx <zlynx@acm.org>
To: Con Kolivas <kernel@kolivas.org>
Cc: =?ISO-8859-1?Q?Andr=E9?= Goddard Rosa <andre.goddard@gmail.com>,
       Lee Revell <rlrevell@joe-job.com>, Andrew Morton <akpm@osdl.org>,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org, ck@vds.kolivas.org
In-Reply-To: <cone.1141858802.179786.26372.501@kolivas.org>
References: <200603081013.44678.kernel@kolivas.org>
	 <200603081322.02306.kernel@kolivas.org> <1141784834.767.134.camel@mindpipe>
	 <200603081330.56548.kernel@kolivas.org>
	 <b8bf37780603071852r6bf3821fr7610597a54ad305b@mail.gmail.com>
	 <cone.1141787137.882268.19235.501@kolivas.org>
	 <1141852064.21958.28.camel@localhost>
	 <cone.1141858802.179786.26372.501@kolivas.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-78/UWGx+zSDjgKJaXXV7"
Date: Wed, 08 Mar 2006 16:48:13 -0700
Message-Id: <1141861694.21958.66.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
X-Envelope-From: zlynx@acm.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-78/UWGx+zSDjgKJaXXV7
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2006-03-09 at 10:00 +1100, Con Kolivas wrote:
> Zan Lynx writes:
[snip]
> > Games and real-time go together like they were made for each other.
>=20
> I guess every single well working windows game since the dawn of time is=20
> some sort of anomaly then.

Yes, those Windows games are anomalies that rely on the OS scheduling
them AS IF they were real-time, but without actually claiming that
priority.

Because these games just assume they own the whole system and aren't
explicitly telling the OS about their real-time requirements, the OS has
to guess instead and can get it wrong, especially when hardware
capabilities advance in ways that force changes to the task scheduler
(multi-core, hyper-threading).  And you said it yourself, many old games
don't work well on dual-core systems.

I think your effort to improve the guessing is a good idea, and
thanks. =20

Just don't dismiss the idea that games do have real-time requirements
and if they did things correctly, games would explicitly specify those
requirements.
--=20
Zan Lynx <zlynx@acm.org>

--=-78/UWGx+zSDjgKJaXXV7
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.1 (GNU/Linux)

iD8DBQBED209G8fHaOLTWwgRAlf9AKCQQoX7TBnsu8+x/ZjB2Wz3HmnZlwCeIl+V
JrldF/RpZPpTGmbhEvg/CUE=
=aCHK
-----END PGP SIGNATURE-----

--=-78/UWGx+zSDjgKJaXXV7--

