Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264731AbUFGNMH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264731AbUFGNMH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 09:12:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264625AbUFGNLM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 09:11:12 -0400
Received: from mx1.redhat.com ([66.187.233.31]:6124 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264505AbUFGMU7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 08:20:59 -0400
Date: Mon, 7 Jun 2004 14:20:47 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: Russell Leighton <russ@elegant-software.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Using getpid() often, another way? [was Re: clone() <->	getpid() bug in 2.6?]
Message-ID: <20040607122046.GC9835@devserv.devel.redhat.com>
References: <40C1E6A9.3010307@elegant-software.com> <Pine.LNX.4.58.0406051341340.7010@ppc970.osdl.org> <40C32A44.6050101@elegant-software.com> <40C33A84.4060405@elegant-software.com> <1086537490.3041.2.camel@laptop.fenrus.com> <40C3B22D.8080308@elegant-software.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="raC6veAxrt5nqIoY"
Content-Disposition: inline
In-Reply-To: <40C3B22D.8080308@elegant-software.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--raC6veAxrt5nqIoY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jun 06, 2004 at 08:09:17PM -0400, Russell Leighton wrote:
> >a library using clone sounds suspect to me, I can't imagine an app using
> >pthreads being able to just use your library as a result.
> >
> Why? In  what way would a program that uses pthreads interfere with 
> threads created using clone()?

you do all kinds of tricks behind the threading library's back, and share
some stuff while not others. I'd be suprised of that would NOT break.

--raC6veAxrt5nqIoY
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFAxF2exULwo51rQBIRAvWLAJ0Zq7Exvk5s0Ge2ZnUeTLXQdEMcJQCfcLyI
VxeApejxyG3WfR+RVeUgY14=
=2rp+
-----END PGP SIGNATURE-----

--raC6veAxrt5nqIoY--
