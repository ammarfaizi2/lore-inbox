Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315468AbSEMCCZ>; Sun, 12 May 2002 22:02:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315471AbSEMCCX>; Sun, 12 May 2002 22:02:23 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:26386 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S315468AbSEMCCR>; Sun, 12 May 2002 22:02:17 -0400
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: Changelogs on kernel.org
Date: Mon, 13 May 2002 02:01:45 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <abn6q9$umv$1@penguin.transmeta.com>
In-Reply-To: <20020512010709.7a973fac.spyro@armlinux.org> <abmi0f$ugh$1@penguin.transmeta.com> <873cwx2hi4.fsf@CERT.Uni-Stuttgart.DE>
X-Trace: palladium.transmeta.com 1021255325 6285 127.0.0.1 (13 May 2002 02:02:05 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 13 May 2002 02:02:05 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <873cwx2hi4.fsf@CERT.Uni-Stuttgart.DE>,
Florian Weimer  <Weimer@CERT.Uni-Stuttgart.DE> wrote:
>
>For your example, the result is:
>
><jsimmons@heisenberg.transvirtual.com>
>        A bunch of fixes.
>
>        Pmac updates
>
>        Some more small fixes.
>
><rmk@arm.linux.org.uk>
>        [PATCH] 2.5.13: vmalloc link failure
>        
>        The following patch fixes this, and also fixes the similar problem in
>        scsi_debug.c:
>
><trond.myklebust@fys.uio.no>
>        [PATCH] in_ntoa link failure
>        
>        Nothing serious. Whoever it was that did that global replacemissed a
>        spot is all...
>
><viro@math.psu.edu>
>        [PATCH] change_floppy() fix
>        
>        Needed both in 2.4 and 2.5
>
>
>IMHO, it doesn't make much sense.

It doesn't make much sense that way, but if you also made the
descriptions shorter (first line only) _and_ then packed them, it would
give a much denser overview. Oh, and remove any [PATCH] marker: I just
use them to keep track of which were imported as email-patches vs which
were done "natively" with BK..

So you'd have something like:

	jsimmons@heisenberg.transvirtual.com:
		A bunch of fixes.
		Pmac updates
		Some more small fixes.

	rmk@arm.linux.org.uk:
		2.5.13: vmalloc link failure

	trond.myklebust@fys.uio.no:
		in_ntoa link failure

	viro@math.psu.edu:
		change_floppy() fix

which I could more easily post to linux-kernel (possibly after some
minor hand-editing) because it wouldn't end up being 20kB worth of text
that not everybody is interested in reading. 

Hmm?

		Linus
