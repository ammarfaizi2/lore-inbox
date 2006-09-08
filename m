Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751519AbWIHByK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751519AbWIHByK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 21:54:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751812AbWIHByK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 21:54:10 -0400
Received: from mse2fe2.mse2.exchange.ms ([66.232.26.194]:933 "EHLO
	mse2fe2.mse2.exchange.ms") by vger.kernel.org with ESMTP
	id S1751519AbWIHByG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 21:54:06 -0400
Subject: Re: [PATCH] x86_64 kexec: Remove experimental mark of kexec
From: Piet Delaney <piet@bluelane.com>
Reply-To: piet@bluelane.com
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Piet Delaney <piet@bluelane.com>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       fastboot@osdl.org
In-Reply-To: <m1ac5crws8.fsf@ebiederm.dsl.xmission.com>
References: <m1veo1vtev.fsf@ebiederm.dsl.xmission.com>
	 <m1k64hvsru.fsf@ebiederm.dsl.xmission.com> <200609062122.14971.ak@suse.de>
	 <m1pse8vjjg.fsf@ebiederm.dsl.xmission.com>
	 <1157610028.14930.32.camel@piet2.bluelane.com>
	 <m1ac5crws8.fsf@ebiederm.dsl.xmission.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-pd/7X9yU9Q7yCxNfnSM5"
Organization: Blue Lane Technologies
Date: Thu, 07 Sep 2006 18:54:00 -0700
Message-Id: <1157680441.14930.63.camel@piet2.bluelane.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4-3mdk 
X-OriginalArrivalTime: 08 Sep 2006 01:54:05.0347 (UTC) FILETIME=[AA53CF30:01C6D2E9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-pd/7X9yU9Q7yCxNfnSM5
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2006-09-07 at 00:55 -0600, Eric W. Biederman wrote:
> Piet Delaney <piet@bluelane.com> writes:
>=20
> > On Wed, 2006-09-06 at 14:15 -0600, Eric W. Biederman wrote:
> >> Andi Kleen <ak@suse.de> writes:
> >>=20
> >> > On Wednesday 06 September 2006 18:55, Eric W. Biederman wrote:
> >> >>=20
> >> >> kexec has been marked experimental for a year now and all
> >> >> of the serious problems have been worked through.  So it
> >> >> is time (if not past time) to remove the experimental mark.
> >> >>=20
> >> >
> >> > Hmm, I personally have some doubts it is really not experimental
> >> > (not because of the kexec code itself, but because of all the other =
drivers
> >> > that still break)
> >>=20
> >> That is a reasonable viewpoint.  Although by that a lot more of the ke=
rnel
> >> deserves to be marked experimental.=20
> >>=20
> >> On the perverse side of the sentiment taking off experimental may incr=
ease
> >> our number of testers and get the bugs fixed faster :)
> >
> > I take it that for using kexec to boot a kdump kernel and then
> > rebooting the primary kernel that there are a few drivers in
> > the dumping kernel that wouldn't work but they aren't likely
> > to be used. Ie: it's "just" a hardware initialization issue
> > on kernels booted with kexec.
>=20
> Yes.  The only place you are likely to observe the driver
> initialization problems are kernels booted with kexec.  But there
> are other rare scenarios that can yield challenging boot driver
> initialization scenarios.   I know soft booting from windows used
> to be one of them.
>=20
> As for the kdump kernel usually you won't load (or build in) any
> drivers you don't intend to use.  If the drivers actually get loaded
> even if you aren't using them you could have problems.

Thanks for the tip, I'll make sure my dumping kernel only
has drivers necessary to make the kernel core file configured.

-piet

>=20
> Eric
--=20
Piet Delaney                                    Phone: (408) 200-5256
Blue Lane Technologies                          Fax:   (408) 200-5299
10450 Bubb Rd.
Cupertino, Ca. 95014                            Email: piet@bluelane.com

--=-pd/7X9yU9Q7yCxNfnSM5
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBFAM04JICwm/rv3hoRAuaHAJwMMHBqSdEe22+tdKbPbM6Ld53P/ACfeH2s
7fMbytnUVSa27fXVi1YS0jY=
=41Mk
-----END PGP SIGNATURE-----

--=-pd/7X9yU9Q7yCxNfnSM5--

