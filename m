Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265626AbSJRS5S>; Fri, 18 Oct 2002 14:57:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265624AbSJRS42>; Fri, 18 Oct 2002 14:56:28 -0400
Received: from mark.mielke.cc ([216.209.85.42]:9481 "EHLO mark.mielke.cc")
	by vger.kernel.org with ESMTP id <S265622AbSJRSza>;
	Fri, 18 Oct 2002 14:55:30 -0400
Date: Fri, 18 Oct 2002 15:00:16 -0400
From: Mark Mielke <mark@mark.mielke.cc>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: John Myers <jgmyers@netscape.com>, Dan Kegel <dank@kegel.com>,
       Davide Libenzi <davidel@xmailserver.org>,
       Benjamin LaHaise <bcrl@redhat.com>,
       Shailabh Nagar <nagar@watson.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-aio <linux-aio@kvack.org>, Andrew Morton <akpm@digeo.com>,
       David Miller <davem@redhat.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Stephen Tweedie <sct@redhat.com>
Subject: Re: epoll (was Re: [PATCH] async poll for 2.5)
Message-ID: <20021018190016.GB14087@mark.mielke.cc>
References: <Pine.LNX.4.44.0210151403370.1554-100000@blue1.dev.mcafeelabs.com> <3DAC9035.2010208@netscape.com> <3DADC5F8.60708@kegel.com> <3DAEF6DC.9000708@netscape.com> <20021018170024.GA13087@mark.mielke.cc> <3DB05918.40204@nortelnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DB05918.40204@nortelnetworks.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2002 at 02:55:20PM -0400, Chris Friesen wrote:
> Mark Mielke wrote:
> >I find myself still not understanding this thread. Lots of examples of
> The main point here is determining which of many open connections need 
> servicing.

> select() and poll() do not scale well, so this is where stuff like 
> /dev/epoll comes in--to tell you which of those file descriptors need to be 
> serviced.

I know what the point is, and I know the concept behind /dev/epoll.

I'm speaking more about the snippets of code that fail to show the
real benefits of /dev/epoll, and the following discussion about which
snippet is better than which other snippet.

mark

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/

