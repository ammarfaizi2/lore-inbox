Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261693AbVDELUk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261693AbVDELUk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 07:20:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261699AbVDELUj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 07:20:39 -0400
Received: from dea.vocord.ru ([217.67.177.50]:60341 "EHLO vocord.com")
	by vger.kernel.org with ESMTP id S261693AbVDELUW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 07:20:22 -0400
Subject: Re: Netlink Connector / CBUS
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Reply-To: johnpol@2ka.mipt.ru
To: hadi@cyberus.ca
Cc: Herbert Xu <herbert@gondor.apana.org.au>, linux-kernel@vger.kernel.org,
       netdev <netdev@oss.sgi.com>, "David S. Miller" <davem@davemloft.net>,
       James Morris <jmorris@redhat.com>, rml@novell.com,
       Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <1112698800.1088.50.camel@jzny.localdomain>
References: <Xine.LNX.4.44.0504050108260.9383-100000@thoron.boston.redhat.com>
	 <1112686480.28858.17.camel@uganda>
	 <1112697888.1089.44.camel@jzny.localdomain>
	 <1112698800.1088.50.camel@jzny.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-sSnCz6Q18Ygv+8vLJ7Uc"
Organization: MIPT
Date: Tue, 05 Apr 2005 15:25:22 +0400
Message-Id: <1112700322.28858.42.camel@uganda>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.4 (vocord.com [192.168.0.1]); Tue, 05 Apr 2005 15:18:39 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-sSnCz6Q18Ygv+8vLJ7Uc
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2005-04-05 at 07:00 -0400, jamal wrote:
> and, oh yeah - wheres the documentation Evgeniy? ;->

In the tree :)
Documentation/connector/connector.txt - some notes, API.
Documentation/connector/cn_test.c - kernel example.
Uses cn_netlink_send(), notification feature.

I will send today a pathc that adds in-source documentation
bits with some code cleanups.

> cheers,
> jamal
>=20
> On Tue, 2005-04-05 at 06:44, jamal wrote:
> > To be fair to Evgeniy I am not against the Konnector idea. I think that
> > it is a useful feature to have an easy to use messaging between
> > kernel-kernel and kernel-userspace. The fact that he leveraged netlink
> > instead of inventing things is a bonus. Having said that i have not
> > seriously scrutinized the code - and i think the idea of this new thing
> > hes tossing around called CBUS maybe pushing it.
> >=20
> > cheers,
> > jamal
> >=20
> > On Tue, 2005-04-05 at 03:34, Evgeniy Polyakov wrote:
> > > On Tue, 2005-04-05 at 01:10 -0400, Herbert Xu wrote:
> > > >On Tue, Apr 05, 2005 at 11:03:16AM +0400, Evgeniy Polyakov wrote:
> > > >>=20
> > > >> I received comments and feature requests from Herbert Xu and Jamal=
 Hadi
> > > >> Salim,
> > > >> almost all were successfully resolved.
> > > >
> > > >Please do not construe my involvement in these threads as endorsemen=
t
> > > >for this system.
> > >=20
> > > Sure.
> > > I remember you are against it :).
> > >=20
> > > >In fact to this day I still don't understand what problems this thin=
g is
> > > >meant to solve.
> > >=20
> > > Hmm, what else can I add to my words?
> > > May be checking the size of the code needed to broadcast kobject chan=
ges
> > > in kobject_uevent.c for example...
> > > Netlink socket allocation + skb handling against call to cn_netlink_s=
end().
> > >=20
> > > >--=20
> > > >Visit Openswan at http://www.openswan.org/
> > > >Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
> > > >Home Page: http://gondor.apana.org.au/~herbert/
> > > >PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
> > >=20
> >=20
> >=20
> >=20
--=20
        Evgeniy Polyakov

Crash is better than data corruption -- Arthur Grabowski

--=-sSnCz6Q18Ygv+8vLJ7Uc
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBCUnWiIKTPhE+8wY0RAlXXAJ9cqMiWKTv+jyUGIgqYjppnwYvvlACfYXx7
uJSA7Zm+fMplyqvjC2bt38w=
=f8I/
-----END PGP SIGNATURE-----

--=-sSnCz6Q18Ygv+8vLJ7Uc--

