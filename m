Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135937AbRDTOUm>; Fri, 20 Apr 2001 10:20:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135938AbRDTOUc>; Fri, 20 Apr 2001 10:20:32 -0400
Received: from snark.tuxedo.org ([207.106.50.26]:32016 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S135937AbRDTOU0>;
	Fri, 20 Apr 2001 10:20:26 -0400
Date: Fri, 20 Apr 2001 10:19:51 -0400
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "Albert D. Cahalan" <acahalan@cs.uml.edu>,
        Matthew Wilcox <willy@ldl.fc.hp.com>,
        james rich <james.rich@m.cc.utah.edu>, linux-kernel@vger.kernel.org,
        parisc-linux@parisc-linux.org
Subject: Re: [parisc-linux] Re: OK, let's try cleaning up another nit. Is anyone paying attention?
Message-ID: <20010420101951.A6011@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	"Albert D. Cahalan" <acahalan@cs.uml.edu>,
	Matthew Wilcox <willy@ldl.fc.hp.com>,
	james rich <james.rich@m.cc.utah.edu>, linux-kernel@vger.kernel.org,
	parisc-linux@parisc-linux.org
In-Reply-To: <20010420095302.A5674@thyrsus.com> <E14qbV6-0001KI-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E14qbV6-0001KI-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Fri, Apr 20, 2001 at 03:03:06PM +0100
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk>:
> People send batches of small fixes to Linus or to me. So for example
> the S/390 folks send me things like 'fix the mm layer to match the
> changes in 2.4.3' and 'Update the DASD storage driver'. Each of
> which fixes one thing or one set of things and is easy to check on
> its own

I'll continue asking stupid questions, then.  Like, under this system how
can either you or the port maintainers maintain a good representation of 
how far out of sync they are with the main tree?

The implied workflow (developers in general, up to port maintainers,
up to you and Linus) makes both technological and sociological sense.
It kind of reminds me of Anglo-Norman feudalism post-1066 ("No lord
without land, no land without a lord.").

There are a couple of funny edge cases that it doesn't seem to handle
well, though.  One is the kind I'm bumping into right now, where
somebody legitimately needs to make small (almost trivial) changes
scattered all through the tree.

Another is the case where a piece of code that needs to be changed doesn't
have an active maintainer for a third party like me to go to.

What's the neighborly way to deal with these?
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

"The best we can hope for concerning the people at large is that they be
properly armed."
        -- Alexander Hamilton, The Federalist Papers at 184-188
