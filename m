Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261511AbULFMbc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261511AbULFMbc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 07:31:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261512AbULFMbc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 07:31:32 -0500
Received: from mail.gmx.de ([213.165.64.20]:21400 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261511AbULFMb3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 07:31:29 -0500
X-Authenticated: #4512188
Message-ID: <41B45134.4040005@gmx.de>
Date: Mon, 06 Dec 2004 13:31:48 +0100
From: "Prakash K. Cheemplavam" <prakashkc@gmx.de>
User-Agent: Mozilla Thunderbird 1.0RC1 (X11/20041203)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Time sliced CFQ #2
References: <20041204104921.GC10449@suse.de> <41B426D4.6080506@gmx.de> <20041206093517.GJ10498@suse.de>
In-Reply-To: <20041206093517.GJ10498@suse.de>
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig7B1795286C3EB8E68617F26D"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig7B1795286C3EB8E68617F26D
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Jens Axboe schrieb:
> On Mon, Dec 06 2004, Prakash K. Cheemplavam wrote:
> 
>>Hi,
>>
>>this one crapped out on me, while having heavy disk activity. (updating 
>> gentoo portage tree - rebuilding metadata of it). Unfortunately I 
>>couldn't save the oops, as I had no hd access anymore and X would freeze 
>>a little later...(and I don't want to risk my data a second time...)
> 
> 
> Did you save anything at all? Just the function of the EIP would be
> better than nothing.

Nope, sorry. I hoped it would be in the logs, but it seems as new cfq 
went havoc, hd access went dead. And I was a bit too nervous about my 
data so that I didn't write it down by hand...

> Well hard to say anything qualified without an oops :/
> 
> I'll try with PREEMPT here.

If you are not able to reproduce, I will try it again on a spare 
partition... Should access to zip drive stil be possible if hd's 
io-scheduler is dead?

Prakash


--------------enig7B1795286C3EB8E68617F26D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFBtFE0xU2n/+9+t5gRAthvAKDlRszC0xEMG+o/SARKj+sVkRRhtwCfbdf4
3B+HxBHIlzWTp4bT+LQ05+E=
=w29E
-----END PGP SIGNATURE-----

--------------enig7B1795286C3EB8E68617F26D--
