Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261860AbVC3KxJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261860AbVC3KxJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 05:53:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261861AbVC3KxJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 05:53:09 -0500
Received: from dea.vocord.ru ([217.67.177.50]:58286 "EHLO vocord.com")
	by vger.kernel.org with ESMTP id S261860AbVC3KxD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 05:53:03 -0500
Subject: Re: [patch 1/2] fork_connector: add a fork connector
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Reply-To: johnpol@2ka.mipt.ru
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Paul Jackson <pj@engr.sgi.com>, guillaume.thouvenin@bull.net,
       akpm@osdl.org, greg@kroah.com, linux-kernel@vger.kernel.org,
       jlan@engr.sgi.com, efocht@hpce.nec.com, linuxram@us.ibm.com,
       gh@us.ibm.com, elsa-devel@lists.sourceforge.net
In-Reply-To: <E1DGaOG-0002Md-00@gondolin.me.apana.org.au>
References: <E1DGaOG-0002Md-00@gondolin.me.apana.org.au>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-TgrbcAQ3/uZdDP0TksjS"
Organization: MIPT
Date: Wed, 30 Mar 2005 14:57:42 +0400
Message-Id: <1112180262.5243.120.camel@uganda>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.4 (vocord.com [192.168.0.1]); Wed, 30 Mar 2005 14:51:12 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-TgrbcAQ3/uZdDP0TksjS
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2005-03-30 at 20:25 +1000, Herbert Xu wrote:
> Paul Jackson <pj@engr.sgi.com> wrote:
> >=20
> > So I suppose if fork_connector were not used to collect <parent pid,
> > child pid> information for accounting, then someone would have to make
> > the case that there were enough other uses, of sufficient value, to add
> > fork_connector.  We have to be a bit careful, in the kernel, to avoid
> > adding mechanisms until we have the immediate use in hand.  If we don't
> > do this, then the kernel ends up looking like the Gargoyles on a
> > Renaissance church - burdened with overly ornate features serving no
> > earthly purpose.
>=20
> I agree completely.  In fact the whole drivers/connector directory
> looks pretty suspect.  Are there any in-kernel users of it at all?

SuperIO subsystem.
In agenda sit w1, acrypto [but it already looks like it will not be
included :) ].

--=20
        Evgeniy Polyakov

Crash is better than data corruption -- Arthur Grabowski

--=-TgrbcAQ3/uZdDP0TksjS
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBCSoYmIKTPhE+8wY0RAgs4AKCXqnemPXi04X9xpBcmUtlT0GRVTACggDnf
WK029g4sPh/9gv9JIax+scY=
=Tk5M
-----END PGP SIGNATURE-----

--=-TgrbcAQ3/uZdDP0TksjS--

