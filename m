Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030372AbVKPPt4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030372AbVKPPt4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 10:49:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030375AbVKPPt4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 10:49:56 -0500
Received: from sipsolutions.net ([66.160.135.76]:63749 "EHLO sipsolutions.net")
	by vger.kernel.org with ESMTP id S1030372AbVKPPt4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 10:49:56 -0500
Subject: Re: PowerBook5,8 - TrackPad update
From: Johannes Berg <johannes@sipsolutions.net>
To: Parag Warudkar <kernel-stuff@comcast.net>
Cc: debian-powerpc@lists.debian.org, linux-kernel@vger.kernel.org
In-Reply-To: <111620051543.21656.437B53B5000EABF300005498220074818400009A9B9CD3040A029D0A05@comcast.net>
References: <111620051543.21656.437B53B5000EABF300005498220074818400009A9B9CD3040A029D0A05@comcast.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-yI5KUXon7gERJkAz2etP"
Date: Wed, 16 Nov 2005 16:49:44 +0100
Message-Id: <1132156185.4843.3.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-yI5KUXon7gERJkAz2etP
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2005-11-16 at 15:43 +0000, Parag Warudkar wrote:
> Ah and yes I forgot about the dual finger scrolling function - newer
> trackpads allow you to use 2 fingers to slide up and down to achieve
> scrolling. I don't see any code in current appletouch.c which handles
> this. We might be able to live without it for some time but maybe we
> can't as it might screw up the reporting if not handled. (PPC assembly
> is fun to work with :)

That's a pure driver function, and we didn't implement it because we
emulate synaptics. I think your erratically moving thing might be caused
by a relayout of the order, maybe you should try to observe the
interrupt transfers the device gives you in a systematic way like I did
with my python scripts? Those display the levels of each byte. Maybe
they changed to transmitting not bytes but words for each level?

johannes

--=-yI5KUXon7gERJkAz2etP
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (SIP Solutions)

iD8DBQBDe1UY/ETPhpq3jKURAlOTAKCP1M1eRU6BniR/knv9qH5xNj9wsQCgoize
WNP0oX6q7dO6jthZ0+XMlkw=
=AOIf
-----END PGP SIGNATURE-----

--=-yI5KUXon7gERJkAz2etP--

