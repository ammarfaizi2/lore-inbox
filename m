Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264238AbUA3Tzz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 14:55:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264246AbUA3Tzy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 14:55:54 -0500
Received: from mx1.redhat.com ([66.187.233.31]:7646 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264238AbUA3Tzp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 14:55:45 -0500
Date: Fri, 30 Jan 2004 20:55:15 +0100
From: Arjan van de Ven <arjanv@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: thomas.schlichter@web.de, thoffman@arnor.net, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, Tim Hockin <thockin@sun.com>
Subject: Re: 2.6.2-rc2-mm2
Message-ID: <20040130195515.GB2977@devserv.devel.redhat.com>
References: <20040130014108.09c964fd.akpm@osdl.org> <1075489136.5995.30.camel@moria.arnor.net> <200401302007.26333.thomas.schlichter@web.de> <1075490624.4272.7.camel@laptop.fenrus.com> <20040130114701.18aec4e8.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RIYY1s2vRbPFwWeW"
Content-Disposition: inline
In-Reply-To: <20040130114701.18aec4e8.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--RIYY1s2vRbPFwWeW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 30, 2004 at 11:47:01AM -0800, Andrew Morton wrote:
> Arjan van de Ven <arjanv@redhat.com> wrote:
> >
> >=20
> > directly calling sys_ANYTHING sounds really wrong to me...
> >=20
>=20
> It's a philosophical thing.  Is a kernel thread like a user process which
> happens to be running from the kernel or it is a piece of mainline kernel
> code which happens to have its own execution context?  I rather favour the
> latter...
>=20
> In this case it looks like it will just happen to work, because
> nfsd_setuser() is executed by nfsd, and kernel threads are allowed to do
> copy_from_user() with the source in kernel memory.  ick.

I didn't imply illegal, just ick ;)


--RIYY1s2vRbPFwWeW
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFAGrajxULwo51rQBIRAtpXAJ9NQMPknVM1vFv8kClzjBUkHRtzjgCdHCTd
yrRWfjnDDOcDKp7FFX5Y060=
=cbjN
-----END PGP SIGNATURE-----

--RIYY1s2vRbPFwWeW--
