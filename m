Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265275AbUENNkl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265275AbUENNkl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 09:40:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265281AbUENNkl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 09:40:41 -0400
Received: from irulan.endorphin.org ([212.13.208.107]:48388 "EHLO
	irulan.endorphin.org") by vger.kernel.org with ESMTP
	id S265275AbUENNkj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 09:40:39 -0400
Date: Fri, 14 May 2004 15:40:26 +0200
To: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       Christophe Saout <christophe@saout.de>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       James Morris <jmorris@redhat.com>
Subject: Re: [PATCH] AES i586 optimized, regparm fixed
Message-ID: <20040514134026.GA8435@ghanima.endorphin.org>
References: <20040514130724.GA8081@ghanima.endorphin.org>
	<20040514141923.A24264@infradead.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+HP7ph2BbKc20aGI"
Content-Disposition: inline
In-Reply-To: <20040514141923.A24264@infradead.org>
User-Agent: Mutt/1.5.6i
From: Fruhwirth Clemens <clemens-dated-1085406027.0ed2@endorphin.org>
X-Delivery-Agent: TMDA/0.92 (Kauai King)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 14, 2004 at 02:19:23PM +0100, Christoph Hellwig wrote:

> We usually use asmlinkage instead of __attribute__((regparm(0))).  while
> it's not nessecary for x86-specific code to abstract this out it at least
> looks cleaner.=20

I will change that.

> BTW, is the assembly code shared with some other project?
> If not it might be a good idea to kill the ifdefs in there.

The only project I'm aware of is loop-aes. aes-i586-asm.S is different wrt
to the parameter positions anyway (cryptoapi source/dest switched). The code
is not subject to regular modifications so, we might kill the #if directives
if we like.

Regards, Clemens

--+HP7ph2BbKc20aGI
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFApMxKW7sr9DEJLk4RAiCGAJ9ZL7LIrRRZRab/OCq3QrPQ3HSP9ACfRZVj
Z8ksQRfxK/yR3cteKzwLoTM=
=DWlt
-----END PGP SIGNATURE-----

--+HP7ph2BbKc20aGI--
