Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287037AbSABWWe>; Wed, 2 Jan 2002 17:22:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287029AbSABWWP>; Wed, 2 Jan 2002 17:22:15 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:58243
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S287027AbSABWWA>; Wed, 2 Jan 2002 17:22:00 -0500
Date: Wed, 2 Jan 2002 17:08:33 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Dave Jones <davej@suse.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: ISA slot detection on PCI systems?
Message-ID: <20020102170833.A17655@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Dave Jones <davej@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <20020102164757.A16976@thyrsus.com> <Pine.LNX.4.33.0201022305090.427-100000@Appserv.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0201022305090.427-100000@Appserv.suse.de>; from davej@suse.de on Wed, Jan 02, 2002 at 11:12:44PM +0100
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones <davej@suse.de>:
> Someone building a new kernel for a box (ie administrator) will have
> root priveledges. Though running 'make guessconfig' or whatever as
> root would suck.

Yeah, that's my point.  Saying "just make it suid" is not a good answer, 
because it ignores the fact that smart sysdamins don't want to run suid
programs more than absolutely necessary.  Not to mention screwing people
who follow Linus's good advice and configure/build kernels as non-root.
 
> > There is already stuff in /proc that seems to be there for precisely this
> > reason.  So /proc/dmi would hardly be a violation of norms.
> 
> Just because its a shitbucket, doesn't mean we should keep adding to it.
> It's become the dumping ground for so much crap that just doesn't need to
> be there.

But this is not a bad reason.  Allowing people to avoid running suid 
programs is a *good* reason.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

Nearly all men can stand adversity, but if you want to test a man's character,
give him power.
	-- Abraham Lincoln
