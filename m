Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261595AbTD0NDx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Apr 2003 09:03:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263987AbTD0NDx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Apr 2003 09:03:53 -0400
Received: from coruscant.franken.de ([193.174.159.226]:10386 "EHLO
	coruscant.gnumonks.org") by vger.kernel.org with ESMTP
	id S261595AbTD0NDv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Apr 2003 09:03:51 -0400
Date: Sun, 27 Apr 2003 15:12:06 +0200
From: Harald Welte <laforge@netfilter.org>
To: "David S. Miller" <davem@redhat.com>
Cc: Maciej Soltysiak <solt@dns.toxicfilms.tv>, linux-kernel@vger.kernel.org,
       netfilter-devel@lists.netfilter.org, kisza@sunbeam.gnumonks.org
Subject: Re: [RESEND][PATCH] net/ipv6/netfilter warnings removal
Message-ID: <20030427131206.GL990@sunbeam.de.gnumonks.org>
Mail-Followup-To: Harald Welte <laforge@netfilter.org>,
	"David S. Miller" <davem@redhat.com>,
	Maciej Soltysiak <solt@dns.toxicfilms.tv>,
	linux-kernel@vger.kernel.org, netfilter-devel@lists.netfilter.org,
	kisza
References: <Pine.LNX.4.51.0304051607310.32140@dns.toxicfilms.tv> <Pine.LNX.4.51.0304072115010.19830@dns.toxicfilms.tv> <Pine.LNX.4.51.0304231434540.4838@dns.toxicfilms.tv> <1051159844.18160.1.camel@rth.ninka.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="09CsGkDdkTpDWDy8"
Content-Disposition: inline
In-Reply-To: <1051159844.18160.1.camel@rth.ninka.net>
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux sunbeam 2.4.20-nfpom
X-Date: Today is Sweetmorn, the 43rd day of Discord in the YOLD 3169
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--09CsGkDdkTpDWDy8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 23, 2003 at 09:50:44PM -0700, David S. Miller wrote:
> On Wed, 2003-04-23 at 05:38, Maciej Soltysiak wrote:
> > And here is the patch to remove those by using casts.
>=20
> It's kind of rediculious that these modules don't use the
> existing AH/ESP/etc. header structure types (ip_auth_header et
> al.)

It's because they predate any AH/ESP stuff in the linux kernel.
I'm not saying this as an excuse, just as an explanation.

Kisza: Can you work on making the changes suggested by DaveM?

> Thanks.

--=20
- Harald Welte <laforge@netfilter.org>             http://www.netfilter.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
  "Fragmentation is like classful addressing -- an interesting early
   architectural error that shows how much experimentation was going
   on while IP was being designed."                    -- Paul Vixie

--09CsGkDdkTpDWDy8
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE+q9cmXaXGVTD0i/8RAhFYAJ9lvqHQ/zM/gMuacYF09hiPFK+TeACfX1+o
XY3G+sxWZYV4modMkNR3XuA=
=nF0D
-----END PGP SIGNATURE-----

--09CsGkDdkTpDWDy8--
