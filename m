Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261363AbVFFMrU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261363AbVFFMrU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 08:47:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261394AbVFFMrT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 08:47:19 -0400
Received: from moutng.kundenserver.de ([212.227.126.177]:58356 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S261363AbVFFMq4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 08:46:56 -0400
Message-ID: <42A445F2.2080809@punnoor.de>
Date: Mon, 06 Jun 2005 14:47:46 +0200
From: Prakash Punnoor <prakash@punnoor.de>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050511)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Dominik Brodowski <linux@dominikbrodowski.net>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: cpufreq/speedstep won't work on Sony Vaio PCG-F807K
References: <42935600.5090008@punnoor.de> <20050524203300.GA24187@isilmar.linta.de> <42939FAF.8040805@punnoor.de> <20050605172455.GH12338@dominikbrodowski.de> <42A42CA1.7080700@punnoor.de> <20050606115542.GA31947@isilmar.linta.de>
In-Reply-To: <20050606115542.GA31947@isilmar.linta.de>
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig98EC3D25BBC47D1E850982EA"
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:cec1af1025af73746bdd9be3587eb485
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig98EC3D25BBC47D1E850982EA
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Dominik Brodowski schrieb:

>>If I enable speedstep in bios and force it, Linux reports 133MHz or
>>alike as CPU speed,which seems to be a more realistic lower limit, as I don't
>>think going to 500MHz will save me much.
> 
> 
> However, the CPU only supports 500 MHz or 600 MHz. Possibly, the other
> effect you're seeing is from CPU frequency throttling which is (mostly)
> useless.

Ok, I did some more experiments and it seems you are right. Then it seems
Linux miscalculates the MHz if I select Auto in the BIOS. (I need to use acpi
pm timer then, otherwise I get lost ticks with tsc.) It is *not* throtteling
which results in this, as I can still throttle down via acpi by hand and then
the laptop feels very sluggish (same if Linux reports 133 or 500MHz). So I
wonder a bit how this comes, but well...

Thanx anyway,

Prakash

--------------enig98EC3D25BBC47D1E850982EA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFCpEXyxU2n/+9+t5gRAgcfAKDIfuB5f8uGbvPy2MKC/2ArdjZa2ACfUQbS
wL9J2RmlpBEnpLCr0v++Fhw=
=BJyO
-----END PGP SIGNATURE-----

--------------enig98EC3D25BBC47D1E850982EA--
