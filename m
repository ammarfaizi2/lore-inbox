Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265501AbRFVT5G>; Fri, 22 Jun 2001 15:57:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265502AbRFVT44>; Fri, 22 Jun 2001 15:56:56 -0400
Received: from snark.tuxedo.org ([207.106.50.26]:57866 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S265501AbRFVT4r>;
	Fri, 22 Jun 2001 15:56:47 -0400
Date: Fri, 22 Jun 2001 16:00:02 -0400
From: "Eric S. Raymond" <esr@thyrsus.com>
To: "Holzrichter, Bruce" <bruce.holzrichter@monster.com>
Cc: David Woodhouse <dwmw2@infradead.org>, Russell King <rmk@arm.linux.org.uk>,
        linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Maintainers master list?
Message-ID: <20010622160002.B16285@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	"Holzrichter, Bruce" <bruce.holzrichter@monster.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org,
	kbuild-devel@lists.sourceforge.net
In-Reply-To: <3AB544CBBBE7BF428DA7DBEA1B85C79C9B6BEA@nocmail.ma.tmpw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3AB544CBBBE7BF428DA7DBEA1B85C79C9B6BEA@nocmail.ma.tmpw.net>; from bruce.holzrichter@monster.com on Fri, Jun 22, 2001 at 10:47:03AM -0400
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Holzrichter, Bruce <bruce.holzrichter@monster.com>:
> Now that sounds like a credible idea.  Would it be possible to set up a LK
> maintainers master list, and host from www.kernel.org or somewhere (Not
> knowing anyone at kernel.org, I can't speak for them.) that could be linked
> from sites, and have one person or maintainer in charge of keeping track of
> who is in charge of maintaining what.  This could be a point of contact for
> issues like this, and where they can be addressed.  It would be a large
> administrative project, but could be a point of help for some of us who are
> not quite capable of real kernel level hacking yet :o)

I think maintaining such a list separately from the kernel sources themselves
will just be asking for extra work and for the database to drift out of sync
with reality.

I have proposed that the MAINTAINERS file should be replaced by
metadata markup in the kernel sources themselves, distributed so that
it will naturally be kept up to date by the people named in it and
mechanically gathered into a generated MAINTAINERS at make dep time.

I still think this is the right thing, and was planning to revisit the 
issue after the 2.5 cutover.  But it certainly doesn't have to be me that
does it, and between CML2 and the Configure.help file and countering 
Microsoft's anti-open-source propaganda war I have plenty of other things
to worry about.  

So if you want to take this on, I encourage you to go to it.  Want a
copy of the metadata schema I wrote up?
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

"The power to tax involves the power to destroy;...the power to
destroy may defeat and render useless the power to create...."
	-- Chief Justice John Marshall, 1819.
