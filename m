Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261206AbVAGCPs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261206AbVAGCPs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 21:15:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261185AbVAGCPi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 21:15:38 -0500
Received: from pop.gmx.net ([213.165.64.20]:12738 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261214AbVAGA20 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 19:28:26 -0500
X-Authenticated: #4512188
Message-ID: <41DDD7C3.8040406@gmx.de>
Date: Fri, 07 Jan 2005 01:28:51 +0100
From: "Prakash K. Cheemplavam" <prakashkc@gmx.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050103)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: bzolnier@gmail.com, drab@kepler.fjfi.cvut.cz, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: APIC/LAPIC hanging problems on nForce2 system.
References: <Pine.LNX.4.60.0501051604200.24191@kepler.fjfi.cvut.cz>	<41DC1AD7.7000705@gmx.de>	<Pine.LNX.4.60.0501051757300.25946@kepler.fjfi.cvut.cz>	<41DC2113.8080604@gmx.de>	<Pine.LNX.4.60.0501051821430.25946@kepler.fjfi.cvut.cz>	<41DC2353.7010206@gmx.de>	<Pine.LNX.4.60.0501060046450.26952@kepler.fjfi.cvut.cz>	<41DCFEF0.5050105@gmx.de>	<58cb370e05010605527f87297e@mail.gmail.com>	<41DD537B.9030304@gmx.de> <20050106154650.33c3b11c.akpm@osdl.org>
In-Reply-To: <20050106154650.33c3b11c.akpm@osdl.org>
X-Enigmail-Version: 0.89.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig6EC5572BBCC00C3431E714BA"
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6EC5572BBCC00C3431E714BA
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Andrew Morton schrieb:
> "Prakash K. Cheemplavam" <prakashkc@gmx.de> wrote:
>
>>This patch applies the Nforce2 C1 halt disconnect fix, no matter if
>>disconnect is enabled of not. I don't know whether checking the whole
>>affected byte is necessary or the nibble would be enough (I am no Nvidia
>>engineer).
>
>
> The patch doesn't apply to the current tree.  Here's what we currently have:

Well, I just got 2.6.10-mm1, went into its dir and here

tachyon linux-2.6.10-mm1 # patch -p0
</home/light/always_nforce2_c1_fix.patch
patching file arch/i386/pci/fixup.c
tachyon linux-2.6.10-mm1 #

it went alright. Perhaps firfox fscked up the inlined patch, so please
try the attached version. If it goes alright, I'll resubmit it,
inlcuding more detailed description.

Prakash

--------------enig6EC5572BBCC00C3431E714BA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFB3dfHxU2n/+9+t5gRApIWAKDg8DRWpsEwtaUn3LpfYfnuGMvlWACgqTa4
Xf4+LOErZd0v9+GUA4AZEtM=
=5uEp
-----END PGP SIGNATURE-----

--------------enig6EC5572BBCC00C3431E714BA--
