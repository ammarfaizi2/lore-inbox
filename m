Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262315AbTJXPxx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Oct 2003 11:53:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262323AbTJXPxx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Oct 2003 11:53:53 -0400
Received: from smtp2.actcom.co.il ([192.114.47.15]:32405 "EHLO
	smtp2.actcom.co.il") by vger.kernel.org with ESMTP id S262315AbTJXPxw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Oct 2003 11:53:52 -0400
Date: Fri, 24 Oct 2003 17:53:44 +0200
From: Muli Ben-Yehuda <mulix@mulix.org>
To: Pavel Roskin <proski@gnu.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Copying .config to /lib/modules/`uname -r`/kernel
Message-ID: <20031024155343.GP5017@actcom.co.il>
References: <Pine.LNX.4.58.0310240406230.17536@portland.hansa.lan>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nzRVTedY3Q7hsbEF"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0310240406230.17536@portland.hansa.lan>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--nzRVTedY3Q7hsbEF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2003 at 04:26:12AM -0400, Pavel Roskin wrote:

> Cannot we just install .config to the same directory as modules?  If

What's wrong with /lib/modules/version/build/.config?=20

> kernel doesn't support modules, then there is no point to compile any new
> modules against it.  But if it does, then we can be sure that the modules
> correspond to that configuration file, because the modules and .config
> would be installed by the same command.

you need the build symlink to compile a module against this kernel
anyway, because you need its includes, not to mention its build
system.=20

Cheers,=20
Muli=20
--=20
Muli Ben-Yehuda
http://www.mulix.org | http://www.livejournal.com/~mulix

"the nucleus of linux oscillates my world" - gccbot@#offtopic


--nzRVTedY3Q7hsbEF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/mUsHKRs727/VN8sRAgwOAJ9ZNNUwA52choXT6yzGrSNM2g1n9wCfT4UM
TM2dBS4sera9zwPnNjxzBg8=
=5cY2
-----END PGP SIGNATURE-----

--nzRVTedY3Q7hsbEF--
