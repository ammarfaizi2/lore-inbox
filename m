Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268578AbUH3R1T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268578AbUH3R1T (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 13:27:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268593AbUH3R1T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 13:27:19 -0400
Received: from puzzle.sasl.smtp.pobox.com ([207.8.226.4]:5031 "EHLO
	sasl.smtp.pobox.com") by vger.kernel.org with ESMTP id S268578AbUH3R0H
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 13:26:07 -0400
Date: Mon, 30 Aug 2004 22:55:57 +0530
From: Joshua N Pritikin <jpritikin@pobox.com>
To: coreteam@netfilter.org
Cc: netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org
Subject: Re: an oops possibly due to an SMP related bug in netfilter
Message-ID: <20040830172557.GD1029@always.joy.eth.net>
References: <20040830120809.GB1029@always.joy.eth.net> <20040830165753.GA22979@sch.bme.hu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0H629O+sVkh21xTi"
Content-Disposition: inline
In-Reply-To: <20040830165753.GA22979@sch.bme.hu>
X-PGP-Key: 06E3 3D22 D307 AAE6 ACB4  6B44 A9CA A794 A4A6 0BBD
X-Request-PGP: http://openheartlogic.org/personal/pubkey.asc
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--0H629O+sVkh21xTi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 30, 2004 at 06:57:53PM +0200, KOVACS Krisztian wrote:
> On Mon, Aug 30, 2004 at 05:38:09PM +0530, Joshua N Pritikin wrote:
> > (Perhaps I am one of the few people crazy enough to run a firewall on
> > an SMP machine.  ;-)
> > =20
> > CPU:    0=20
> > EIP:    0060:[<c8895955>]    Not tainted=20
> > EFLAGS: 00010246   (2.6.7) =20
> > EIP is at __ip_conntrack_find+0x179/0x1a0 [ip_conntrack]=20
> > eax: 00000001   ebx: 00000000   ecx: c0353cc0   edx: 00000000=20
> > esi: 00000000   edi: 00000000   ebp: c0353c88   esp: c0353c6c=20
> > ds: 007b   es: 007b   ss: 0068=20
> > Process swapper (pid: 0, threadinfo=3Dc0352000 task=3Dc0300980)
>=20
>   I don't think you're the only one running iptables on SMP... This looks
> like a conntrack hash table corruption, so the first thing you should
> check is your memory, of course. Are you 100 percent sure that it is ok?

Fair enough.

Memtest86 doesn't spot anything BUT it could be due to voltage
fluctuation.  I guess I can't run this motherboard without a UPS.

--=20
A new cognitive theory of emotion, http://openheartlogic.org

--0H629O+sVkh21xTi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBM2MlqcqnlKSmC70RAot0AKC+6YYtmVS+2DRxoXFMhxFQLGGDvACffDqg
k0inR5jU6YzdM7BXo/TFLzc=
=JUSB
-----END PGP SIGNATURE-----

--0H629O+sVkh21xTi--
