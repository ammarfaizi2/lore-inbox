Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261178AbULMVka@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261178AbULMVka (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 16:40:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261180AbULMVka
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 16:40:30 -0500
Received: from hamlet.e18.physik.tu-muenchen.de ([129.187.154.223]:4998 "EHLO
	hamlet.e18.physik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id S261178AbULMVkM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 16:40:12 -0500
In-Reply-To: <41BDF8B6.8050204@netshadow.at>
References: <41BD24EB.8000502@globaledgesoft.com> <41BD2D35.5080101@netshadow.at> <41BD2F0C.9040602@globaledgesoft.com> <41BDF8B6.8050204@netshadow.at>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg=pgp-sha1; boundary="Apple-Mail-8-112318925"
Message-Id: <8A230BAC-4D4E-11D9-AC6C-000A9567DDDE@e18.physik.tu-muenchen.de>
Content-Transfer-Encoding: 7bit
Cc: krishna.c@globaledgesoft.com, linux-kernel@vger.kernel.org
From: Roland Kuhn <rkuhn@e18.physik.tu-muenchen.de>
Subject: Re: How to enable sysrq feature
Date: Mon, 13 Dec 2004 22:32:50 +0100
To: Andreas Unterkircher <unki@netshadow.at>
X-Pgp-Agent: GPGMail 1.0.1 (v33, 10.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail-8-112318925
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; format=flowed

Hi!

On Dec 13, 2004, at 9:16 PM, Andreas Unterkircher wrote:

> Hi Krishna,
>
> If u compiled in sysrq into your kernel and booted the correct kernel 
> - it must be there.
>
echo 1 > /proc/sys/kernel/sysrq

> If u enabled the /proc/config (or /proc/config.gz) with these kernel 
> options
>
>    CONFIG_IKCONFIG
>    (maybe CONFIG_IKCONFIG_PROC too)
>
> you can check with
>
> cat /proc/config | grep -i sysrq
>
> (or zcat /proc/config.gz | grep -i sysrq)
>
> if this options are really in your running kernel.
>
> Andi

[snip]
Was it really necessary to quote the .config four times?

Ciao,
					Roland

--
TU Muenchen, Physik-Department E18, James-Franck-Str. 85747 Garching
Telefon 089/289-12592; Telefax 089/289-12570
--
A mouse is a device used to point at
the xterm you want to type in.
Kim Alm on a.s.r.

--Apple-Mail-8-112318925
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (Darwin)

iD8DBQFBvgqGI4MWO8QIRP0RAsKPAJ9C0JnzE7dts+raDl2kpvSnAPjt6ACeOU3Y
CsOxLkaYjRiR/PMsjPTANGQ=
=y5ff
-----END PGP SIGNATURE-----

--Apple-Mail-8-112318925--

