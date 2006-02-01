Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422963AbWBAVwD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422963AbWBAVwD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 16:52:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422964AbWBAVwD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 16:52:03 -0500
Received: from mx1.redhat.com ([66.187.233.31]:50379 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1422963AbWBAVwC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 16:52:02 -0500
Subject: Re: 2.6.15-rt16
From: Clark Williams <williams@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: chris perkins <cperkins@OCF.Berkeley.EDU>, linux-kernel@vger.kernel.org
In-Reply-To: <1138830476.6632.5.camel@localhost.localdomain>
References: <Pine.SOL.4.63.0601300839050.8546@conquest.OCF.Berkeley.EDU>
	 <1138640592.12625.0.camel@localhost.localdomain>
	 <Pine.SOL.4.63.0601300917120.8546@conquest.OCF.Berkeley.EDU>
	 <1138653235.26657.7.camel@localhost.localdomain>
	 <Pine.SOL.4.63.0601310946000.8770@conquest.OCF.Berkeley.EDU>
	 <1138730835.5959.3.camel@localhost.localdomain>
	 <1138818770.6685.1.camel@localhost.localdomain>
	 <1138819142.18762.10.camel@localhost.localdomain>
	 <1138830476.6632.5.camel@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-YHhkh8PrvQtGgKs4TG7c"
Date: Wed, 01 Feb 2006 15:51:34 -0600
Message-Id: <1138830694.18762.46.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-YHhkh8PrvQtGgKs4TG7c
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2006-02-01 at 16:47 -0500, Steven Rostedt wrote:
> On Wed, 2006-02-01 at 12:39 -0600, Clark Williams wrote:=20
> > On Wed, 2006-02-01 at 13:32 -0500, Steven Rostedt wrote:
> > >=20
> > > I'm still curious to what's happening with your kernel.  I'm currentl=
y
> > > running my x86_64 (typing right now on it) with CONFIG_SMP=3Dn and
> > > CONFIG_LATENCY=3Dy.  I know you probably sent a config before, but co=
uld
> > > you send it to me again.  (probably best to send it to me off list)
> >=20
> > yeah, it's been gnawing at me too. Not really stopping me, but I've see=
n
> > it happen on two Athlon64's (3000+ and 3400+).=20
> >=20
> > I'll send the .config offlist.
>=20
> Clark,
>=20
> Could you make sure that your modules in the initrd that you use are the
> ones created with the LATENCY_TRACE option.  After converting all the
> modules into compiled in options, I successfully booted the kernel.  So
> you might have an incompatibility with the modules in initrd, when you
> turn on LATENCY_TRACE.

Did you ever duplicated the failure?

I'm fairly certain that the initrd contains the appropriate modules,
since I regenerate the initrd each time I generate a new kernel, but
I'll go back and verify.=20

I'll also convert modules to compiled in and see if that makes a
difference.

Clark

--=20
Clark Williams <williams@redhat.com>

--=-YHhkh8PrvQtGgKs4TG7c
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBD4S1mHyuj/+TTEp0RAqXAAKCIIIgk/+NruM8qnE3cUCwQreUF4QCfaGM5
rk3Vl8pnZVTQLBaqNGLTmow=
=1qH4
-----END PGP SIGNATURE-----

--=-YHhkh8PrvQtGgKs4TG7c--

