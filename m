Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261908AbTJDGbD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Oct 2003 02:31:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261914AbTJDGbC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Oct 2003 02:31:02 -0400
Received: from [200.55.45.169] ([200.55.45.169]:25014 "EHLO smtp.bensa.ar")
	by vger.kernel.org with ESMTP id S261908AbTJDGbA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Oct 2003 02:31:00 -0400
From: Norberto Bensa <nbensa@gmx.net>
To: Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.23pre6aa1
Date: Sat, 4 Oct 2003 03:26:36 -0300
User-Agent: KMail/1.5.4
References: <20031002152648.GB1240@velociraptor.random>
In-Reply-To: <20031002152648.GB1240@velociraptor.random>
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_ggmf/AuKG5RXFCj";
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200310040326.40508.nbensa@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_ggmf/AuKG5RXFCj
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Description: signed data
Content-Disposition: inline

Hi Andrea,

Andrea Arcangeli wrote:
> URL:
>
> 	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.2
>3pre6aa1.gz

find kernel -path '*/pcmcia/*' -name '*.o' | xargs -i -r ln -sf ../{} pcmcia
if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.4.23; fi
depmod: *** Unresolved symbols in /lib/modules/2.4.23/kernel/fs/xfs/xfs.o
depmod:         qsort

Regards,
Norberto

--Boundary-02=_ggmf/AuKG5RXFCj
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/fmggFXVF50lmS74RApQEAKCh268jIfnTbAzb/g28D3uqolYtOwCglFEq
l5EgY8oaPZ6sybtwa+1VU2I=
=sBMj
-----END PGP SIGNATURE-----

--Boundary-02=_ggmf/AuKG5RXFCj--

