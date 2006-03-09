Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932746AbWCIDNp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932746AbWCIDNp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 22:13:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932747AbWCIDNp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 22:13:45 -0500
Received: from threatwall.zlynx.org ([199.45.143.218]:54929 "EHLO zlynx.org")
	by vger.kernel.org with ESMTP id S932746AbWCIDNo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 22:13:44 -0500
Subject: Re: [PATCH] mm: yield during swap prefetching
From: Zan Lynx <zlynx@acm.org>
To: Con Kolivas <kernel@kolivas.org>
Cc: =?ISO-8859-1?Q?Andr=E9?= Goddard Rosa <andre.goddard@gmail.com>,
       Lee Revell <rlrevell@joe-job.com>, Andrew Morton <akpm@osdl.org>,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org, ck@vds.kolivas.org
In-Reply-To: <cone.1141862870.463023.26372.501@kolivas.org>
References: <200603081013.44678.kernel@kolivas.org>
	 <200603081322.02306.kernel@kolivas.org> <1141784834.767.134.camel@mindpipe>
	 <200603081330.56548.kernel@kolivas.org>
	 <b8bf37780603071852r6bf3821fr7610597a54ad305b@mail.gmail.com>
	 <cone.1141787137.882268.19235.501@kolivas.org>
	 <1141852064.21958.28.camel@localhost>
	 <cone.1141858802.179786.26372.501@kolivas.org>
	 <1141861694.21958.66.camel@localhost>
	 <cone.1141862870.463023.26372.501@kolivas.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-zJ9LnmXwAF2CSBtVTkz0"
Date: Wed, 08 Mar 2006 20:13:32 -0700
Message-Id: <1141874012.21958.138.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
X-Envelope-From: zlynx@acm.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-zJ9LnmXwAF2CSBtVTkz0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2006-03-09 at 11:07 +1100, Con Kolivas wrote:
> Games worked on windows for a decade on single core without real time=20
> scheduling because that's what they were written for.=20
>=20
> Now that games are written for windows with dual core they work well -
> again=20
> without real time scheduling.=20
>=20
> Why should a port of these games to linux require real time?

That isn't what I said.  I said nothing about *requiring* anything, only
about how to do it better.

Here is what Con said that I was disagreeing with.  All the rest was to
justify my disagreement. =20

Con said, "... games should _not_ need special scheduling classes. They
are not written in a real time smart way and they do not have any
realtime constraints or requirements."

And he said later, "No they shouldn't need real time scheduling to work
well if they are coded properly."

Here is a list of simple statements of what I am saying:
Games do have real-time requirements.
The OS guessing about real-time priorities will sometimes get it wrong.
Guessing task priority is worse than being told and knowing for sure.
Games should, in an ideal world, be using real-time OS scheduling.
Games would work better using real-time OS scheduling.

That is all from me.
--=20
Zan Lynx <zlynx@acm.org>

--=-zJ9LnmXwAF2CSBtVTkz0
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.1 (GNU/Linux)

iD8DBQBED51cG8fHaOLTWwgRAn4XAKCNNx6BkyM7bKMsUSHQlaZ6aYjskgCfZ/8V
PhwwV6gfUdOOZR/NUa+D4ho=
=sP7C
-----END PGP SIGNATURE-----

--=-zJ9LnmXwAF2CSBtVTkz0--

