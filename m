Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261535AbVCNPQ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261535AbVCNPQ2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 10:16:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261536AbVCNPQ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 10:16:28 -0500
Received: from locomotive.csh.rit.edu ([129.21.60.149]:29718 "EHLO
	locomotive.unixthugs.org") by vger.kernel.org with ESMTP
	id S261535AbVCNPQX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 10:16:23 -0500
Message-ID: <4235AB83.90606@suse.com>
Date: Mon, 14 Mar 2005 10:19:31 -0500
From: Jeff Mahoney <jeffm@suse.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Segher Boessenkool <segher@kernel.crashing.org>, Olaf Hering <olh@suse.de>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 2/3] openfirmware: adds sysfs nodes for	openfirmware	devices
References: <20050301211824.GC16465@locomotive.unixthugs.org>	 <1109806334.5611.121.camel@gaston> <42275536.8060507@suse.com>	 <20050303202319.GA30183@suse.de> <42277ED8.6050500@suse.com>	 <b34edd09a60d945f41bbe123a8321f22@kernel.crashing.org>	 <1110808986.5863.2.camel@gaston>	 <0409878c894cf868678d8e5226e20c42@kernel.crashing.org> <1110812661.5863.7.camel@gaston>
In-Reply-To: <1110812661.5863.7.camel@gaston>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Bogosity: No, tests=bogofilter, spamicity=0.000000, version=0.92.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Benjamin Herrenschmidt wrote:
>>>Well, we have an unmaintained spec on one side that can't even be
>>>ordered from IEEE anymore and actual imlementations that work today,
>>>what do you chose ? ;)
>>
>>I choose the spec.  If an implementation is not conformant to the spec,
>>it doesn't "work".
>>
>>Not to say that Linux doesn't have to work around bugs in actual
>>implementations, of course.  And there's a lot of those.  Too bad ;-)
> 
> 
> Yah, well.. ok, let's say we have a spec... and an implementation that
> represents about 90% of the machines concerned. Those 90% have the
> "bug"... what do you chose ? :) 
> 
> The separator in "compatible", afaik, is \0, not space btw.
> 
> On possibiliy would be to have the kernel replace spaces with
> underscores for the sake of matching. That would make life easier for
> everybody.

I had suggested this a few days ago, but got no response. Can we agree
that this would be an acceptable solution?

- -Jeff

- --
Jeff Mahoney
SuSE Labs
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFCNauDLPWxlyuTD7IRAt+IAJ9mJRrrYT5trhv03qbGGPrwIwosqwCgpLS6
K/xQZE+dB4BPZc+R/FW74Nw=
=9Pgi
-----END PGP SIGNATURE-----
