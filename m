Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316675AbSEVSuD>; Wed, 22 May 2002 14:50:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316680AbSEVSuC>; Wed, 22 May 2002 14:50:02 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:18640 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S316675AbSEVSuA>;
	Wed, 22 May 2002 14:50:00 -0400
Date: Wed, 22 May 2002 11:48:00 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Rik van Riel <riel@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        William Lee Irwin III <wli@holomorphy.com>,
        "M. Edward Borasky" <znmeb@aracnet.com>, linux-kernel@vger.kernel.org,
        andrea@suse.de, akpm@zip.com.au
Subject: Re: Have the 2.4 kernel memory management problems on large machines been fixed?
Message-ID: <372130000.1022093280@flay>
In-Reply-To: <Pine.LNX.4.44L.0205221528070.14140-100000@imladris.surriel.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> don't want to upgrade your CPU's, it's a _whole_ lot easier to just have a
>> magic "map_large_page()" system call, and start using the 2MB page support
>> of the x86.
>> 
>> And no, this should NOT be a mmap.
>> 
>> It's a magic x86-only system call,
> 
>> Making the _generic_ code jump through hoops because some stupid special
>> case that nobody else is interested in is bad.
> 
> Actually, I suspect that MIPS, x86-64 and other
> architectures are also interested ...

Indeed. Even if you happen to have a spare 10Gb of RAM, and can address it
efficiently, that's still no reason to blow it on mindless copies of data ;-)

M.

