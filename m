Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267701AbUHVQ05@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267701AbUHVQ05 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 12:26:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268015AbUHVQ05
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 12:26:57 -0400
Received: from mylinuxtime.de ([217.160.170.124]:49371 "EHLO solar.linuxob.de")
	by vger.kernel.org with ESMTP id S267701AbUHVQ0z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 12:26:55 -0400
From: Christian Hesse <mail@earthworm.de>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Subject: Re: v2.6.8.1 breaks tspc
Date: Sun, 22 Aug 2004 18:26:35 +0200
User-Agent: KMail/1.7
Cc: linux-kernel@vger.kernel.org, netfilter-devel@lists.netfilter.org
References: <200408212303.05143.mail@earthworm.de> <200408221506.07883.mail@earthworm.de> <200408221743.22561.vda@port.imtp.ilyichevsk.odessa.ua>
In-Reply-To: <200408221743.22561.vda@port.imtp.ilyichevsk.odessa.ua>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1111785.RsWhZC3J7t";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200408221826.41842.mail@earthworm.de>
X-AntiVirus: checked by AntiVir Milter 1.0.6; AVE 6.27.0.6; VDF 6.27.0.23
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1111785.RsWhZC3J7t
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Sunday 22 August 2004 16:43, Denis Vlasenko wrote:
> [...]
> Looks like window scaling is not understood or incorrectly
> handled by Linux or by remote box. I am no expert on this,
> thus CCing LKML and netfilter list.
>
> Please try whether it works whan you do
> "echo 0 > /proc/sys/net/ipv4/tcp_window_scaling"

That helps. Thanks so far.

> [...]
=2D-=20
Christian

--nextPart1111785.RsWhZC3J7t
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBBKMlBlZfG2c8gdSURAplNAJ0Uet0q3sIPv29ghpDRtqCBHSvhBgCg44s9
tgYgiXDFCgnE86IWddPVuHA=
=KJLl
-----END PGP SIGNATURE-----

--nextPart1111785.RsWhZC3J7t--
