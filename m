Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266614AbUGKPTy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266614AbUGKPTy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jul 2004 11:19:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266616AbUGKPTy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jul 2004 11:19:54 -0400
Received: from mail007.syd.optusnet.com.au ([211.29.132.55]:4020 "EHLO
	mail007.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S266614AbUGKPTt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jul 2004 11:19:49 -0400
Message-ID: <40F15A86.1030208@kolivas.org>
Date: Mon, 12 Jul 2004 01:19:34 +1000
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: Matthias Andree <matthias.andree@gmx.de>,
       Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: post 2.6.7 BK change breaks Java?
References: <40EEB1B2.7000800@kolivas.org> <Pine.LNX.4.56.0407091954160.22376@jjulnx.backbone.dif.dk> <Pine.LNX.4.56.0407111713420.23979@jjulnx.backbone.dif.dk>
In-Reply-To: <Pine.LNX.4.56.0407111713420.23979@jjulnx.backbone.dif.dk>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig319ECA042F894643A4AC0048"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig319ECA042F894643A4AC0048
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Jesper Juhl wrote:
> On Fri, 9 Jul 2004, Jesper Juhl wrote:
> 
> 
>>On Fri, 9 Jul 2004, Con Kolivas wrote:
>>
>>
>>>but I suspect it's one of those possibly interfering. Looking at the
>>>patches in question I have no idea how they could do it. I guess if you
>>>can try backing them out it would be helpful. Here are links to the
>>>patches in question.
>>>http://ck.kolivas.org/patches/2.6/2.6.7/2.6.7-ck5/split-out/1100_ip_tabl
>>>es.patch
>>>http://ck.kolivas.org/patches/2.6/2.6.7/2.6.7-ck5/split-out/1105_CAN-200
>>>4-0497.patch
>>>http://ck.kolivas.org/patches/2.6/2.6.7/2.6.7-ck5/split-out/1110_proc.pa
>>>tch
>>
>>Thanks Con, I'll try playing with those tomorrow (got no time tonight),
>>and report back.
>>
> 
> Ok, got them all 3 backed out of 2.6.7-mm7 , but that doesn't change a
> thing. The JVM still dies when I try to run eclipse.

Sorry someone else reported success with this:

quote:
------
If I removed this changeset, java worked.
http://linux.bkbits.net:8080/linux-2.6/cset@1.1743
------

Sorry I was hoping others saw this.

Con

--------------enig319ECA042F894643A4AC0048
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFA8VqGZUg7+tp6mRURAu5tAJ9uVtpF193lFbFn2vQ0MOK2SCT6/gCdGEDg
oZk4Kl+a34BF2l0SNKzoGLI=
=hVRF
-----END PGP SIGNATURE-----

--------------enig319ECA042F894643A4AC0048--
