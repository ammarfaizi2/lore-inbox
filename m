Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262322AbVDFUpF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262322AbVDFUpF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 16:45:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262323AbVDFUpF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 16:45:05 -0400
Received: from 213-239-212-8.clients.your-server.de ([213.239.212.8]:62887
	"EHLO live1.axiros.com") by vger.kernel.org with ESMTP
	id S262322AbVDFUoz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 16:44:55 -0400
In-Reply-To: <4252E827.4080807@google.com>
References: <4252E827.4080807@google.com>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-33--778398117"
Message-Id: <c818c171530aec46fe0c8895b6e59901@axiros.com>
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org
From: Daniel Egger <de@axiros.com>
Subject: Re: [RFC/Patch 2.6.11] Take control of PCI Master Abort Mode
Date: Wed, 6 Apr 2005 22:44:31 +0200
To: Ross Biro <rossb@google.com>
X-Pgp-Agent: GPGMail 1.0.2
X-Mailer: Apple Mail (2.619.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail-33--778398117
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; format=flowed

On 05.04.2005, at 21:33, Ross Biro wrote:

> The problem with always setting the bit is that some PCI hardware, 
> notably some Intel E-1000 chips (Ethernet controller: Intel 
> Corporation: Unknown device 1076) cannot properly handle the target 
> abort bit.  In the case of the E-1000 chip, the driver must reset the 
> chip to recover. This usually leads to the machine being off the 
> network for several seconds, or sometimes even minutes, which can be 
> bad for servers.

This sounds *exactly* like my problem since I swapped
motherboards. I'll see whether there's some option in
the BIOS that fixes it and if not bite the bullet and
compile a generic kernel....

Thanks a lot for investigating this.

Servus,
       Daniel

--Apple-Mail-33--778398117
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (Darwin)

iD8DBQFCVEovchlzsq9KoIYRAvRcAKCg3H7JL3sh6B7KL0yiF8km/67NyACgwtbr
JzNFYrPfkjr0b356+Ds0Uh4=
=9Aqd
-----END PGP SIGNATURE-----

--Apple-Mail-33--778398117--

