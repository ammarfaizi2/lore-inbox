Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264058AbUGFQBX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264058AbUGFQBX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jul 2004 12:01:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264061AbUGFQBW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jul 2004 12:01:22 -0400
Received: from ganesha.gnumonks.org ([213.95.27.120]:35538 "EHLO
	ganesha.gnumonks.org") by vger.kernel.org with ESMTP
	id S264058AbUGFQBU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jul 2004 12:01:20 -0400
Date: Tue, 6 Jul 2004 18:01:09 +0200
From: Harald Welte <laforge@netfilter.org>
To: davem@redhat.com, linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       netfilter-devel@lists.netfilter.org
Subject: Re: [PATCH 2.6] ip6t_LOG and packets with hop-by-hop options
Message-ID: <20040706160109.GO32707@sunbeam2>
Mail-Followup-To: Harald Welte <laforge@netfilter.org>, davem@redhat.com,
	linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
	netfilter-devel@lists.netfilter.org
References: <20040706150918.GA5009@penguin.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yZxAaITavNk3ADw/"
Content-Disposition: inline
In-Reply-To: <20040706150918.GA5009@penguin.localdomain>
User-Agent: Mutt/1.5.6+20040523i
X-Spam-Score: -4.9 (----)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--yZxAaITavNk3ADw/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 06, 2004 at 05:09:18PM +0200, Marcel Sebek wrote:
> Packet with IPPROTO_HOPOPTS extended header isn't logged properly by
> ip6t_LOG.c. It only prints PROTO=3D0 and nothing more, because
> IPPROTO_HOPOPTS=3D0 and in this file 0 is used to indicate last header.
> This patch fix it by using IPPROTO_NONE to indicate last header.

looks fine to me.  Dave, can you please include this to your tree?
Thanks.
--=20
- Harald Welte <laforge@netfilter.org>             http://www.netfilter.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
  "Fragmentation is like classful addressing -- an interesting early
   architectural error that shows how much experimentation was going
   on while IP was being designed."                    -- Paul Vixie

--yZxAaITavNk3ADw/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA6szFXaXGVTD0i/8RAqyBAKCwVgXhaL90YOmbJdWeOmwtGtRC5wCcDh6z
cdyKWtNc2S4+4qaOg28Tiig=
=aqI8
-----END PGP SIGNATURE-----

--yZxAaITavNk3ADw/--
