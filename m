Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262373AbTKYLDx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 06:03:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262375AbTKYLDx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 06:03:53 -0500
Received: from node-d-1fcf.a2000.nl ([62.195.31.207]:46210 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S262373AbTKYLDu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 06:03:50 -0500
Subject: Re: hyperthreading
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: lgb@lgb.hu
Cc: AlberT@SuperAlberT.it, linux-kernel@vger.kernel.org
In-Reply-To: <20031125100526.GE339@vega.digitel2002.hu>
References: <20031125094419.GB339@vega.digitel2002.hu>
	 <200311251048.53046.AlberT_NOSPAM_@SuperAlberT.it>
	 <20031125100526.GE339@vega.digitel2002.hu>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Gwc0fi9EJsZ0KHNUuTmc"
Organization: Red Hat, Inc.
Message-Id: <1069755396.5214.2.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Tue, 25 Nov 2003 11:16:36 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Gwc0fi9EJsZ0KHNUuTmc
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 2003-11-25 at 11:05, G=C3=A1bor L=C3=A9n=C3=A1rt wrote:
> On Tue, Nov 25, 2003 at 10:48:51AM +0100, Emiliano 'AlberT' Gabrielli wro=
te:
\
> OK, but if this CPU does not support HT, then why 'ht' is shown at
> flags in /proc/cpuinfo? It looks like quite illogical for me then ...

/proc/cpuinfo only reports what the cpu reports. The 'ht' flag means not
HyperThreading per se. It means it listens to the "rep; nop" sequence
for example. Also all Hyperthreading capable cpus have this flag set,
but that is a one way relationship. Esp since this needs more support
than just the cpu.

--=-Gwc0fi9EJsZ0KHNUuTmc
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/wywExULwo51rQBIRAoGjAKCL583jRBbIQNJDs+ki4+s65u5WsgCdGwvV
DaVRdP3SPCciPL+9mBoJqqo=
=3wAo
-----END PGP SIGNATURE-----

--=-Gwc0fi9EJsZ0KHNUuTmc--
