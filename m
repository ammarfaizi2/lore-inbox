Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266521AbUGKVV3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266521AbUGKVV3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jul 2004 17:21:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266522AbUGKVV3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jul 2004 17:21:29 -0400
Received: from mail003.syd.optusnet.com.au ([211.29.132.144]:42958 "EHLO
	mail003.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S266521AbUGKVV0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jul 2004 17:21:26 -0400
Message-ID: <40F1AF1E.7030301@kolivas.org>
Date: Mon, 12 Jul 2004 07:20:30 +1000
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Grzegorz Kulewski <kangur@polcom.net>
Cc: =?ISO-8859-1?Q?Andr=E9_Goddard_Rosa?= <andre.goddard@gmail.com>,
       ck kernel mailing list <ck@vds.kolivas.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjanv@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [ck] Re: [announce] [patch] Voluntary Kernel Preemption Patch
References: <20040709182638.GA11310@elte.hu>	<20040709195105.GA4807@infradead.org>	<20040710124814.GA27345@elte.hu> <40F0075C.2070607@kolivas.org>	<40F016D9.8070300@kolivas.org> <20040711064730.GA11254@elte.hu>	<40F14E53.2030300@kolivas.org> <20040711143853.GA6555@elte.hu>	<b8bf377804071110291e61d19b@mail.gmail.com> <Pine.LNX.4.58.0407111945030.8681@alpha.polcom.net>
In-Reply-To: <Pine.LNX.4.58.0407111945030.8681@alpha.polcom.net>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig72E2B4212A13B8C0A0DA1797"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig72E2B4212A13B8C0A0DA1797
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

Grzegorz Kulewski wrote:
> On Sun, 11 Jul 2004, [ISO-8859-1] André Goddard Rosa wrote:
> 
> 
>>Hi, can anyone explain this:
>>
>>Using Ingo's first patch when I:
>>echo 1 > /proc/sys/kernel/kernel_preempt
>>
>>my system hang up after 2 seconds aproximately.
> 
> 
> I had the same problem.
> 
> 
> 
>>Using Ingo's modifications + Con's it doesn't lock anymore 
> 
> 
> Yes, my too. Maybe H3 version of Ingo's patch fixed that?
> 
>  
> 
>>and is the best kernel that I have used to test..
> 
> 
> Yes, 2.6.7-bk20-ck5 is really the best!

You have an earlier snapshot wich had Ingo's H2 patch which was buggy. 
The last snapshot I announced had Ingo's H3 patch which fixed that exact 
problem.

Cheers,
Con

--------------enig72E2B4212A13B8C0A0DA1797
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFA8a8iZUg7+tp6mRURAqpLAJ0cxnhNACO+9W+uKHT+KZt3CguCVACeIv7b
WdIVSZreqiw2nRfVb8+1roE=
=OvX6
-----END PGP SIGNATURE-----

--------------enig72E2B4212A13B8C0A0DA1797--
