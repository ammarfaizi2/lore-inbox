Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284366AbRL1XUi>; Fri, 28 Dec 2001 18:20:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284506AbRL1XUb>; Fri, 28 Dec 2001 18:20:31 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:60123
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S284445AbRL1XUS>; Fri, 28 Dec 2001 18:20:18 -0500
Date: Fri, 28 Dec 2001 18:04:28 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Legacy Fishtank <garzik@havoc.gtf.org>,
        Linus Torvalds <torvalds@transmeta.com>, Dave Jones <davej@suse.de>,
        "Eric S. Raymond" <esr@snark.thyrsus.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: State of the new config & build system
Message-ID: <20011228180428.F20254@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Legacy Fishtank <garzik@havoc.gtf.org>,
	Linus Torvalds <torvalds@transmeta.com>, Dave Jones <davej@suse.de>,
	"Eric S. Raymond" <esr@snark.thyrsus.com>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
In-Reply-To: <20011228154537.E17774@thyrsus.com> <E16K6BQ-00029u-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E16K6BQ-00029u-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Fri, Dec 28, 2001 at 11:13:00PM +0000
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk>:
> > I'd be happy to take another swing at this problem once the kbuild-2.5/CML2
> > transition is done.  But I don't think we should let it block us from
> > having the good results we can get from that change.
> 
> It would certainly fit nicely with the existing metadata. We already rip out
> code comments via kernel-doc, and extending it to rip out
> 
> 	-	Help text
> 	-	Web site
> 	-	Version information
> 	-	Man page for the driver
> 	-	Module options
> 
> etc, shouldn't be too challenging. Ok so kernel-doc is in perl and ugly perl
> but if someone hates it enough to rewrite it in python thats a win too 8)

I've been thinking about doing that very thing anyway.  Part of my master
plan to reduce the tree's external dependencies.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

I do not find in orthodox Christianity one redeeming feature.
	-- Thomas Jefferson
