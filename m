Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290494AbSAYB7x>; Thu, 24 Jan 2002 20:59:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290495AbSAYB7e>; Thu, 24 Jan 2002 20:59:34 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:10756 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S290494AbSAYB71>;
	Thu, 24 Jan 2002 20:59:27 -0500
Date: Thu, 24 Jan 2002 22:29:53 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: <rwhron@earthlink.net>
Cc: Daniel Phillips <phillips@bonn-fries.net>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.18pre4aa1
In-Reply-To: <20020124191927.A809@earthlink.net>
Message-ID: <Pine.LNX.4.33L.0201242226360.32617-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Jan 2002 rwhron@earthlink.net wrote:

> > > http://home.earthlink.net/~rwhron/kernel/k6-2-475.html
> >
> > Even when mostly uncached, dbench still produces flaky results.

> Below are results from a couple of aa releases, and a few rmap
> releases.

  [snip results:  -aa twice as fast as -rmap for dbench,
                  -rmap twice as fast as -aa for tiobench]

What would be interesting here are the dbench dots, where
a '+' indicates that a program exits.

It's possible that under one of the kernels the programs
are getting throttled differently and some of the dbench
processes exit _way_ earlier than the others, leaving a
much lighter load on the rest of the system for the second
part of the test.

It would be interesting to see the dbench dots from both
-aa and -rmap ;)

regards,

Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/

