Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262006AbVA0SEJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262006AbVA0SEJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 13:04:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262681AbVA0SEJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 13:04:09 -0500
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:55778 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S262006AbVA0SEC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 13:04:02 -0500
Message-ID: <41F92D2B.4090302@comcast.net>
Date: Thu, 27 Jan 2005 13:04:27 -0500
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041211)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: linux-kernel@vger.kernel.org, akpm@osdl.org, torvalds@osdl.org
Subject: Re: Patch 4/6  randomize the stack pointer
References: <20050127101117.GA9760@infradead.org>	 <20050127101322.GE9760@infradead.org>  <41F92721.1030903@comcast.net> <1106848051.5624.110.camel@laptopd505.fenrus.org>
In-Reply-To: <1106848051.5624.110.camel@laptopd505.fenrus.org>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

What the hell?

So instead of bringing something in that works, you bring something in
that does significantly less, and gives no savings on overhead or patch
complexity why?  So you can later come out and say "We're so great now
we've increased the randomization by tweaking one variable aren't we
cool!!!"?

Red Hat is all smoke and mirrors anyway when it comes to security, just
like Microsoft.  This just reaffirms that.

Arjan van de Ven wrote:
> On Thu, 2005-01-27 at 12:38 -0500, John Richard Moser wrote:
> 
>>-----BEGIN PGP SIGNED MESSAGE-----
>>Hash: SHA1
>>
>>
>>
>>Arjan van de Ven wrote:
>>
>>>The patch below replaces the existing 8Kb randomisation of the userspace
>>>stack pointer (which is currently only done for Hyperthreaded P-IVs) with a 
>>>more general randomisation over a 64Kb range.
>>>
>>
>>64k of stack randomization is trivial to evade. 
> 
> 
> I think you're focussing on the 64k number WAY too much. Yes it's too
> small. But it's an initial number to show the infrastructure and get it
> tested. Yes it should and will be increased later on in the patch
> series.
> 
> Same for the other heap randomisation.
> 
> This thing is about getting the infrastructure in place and used. The
> actual numbers are mere finetuning that can be done near the end.
> 
> 
> 

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB+S0qhDd4aOud5P8RAquRAJ9FoWdhW6bpurTA6jObM6XEixTPFQCfbLvi
14Vp5H3Y//5kylroWGQRKek=
=o0Ra
-----END PGP SIGNATURE-----
