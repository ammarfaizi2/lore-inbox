Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932473AbWCNVbL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932473AbWCNVbL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 16:31:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932477AbWCNVbL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 16:31:11 -0500
Received: from A.painless.aaisp.net.uk ([81.187.81.51]:4276 "EHLO
	smtp.aaisp.net.uk") by vger.kernel.org with ESMTP id S932473AbWCNVbJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 16:31:09 -0500
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
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-6/xNxt5p/oiQpLZ42xOb"
Date: Tue, 14 Mar 2006 21:30:36 +0000
Message-Id: <1142371836.2513.24.camel@alpha.digital-domain.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-6/xNxt5p/oiQpLZ42xOb
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

OK, looks like I may have spoke too soon, just found my ssh session to
it dead and the machine no longer reachable (other machines on the same
network are). I'll be able to see for sure when I get into work in the
morning.


Andrew


--=-6/xNxt5p/oiQpLZ42xOb
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.1 (GNU/Linux)

iD8DBQBEFzX866HmHTysXMwRAnAwAJ9DSxYnN4y4Eb9Iqs/hY2OEV1Ds7QCfXyJq
Ourh35ZCa4TIXWdGbZSrGcc=
=+6sN
-----END PGP SIGNATURE-----

--=-6/xNxt5p/oiQpLZ42xOb--

