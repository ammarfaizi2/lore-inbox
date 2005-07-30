Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262959AbVG3Nnr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262959AbVG3Nnr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 09:43:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262963AbVG3Nnr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 09:43:47 -0400
Received: from 213-239-212-8.clients.your-server.de ([213.239.212.8]:7404 "EHLO
	live1.axiros.com") by vger.kernel.org with ESMTP id S262959AbVG3Nnq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 09:43:46 -0400
In-Reply-To: <Pine.LNX.4.61.0507290929420.8400@tm8103.perex-int.cz>
References: <Pine.LNX.4.61.0507281546040.8458@tm8103.perex-int.cz> <20050728102525.234e6511.akpm@osdl.org> <Pine.LNX.4.61.0507290929420.8400@tm8103.perex-int.cz>
Mime-Version: 1.0 (Apple Message framework v733)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-2-542349396"
Message-Id: <3442015A-4821-45DA-ACD4-16AAD9DC3268@axiros.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Mailing List Kernel linux-kernel 
	<linux-kernel@vger.kernel.org>,
       tiwai@suse.de
Content-Transfer-Encoding: 7bit
From: Daniel Egger <de@axiros.com>
Subject: Re: [ALSA PATCH] 1.0.9b+
Date: Sat, 30 Jul 2005 15:42:33 +0200
To: Jaroslav Kysela <perex@suse.cz>
X-Pgp-Agent: GPGMail 1.1.1 (Tiger)
X-Mailer: Apple Mail (2.733)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-2-542349396
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed

On 29.07.2005, at 09:39, Jaroslav Kysela wrote:

> Note that most of lines are from new Sparc and ARM drivers. Other  
> changes
> are mostly small bugfixes, cleanups and new hardware ID additions.  
> The all
> changes goes through all ALSA developers (our CVS server sends us  
> whole
> diffs back), so all of them review/verify new code and can fix it  
> ASAP. It
> works quite well.

FWIW the current ALSA patch against 2.6.12 works much better than
the original version for my Asus W3V with Intel HDA ALC880 in the sense
that there's a possibility to prevent crashing the kernel when loading
the module. However apart from the ID fixes this involves disabling the
autodetection code and hardcoding the correct type in the realtek code.

As it stands the code seems to be really buggy and I'd love to test the
driver after someone wiser than me in this area reviewed and fixed the
code.

Servus,
       Daniel


--Apple-Mail-2-542349396
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (Darwin)

iD8DBQFC64PJchlzsq9KoIYRArktAJ4tjvoHgeMHDfZkuQOTUc5hxSXLNACgrJIP
SVhHeGkfcldjGUmHObtymNw=
=goK4
-----END PGP SIGNATURE-----

--Apple-Mail-2-542349396--
