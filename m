Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751936AbWCNSzg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751936AbWCNSzg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 13:55:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750937AbWCNSzg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 13:55:36 -0500
Received: from A.painless.aaisp.net.uk ([81.187.81.51]:28565 "EHLO
	smtp.aaisp.net.uk") by vger.kernel.org with ESMTP id S1751936AbWCNSzf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 13:55:35 -0500
Subject: Re: 2.6.16-rc6-git[12] spontaneous reboots on x86_64
From: Andrew Clayton <andrew@rootshell.co.uk>
To: Hugh Dickins <hugh@veritas.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0603141843110.6114@goblin.wat.veritas.com>
References: <1142337319.4412.2.camel@zeus.pccl.info>
	 <Pine.LNX.4.61.0603141523340.4309@goblin.wat.veritas.com>
	 <Pine.LNX.4.64.0603140805380.3618@g5.osdl.org>
	 <1142353443.30466.2.camel@zeus.pccl.info>
	 <Pine.LNX.4.61.0603141843110.6114@goblin.wat.veritas.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-YFnaPF6qorX7uonNgJEz"
Date: Tue, 14 Mar 2006 18:55:06 +0000
Message-Id: <1142362506.2513.21.camel@alpha.digital-domain.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-YFnaPF6qorX7uonNgJEz
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2006-03-14 at 18:50 +0000, Hugh Dickins wrote:
> On Tue, 14 Mar 2006, Andrew Clayton wrote:
> > On Tue, 2006-03-14 at 08:06 -0800, Linus Torvalds wrote:
> > >=20
> > > Reverted. Let's get wider testing before applying an alternate fix.
> >=20
> > Just to note: Doing what Andi suggested seems to be working OK.
>=20
> Whereas on EM64T I found the opposite,
> reverting just the stub_execve hunk still behaved badly.
>=20
> I've double-checked that finding since, built and ran another
> kernel to confirm it.  But your Athlon64 still works OK that way?

Yeah, reverting just the stub_execve hunk and 3 hours later everything
still looks good.

> Just trying to clarify - I don't think we're in any rush to
> settle it now that Linus has reverted the damage from his tree.

Sure.

> Hugh

Andrew


--=-YFnaPF6qorX7uonNgJEz
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.1 (GNU/Linux)

iD8DBQBEFxGK66HmHTysXMwRAlioAJ0TnsMhtjNkXXW8d903r6lMc9JrgwCeLqLX
Li7CBjISVxn1hhx+wrSayNM=
=Liqo
-----END PGP SIGNATURE-----

--=-YFnaPF6qorX7uonNgJEz--

