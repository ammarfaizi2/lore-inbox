Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264269AbTLBAYz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Dec 2003 19:24:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264270AbTLBAYz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Dec 2003 19:24:55 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:28708 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id S264269AbTLBAYx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Dec 2003 19:24:53 -0500
Date: Tue, 2 Dec 2003 11:23:47 +1100
From: Nathan Scott <nathans@sgi.com>
To: Larry McVoy <lm@work.bitmover.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Re: XFS for 2.4
Message-ID: <20031202002347.GD621@frodo>
References: <20031201062052.GA2022@frodo> <Pine.LNX.4.44.0312011202330.13692-100000@logos.cnet> <20031201221058.GA621@frodo> <20031201222025.GA6152@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20031201222025.GA6152@work.bitmover.com>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Larry,

On Mon, Dec 01, 2003 at 02:20:25PM -0800, Larry McVoy wrote:
> 
> I have no idea if XFS should or should not go in, I'm not commenting on that.
> 
> However, having a bunch of XFS users say "put it in" when the maintainer
> said no, DaveM said no, and no other file system people seem to be
> stepping up to the bat with a review and a nod seems wrong.  

I must have missed that mail from Dave - or perhaps its still
in flight to me.  If you're refering to his "super-maintainence
mode" comment, I don't believe there was any specific comments
relating to XFS there (and XFS on 2.4 is in maintenance mode,
has been for a long time).

I also have mail from Marcelo saying he would look at merging XFS
in 2.4.24-pre (back when we last sent it, in 2.4.23-pre) ... so,
obviously I'm a little confused by this turn of events.

> Have you spoken with the people who maintain the generic parts of the
> VFS layer that you want to change?  If those people were in the list of
> people saying "XFS should go in" then I think you'd get a lot farther.

That level of discussion with other kernel coders, and extensive
review _has_ happened, in many cases _years_ ago now - this stuff
has all been merged in 2.5 for ages.  I wouldn't expect discussion
from other filesystem people at this stage - it is all old news to
them.

> ... the people who maintain those interfaces which
> are generic should make that decision.  Don't you agree?

Of course, and they have agreed that these are the way the changes
should be made - if you look at 2.6 you will see these changes all
merged there, a long time ago.  As I said, there is nothing new or
surprising here, and the changes are small and such that the other
filesystems are unaffected.

cheers.

-- 
Nathan
