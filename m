Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286662AbRL1Bhw>; Thu, 27 Dec 2001 20:37:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286660AbRL1Bhh>; Thu, 27 Dec 2001 20:37:37 -0500
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:3728 "EHLO
	opus.bloom.county") by vger.kernel.org with ESMTP
	id <S286649AbRL1BhW>; Thu, 27 Dec 2001 20:37:22 -0500
Date: Thu, 27 Dec 2001 18:36:54 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Dave Jones <davej@suse.de>
Cc: "Eric S. Raymond" <esr@thyrsus.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kbuild-devel@lists.sourceforge.net
Subject: Re: [kbuild-devel] Re: State of the new config & build system
Message-ID: <20011228013654.GK712@cpe-24-221-152-185.az.sprintbbd.net>
In-Reply-To: <20011227195738.A26889@thyrsus.com> <Pine.LNX.4.33.0112280219090.18346-100000@Appserv.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0112280219090.18346-100000@Appserv.suse.de>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 28, 2001 at 02:22:01AM +0100, Dave Jones wrote:
> On Thu, 27 Dec 2001, Eric S. Raymond wrote:
> 
> > That is such an unutterably horrible concept that the very tentacles
> > of Cthulhu himself must twitch in dread at the thought.  The last thing
> > anyone sane wants to do is have to maintain two parallel build systems
> > at the same time.
> 
> Funny, I could have sworn I read this was Keith's intention at least
> for a few pre's. Maybe I misinterpreted his intentions.

I think Keith wanted a very small time window tho (~24 hrs, barring big
supprises).  But if we're going to be worried about the build time,
kbuild-2.5 and cml2 aren't co-dependant, yes?  I know kbuild-2.5 works
w/o cml2, and last I tried (ages ago admitedly) cml2 didn't need
kbuild-2.5.  So we could, in theory dump cml1 quickly but leave the old
Makefiles for a bit longer.  Or if Keith thinks he can start on the
speed problems soon, just plod along for a few releases. :)

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
