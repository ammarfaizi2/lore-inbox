Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263294AbRFRCVO>; Sun, 17 Jun 2001 22:21:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263298AbRFRCVE>; Sun, 17 Jun 2001 22:21:04 -0400
Received: from ndslppp243.ptld.uswest.net ([63.224.227.243]:31321 "HELO
	knghtbrd.dyn.dhs.org") by vger.kernel.org with SMTP
	id <S263294AbRFRCUr>; Sun, 17 Jun 2001 22:20:47 -0400
Date: Sun, 17 Jun 2001 19:22:11 -0700
From: Joseph Carter <knghtbrd@d2dc.net>
To: Daniel Bertrand <d.bertrand@ieee.ca>
Cc: Robert Love <rml@ufl.edu>, Dylan Griffiths <Dylan_G@bigfoot.com>,
        emu10k1-devel <emu10k1-devel@opensource.creative.com>,
        Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Emu10k1-devel] Re: Buggy emu10k1 drivers.
Message-ID: <20010617192211.A15116@debian.org>
In-Reply-To: <992822448.3798.6.camel@phantasy> <Pine.LNX.4.33.0106171707150.2262-100000@kilrogg>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IS0zKkzwUGydFO0o"
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <Pine.LNX.4.33.0106171707150.2262-100000@kilrogg>; from d.bertrand@ieee.ca on Sun, Jun 17, 2001 at 05:25:11PM -0700
X-Operating-System: Linux galen 2.4.3-ac12
X-No-Junk-Mail: Spam will solicit a hostile reaction, at the very least.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 17, 2001 at 05:25:11PM -0700, Daniel Bertrand wrote:
> > if the driver in the kernel is that old, could we try merging a newer
> > release?  is there any reason why it has not been done yet?
>=20
> A patch was submitted to Alan in April but appears to have never made it
> in, I'm not sure what his reason was.

Right after it was made I found out that it had broken mmap.  Rui sent me
a patch, then another.  Seems he has committed most of that patch to CVS
now but there are differences still.  I'm not sure if the differences are
actually still important, I may have to try building fresh CVS to be sure.

I don't know for sure if that's why Alan hasn't applied the new driver,
but it was an issue that would have broken the patch he was given which is
supposed to be fixed now.  I'm thinking Rui has gotten busy in the
meantime since he's been rather quiet lately.

--=20
Joseph Carter <knghtbrd@d2dc.net>                   Free software developer

<jt> should a bug be marked critical if it only affects one arch?
<james-workaway> jt: rc for that arch maybe, but those kind of arch
                 specific bugs are rare...
<jt> not when it's caused by a bug in gcc
<doogie> jt: get gcc removed from that arch. :)


--IS0zKkzwUGydFO0o
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.5 (GNU/Linux)
Comment: 1024D/DCF9DAB3  20F6 2261 F185 7A3E 79FC  44F9 8FF7 D7A3 DCF9 DAB3

iEYEARECAAYFAjstZdMACgkQj/fXo9z52rNKpQCfdFwuf6FDL940ks+lBsc14DFf
2RYAniNIhG7DSgtN50z4NVgrbu+R8wAI
=tS5I
-----END PGP SIGNATURE-----

--IS0zKkzwUGydFO0o--
