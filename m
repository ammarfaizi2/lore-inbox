Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263299AbTJUT6m (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 15:58:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263300AbTJUT6m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 15:58:42 -0400
Received: from 24-216-47-96.charter.com ([24.216.47.96]:21382 "EHLO
	wally.rdlg.net") by vger.kernel.org with ESMTP id S263299AbTJUT6j
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 15:58:39 -0400
Date: Tue, 21 Oct 2003 15:58:34 -0400
From: "Robert L. Harris" <Robert.L.Harris@rdlg.net>
To: Zan Lynx <zlynx@acm.org>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test8 and HIGMEM = segfaults and panics?
Message-ID: <20031021195834.GG2617@rdlg.net>
Mail-Followup-To: Zan Lynx <zlynx@acm.org>,
	Linux-Kernel <linux-kernel@vger.kernel.org>
References: <20031021155337.GF2617@rdlg.net> <1066762982.5055.3.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="m0vRWufqUC70IDnR"
Content-Disposition: inline
In-Reply-To: <1066762982.5055.3.camel@localhost.localdomain>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--m0vRWufqUC70IDnR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable



Yup, I've played musical DIMMS as well.  It's currently up running with
1.5G install without the HIGMEM and I've taxed it pretty hard today
without issue.

What kernel are you running on?

They are registered.



Thus spake Zan Lynx (zlynx@acm.org):

> On Tue, 2003-10-21 at 09:53, Robert L. Harris wrote:
> > I'm running a dual-athalon system.  When I compiled the 2.6.0-test8 ker=
nel I
> > enabled HIGHMEM for 4 Gigs as I'm at 1.5G now and planning on purchasing
> > an additional 512Meg DIMM next weekend (yeah, should have with the
> > 1.5Gig).
> >=20
> > At any rate the box comes up just fine and runs for a while but once the
> > memory is in use for a few hours and seems to exceed 220+ Megs about any
> > command I execute will Segfault and the kernel has panic'd twice
> > (couldn't read the whole oops).
>=20
> I run a dual athlon system with 2 GB, and it has never done anything
> like that.
>=20
> Have you run memtest86 on your system to verify it isn't a physical
> memory problem?
>=20
> Are you using registered RAM chips?  I seem to remember from my
> motherboard documentation that registered is required to use more than 2
> memory slots.
> --=20
> Zan Lynx <zlynx@acm.org>



:wq!
---------------------------------------------------------------------------
Robert L. Harris                     | GPG Key ID: E344DA3B
                                         @ x-hkp://pgp.mit.edu
DISCLAIMER:
      These are MY OPINIONS ALONE.  I speak for no-one else.

Life is not a destination, it's a journey.
  Microsoft produces 15 car pileups on the highway.
    Don't stop traffic to stand and gawk at the tragedy.

--m0vRWufqUC70IDnR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/lY/q8+1vMONE2jsRAgc4AJ484MNSfLjVceceK1yxSFpbreRDJgCfVNP+
m0XxYs6j0PwQDUSV0l1qpME=
=FEbf
-----END PGP SIGNATURE-----

--m0vRWufqUC70IDnR--
