Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291177AbSAaRgP>; Thu, 31 Jan 2002 12:36:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291178AbSAaRgH>; Thu, 31 Jan 2002 12:36:07 -0500
Received: from altus.drgw.net ([209.234.73.40]:23812 "EHLO altus.drgw.net")
	by vger.kernel.org with ESMTP id <S291174AbSAaRf4>;
	Thu, 31 Jan 2002 12:35:56 -0500
Date: Thu, 31 Jan 2002 11:35:10 -0600
From: Troy Benjegerdes <hozer@drgw.net>
To: Larry McVoy <lm@work.bitmover.com>, Rob Landley <landley@trommello.org>,
        Larry McVoy <lm@bitmover.com>, Alexander Viro <viro@math.psu.edu>,
        Linus Torvalds <torvalds@transmeta.com>,
        Eli Carter <eli.carter@inet.com>,
        Georg Nikodym <georgn@somanetworks.com>, Ingo Molnar <mingo@elte.hu>,
        Rik van Riel <riel@conectiva.com.br>,
        Tom Rini <trini@kernel.crashing.org>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: A modest proposal -- We need a patch penguin
Message-ID: <20020131113510.Z14339@altus.drgw.net>
In-Reply-To: <20020130195154.R22323@work.bitmover.com> <20020131002355.X14339@altus.drgw.net> <20020130223711.L18381@work.bitmover.com> <20020131074924.QZMB10685.femail14.sdc1.sfba.home.com@there> <20020131111337.Y14339@altus.drgw.net> <20020131091914.L1519@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020131091914.L1519@work.bitmover.com>; from lm@bitmover.com on Thu, Jan 31, 2002 at 09:19:14AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2002 at 09:19:14AM -0800, Larry McVoy wrote:
> On Thu, Jan 31, 2002 at 11:13:37AM -0600, Troy Benjegerdes wrote:
> > Can you detect the 'collapsed vs full version' thing, and force it to be 
> > a merge conflict? That, and working LOD support would probably get most 
> > of what I want (until I try the new version and find more stuff I want 
> > :P)
> 
> Are you sure you want that?  If so, that would work today, it's about a
> 20 line script.  You clone the tree, collapse all the stuff into a new
> changeset, and pull.  It will all automerge.  But now you have the detailed
> stuff and the non-detailed stuff in the same tree, which I doubt is what
> you want.  I thought the point was to remove information, not double it.

Well, what I meant was have some kind of pointer in the collapsed stuff 
that conflicts with the detailed stuff, and requires the user to pick 
which on they want. Ideally, this could default to user picks, but a 
repository policy of 'only take collapsed versions' could be used for 
upstream trees, say like linuxppc_2_4.  (linuxppc_2_4_devel could take 
detailed versions).

-- 
Troy Benjegerdes | master of mispeeling | 'da hozer' |  hozer@drgw.net
-----"If this message isn't misspelled, I didn't write it" -- Me -----
"Why do musicians compose symphonies and poets write poems? They do it
because life wouldn't have any meaning for them if they didn't. That's 
why I draw cartoons. It's my life." -- Charles Schulz
