Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751498AbWAFPDe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751498AbWAFPDe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 10:03:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751497AbWAFPDe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 10:03:34 -0500
Received: from mxfep01.bredband.com ([195.54.107.70]:1457 "EHLO
	mxfep01.bredband.com") by vger.kernel.org with ESMTP
	id S1751494AbWAFPDd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 10:03:33 -0500
Message-ID: <43BE86BE.3010203@stesmi.com>
Date: Fri, 06 Jan 2006 16:03:26 +0100
From: Stefan Smietanowski <stesmi@stesmi.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hannu Savolainen <hannu@opensound.com>
CC: Lee Revell <rlrevell@joe-job.com>, Takashi Iwai <tiwai@suse.de>,
       linux-sound@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [OT] ALSA userspace API complexity
References: <20050726150837.GT3160@stusta.de>  <20060103193736.GG3831@stusta.de>  <Pine.BSO.4.63.0601032210380.29027@rudy.mif.pg.gda.pl>  <mailman.1136368805.14661.linux-kernel2news@redhat.com>  <20060104030034.6b780485.zaitcev@redhat.com>  <Pine.LNX.4.61.0601041220450.9321@tm8103.perex-int.cz>  <Pine.BSO.4.63.0601051253550.17086@rudy.mif.pg.gda.pl>  <Pine.LNX.4.61.0601051305240.10350@tm8103.perex-int.cz>  <Pine.BSO.4.63.0601051345100.17086@rudy.mif.pg.gda.pl>  <s5hmziaird8.wl%tiwai@suse.de>  <Pine.LNX.4.61.0601060028310.27932@zeus.compusonic.fi> <1136504460.847.91.camel@mindpipe> <Pine.LNX.4.61.0601060156430.27932@zeus.compusonic.fi>
In-Reply-To: <Pine.LNX.4.61.0601060156430.27932@zeus.compusonic.fi>
X-Enigmail-Version: 0.93.0.0
Content-Type: multipart/signed; micalg=pgp-ripemd160;
 protocol="application/pgp-signature";
 boundary="------------enig9B277B93160D1B757F2CDE18"
X-AntiVirus: checked by Vexira Milter 1.0.7; VAE 6.29.0.5; VDF 6.29.0.100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig9B277B93160D1B757F2CDE18
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hannu Savolainen wrote:
> On Thu, 5 Jan 2006, Lee Revell wrote:
> 
> 
>>On Fri, 2006-01-06 at 01:06 +0200, Hannu Savolainen wrote:
>>
>>>We have not received any single bug report that is caused 
>>>by the concept of kernel mixing.
>>>Kernel mixing is not rocket science. All you need to do is picking a 
>>>sample from the output buffers of each of the applications, sum them 
>>>together (with some volume scaling) and feed the result to the
>>>physical 
>>>device. 
>>
>>Hey, interesting, this is exactly what dmix does in userspace.  And we
>>have not seen any bug reports caused by the concept of userspace mixing
>>(just implementation bugs like any piece of software).
> 
> Having dmix working in user space doesn't prove that kernel level mixing 
> is evil. This was the original topic.

Wasn't there a thread a few years ago (3-5?) about sound mixing in the
kernel?

I've tried searching for it but have been unsuccessful so I could be
remembering wrong.

I can't remember if it was about OSS, ALSA or anything else but I
believe the conclusion was that sound mixing does NOT belong in the
kernel and SHOULD be done in userspace. I have a faint memory of that
being written by Alan Cox, but since it was a while ago I could very
well be mistaken there (too?).

// Stefan

--------------enig9B277B93160D1B757F2CDE18
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFDvobBBrn2kJu9P78RAykCAKCiyP/4h/9Hfm32u234hOkDAQqRXACdHb0t
wxf3EgLQpV+ZoI259URZcRU=
=Gg3n
-----END PGP SIGNATURE-----

--------------enig9B277B93160D1B757F2CDE18--
