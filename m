Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316667AbSEVSdJ>; Wed, 22 May 2002 14:33:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316643AbSEVSb5>; Wed, 22 May 2002 14:31:57 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:20486 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S316659AbSEVSas>; Wed, 22 May 2002 14:30:48 -0400
Date: Wed, 22 May 2002 15:30:00 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Linus Torvalds <torvalds@transmeta.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        William Lee Irwin III <wli@holomorphy.com>,
        "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
        "M. Edward Borasky" <znmeb@aracnet.com>,
        <linux-kernel@vger.kernel.org>, <andrea@suse.de>, <akpm@zip.com.au>
Subject: Re: Have the 2.4 kernel memory management problems on large machines
 been fixed?
In-Reply-To: <Pine.LNX.4.33.0205221048570.23621-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.44L.0205221528070.14140-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 May 2002, Linus Torvalds wrote:

> don't want to upgrade your CPU's, it's a _whole_ lot easier to just have a
> magic "map_large_page()" system call, and start using the 2MB page support
> of the x86.
>
> And no, this should NOT be a mmap.
>
> It's a magic x86-only system call,

> Making the _generic_ code jump through hoops because some stupid special
> case that nobody else is interested in is bad.

Actually, I suspect that MIPS, x86-64 and other
architectures are also interested ...

kind regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

