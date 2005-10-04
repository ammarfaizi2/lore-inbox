Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751216AbVJDKz6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751216AbVJDKz6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 06:55:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751217AbVJDKz6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 06:55:58 -0400
Received: from wg.technophil.ch ([213.189.149.230]:6551 "HELO
	hydrogenium.schottelius.org") by vger.kernel.org with SMTP
	id S1751216AbVJDKz6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 06:55:58 -0400
Date: Tue, 4 Oct 2005 12:55:54 +0200
From: Nico Schottelius <nico-kernel@schottelius.org>
To: Coywolf Qi Hunt <coywolf@gmail.com>
Cc: Nico Schottelius <nico-kernel@schottelius.org>,
       linux-kernel@vger.kernel.org
Subject: Re: halt: init exits/panic
Message-ID: <20051004105554.GB1750@schottelius.org>
Mail-Followup-To: Nico Schottelius <nico-kernel@schottelius.org>,
	Coywolf Qi Hunt <coywolf@gmail.com>, linux-kernel@vger.kernel.org
References: <20050709151227.GM1322@schottelius.org> <2cd57c9005070910091f1051f7@mail.gmail.com> <20051004073740.GA1498@schottelius.org> <2cd57c900510040112q10eb5cdbya2ef62689e8f90f2@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aVD9QWMuhilNxW9f"
Content-Disposition: inline
In-Reply-To: <2cd57c900510040112q10eb5cdbya2ef62689e8f90f2@mail.gmail.com>
User-Agent: echo $message | gpg -e $sender  -s | netcat mailhost 25
X-Linux-Info: http://linux.schottelius.org/
X-Operating-System: Linux 2.6.13.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--aVD9QWMuhilNxW9f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Coywolf Qi Hunt [Tue, Oct 04, 2005 at 04:12:40PM +0800]:
> On 10/4/05, Nico Schottelius <nico-kernel@schottelius.org> wrote:
> > Coywolf Qi Hunt [Sun, Jul 10, 2005 at 01:09:22AM +0800]:
> > > On 7/9/05, Nico Schottelius <nico-kernel@schottelius.org> wrote:
> > > > Hello!
> > > >
> > > > What's the 'correct behaviour' of an init system, if someone wants
> > > > to shutdown the system?
> > > >
> > > > I currently do:
> > > >
> > > > - call reboot(RB_POWER_OFF/RB_AUTOBOOT/RB_HALT_SYSTEM)
> > > > - _exit(0)
> > > >
> > > > Is this exit() call wrong? If I do RB_HALT_SYSTEM and _exit(0) afte=
r,
> > > > the kernel panics.
> > >
> > > What the panic shows?
> >
> > To be fully correct:
> >
> > "Kernel panic - not syncing: Attempted to kill init" (from the last time
> > I tried, 2.6.13.2)
> >
> > Perhaps _exit(0) is not correct for an init system?
> > This at least explains why it always looks like nothing is synced.
>=20
> Right. init(8) should not call _exit() or exit(). Otherwise you'll get
> that panic. It's OK for *another* process, reboot(8) to call reboot(2)
> and then exit(). You should follow this way.

Ok, as far as I understood my init simply returns to its normal state
and hopes that the kernel halts|reboots|powers off.

Will do that' thanks for the info.

Nico

--=20
Latest project: cconfig (http://nico.schotteli.us/papers/linux/cconfig/)
Open Source nutures open minds and free, creative developers.

--aVD9QWMuhilNxW9f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iQIVAwUBQ0JfurOTBMvCUbrlAQIXWBAAjYF8UyBMKGnnbx7GMpysjcU9eJV4zgxS
yam8E5OC4YBGrpTeInTjzDIjQbx1OsM3RZLQLkvZnIi55bXXEJls2F5Bzgsq+hCY
J5vlErY2nEDarnBx9il/nxS7wIxNSeZVdv5rgiQEPSeqVmf7Et7I05I0TLttKTrM
3cm2MvAJ6HE2rUjUHEZPb//J9L5ggYCILtnDRF7WMu/OFBBFP8MvzTna5BR6kdiq
vQm/vAWh+mRwr9yBFEA5P4TKlPw24Qe7HLRRNtI7fAw2okiT9SYfl0dkD3XSHqTf
euIJsPwPDxS74ki6tZxDIY6BaoLbyAPHBjY7IwuBxeoBFfJueRpWfFDt2pg9C/+c
3BK2v4ywY3KdZ6YhqPbX8wmC8LMZmFC2THpyuVvbRSrJnbjfo5jxbdLXAczslCqU
skuy56DyWpIzIByLTHCaRvuOLDLtqW2QfE4icULOdK/EfUNt4Svxg4WjOenx95Y4
YXiW8OnG3S1Im0hxceSE6rLi72Ybge2x+QwjkH6bDc8az2xoqyu4sQSnZkMJg0yV
vOWZpiBw/WUB0PLWoOw4foqvNtqCzt5e56o0e5yQ/4joknqsiKFBpl1eL1DCT48b
pKYAHi9j53D/7gZVh+ElxYFZ2MFu5QLiC9YRqWijM7OJLDcgKGAIe71UifwrfjJX
a+xMvL68ijY=
=nFGO
-----END PGP SIGNATURE-----

--aVD9QWMuhilNxW9f--
