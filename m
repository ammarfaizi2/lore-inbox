Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275243AbTHGItr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 04:49:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275244AbTHGItr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 04:49:47 -0400
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:38382 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S275243AbTHGItq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 04:49:46 -0400
Subject: Re: NPTL v userland v LT (RH9+custom kernel problem)
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Frank Cusack <fcusack@fcusack.com>
Cc: lkml <linux-kernel@vger.kernel.org>, phil-list@redhat.com
In-Reply-To: <20030807013930.A26426@google.com>
References: <20030807013930.A26426@google.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Uqe1jszCoANiazoLt/dT"
Organization: Red Hat, Inc.
Message-Id: <1060246177.5142.1.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-2) 
Date: Thu, 07 Aug 2003 10:49:37 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Uqe1jszCoANiazoLt/dT
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> So, finally getting to my question, should I even *expect* a non-NPTL
> kernel to work with the RH9 userland? =20

Yes, absolutely. It's a design goal of RHL to work with unpatched
kernel.org kernels.

>
> If not, is there a simple fix
> without going to NPTL, say just rebuilding glibc?  hmm... now that I
> ask it I feel dumb, I do think I would need to rebuild glibc so it
> knows the kernel has LinuxThreads, not NPTL.=20

no need. RHL9 ships with BOTH LinuxThreads and NPTL and will switch
dynamically at runtime depending on your kernel capabilities.

--=-Uqe1jszCoANiazoLt/dT
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/MhKhxULwo51rQBIRAgjPAJwPmxbb6VAkrlmv+fsqCwODu1N7lwCeL822
laIt31On2BtumZnKCSMWBv4=
=wkMv
-----END PGP SIGNATURE-----

--=-Uqe1jszCoANiazoLt/dT--
