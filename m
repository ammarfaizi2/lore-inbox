Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265414AbRFVNtB>; Fri, 22 Jun 2001 09:49:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265413AbRFVNsv>; Fri, 22 Jun 2001 09:48:51 -0400
Received: from snark.tuxedo.org ([207.106.50.26]:25096 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S265412AbRFVNse>;
	Fri, 22 Jun 2001 09:48:34 -0400
Date: Fri, 22 Jun 2001 09:51:59 -0400
From: "Eric S. Raymond" <esr@thyrsus.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Russell King <rmk@arm.linux.org.uk>, Nicolas Pitre <nico@cam.org>,
        CML2 <linux-kernel@vger.kernel.org>,
        kbuild-devel@lists.sourceforge.net
Subject: Re: Missing help entries in 2.4.6pre5
Message-ID: <20010622095159.B13075@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Russell King <rmk@arm.linux.org.uk>, Nicolas Pitre <nico@cam.org>,
	CML2 <linux-kernel@vger.kernel.org>,
	kbuild-devel@lists.sourceforge.net
In-Reply-To: <20010621185144.A8669@thyrsus.com> <20010621154934.A6582@thyrsus.com> <Pine.LNX.4.33.0106211812560.30096-100000@xanadu.home> <20010621234002.Z18978@flint.arm.linux.org.uk> <20010621185144.A8669@thyrsus.com> <8226.993198272@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <8226.993198272@redhat.com>; from dwmw2@infradead.org on Fri, Jun 22, 2001 at 09:24:32AM +0100
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse <dwmw2@infradead.org>:
> 
> esr@thyrsus.com said:
> >  I've done that in my rulesfile, thanks.  Here is the current list of
> > ignored symbols:
> 
> > derive CMDLINE_BOOL from n
>  ....etc...
> 
> 
> That'll nicely break oldconfig behaviour when the options in question do 
> get merged into the main tree, won't it?

Actually, what will happen is that when the symbol goes active and I know 
about it, I'll add a declaration to the symbols table.  Then, if I've
forgotten that I had the symbol on my ignore list, I'll get a compilation
error the next time I try to builsd a rulebase.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

A ``decay in the social contract'' is detectable; there is a growing
feeling, particularly among middle-income taxpayers, that they are not
getting back, from society and government, their money's worth for
taxes paid. The tendency is for taxpayers to try to take more control
of their finances ..
	-- IRS Strategic Plan, (May 1984)
