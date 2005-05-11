Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261855AbVEKALp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261855AbVEKALp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 20:11:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261853AbVEKALo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 20:11:44 -0400
Received: from attila.bofh.it ([213.92.8.2]:33994 "EHLO attila.bofh.it")
	by vger.kernel.org with ESMTP id S261866AbVEKALI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 20:11:08 -0400
Date: Wed, 11 May 2005 02:10:56 +0200
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Greg KH <gregkh@suse.de>, "Alexander E. Patrakov" <patrakov@ums.usu.ru>,
       linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] hotplug-ng 002 release
Message-ID: <20050511001056.GB17762@wonderland.linux.it>
Mail-Followup-To: Rusty Russell <rusty@rustcorp.com.au>,
	Greg KH <gregkh@suse.de>,
	"Alexander E. Patrakov" <patrakov@ums.usu.ru>,
	linux-hotplug-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
References: <20050506212227.GA24066@kroah.com> <1115611034.14447.11.camel@localhost.localdomain> <20050509232103.GA24238@suse.de> <1115717357.10222.1.camel@localhost.localdomain> <20050510094339.GC6346@wonderland.linux.it> <4280AFF4.6080108@ums.usu.ru> <20050510172447.GA11263@wonderland.linux.it> <20050510201355.GB3226@suse.de> <1115769676.17201.14.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9zSXsLTf0vkW971A"
Content-Disposition: inline
In-Reply-To: <1115769676.17201.14.camel@localhost.localdomain>
User-Agent: Mutt/1.5.9i
From: md@Linux.IT (Marco d'Itri)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--9zSXsLTf0vkW971A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On May 11, Rusty Russell <rusty@rustcorp.com.au> wrote:

> The other possible solution is for /etc/hotplug.d/blacklist to contain
> "install xxx /bin/false // install yyy /bin/true //
> include /etc/modprobe.d" and have hotplug invoke modprobe with
> --config=3D/etc/hotplug.d/blacklist.  Substitute names to fit.
I understand that this modprobe would look for an alias or install
directive for $MODALIAS, while it's the actual module name which users
need to blacklist (but I know a few situations in which it would be
useful to be able to match $MODALIAS on the blacklist too...).

--=20
ciao,
Marco

--9zSXsLTf0vkW971A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCgU2QFGfw2OHuP7ERAvJuAJ483qe84LJQCB5MiC1sjPvdi9mPpwCfQzl2
k6iR2L2ZkJnVrQ8qawh1VBo=
=hW/y
-----END PGP SIGNATURE-----

--9zSXsLTf0vkW971A--
