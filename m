Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263336AbUCTK0s (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 05:26:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263339AbUCTK0H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 05:26:07 -0500
Received: from mx1.redhat.com ([66.187.233.31]:50313 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263336AbUCTKYG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 05:24:06 -0500
Date: Sat, 20 Mar 2004 11:22:41 +0100
From: Arjan van de Ven <arjanv@redhat.com>
To: Peter Williams <peterw@aurema.com>
Cc: Micha Feigin <michf@post.tau.ac.il>, John Reiser <jreiser@BitWagon.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: finding out the value of HZ from userspace
Message-ID: <20040320102241.GK2803@devserv.devel.redhat.com>
References: <20040311141703.GE3053@luna.mooo.com> <1079198671.4446.3.camel@laptop.fenrus.com> <4053624D.6080806@BitWagon.com> <20040313193852.GC12292@devserv.devel.redhat.com> <40564A22.5000504@aurema.com> <20040316063331.GB23988@devserv.devel.redhat.com> <40578FDB.9060000@aurema.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dxRQSzdsN/lOP445"
Content-Disposition: inline
In-Reply-To: <40578FDB.9060000@aurema.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--dxRQSzdsN/lOP445
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


On Wed, Mar 17, 2004 at 10:38:03AM +1100, Peter Williams wrote:
> >there is one. Nothing uses it
> >(sysconf() provides this info)
> 
> Seems to me that it would be fairly trivial to modify those programs 
> (that should use this mechanism but don't) to use it?  So why should 
> they be allowed to dictate kernel behaviour?

quality of implementation; for example shell scripts that want to do
echo 500 > /proc/sys/foo/bar/something_in_HZ
...
or /etc/sysctl.conf or ...


--dxRQSzdsN/lOP445
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFAXBtwxULwo51rQBIRAhstAKCpWVGajadToIP8LeUEfwix1ArN5gCeI3h8
a7Y/6WfrgblxT0qdhHe7uII=
=Y/Ag
-----END PGP SIGNATURE-----

--dxRQSzdsN/lOP445--
