Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261969AbUDGI7D (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 04:59:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262351AbUDGI7D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 04:59:03 -0400
Received: from dialin-212-144-167-162.arcor-ip.net ([212.144.167.162]:20129
	"EHLO karin.de.interearth.com") by vger.kernel.org with ESMTP
	id S261969AbUDGI6y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 04:58:54 -0400
In-Reply-To: <4072CD01.6070408@pobox.com>
References: <4072CD01.6070408@pobox.com>
Mime-Version: 1.0 (Apple Message framework v613)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-4--102663672"
Message-Id: <FE87A41F-8809-11D8-8F2A-000A9597297C@fhm.edu>
Content-Transfer-Encoding: 7bit
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Netdev <netdev@oss.sgi.com>
From: Daniel Egger <degger@fhm.edu>
Subject: Re: [NET] net driver updates
Date: Tue, 6 Apr 2004 22:35:51 +0200
To: Jeff Garzik <jgarzik@pobox.com>
X-Pgp-Agent: GPGMail 1.0.1 (v33, 10.3)
X-Mailer: Apple Mail (2.613)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail-4--102663672
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; format=flowed

On 06.04.2004, at 17:30, Jeff Garzik wrote:

> * Francois work on r8169, epic100, sis190: PCI DMA, NAPI, other minor 
> fixes and cleanups

r8169 seems to work though it is not even a tad bit faster
than plain 2.6.5.

Those cards are really driving me nuts. Between two r8169 cards, one
on Athlon with kernel 2.4.24, one on Athlon with 2.6.5 or 2.4.24, I
get 90Mbit/s in one direction and 39Mbit/s in the other using iperf and
TCP. With iperf and UDP they deliver 100Mbit/s resp. 230Mbit/s depending
on the direction. Crosschecking with my PowerBook (OS X) shows that I 
can
get 844Mbit/s (UDP) or 572Mbit/s (TCP) to one host and 844Mbit/s (UDP) 
but
only 88Mbit/s (TCP) to the other.

The environment is switched and changing cables and/or ports doesn't
improve the results.

Ideas? (Yeah, I'll get Intel NICs RSN...)

Servus,
       Daniel

--Apple-Mail-4--102663672
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (Darwin)

iQEVAwUBQHMUpzBkNMiD99JrAQL45Qf/b96+36QbfCn1DYBW1dc3kdvwwK89svqT
Hu2akhQbncciQ8Wuy0yw8tYd4N5oDAOi+4NnJMA77JveHIlKSoMcRB5m8O2of5SJ
PvNhKQhU3I6ysoUrOO5AIpoiycymYuxgv76tMKQbiouSY/xR8EfxXPRGkCxzfV3w
7yHhjgMFEz9DbgTEQJj3ed5I4GalpCVh/x5EPqv7c/7+LLkWkDYhwoWtZCxb3lrS
W5LjRVfHmks+kqk+9WbhwnJEtcoSGEVOLyRGmL8PxUgTDYZjm98MxSgUbnWO6KP2
C0FVe6VtBfElQbLgWuJOHqDjynxwuosMeeEsdigOCuis2hIUBUXQ9w==
=j3y8
-----END PGP SIGNATURE-----

--Apple-Mail-4--102663672--

