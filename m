Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291421AbSBHFa4>; Fri, 8 Feb 2002 00:30:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291426AbSBHFar>; Fri, 8 Feb 2002 00:30:47 -0500
Received: from altus.drgw.net ([209.234.73.40]:61956 "EHLO altus.drgw.net")
	by vger.kernel.org with ESMTP id <S291421AbSBHFaa>;
	Fri, 8 Feb 2002 00:30:30 -0500
Date: Thu, 7 Feb 2002 23:28:58 -0600
From: Troy Benjegerdes <hozer@drgw.net>
To: Larry McVoy <lm@work.bitmover.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Stelian Pop <stelian.pop@fr.alcove.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-2.5.4-pre1 - bitkeeper testing
Message-ID: <20020207232858.M17426@altus.drgw.net>
In-Reply-To: <20020207080714.GA10860@come.alcove-fr> <Pine.LNX.4.33.0202070833400.2269-100000@athlon.transmeta.com> <20020207092640.P27932@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020207092640.P27932@work.bitmover.com>; from lm@bitmover.com on Thu, Feb 07, 2002 at 09:26:40AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 07, 2002 at 09:26:40AM -0800, Larry McVoy wrote:
> On Thu, Feb 07, 2002 at 08:36:20AM -0800, Linus Torvalds wrote:
> > > What about people who send you occasionnal patches, and happen to
> > > be using Bitkeeper too ?
> > 
> > For those people, "bk send -d torvalds@transmeta.com" is fine. It ends up
> 
> No!  This will send the entire repository.  Do a "bk help send", you probably
> want "bk send -d -r+ torvalds@transmeta.com" to send the most recent cset.

Larry, I think this means you should change the default behavior of 'bk 
send' to ask the user what the hell they are smoking if they the patch to 
be sent is larger than say, oh 200k.

I got clobbered by this a couple of times trying to get someone to 'bk 
send' me a patch.

I got burned enough times to just decide never to use it again.

Either remove 'bk send' or at least warn us before we shoot off a foot.

Ideally, this should ask what changesets you want to send, and what 
public tree to look at to see *what* makes sense to send.

-- 
Troy Benjegerdes | master of mispeeling | 'da hozer' |  hozer@drgw.net
-----"If this message isn't misspelled, I didn't write it" -- Me -----
"Why do musicians compose symphonies and poets write poems? They do it
because life wouldn't have any meaning for them if they didn't. That's 
why I draw cartoons. It's my life." -- Charles Schulz
