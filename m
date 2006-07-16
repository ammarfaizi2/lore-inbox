Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751108AbWGPQ2g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751108AbWGPQ2g (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jul 2006 12:28:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751112AbWGPQ2f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jul 2006 12:28:35 -0400
Received: from mail.gmx.de ([213.165.64.21]:37288 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751108AbWGPQ2f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jul 2006 12:28:35 -0400
X-Authenticated: #2308221
Date: Sun, 16 Jul 2006 18:28:31 +0200
From: Christian Trefzer <ctrefzer@gmx.de>
To: Xavier Roche <roche+kml2@exalead.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: reiserFS?
Message-ID: <20060716162831.GB22562@zeus.uziel.local>
References: <20060716161631.GA29437@httrack.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/Uq4LBwYP4y1W6pO"
Content-Disposition: inline
In-Reply-To: <20060716161631.GA29437@httrack.com>
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--/Uq4LBwYP4y1W6pO
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 16, 2006 at 06:16:31PM +0200, Xavier Roche wrote:
> > It simply the best filesystem for many kinds of usage patterns.
>=20
> The most frightening too. Reiserfs might be suitable for very specific
> appliactions, but to use it in production machine, you need to have
> some guts.
>=20
> My last reiserfs partition was blown up two days ago, because of a bad
> sector, plus a fatal oops, looping endlessly. This was the second
> time, and the last one, as none of my ext3 filesystems *ever* had
> similar problems, despite numerous other bad sector issues. Not
> mentionning the funny "recovery" tool, which generally finishes to
> trash your data.

I don't quite understand. You are supposed to dd_rescue the whole block
device to a working drive and use fsck on the copy.  Whatever is lost in
the process must of course be restored from a recent backup. But, as a
friend of mine put it recently, people don't need backup, they only need
restore ; )

fsck on a faulty drive might cause even more damage - how do you know
that other areas of the device are OK?=20

I also oppose the ReiserFS-v3.x design philosophy regarding faulty
storage layer, but in any case where your _live_ data is valuable and
uptime counts, you _really_should_ use a RAID of some sort.

Kind regards,
uziel

PS: Your mail was line-wrapped really bad, you might want to look into
that.

--/Uq4LBwYP4y1W6pO
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)

iQIVAwUBRLppL6nY3eLOiwZcAQpEzRAAkFDS+APKJw6oEOgRxGE+x1fz19lNCpYq
0ueMttzXp2Z99V1LjJWuzP08k+MLOoHpYHhEQtKoXD/RbanRSHJa+/MYIJGRbPdj
Us7gKCxYDvZsNtjD/YXx/cT/R9wuFKO6l8/6T09kPvHm3jNB0Y2ZCE+Njxgh+wtA
scXdO+kPPCxJCErG73OL3UMycQP8Igus+ZpHO411i+0gHuZ3YHISJdg2m4FWk25F
+lbENUI29NZr98YgiRaMM1D5OrnLFIyjNzyHaXi241LkkXqVvI+t4GSk893y7HwD
zUbDhNLCeNbyH8/IhqrZgfQme4ny8oYAx0pptLqydOfT5M0i3ap1SAUTA/yHyr0E
3GS2td0iDYQSljLOzcZP7ii4OzpwrYRx8km1Gl16jl5RC2AzUNoYCKfb0DjUrhld
jbmxpbf3hC+jhBjSAlVF1XQkRmz53ea/bIhsLVeyimQluHlXmhRiupB5b3m1nJzp
KXqWGj/paMiqKxXVqAjsWiaPTGWqZHjOVBGu84adao0+i/gT+vaC5KY0L2r4EmOh
RRq1nZJgVN8wVU5WtRnz/OvN6m76Ub6HY7oC/uERBYU29Z8Aqhhmdl6cGeUH/yux
baNGTaWzhxSpwIVEEj5zgOrgYLcMMAKn+DfAA+xDuI0ta0vQ3V/eSeR8vbKmsQIo
AapPGeM1MN8=
=X7Q/
-----END PGP SIGNATURE-----

--/Uq4LBwYP4y1W6pO--

