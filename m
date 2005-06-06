Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261292AbVFFK7m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261292AbVFFK7m (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 06:59:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261308AbVFFK7m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 06:59:42 -0400
Received: from moutng.kundenserver.de ([212.227.126.177]:50909 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S261292AbVFFK7V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 06:59:21 -0400
Message-ID: <42A42CA1.7080700@punnoor.de>
Date: Mon, 06 Jun 2005 12:59:45 +0200
From: Prakash Punnoor <prakash@punnoor.de>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050511)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Dominik Brodowski <linux@dominikbrodowski.net>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: cpufreq/speedstep won't work on Sony Vaio PCG-F807K
References: <42935600.5090008@punnoor.de> <20050524203300.GA24187@isilmar.linta.de> <42939FAF.8040805@punnoor.de> <20050605172455.GH12338@dominikbrodowski.de>
In-Reply-To: <20050605172455.GH12338@dominikbrodowski.de>
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig3A3300A4725DEF90A784A3F7"
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:cec1af1025af73746bdd9be3587eb485
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig3A3300A4725DEF90A784A3F7
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Dominik Brodowski schrieb:
> Hi,
> 
> 
>>speedstep-smi: signature:0x47534943, command:0x008000b2, event:0x000000b3,
>>perf_level:0x07d00100.
> 
> 
> Could you try passing the module option "smi_cmd=0x82" to speedstep-smi?
> Most often this is the correct value, and in several cases the BIOS reports
> false values (in your case: 0x80) which cause speedstep-smi not to work
> properly.

Thanx, now the module loads and (partly) works: I now have 500MHz and 650MHz
*only* as selection and I can switch between them both. But why only this two
options? If I enable speedstep in bios and force it, Linux reports 133MHz or
alike as CPU speed,which seems to be a more realistic lower limit, as I don't
think going to 500MHz will save me much.

Anyway, shoudl a quirk for this notebook be added somewhere? Do you need
additional infos for this, in case?

Is there a possibility to get the ACPI P-state driver going? Perhaps this
would give me a lower minimum clock. Or is the ACPI crew responsible for this
driver and should I ask them?

Cheers,

Prakash

--------------enig3A3300A4725DEF90A784A3F7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFCpCyhxU2n/+9+t5gRAkzQAKDHmhX+pEyZ3r0Yt0FnlKYmcm0/ZQCgwUVd
zn5rRktjKF5vsN7ZOrtumUc=
=Sv0N
-----END PGP SIGNATURE-----

--------------enig3A3300A4725DEF90A784A3F7--
