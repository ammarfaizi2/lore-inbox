Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261591AbVDEHEr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261591AbVDEHEr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 03:04:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261589AbVDEHEe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 03:04:34 -0400
Received: from ns2.vocord.com ([194.220.215.56]:42181 "EHLO vocord.com")
	by vger.kernel.org with ESMTP id S261588AbVDEHET (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 03:04:19 -0400
Subject: Re: Netlink Connector / CBUS
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Reply-To: johnpol@2ka.mipt.ru
To: James Morris <jmorris@redhat.com>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       "David S. Miller" <davem@davemloft.net>,
       Herbert Xu <herbert@gondor.apana.org.au>, rml@novell.com,
       Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <Xine.LNX.4.44.0504050108260.9383-100000@thoron.boston.redhat.com>
References: <Xine.LNX.4.44.0504050108260.9383-100000@thoron.boston.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Q31YfxoFqrjCdpDRIKy3"
Organization: MIPT
Date: Tue, 05 Apr 2005 11:08:04 +0400
Message-Id: <1112684884.28858.10.camel@uganda>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.4 (vocord.com [192.168.0.1]); Tue, 05 Apr 2005 11:03:05 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Q31YfxoFqrjCdpDRIKy3
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2005-04-05 at 01:10 -0400, James Morris wrote:
> On Tue, 5 Apr 2005, James Morris wrote:
>=20
> > A few questions:
>=20
> Also, please allow cn_add_callback() allow it to be passed a NULL=20
> callback function, so the caller doesn't pass in a dummy function and you=
r=20
> code doesn't waste time dealing with something which isn't real.

Why can anyone want to add callback that will not supposed to be
usefull?
Callback is called when someone sends netlink message with appropriate
idx/val inside, if there is no registered callback with such ID,=20
nothing will be called and skb will be freed.

>=20
> - James
--=20
        Evgeniy Polyakov

Crash is better than data corruption -- Arthur Grabowski

--=-Q31YfxoFqrjCdpDRIKy3
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBCUjlUIKTPhE+8wY0RAv/qAJ4gmxfOafjdLprCQ4Ue0e7d6SxbrACfcJM7
qFXZGBk8rY3rtFUCIyZgu3Q=
=0Car
-----END PGP SIGNATURE-----

--=-Q31YfxoFqrjCdpDRIKy3--

