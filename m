Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267615AbUIHORl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267615AbUIHORl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 10:17:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269156AbUIHOO2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 10:14:28 -0400
Received: from mx1.redhat.com ([66.187.233.31]:13278 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268345AbUIHOJ4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 10:09:56 -0400
Subject: Re: [patch] generic-hardirqs.patch, 2.6.9-rc1-bk14
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Christoph Hellwig <hch@infradead.org>,
       William Lee Irwin III <wli@holomorphy.com>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Scott Wood <scott@timesys.com>
In-Reply-To: <Pine.LNX.4.53.0409080938470.15087@montezuma.fsmlabs.com>
References: <20040908120613.GA16916@elte.hu>
	 <20040908133445.A31267@infradead.org> <20040908124547.GA19231@elte.hu>
	 <20040908125755.GC3106@holomorphy.com>
	 <Pine.LNX.4.53.0409080932050.15087@montezuma.fsmlabs.com>
	 <20040908143143.A32002@infradead.org>
	 <Pine.LNX.4.53.0409080938470.15087@montezuma.fsmlabs.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-gcVs7A8O3Ng80AoI0fr4"
Organization: Red Hat UK
Message-Id: <1094652572.2800.14.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 08 Sep 2004 16:09:32 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-gcVs7A8O3Ng80AoI0fr4
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2004-09-08 at 15:47, Zwane Mwaikambo wrote:
> On Wed, 8 Sep 2004, Christoph Hellwig wrote:
>=20
> > On Wed, Sep 08, 2004 at 09:34:03AM -0400, Zwane Mwaikambo wrote:
> > > Hmm, whenever i've brought up weak functions in a patch it's never we=
ll=20
> > > received. Frankly i prefer it to littering the architectures with sim=
ilar=20
> > > functions.
> >=20
> > That's what we have asm-generic for.
>=20
> So you have an inline function in a header and include it everywhere? How=
=20
> is that better?

the thing is, now with the config option, you don't need the generic_
wrapper thing, just use the full real name. And the prototypes can be
generic for the arch's that want it.


--=-gcVs7A8O3Ng80AoI0fr4
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBPxKcxULwo51rQBIRAufOAJwMdn015A9rR30F3HRXEPNPQL5sBwCeJCwr
l+mRl1OgekLAgAossLPHAzA=
=x2mW
-----END PGP SIGNATURE-----

--=-gcVs7A8O3Ng80AoI0fr4--

