Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293013AbSCGE6M>; Wed, 6 Mar 2002 23:58:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293210AbSCGE5x>; Wed, 6 Mar 2002 23:57:53 -0500
Received: from altus.drgw.net ([209.234.73.40]:24330 "EHLO altus.drgw.net")
	by vger.kernel.org with ESMTP id <S293013AbSCGE5l>;
	Wed, 6 Mar 2002 23:57:41 -0500
Date: Wed, 6 Mar 2002 22:56:52 -0600
From: Troy Benjegerdes <hozer@drgw.net>
To: Larry McVoy <lm@work.bitmover.com>, Tom Lord <lord@regexps.com>,
        linux-kernel@vger.kernel.org, davej@suse.de
Subject: Re: Why not an arch mirror for the kernel?
Message-ID: <20020306225652.Q1682@altus.drgw.net>
In-Reply-To: <200203071425.GAA06679@morrowfield.home> <20020306190419.E31751@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020306190419.E31751@work.bitmover.com>; from lm@bitmover.com on Wed, Mar 06, 2002 at 07:04:19PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I am working on some tools that will help to implement automatic,
> > incremental, bidirectional gateways between arch, Subversion, and Bk.
> 
> Gateways, yes, bidirectional, no.  Arch doesn't begin to maintain
> the metadata which BK maintains, so it can't begin to solve the
> same problems.  If you have a bidirectional gateway, you reduce BK
> to the level of arch or subversion, in which case, why use BK at all?
> If CVS/Arch/Subversion/whatever works for you, I'd say just use it and
> leave BK out of it.

Okay Larry, reality check here... 

We really *DO* need to have more than one source control system available 
for people to use.

So maybe Arch and Subversion don't maintain all the metadata BK maintains.  
That just means that the $OTHER_SCM->BK gateway process has some manual
involvement. This is no different conceptually than sending a 'plain old
patch' in email to $MAINTAINER. 

It is in everyone's best interest to make a functional *bidirectional* 
BK<->Arch gateway. (Including you Larry)

This keeps the all the open source zealots quiet, and reduces the support 
load of Bitmover to those people that actually *want* to use Larry's stuff 
because it's better, not those that use it now because there is no '90%' 
alternative.

I'd love to see Larry and Tom sit down in a room and come up with an 
*easy* way for $MAINTAINER to take patches from both Arch and BK. (I have 
only left Subversion out because I haven't seen anyone from the project 
take an interest in making changes for kernel developers)

Now, obviously, my time would have been a lot better spent actually 
working on this myself, but I have deadlines, and wouldn't have time to 
finish it right now. So, I'm trying to spread some sanity around in the 
hopes it is contagious. (doubtfull, but I suppose I'll try)

-- 
Troy Benjegerdes | master of mispeeling | 'da hozer' |  hozer@drgw.net
-----"If this message isn't misspelled, I didn't write it" -- Me -----
"Why do musicians compose symphonies and poets write poems? They do it
because life wouldn't have any meaning for them if they didn't. That's 
why I draw cartoons. It's my life." -- Charles Schulz
