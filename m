Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263801AbUDZNNq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263801AbUDZNNq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 09:13:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261604AbUDZNNq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 09:13:46 -0400
Received: from dialin-212-144-165-090.arcor-ip.net ([212.144.165.90]:9354 "EHLO
	karin.de.interearth.com") by vger.kernel.org with ESMTP
	id S263801AbUDZNNn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 09:13:43 -0400
In-Reply-To: <20040426123433.48970.qmail@web41205.mail.yahoo.com>
References: <20040426123433.48970.qmail@web41205.mail.yahoo.com>
Mime-Version: 1.0 (Apple Message framework v613)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-5--548782349"
Message-Id: <4B1359A6-9783-11D8-B40E-000A958E35DC@fhm.edu>
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org
From: Daniel Egger <degger@fhm.edu>
Subject: Re: PROBLEM: memory managment bug in kernel >= 2.4.23
Date: Mon, 26 Apr 2004 15:11:56 +0200
To: Pierre Berthier <berthierp@yahoo.com>
X-Pgp-Agent: GPGMail 1.0.1 (v33, 10.3)
X-Mailer: Apple Mail (2.613)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail-5--548782349
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; format=flowed

On 26.04.2004, at 14:34, Pierre Berthier wrote:

> a bug report concerning memory managment (?).  I did not subscribe to 
> the list,
> please CC me.

> every two minutes a "__alloc_pages: 0-order allocation failed 
> (gfp=0x21/0)"
> message.

Interesting. I had been seeing the same until yesterday where I updated 
to
2.4.26. I explicitely tried reproducing it in order to compose a usable
problem report on the l-k mailinglist but couldn't.

The problem on my machine was that I could trigger some memory leak by
rsync'ing between two local IDE disks which would eventually eat up all
of the systems memory without the possibility of recovery forcing all
other processes into swap or having them killed.

Servus,
       Daniel

--Apple-Mail-5--548782349
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (Darwin)

iQEVAwUBQI0KnDBkNMiD99JrAQI81AgAyUeDakrlLwMIElqIBUbTvrQpu9SFgFxM
sB4m+aBo8k7V4mvo1vvzZ4LGMfYgSwczrWhea8hXMQiZ4jtnVQTrgeIPtfub7bY8
iNGJf74hU4gG/ZKJ2AB5j/21tnIGhVa83mKyUP2dxynDSV59GS4mF3cco5bFwN7j
44KCaNhbiUh67/q23FdE3bSz3d9ujwdfffbjKmjqXZfwr8cqLnpHfxDWcBcIu5d4
KXQk7KjYnVSUG6k+1KuoaElypiAh8kwd4qCt6V5NCcuegtdvsTfluSdk4wu7bOVT
akwEIkz4knhO378DezeZMh8VQj9LzG/dPenibTg+abiVyzgKJIpCDA==
=k3Zs
-----END PGP SIGNATURE-----

--Apple-Mail-5--548782349--

