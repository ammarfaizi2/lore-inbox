Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265270AbUATAd0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 19:33:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263523AbUATA1x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 19:27:53 -0500
Received: from mtaw6.prodigy.net ([64.164.98.56]:11253 "EHLO mtaw6.prodigy.net")
	by vger.kernel.org with ESMTP id S263742AbUATAXq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 19:23:46 -0500
Date: Mon, 19 Jan 2004 16:23:38 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Luca Barbato <lu_zero@gentoo.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: gcloop: compressed loopback support for 2.6
Message-ID: <20040120002338.GV8664@srv-lnx2600.matchmail.com>
Mail-Followup-To: Luca Barbato <lu_zero@gentoo.org>,
	linux-kernel@vger.kernel.org
References: <3F5F4F96.4050000@gentoo.org> <400C05E1.70005@gentoo.org> <20040119164139.GR1748@srv-lnx2600.matchmail.com> <400C650C.1070303@gentoo.org> <20040119232538.GW1748@srv-lnx2600.matchmail.com> <400C6AA2.4000307@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <400C6AA2.4000307@gentoo.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >On Tue, Jan 20, 2004 at 12:15:24AM +0100, Luca Barbato wrote:
> >>gcloop isn't file format compatible with the old cloop-0.68 fileformat 
> >>since I had to use in a different way the index and I prefer ucl instead 
> >>of zlib.

> Mike Fedyk wrote:
> >Maybe you can merge ucl into cloop 2.x, and support both (one compression

On Tue, Jan 20, 2004 at 12:39:14AM +0100, Luca Barbato wrote:
> >scheme per image, of course) in the same codebase?
> gcloop supports arbitrary compressor you just have to make the cryptoapi 
> module of it, 

That's good.

> and obviously change the userspace tools, the only 

Hmm, so I presume that gcloop has its own userspace utilities...

> restraint is the file format, the changes I made are due the need to 
> avoid high penality on uncompressible blocks

Interesting.

> , with some effort I can 
> make the parser support all the formats (gcloop, cloop-0.68, 
> cloop-1.0/2.0) but would enlarge the code a bit or make it slower.

It would be good to have all of these competing formats handled, dicesions
on which format(s) should be used for future versions before it's integrated
into mainline.

> >
> >Has cloop been ported to 2.6?
> >
> not that I know.

Boooo, bad knoppix! ;)
