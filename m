Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261499AbVAMUCP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261499AbVAMUCP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 15:02:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261498AbVAMT7Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 14:59:16 -0500
Received: from sccrmhc12.comcast.net ([204.127.202.56]:32662 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261496AbVAMT5Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 14:57:16 -0500
Message-ID: <41E6D2AD.9070203@comcast.net>
Date: Thu, 13 Jan 2005 14:57:33 -0500
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041211)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Christoph Hellwig <hch@infradead.org>,
       Dave Jones <davej@redhat.com>, Andrew Morton <akpm@osdl.org>,
       marcelo.tosatti@cyclades.com, Greg KH <greg@kroah.com>, chrisw@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: thoughts on kernel security issues
References: <Pine.LNX.4.58.0501121002200.2310@ppc970.osdl.org>  <20050112185133.GA10687@kroah.com>  <Pine.LNX.4.58.0501121058120.2310@ppc970.osdl.org>  <20050112161227.GF32024@logos.cnet>  <Pine.LNX.4.58.0501121148240.2310@ppc970.osdl.org>  <20050112205350.GM24518@redhat.com>  <Pine.LNX.4.58.0501121750470.2310@ppc970.osdl.org>  <20050112182838.2aa7eec2.akpm@osdl.org> <20050113033542.GC1212@redhat.com>  <Pine.LNX.4.58.0501122025140.2310@ppc970.osdl.org>  <20050113082320.GB18685@infradead.org>  <Pine.LNX.4.58.0501130822280.2310@ppc970.osdl.org> <1105632757.4624.59.camel@localhost.localdomain> <Pine.LNX.4.58.0501130926260.2310@ppc970.osdl.org> <41E6C507.5050302@comcast.net> <Pine.LNX.4.58.0501131142500.2310@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0501131142500.2310@ppc970.osdl.org>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Linus Torvalds wrote:
> 
> On Thu, 13 Jan 2005, John Richard Moser wrote:
> 
>>>So all security issues are about balancing cost vs gain. I'm convinced
>>>that the gain from openness is higher than the cost. Others will disagree.  
>>
>>Yes.  Nobody code audits your binaries.  You need source code to do
>>source code auditing.  :)
> 
> 
> Oh, it's very clear that some exploits have definitely been written by
> looking at the source code with automated tools or by instrumenting
> things, and that the exploits would likely have never been found without
> source code. That's fine. We just have higher requirements in the open
> source community.

Yeah but malicious people are more determined than whitehats and
greyhats.  If I'm trying to find bugs to help you fix them, I'm not
going to waste my time on running your binaries through a debugger.  If
I want to use your machine as a sock puppet to attack SCO, then maybe.

In contrast, if I've got a good background in programming and want to
help you find and fix security bugs, it's not that big a deal for me to
brush over your source code.  If I'm just in there to improve it or add
new features, I might even ACCIDENTALLY stumble over something.  This is
where OSS becomes more secure :)

I think we're on the same page, Linus :)

> 
> And I do think that the same is true for being open about security
> advisories: I think that to offset an open security list, we'd have to
> then have more "best practices" than a vendor-sec-type closed security
> list might need. I think it would be worth it.
> 

It'd need control.  You can start an open security advisory list if you
like, but don't just flip off the vendors who want to keep their
security advisories quiet until they have a fix.

Aside from that, go for it.

> 			Linus
> 

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB5tKshDd4aOud5P8RApj6AJ41VAxD5SDTzLJZGX6K0OfOjhh4iQCfRHPC
c9zacuxvB3/gPlXMCZklyso=
=C7LA
-----END PGP SIGNATURE-----
