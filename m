Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261279AbUKBMnn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261279AbUKBMnn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 07:43:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261282AbUKBMnF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 07:43:05 -0500
Received: from mail18.syd.optusnet.com.au ([211.29.132.199]:53990 "EHLO
	mail18.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261279AbUKBMlN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 07:41:13 -0500
Message-ID: <41878057.9000302@kolivas.org>
Date: Tue, 02 Nov 2004 23:40:55 +1100
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
Cc: linux <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] remove interactive credit
References: <418707CD.1080903@kolivas.org> <20041102123746.GB15290@elte.hu>
In-Reply-To: <20041102123746.GB15290@elte.hu>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig6DE2C6F417CB206682C60080"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6DE2C6F417CB206682C60080
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Ingo Molnar wrote:
> * Con Kolivas <kernel@kolivas.org> wrote:
> 
> 
>>remove interactive credit
> 
> 
> we could try this in -mm, but it obviously needs alot of testing first. 
> Do you have any particular workload in mind where the fairness win due
> to this revert would/should be significant?

Since I created this variable in the first place I can say with quite 
some certainty that the size of the advantage is miniscule. Whereas 
clearly the design introduces special case mistreatment of only one type 
of task. It's an addition to the interactivity code I've often looked at 
and regretted doing.

Con

--------------enig6DE2C6F417CB206682C60080
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBh4BaZUg7+tp6mRURAsm6AJ98U6ZolUSekmWB50lckbW74+wnegCeLjXI
SWux8VxI4PGm6AKWUkZtmCs=
=OvLx
-----END PGP SIGNATURE-----

--------------enig6DE2C6F417CB206682C60080--
