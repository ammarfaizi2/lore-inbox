Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1760294AbWLFIOw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760294AbWLFIOw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 03:14:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760291AbWLFIOw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 03:14:52 -0500
Received: from mtaout01-winn.ispmail.ntl.com ([81.103.221.47]:43358 "EHLO
	mtaout01-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760295AbWLFIOv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 03:14:51 -0500
From: Ian Campbell <ijc@hellion.org.uk>
To: john stultz <johnstul@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>
In-Reply-To: <1165347242.8326.15.camel@localhost>
References: <1165153834.5499.40.camel@localhost.localdomain>
	 <1165259962.6152.5.camel@localhost.localdomain>
	 <1165261226.5499.54.camel@localhost.localdomain>
	 <1165263296.6152.8.camel@localhost.localdomain>
	 <1165304498.5499.62.camel@localhost.localdomain>
	 <1165347242.8326.15.camel@localhost>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-u8Vbp+ROwdPJQeIuA+1d"
Date: Wed, 06 Dec 2006 08:14:23 +0000
Message-Id: <1165392864.5499.68.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
X-SA-Exim-Connect-IP: 192.168.1.5
X-SA-Exim-Mail-From: ijc@hellion.org.uk
Subject: Re: PMTMR running too fast
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on hopkins.hellion.org.uk)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-u8Vbp+ROwdPJQeIuA+1d
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2006-12-05 at 11:34 -0800, john stultz wrote:
> On Tue, 2006-12-05 at 07:41 +0000, Ian Campbell wrote:
> > Should tsc be preferred to pit though?
>=20
> Depends on your system. If C2/C3 or cpufreq state changes are detected,
> we mark the tsc as unstable.=20

I'm not using them on purpose but I'll check it out.

> It sounds as if from your earlier email the TSC works fine, so we might
> want to look at what's making the system think its not ok. I probably
> need to add a message as to why it was disqualified. However, that's a
> separate issue from the last patch.

I'll have a play, see if I can figure it out.

> Thanks for the testing!

Thanks for the fix!

Ian.

--=20
Ian Campbell

* Turken thinks little kids are absolutely adorable... especialyy when
  they're someone elses.

--=-u8Vbp+ROwdPJQeIuA+1d
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFdnvfM0+0qS9rzVkRAuaIAJ9T2bG/DfggXBQwybwK+F+FVWpMVwCgnZ+V
eMjjCEpLdTFKYkFtagdIdSw=
=wIIG
-----END PGP SIGNATURE-----

--=-u8Vbp+ROwdPJQeIuA+1d--

