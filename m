Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267566AbUG2Qog@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267566AbUG2Qog (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 12:44:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264937AbUG2QnP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 12:43:15 -0400
Received: from postimies.kymp.net ([80.248.96.135]:51461 "EHLO pales.kymp.net")
	by vger.kernel.org with ESMTP id S267752AbUG2Qg0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 12:36:26 -0400
Date: Thu, 29 Jul 2004 19:36:01 +0300
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Mika Bostrom <bostik+lkml@bostik.iki.fi>, Nathan Scott <nathans@sgi.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] let 4KSTACKS depend on EXPERIMENTAL and XFS on 4KSTACKS
Message-ID: <20040729163601.GA3308@bostik.iki.fi>
Reply-To: Mika Bostrom <bostik+lkml@bostik.iki.fi>
Mail-Followup-To: Zwane Mwaikambo <zwane@linuxpower.ca>,
	Mika Bostrom <bostik+lkml@bostik.iki.fi>,
	Nathan Scott <nathans@sgi.com>, linux-kernel@vger.kernel.org
References: <20040720114418.GH21918@email.archlab.tuwien.ac.at> <40FD0A61.1040503@xfs.org> <40FD2E99.20707@mnsu.edu> <20040720195012.GN14733@fs.tum.de> <20040729060900.GA1946@frodo> <20040729154224.GA3030@bostik.iki.fi> <Pine.LNX.4.58.0407291205590.8976@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4Ckj6UjgE2iN1+kY"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0407291205590.8976@montezuma.fsmlabs.com>
User-Agent: Mutt/1.5.6+20040523i
From: bostik@bostik.iki.fi (Mika Bostrom)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 29, 2004 at 12:09:29PM -0400, Zwane Mwaikambo wrote:
> On Thu, 29 Jul 2004, Mika Bostrom wrote:
>=20
> >   Now, the reason this can't be any kind of bugreport is clear:
> >   1) kernel is tainted
> >   2) VMWare's modules are not yet updated to cope with 2.6.7 kernel
> >
> >   So until VMWare updates their product, I consider this a bug in their
> > modules. When they do, I intend to test 4k stacks again. If the hangs
> > continue, then I shall see with their support whether it can be tracked
> > to their code or not.
> >
> >   But at least at the moment if you wish to use VMWare and XFS, using 4k
> > stacks is, in my experience, asking for trouble.
>=20
> Given that XFS and 4k stacks has known issues perhaps it isn't a fault of
> VMWare. I've been using VMWare 4 with 4K stacks running linux, netbsd and
> win2k on a system with a 30day uptime, i'm using ext3 on 2.6.7-rc3-mm2.

  Quite true, and a good point. However, this is one case that can be
reproduced - not systematically, but with certainty - and which displays
a clear difference between 4k and 8k stacks. Enabling noisy debugs and
tagging on a serial console might catch something.=20

  My co-worker uses a FC2 stock kernel and I remember someone from RH
(Ingo Molnar?) saying that those are currently built with 4k stacks.  He
has had no such troubles, but then, he isn't using XFS.

  I'm merely providing this as an additional info for those who assume
that VMWare knows what they are doing and wish to start debugging the
combination sooner rather than later. (Even if 'later' proves to
eliminate some dead-end test-case scenarios.) Nathan Scott explicitly
requested for information on troublesome setups, so one could say I'm
humouring him and granting a wish, of a sort :)

--=20
 Mika Bostr=F6m      +358-40-525-7347  \-/  "World peace will be achieved
 Bostik@iki.fi    www.iki.fi/bostik   X    when the last man has killed
 Security freak, and proud of it.    /-\   the second-to-last." -anon?

--4Ckj6UjgE2iN1+kY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBCSdxv829VwOfGI4RAg4cAKCT/tpYaandEoZRJw0hxEpYkw4y9wCgoh1i
O0SmrNniDqnG9Z33Xm7hqEY=
=BVxy
-----END PGP SIGNATURE-----

--4Ckj6UjgE2iN1+kY--
