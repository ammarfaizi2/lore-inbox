Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751407AbWFGAcz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751407AbWFGAcz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 20:32:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751408AbWFGAcz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 20:32:55 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:20147 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S1751407AbWFGAcz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 20:32:55 -0400
From: Nigel Cunningham <ncunningham@linuxmail.org>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [2.6.17-rc5-mm2] crash when doing second suspend: BUG in arch/i386/kernel/nmi.c:174
Date: Wed, 7 Jun 2006 10:33:59 +1000
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, Don Zickus <dzickus@redhat.com>, ak@suse.de,
       shaohua.li@intel.com, miles.lane@gmail.com,
       linux-kernel@vger.kernel.org
References: <4480C102.3060400@goop.org> <200606071013.53490.ncunningham@linuxmail.org> <44861D37.7050301@goop.org>
In-Reply-To: <44861D37.7050301@goop.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart6085365.MzHjHWlE2r";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200606071034.03228.ncunningham@linuxmail.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart6085365.MzHjHWlE2r
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Wednesday 07 June 2006 10:26, Jeremy Fitzhardinge wrote:
> Nigel Cunningham wrote:
> > It's probably safter to say "In the suspend/resume case, they may well
> > be." It's not inconceivable that a system could be suspended, a faulty
> > cpu replaced with another, and the system resumed. Hotplugging ought to
> > handle that nicely.
>
> I think, in general, changing the hardware configuration of the system
> while its suspend is not supported.  But perhaps someone who actually
> knows about this PM stuff has a more authoritative view...

In general, you're right because we don't have perfect hardware hotplugging=
=20
yet. But cpu hotplugging is one area we do have, so it should work. (I ough=
t=20
to be one of those people, because I'm the author of the Suspend2=20
patches :) ... not that I'm claiming complete knowledge of all things relat=
ed=20
to suspending! )

Regards,

Nigel
=2D-=20
Nigel, Michelle and Alisdair Cunningham
5 Mitchell Street
Cobden 3266
Victoria, Australia

--nextPart6085365.MzHjHWlE2r
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEhh77N0y+n1M3mo0RAg/SAJ9namNJDDp64t4v4KnewJ5Tksd9FACgrEzv
P8ymHFuM1DX2G87fjK1bLAA=
=PEgO
-----END PGP SIGNATURE-----

--nextPart6085365.MzHjHWlE2r--
