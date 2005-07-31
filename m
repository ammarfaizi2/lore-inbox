Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261665AbVGaKyW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261665AbVGaKyW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 06:54:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261675AbVGaKyW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 06:54:22 -0400
Received: from ganesha.gnumonks.org ([213.95.27.120]:28830 "EHLO
	ganesha.gnumonks.org") by vger.kernel.org with ESMTP
	id S261665AbVGaKyU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 06:54:20 -0400
Date: Sun, 31 Jul 2005 12:42:53 +0200
From: Harald Welte <laforge@netfilter.org>
To: Denis Vlasenko <vda@ilport.com.ua>
Cc: netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org
Subject: Re: iptables redirect is broken on bridged setup
Message-ID: <20050731104253.GG14874@rama.de.gnumonks.org>
Mail-Followup-To: Harald Welte <laforge@netfilter.org>,
	Denis Vlasenko <vda@ilport.com.ua>,
	netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org
References: <200507291209.37247.vda@ilport.com.ua>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="B8ONY/mu/bqBak9m"
Content-Disposition: inline
In-Reply-To: <200507291209.37247.vda@ilport.com.ua>
User-Agent: mutt-ng devel-20050619 (Debian)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--B8ONY/mu/bqBak9m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[removed a number of unneccessarry CC's from list]

On Fri, Jul 29, 2005 at 12:11:52PM +0300, Denis Vlasenko wrote:
> Linux 2.6.12

Denis, your bug is not getting fixed faster, no matter how often you
will post it at how many places and to how many recipients.  We have
seen it, and we will look at it.=20

bridging and netfilter/iptables is always a very tricky case, and the
code was developed by separate groups who - as it is my impression -
don't fully understand each others codebase too well.  Also, many of the
possible combinations of bridging and netfilter/iptables have apparently
not been tested (or even used by anyone), so I'm not surprised that you
see some unexpected behaviour.

Also, the bridging/ebtables maintainer Bart de Schuymer is currently on
holidays, as I understand.

So please be patient.
--=20
- Harald Welte <laforge@netfilter.org>                 http://netfilter.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
  "Fragmentation is like classful addressing -- an interesting early
   architectural error that shows how much experimentation was going
   on while IP was being designed."                    -- Paul Vixie

--B8ONY/mu/bqBak9m
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFC7KssXaXGVTD0i/8RAh98AJ0ZP1lFIoEi40M2ZCead5Ed5O603ACgqfGW
69jY3YnTj/ChYeEwgCgB6bg=
=/1Dh
-----END PGP SIGNATURE-----

--B8ONY/mu/bqBak9m--
