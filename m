Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965046AbVLVEQY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965046AbVLVEQY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 23:16:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965048AbVLVEQX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 23:16:23 -0500
Received: from mail10.syd.optusnet.com.au ([211.29.132.191]:23736 "EHLO
	mail10.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S965046AbVLVEQX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 23:16:23 -0500
References: <20051214234016.0112a86e.akpm@osdl.org> <9a8748490512211514g62bec66dqfb00b4dc1aeb7628@mail.gmail.com>
Message-ID: <cone.1135224970.635407.3942.501@kolivas.org>
X-Mailer: http://www.courier-mta.org/cone/
From: Con Kolivas <kernel@kolivas.org>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-rc5-mm3
Date: Thu, 22 Dec 2005 15:16:10 +1100
Mime-Version: 1.0
Content-Type: multipart/signed;
    boundary="=_mimegpg-kolivas.org-3942-1135224970-0001";
    micalg=pgp-sha1; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME GnuPG-signed message.  If you see this text, it means that
your E-mail or Usenet software does not support MIME signed messages.

--=_mimegpg-kolivas.org-3942-1135224970-0001
Content-Type: text/plain; format=flowed; charset="US-ASCII"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Jesper Juhl writes:

> On 12/15/05, Andrew Morton <akpm@osdl.org> wrote:
>>
> <!-- snip -->
>>
>> -mm-implement-swap-prefetching.patch
>> -mm-implement-swap-prefetching-default-y.patch
>> -mm-implement-swap-prefetching-tweaks.patch
>> -mm-implement-swap-prefetching-tweaks-2.patch
>> -mm-swap-prefetch-magnify.patch
>>
>>  Dropped swap prefetching, sorry.  I wasn't able to notice much benefit from
>>  it in my testing, and the number of mm/ patches in getting crazy, so we don't
>>  have capacity for speculative things at present.
>>
> <!-- snip -->
> 
> This is a bit sad.
> On my system (1.4GHz Athlon w/512MB RAM, 768MB swap) this did have an effect.
> One situation in particular where it helped (and which is a common
> case for me) was when I had OpenOffice2 + Eclipse (with CDT) + xchat +
> nedit + Firefox + a few konsole windows open (running KDE 3.5 btw and
> all apps usually have a lot of content loaded), minimized all the apps
> and then started an allyesconfig build in one window - the
> allyesconfig build would drag the machine to its knees and eat up more
> or less all RAM + swap, so I usually left it alone for a while to
> finish and when I then came back later and reactivated the apps I had
> minimized they came back pretty fast. Without the swap prefetch
> patches things come back somewhat slower - it's not an earth
> shattering difference, but it's definately noticable.

Apart from the feedback I've gotten directly from users of the -ck patchset 
incorporating this, Andrew and lkml has had very few reports about it until 
he decided to drop it. I'm still maintaining the code in -ck indefinitely 
for the moment. Here's hoping he picks it up again in the future.

Cheers,
Con


--=_mimegpg-kolivas.org-3942-1135224970-0001
Content-Type: application/pgp-signature
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBDqiiKZUg7+tp6mRURApPrAJ0Y0HGUBjb8bxA9xXpPsbhAMbhOeACdGrc6
8MpUlpwAB4hRAtBrBTE/HzM=
=UBNP
-----END PGP SIGNATURE-----

--=_mimegpg-kolivas.org-3942-1135224970-0001--
