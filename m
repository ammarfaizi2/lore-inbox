Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751268AbVLIEIn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751268AbVLIEIn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 23:08:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751272AbVLIEIn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 23:08:43 -0500
Received: from ganesha.gnumonks.org ([213.95.27.120]:12682 "EHLO
	ganesha.gnumonks.org") by vger.kernel.org with ESMTP
	id S1751268AbVLIEIm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 23:08:42 -0500
Date: Fri, 9 Dec 2005 10:34:50 +0530
From: Harald Welte <laforge@netfilter.org>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Netfilter Core Team <coreteam@netfilter.org>,
       James Morris <jmorris@intercode.com.au>, Andrew Morton <akpm@osdl.org>,
       Patrick McHardy <kaber@trash.net>
Subject: Re: [PATCH] Decrease number of pointer derefs in nfnetlink_queue.c
Message-ID: <20051209050450.GF4244@rama.exocore.com>
References: <200512082336.01678.jesper.juhl@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qftxBdZWiueWNAVY"
Content-Disposition: inline
In-Reply-To: <200512082336.01678.jesper.juhl@gmail.com>
User-Agent: mutt-ng devel-20050619 (Debian)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--qftxBdZWiueWNAVY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 08, 2005 at 11:36:01PM +0100, Jesper Juhl wrote:
=20
> Here's a small patch to decrease the number of pointer derefs in
> net/netfilter/nfnetlink_queue.c

Thanks, the patch looks fine to me. =20

Also, if you feel like it, I would recommend doing a similar patch for
nfnetlink_log (which has a similar architecture to nfnetlink_queue).

Patrick: Please merge into your queue of pending patches, unless you
have any objections. Thanks!

--=20
- Harald Welte <laforge@netfilter.org>                 http://netfilter.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
  "Fragmentation is like classful addressing -- an interesting early
   architectural error that shows how much experimentation was going
   on while IP was being designed."                    -- Paul Vixie

--qftxBdZWiueWNAVY
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDmRByXaXGVTD0i/8RAjswAJ91ZhwU6D72Rr4qN6xJfyVaG6ilBQCbBz6F
1VmpeE9Ssm1gXw8fR5IQ1Tg=
=UTcS
-----END PGP SIGNATURE-----

--qftxBdZWiueWNAVY--
