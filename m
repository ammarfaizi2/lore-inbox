Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261599AbVEJJ7Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261599AbVEJJ7Z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 05:59:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261600AbVEJJ7Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 05:59:24 -0400
Received: from attila.bofh.it ([213.92.8.2]:12484 "EHLO attila.bofh.it")
	by vger.kernel.org with ESMTP id S261599AbVEJJ7U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 05:59:20 -0400
Date: Tue, 10 May 2005 11:43:39 +0200
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Greg KH <gregkh@suse.de>, linux-hotplug-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] hotplug-ng 002 release
Message-ID: <20050510094339.GC6346@wonderland.linux.it>
Mail-Followup-To: Rusty Russell <rusty@rustcorp.com.au>,
	Greg KH <gregkh@suse.de>, linux-hotplug-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
References: <20050506212227.GA24066@kroah.com> <1115611034.14447.11.camel@localhost.localdomain> <20050509232103.GA24238@suse.de> <1115717357.10222.1.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AhhlLboLdkugWU4S"
Content-Disposition: inline
In-Reply-To: <1115717357.10222.1.camel@localhost.localdomain>
User-Agent: Mutt/1.5.9i
From: md@Linux.IT (Marco d'Itri)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On May 10, Rusty Russell <rusty@rustcorp.com.au> wrote:

> So I rewrote it yesterday, so now it passes the testsuite.  I also added
> a test.  It's in 3.2-pre4: if there are no more requests/bugs in the
> next couple of days, I'll make that 3.3.
My major request is support for /etc/hotplug/blacklist.d/ in modprobe:
now that the hotplug subsystem does not know anymore the name of the
module to be loaded, it's up to modprobe to check the system blacklist.
IME, without this feature users will not accept hotplug-ng.

--=20
ciao,
Marco

--AhhlLboLdkugWU4S
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCgIJLFGfw2OHuP7ERAgxEAJ9Da1wXIicQ3bnJvOluIxS0LycH5gCfReRm
1kvbi5Es4IbEnKBtM1aXgsI=
=z3W0
-----END PGP SIGNATURE-----

--AhhlLboLdkugWU4S--
