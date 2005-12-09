Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751275AbVLIEQy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751275AbVLIEQy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 23:16:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751276AbVLIEQy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 23:16:54 -0500
Received: from ganesha.gnumonks.org ([213.95.27.120]:20456 "EHLO
	ganesha.gnumonks.org") by vger.kernel.org with ESMTP
	id S1751275AbVLIEQv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 23:16:51 -0500
Date: Fri, 9 Dec 2005 10:35:32 +0530
From: Harald Welte <laforge@netfilter.org>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Rusty Russell <rusty@rustcorp.com.au>,
       Netfilter Core Team <coreteam@netfilter.org>,
       Patrick McHardy <kaber@trash.net>
Subject: Re: [netfilter-core] [PATCH] Decrease number of pointer derefs in nf_conntrack_core.c
Message-ID: <20051209050532.GG4244@rama.exocore.com>
References: <200512082336.19695.jesper.juhl@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qoTlaiD+Y2fIM3Ll"
Content-Disposition: inline
In-Reply-To: <200512082336.19695.jesper.juhl@gmail.com>
User-Agent: mutt-ng devel-20050619 (Debian)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--qoTlaiD+Y2fIM3Ll
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 08, 2005 at 11:36:19PM +0100, Jesper Juhl wrote:
> Here's a small patch to decrease the number of pointer derefs in
> net/netfilter/nf_conntrack_core.c

thanks, looks fine.

Patrick: please merge into your queue, too.

--=20
- Harald Welte <laforge@netfilter.org>                 http://netfilter.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
  "Fragmentation is like classful addressing -- an interesting early
   architectural error that shows how much experimentation was going
   on while IP was being designed."                    -- Paul Vixie

--qoTlaiD+Y2fIM3Ll
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDmRCcXaXGVTD0i/8RAv4mAKCvllttvcZQ37RDkEeFftA8L1hWkACgmFoC
J50FT6Oj39KSnQhIUgUaVkg=
=IfOv
-----END PGP SIGNATURE-----

--qoTlaiD+Y2fIM3Ll--
