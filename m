Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262228AbUCGQuW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Mar 2004 11:50:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262229AbUCGQuW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Mar 2004 11:50:22 -0500
Received: from mx1.redhat.com ([66.187.233.31]:62955 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262228AbUCGQuQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Mar 2004 11:50:16 -0500
Date: Sun, 7 Mar 2004 17:49:53 +0100
From: Arjan van de Ven <arjanv@redhat.com>
To: Andreas Gruenbacher <agruen@suse.de>
Cc: Sam Ravnborg <sam@ravnborg.org>, lkml <linux-kernel@vger.kernel.org>,
       "kbuild-devel@lists.sourceforge.net" 
	<kbuild-devel@lists.sourceforge.net>
Subject: Re: External kernel modules, second try
Message-ID: <20040307164953.GB14967@devserv.devel.redhat.com>
References: <1078620297.3156.139.camel@nb.suse.de> <20040307125348.GA2020@mars.ravnborg.org> <1078664629.9812.1.camel@laptop.fenrus.com> <1078667199.3594.50.camel@nb.suse.de> <1078668091.9106.1.camel@laptop.fenrus.com> <20040307160527.GA2027@mars.ravnborg.org> <20040307160824.GA14967@devserv.devel.redhat.com> <1078677922.3615.47.camel@e136.suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hHWLQfXTYDoKhP50"
Content-Disposition: inline
In-Reply-To: <1078677922.3615.47.camel@e136.suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--hHWLQfXTYDoKhP50
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Mar 07, 2004 at 05:45:22PM +0100, Andreas Gruenbacher wrote:
> > From a distribution kernel pov; I already ship a subset of files for building
> > modules against (basically include/, the KConfig and makefiles), which only
> > not 100% works because I don't ship vmlinux.
> 
> We have tried that with our latest round of kernels (still 2.4), and the
> results have been mixed. You need various headers outside include/ for

2.6 has the biggest offender (scsi) fixed.

> some obscure external modules. Amazingly there are even external modules
> that make use of kernel C files.

I can't imagine that being the case anymore, and for sure it won't be binary
only ones ;)


> ), the default being the running kernel. The Red Hat kernel has had a
> partial solution for merging autoconf.h.

It's a gross hack that we thankfully got rid of finally!

--hHWLQfXTYDoKhP50
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFAS1KwxULwo51rQBIRAr3GAJ9VPtT/WX4pP6BHGZKENbViEtdphQCdGKMf
N9lwzonNbjzi9zDjyISumPM=
=KEWa
-----END PGP SIGNATURE-----

--hHWLQfXTYDoKhP50--
