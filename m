Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131886AbRDSSOu>; Thu, 19 Apr 2001 14:14:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132318AbRDSSOk>; Thu, 19 Apr 2001 14:14:40 -0400
Received: from snark.tuxedo.org ([207.106.50.26]:48394 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S131886AbRDSSOV>;
	Thu, 19 Apr 2001 14:14:21 -0400
Date: Thu, 19 Apr 2001 14:14:25 -0400
From: "Eric S. Raymond" <esr@thyrsus.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Russell King <rmk@arm.linux.org.uk>, CML2 <linux-kernel@vger.kernel.org>,
        kbuild-devel@lists.sourceforge.net
Subject: Re: Dead symbol elimination, stage 1
Message-ID: <20010419141425.A4461@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Russell King <rmk@arm.linux.org.uk>,
	CML2 <linux-kernel@vger.kernel.org>,
	kbuild-devel@lists.sourceforge.net
In-Reply-To: <20010419135955.A3841@thyrsus.com> <20010419131944.A3049@thyrsus.com> <20010419184444.A3111@flint.arm.linux.org.uk> <20010419135955.A3841@thyrsus.com> <18282.987703518@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <18282.987703518@redhat.com>; from dwmw2@infradead.org on Thu, Apr 19, 2001 at 07:05:18PM +0100
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse <dwmw2@infradead.org>:
> 
> esr@thyrsus.com said:
> >  I read this as "I haven't fixed the problem because..."  not as
> > "Don't fix the problem."  Please be more explicit next time so I won't
> > step on your toes? 
> 
> "This is not a problem, please don't \"fix\" it".

But it is.  The more false positives I get in the dead-symbol reports,
the harder it will be to spot real problems like that business in the 
ARM kernel.c file.

I grant you this wasn't a problem before I wrote kxref.py, but it is
one now.  New tools create new opportunities, but they sometimes require
better discipline and working practices to be useful.  This is one of
those cases.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

"I hold it, that a little rebellion, now and then, is a good thing, and as 
necessary in the political world as storms in the physical."
	-- Thomas Jefferson, Letter to James Madison, January 30, 1787
