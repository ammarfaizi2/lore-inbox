Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261608AbVD0GBl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261608AbVD0GBl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 02:01:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261614AbVD0GBl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 02:01:41 -0400
Received: from user-edvans3.msk.internet2.ru ([217.25.93.4]:12742 "EHLO
	vocord.com") by vger.kernel.org with ESMTP id S261608AbVD0GBi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 02:01:38 -0400
Subject: Re: [1/1] connector/CBUS: new messaging subsystem. Revision number
	next.
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Reply-To: johnpol@2ka.mipt.ru
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: netdev@oss.sgi.com, Greg KH <greg@kroah.com>,
       Jamal Hadi Salim <hadi@cyberus.ca>, Kay Sievers <kay.sievers@vrfy.org>,
       Herbert Xu <herbert@gondor.apana.org.au>,
       James Morris <jmorris@redhat.com>,
       Guillaume Thouvenin <guillaume.thouvenin@bull.net>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Thomas Graf <tgraf@suug.ch>, Jay Lan <jlan@engr.sgi.com>
In-Reply-To: <200504270046.41042.dtor_core@ameritech.net>
References: <20050411125932.GA19538@uganda.factory.vocord.ru>
	 <200504270016.34002.dtor_core@ameritech.net>
	 <1114579926.14282.16.camel@uganda>
	 <200504270046.41042.dtor_core@ameritech.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-vFoTmKJ8c4En+UikOrm6"
Organization: MIPT
Date: Wed, 27 Apr 2005 10:08:36 +0400
Message-Id: <1114582116.14282.25.camel@uganda>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.4 (vocord.com [192.168.0.1]); Wed, 27 Apr 2005 10:01:05 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-vFoTmKJ8c4En+UikOrm6
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2005-04-27 at 00:46 -0500, Dmitry Torokhov wrote:

> into callback queue. Hmm, might be useful if it was, for implementing
> various kinds of in-kernel notifications.

There was implementation for that, but I dropped it due to broken code
[fix was simple, but there is issue number 2]
and I think it may end up in various microkerel-alike message queues.
Since I worked too much with projects that are based on such design,
so I afraid it will be very bad to allow such using in Linux kernel.
Although it can be compile-time or something...

--=20
        Evgeniy Polyakov

Crash is better than data corruption -- Arthur Grabowski

--=-vFoTmKJ8c4En+UikOrm6
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBCbyxkIKTPhE+8wY0RAr9oAJ0cfP93igGWrGw9lxnt8/z1zLZD5ACeIEr4
aDWPAjPDKW1Aqt4xff0MOd4=
=2d1b
-----END PGP SIGNATURE-----

--=-vFoTmKJ8c4En+UikOrm6--

