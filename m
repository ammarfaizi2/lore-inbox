Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751920AbWIGGUd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751920AbWIGGUd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 02:20:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751951AbWIGGUd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 02:20:33 -0400
Received: from mse2fe2.mse2.exchange.ms ([66.232.26.194]:44376 "EHLO
	mse2fe2.mse2.exchange.ms") by vger.kernel.org with ESMTP
	id S1751920AbWIGGUc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 02:20:32 -0400
Subject: Re: [PATCH] x86_64 kexec: Remove experimental mark of kexec
From: Piet Delaney <piet@bluelane.com>
Reply-To: piet@bluelane.com
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Piet Delaney <piet@bluelane.com>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       fastboot@osdl.org
In-Reply-To: <m1pse8vjjg.fsf@ebiederm.dsl.xmission.com>
References: <m1veo1vtev.fsf@ebiederm.dsl.xmission.com>
	 <m1k64hvsru.fsf@ebiederm.dsl.xmission.com> <200609062122.14971.ak@suse.de>
	 <m1pse8vjjg.fsf@ebiederm.dsl.xmission.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-eXZUShk205RVQmvSd0fz"
Organization: Blue Lane Technologies
Date: Wed, 06 Sep 2006 23:20:27 -0700
Message-Id: <1157610028.14930.32.camel@piet2.bluelane.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4-3mdk 
X-OriginalArrivalTime: 07 Sep 2006 06:20:31.0443 (UTC) FILETIME=[B85EBA30:01C6D245]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-eXZUShk205RVQmvSd0fz
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2006-09-06 at 14:15 -0600, Eric W. Biederman wrote:
> Andi Kleen <ak@suse.de> writes:
>=20
> > On Wednesday 06 September 2006 18:55, Eric W. Biederman wrote:
> >>=20
> >> kexec has been marked experimental for a year now and all
> >> of the serious problems have been worked through.  So it
> >> is time (if not past time) to remove the experimental mark.
> >>=20
> >
> > Hmm, I personally have some doubts it is really not experimental
> > (not because of the kexec code itself, but because of all the other dri=
vers
> > that still break)
>=20
> That is a reasonable viewpoint.  Although by that a lot more of the kerne=
l
> deserves to be marked experimental.=20
>=20
> On the perverse side of the sentiment taking off experimental may increas=
e
> our number of testers and get the bugs fixed faster :)

I take it that for using kexec to boot a kdump kernel and then
rebooting the primary kernel that there are a few drivers in
the dumping kernel that wouldn't work but they aren't likely
to be used. Ie: it's "just" a hardware initialization issue
on kernels booted with kexec.

-piet

>=20
> > But applied for now.
>=20
> Thanks.
>=20
> Eric
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
--=20
Piet Delaney                                    Phone: (408) 200-5256
Blue Lane Technologies                          Fax:   (408) 200-5299
10450 Bubb Rd.
Cupertino, Ca. 95014                            Email: piet@bluelane.com

--=-eXZUShk205RVQmvSd0fz
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBE/7orJICwm/rv3hoRAlgdAJ4iWdSIocPTo5MGcnj5l48C0FRreQCfYv2e
wsTlzY84kzu4WDdy9wtIMs8=
=HOGp
-----END PGP SIGNATURE-----

--=-eXZUShk205RVQmvSd0fz--

