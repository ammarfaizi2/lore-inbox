Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265536AbSJSGxJ>; Sat, 19 Oct 2002 02:53:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265538AbSJSGxJ>; Sat, 19 Oct 2002 02:53:09 -0400
Received: from mark.mielke.cc ([216.209.85.42]:29962 "EHLO mark.mielke.cc")
	by vger.kernel.org with ESMTP id <S265536AbSJSGxI>;
	Sat, 19 Oct 2002 02:53:08 -0400
Date: Sat, 19 Oct 2002 02:59:16 -0400
From: Mark Mielke <mark@mark.mielke.cc>
To: John Myers <jgmyers@netscape.com>
Cc: Davide Libenzi <davidel@xmailserver.org>,
       Benjamin LaHaise <bcrl@redhat.com>, Dan Kegel <dank@kegel.com>,
       Shailabh Nagar <nagar@watson.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-aio <linux-aio@kvack.org>, Andrew Morton <akpm@digeo.com>,
       David Miller <davem@redhat.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Stephen Tweedie <sct@redhat.com>
Subject: Re: epoll (was Re: [PATCH] async poll for 2.5)
Message-ID: <20021019065916.GB17553@mark.mielke.cc>
References: <Pine.LNX.4.44.0210181241300.1537-100000@blue1.dev.mcafeelabs.com> <3DB0AD79.30401@netscape.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DB0AD79.30401@netscape.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2002 at 05:55:21PM -0700, John Myers wrote:
> So whether or not a proposed set of epoll semantics is consistent with 
> your Platonic ideal of "use the fd until EAGAIN" is simply not an issue. 
> What matters is what works best in practice.

>From this side of the fence: One vote for "use the fd until EAGAIN" being
flawed. If I wanted a method of monopolizing the event loop with real time
priorities, I would implement real time priorities within the event loop.

mark

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/

