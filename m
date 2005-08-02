Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261504AbVHBM6F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261504AbVHBM6F (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 08:58:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261509AbVHBM6F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 08:58:05 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:35542 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S261504AbVHBM6C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 08:58:02 -0400
Message-ID: <42EF6DF7.6030100@punnoor.de>
Date: Tue, 02 Aug 2005 14:58:31 +0200
From: Prakash Punnoor <prakash@punnoor.de>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050723)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       ck list <ck@vds.kolivas.org>, Tony Lindgren <tony@atomide.com>,
       tuukka.tikkanen@elektrobit.com
Subject: Re: [PATCH] no-idle-hz aka dynamic ticks
References: <200508022225.31429.kernel@kolivas.org>
In-Reply-To: <200508022225.31429.kernel@kolivas.org>
X-Enigmail-Version: 0.92.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig6417424F107E2E730E2A18E3"
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:cec1af1025af73746bdd9be3587eb485
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6417424F107E2E730E2A18E3
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Con Kolivas schrieb:
> As promised, here is an updated patch for the newly released 2.6.13-rc5. Boots 
> and runs fine on P4HT (SMP+SMT kernel) built with gcc 4.0.1.

Doesn't compile for me w/ gcc 3.4.4:


  CC      arch/i386/kernel/irq.o
In file included from include/linux/dyn-tick.h:64,
                 from arch/i386/kernel/irq.c:21:
include/asm/dyn-tick.h: In function `reprogram_apic_timer':
include/asm/dyn-tick.h:48: warning: implicit declaration of function
`apic_write_around'
include/asm/dyn-tick.h:48: error: `APIC_TMICT' undeclared (first use in this
function)
include/asm/dyn-tick.h:48: error: (Each undeclared identifier is reported only
once
include/asm/dyn-tick.h:48: error: for each function it appears in.)
make[1]: *** [arch/i386/kernel/irq.o] Error 1


Cheers,

Prakash

--------------enig6417424F107E2E730E2A18E3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFC7233xU2n/+9+t5gRAgEAAKDatagAteg3KUbmNGlHvCrpVGKlmgCg97RU
EevN2mTs3hJi5QvLJn/YuYw=
=bPif
-----END PGP SIGNATURE-----

--------------enig6417424F107E2E730E2A18E3--
