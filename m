Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318285AbSHPJ7x>; Fri, 16 Aug 2002 05:59:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318281AbSHPJ7w>; Fri, 16 Aug 2002 05:59:52 -0400
Received: from [195.223.140.120] ([195.223.140.120]:28170 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S318285AbSHPJ7w>; Fri, 16 Aug 2002 05:59:52 -0400
Date: Fri, 16 Aug 2002 12:03:34 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Suparna Bhattacharya <suparna@in.ibm.com>
Cc: Benjamin LaHaise <bcrl@redhat.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Chris Friesen <cfriesen@nortelnetworks.com>,
       Pavel Machek <pavel@elf.ucw.cz>, linux-kernel@vger.kernel.org,
       linux-aio@kvack.org
Subject: Re: aio-core why not using SuS? [Re: [rfc] aio-core for 2.5.29 (Re: async-io API registration for 2.5.29)]
Message-ID: <20020816100334.GP14394@dualathlon.random>
References: <1028223041.14865.80.camel@irongate.swansea.linux.org.uk> <Pine.LNX.4.44.0208010924050.14765-100000@home.transmeta.com> <20020801140112.G21032@redhat.com> <20020815235459.GG14394@dualathlon.random> <20020815214225.H29874@redhat.com> <20020816150945.A1832@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020816150945.A1832@in.ibm.com>
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 16, 2002 at 03:09:46PM +0530, Suparna Bhattacharya wrote:
> Also, wasn't the fact that the API was designed to support both POSIX 
> and completion port style semantics, another reason for a different 
> (lightweight) in-kernel api? The c10k users of aio are likely to find 
> the latter model (i.e.  completion ports) more efficient.

if it's handy for you, can you post a link to the API defined by
POSIX and completion ports so I can read them too and not only SuS?

btw, I don't see why there are so many API doing the same thing, I think
for the goodness of linux it would be nice to standardize and recommend
one of these user API so new software will use the API we recommend now,
rather than choosing almost randomly every time. So the rest will be
backwards compatibilty stuff for apps ported from other OS, and it will
be worthwhile to have the kernel API to match what we recommend as user
API.

Andrea
