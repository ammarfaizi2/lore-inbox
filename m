Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267353AbUIARYQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267353AbUIARYQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 13:24:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267364AbUIAPyy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 11:54:54 -0400
Received: from null.rsn.bth.se ([194.47.142.3]:25050 "EHLO null.rsn.bth.se")
	by vger.kernel.org with ESMTP id S267165AbUIAPw4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 11:52:56 -0400
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-Q5
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Ingo Molnar <mingo@elte.hu>, Daniel Schmitt <pnambic@unu.nu>,
       "K.R. Foley" <kr@cybsft.com>,
       Felipe Alfaro Solana <lkml@felipe-alfaro.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Mark_H_Johnson@raytheon.com, tytso@mit.edu
In-Reply-To: <1093993396.3404.17.camel@krustophenia.net>
References: <200408282210.03568.pnambic@unu.nu>
	 <20040828203116.GA29686@elte.hu>
	 <1093727453.8611.71.camel@krustophenia.net>
	 <20040828211334.GA32009@elte.hu> <1093727817.860.1.camel@krustophenia.net>
	 <1093737080.1385.2.camel@krustophenia.net>
	 <1093746912.1312.4.camel@krustophenia.net> <20040829054339.GA16673@elte.hu>
	 <20040830090608.GA25443@elte.hu> <1093934448.5403.4.camel@krustophenia.net>
	 <20040831065327.GA30631@elte.hu>
	 <1093993396.3404.17.camel@krustophenia.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Oj0eDTBfwF48FL9nMAsn"
Message-Id: <1094053973.2282.2.camel@tux.rsn.bth.se>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 01 Sep 2004 17:52:53 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Oj0eDTBfwF48FL9nMAsn
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2004-09-01 at 01:03, Lee Revell wrote:

Hi Lee

> This solves the problem with the random driver.  The worst latencies I
> am seeing are in netif_receive_skb().  With netdev_max_backlog set to 8,
> the worst is about 160 usecs:

I'm a bit curious... have you tried these tests with ip_conntrack
enabled?

--=20
/Martin

--=-Oj0eDTBfwF48FL9nMAsn
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBNfBVWm2vlfa207ERAqJkAKCcf2x+cRcK5eaZgpK8tWdqmkGi1gCgtdNU
GDLeKPsDkbLGJZLTGoNg1T0=
=FLhO
-----END PGP SIGNATURE-----

--=-Oj0eDTBfwF48FL9nMAsn--
