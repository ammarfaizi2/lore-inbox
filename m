Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265865AbUACBTc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 20:19:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265873AbUACBTc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 20:19:32 -0500
Received: from adsl-67-121-154-253.dsl.pltn13.pacbell.net ([67.121.154.253]:32917
	"EHLO triplehelix.org") by vger.kernel.org with ESMTP
	id S265865AbUACBTa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 20:19:30 -0500
Date: Fri, 2 Jan 2004 17:19:25 -0800
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-rc1-mm1
Message-ID: <20040103011925.GA5518@triplehelix.org>
Mail-Followup-To: joshk@triplehelix.org, linux-kernel@vger.kernel.org
References: <20031231004725.535a89e4.akpm@osdl.org> <200401021340.37935.email@steffenweber.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8t9RHnE3ZwKMSgU+"
Content-Disposition: inline
In-Reply-To: <200401021340.37935.email@steffenweber.net>
User-Agent: Mutt/1.5.4i
From: joshk@triplehelix.org (Joshua Kwan)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 02, 2004 at 01:40:37PM +0100, Steffen Weber wrote:
> drivers/net/8139too.c:1326: error: `CONFIG_8139_RXBUF_IDX' undeclared (fi=
rst=20
> use in this function)

Could you try a make oldconfig? CONFIG_8139_RXBUF_IDX is a new
configuration option in -mm1.

(Though it should have run solely on the basis of Makefile dependencies.
Weird...)

--=20
Joshua Kwan

--8t9RHnE3ZwKMSgU+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iQIVAwUBP/YYnKOILr94RG8mAQLRBxAA014mLBRWx7CaE5L6LZSR4zwTYKPlfxqt
vw7xzd1u0punZg6YAc5ihUC8CeaZJxyCiaEgJfHE6YssMos7DfhzYIR2kj7BPAi+
PNm3IUhHvhE9lnVXNOIAhHwES/pTN6vpiYlc/i1MHzfNl0tUM60UgcoeOOibx0fF
pmxMtwVwoH3VG7Gk56o9tRD8XkX8VTV79Iirac9KGwEut5Y8SYnwJ/0/VsjMwauN
0AGAv37VTuHbR10p+xJ0A0FsUK3eYDpaABKEwZ7226TJI7A2ed+qoX+FsYPASFFn
Bhl+YoJioptYCektfZdOAfWSLByk663/ZrRNF0KHiCeGp27XaPwWzSdRM+8neIPy
Vvdst9Qn1CELkLaxyS1EMgKxJwZrBJfL4dsz7BE4u107nF+njNzGTnhERZ2b6ksd
0fQhy19ivi/GktghrCSC9Q39hzPRvESjIFChxvzpi8ZJO26E8JLghKcdetXFTfXq
v2UbAZkDbamhDQKdhpNFPo+ps3RjpzYBcRkEX2xbXiABWc02BEi/m/WenXMRkZNn
8BYHLYgEEdMOFLHzbP4InRKpCtJ0dQrCCB+fumAC71S9QdC7ZRznxN7Ja9P4DLrY
8lxMWfCYThHxzrSY8EzcjYtmnaGPaGHma30sy4UOxxdQrtVsPlEfuH5nd8pYw7A4
1yaH6e5HdE4=
=8fFC
-----END PGP SIGNATURE-----

--8t9RHnE3ZwKMSgU+--
