Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265389AbUANJpa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 04:45:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265439AbUANJp3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 04:45:29 -0500
Received: from mx1.redhat.com ([66.187.233.31]:40366 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265389AbUANJoh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 04:44:37 -0500
Date: Wed, 14 Jan 2004 10:44:17 +0100
From: Arjan van de Ven <arjanv@redhat.com>
To: Andi Kleen <ak@colin2.muc.de>
Cc: Andi Kleen <ak@muc.de>, akpm@osdl.org, linux-kernel@vger.kernel.org,
       jh@suse.cz
Subject: Re: [PATCH] Add CONFIG for -mregparm=3
Message-ID: <20040114094417.GB12378@devserv.devel.redhat.com>
References: <20040114090603.GA1935@averell> <1074072899.4981.4.camel@laptop.fenrus.com> <20040114093940.GC19652@colin2.muc.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9zSXsLTf0vkW971A"
Content-Disposition: inline
In-Reply-To: <20040114093940.GC19652@colin2.muc.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--9zSXsLTf0vkW971A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


On Wed, Jan 14, 2004 at 10:39:40AM +0100, Andi Kleen wrote:
> On Wed, Jan 14, 2004 at 10:34:59AM +0100, Arjan van de Ven wrote:
> > On Wed, 2004-01-14 at 10:06, Andi Kleen wrote:
> >=20
> > >=20
> > > According to some gcc developers it should be safe to use in all
> > > gccs that are still supports (2.95 and up)=20
> >=20
> > it is not safe for the kernel until the cardbus CardServices patches get
> > merged (is in -mm), for the same reason CardServices() is broken on
> > amd64.
>=20
> Just mark them asmlinkage then.
>=20
> I would be a shame to leave that much space saving on the table just
> for an single misdesigned API than can be easily fixed.

Oh I rather just fix the API period... :)
Patches exist and work excellent for me.

--9zSXsLTf0vkW971A
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFABQ9wxULwo51rQBIRAvkTAJ9m1KSZBfrSoqL3hLykLfef6CyJhQCfSkMi
OGqTes4PfMI1jf5xVUAVokw=
=7Rf2
-----END PGP SIGNATURE-----

--9zSXsLTf0vkW971A--
