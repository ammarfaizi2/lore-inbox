Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262348AbUKKSfN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262348AbUKKSfN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 13:35:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262300AbUKKSdO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 13:33:14 -0500
Received: from websrv2.werbeagentur-aufwind.de ([213.239.197.240]:2226 "EHLO
	websrv2.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S262337AbUKKScN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 13:32:13 -0500
Subject: Re: Fixing UML against NPTL (was: Re: [uml-devel] [PATCH] UML: Use
	PTRACE_KILL instead of SIGKILL to kill host-OS processes (take #2))
From: Christophe Saout <christophe@saout.de>
To: Daniel Jacobowitz <dan@debian.org>
Cc: Blaisorblade <blaisorblade_spam@yahoo.it>, Chris Wedgwood <cw@f00f.org>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20041111174512.GA27809@nevyn.them.org>
References: <20041103113736.GA23041@taniwha.stupidest.org>
	 <200411040113.27747.blaisorblade_spam@yahoo.it>
	 <20041104003943.GB17467@taniwha.stupidest.org>
	 <200411040531.29596.blaisorblade_spam@yahoo.it>
	 <20041111174512.GA27809@nevyn.them.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Xldj7f/JOMnHC4Xg9cYe"
Date: Thu, 11 Nov 2004 19:31:51 +0100
Message-Id: <1100197911.11951.1.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Xldj7f/JOMnHC4Xg9cYe
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Am Donnerstag, den 11.11.2004, 12:45 -0500 schrieb Daniel Jacobowitz:

> Glibc caches the PID.  If you're going to use clone directly, use the
> gettid/getpid syscall directly.  It's kind of rude that glibc breaks
> getpid in this way; I recommend filing a bug in the glibc bugzilla at
> sources.redhat.com.

If glibc insists on caching the pid, it could also simply invalidate the
pid cache in the clone function.


--=-Xldj7f/JOMnHC4Xg9cYe
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBk7AXZCYBcts5dM0RAn3jAJ9m05Eo2vI6kZw5Xy7w2o+p2C5qYwCggoWS
a9/CfvvGELD3vzMCQxC2PEI=
=VxMr
-----END PGP SIGNATURE-----

--=-Xldj7f/JOMnHC4Xg9cYe--

