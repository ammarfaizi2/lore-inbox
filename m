Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265534AbSJSGuV>; Sat, 19 Oct 2002 02:50:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265536AbSJSGuU>; Sat, 19 Oct 2002 02:50:20 -0400
Received: from findaloan-online.cc ([216.209.85.42]:26890 "EHLO mark.mielke.cc")
	by vger.kernel.org with ESMTP id <S265534AbSJSGuU>;
	Sat, 19 Oct 2002 02:50:20 -0400
Date: Sat, 19 Oct 2002 02:56:24 -0400
From: Mark Mielke <mark@mark.mielke.cc>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Dan Kegel <dank@kegel.com>, John Myers <jgmyers@netscape.com>,
       Benjamin LaHaise <bcrl@redhat.com>,
       Shailabh Nagar <nagar@watson.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-aio <linux-aio@kvack.org>, Andrew Morton <akpm@digeo.com>,
       David Miller <davem@redhat.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Stephen Tweedie <sct@redhat.com>
Subject: Re: epoll (was Re: [PATCH] async poll for 2.5)
Message-ID: <20021019065624.GA17553@mark.mielke.cc>
References: <20021018185528.GC13876@mark.mielke.cc> <Pine.LNX.4.44.0210181209510.1537-100000@blue1.dev.mcafeelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0210181209510.1537-100000@blue1.dev.mcafeelabs.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2002 at 12:16:48PM -0700, Davide Libenzi wrote:
> These functions are taken from the really simple example http server used
> to test/compare /dev/epoll with poll()/select()/rt-sig//dev/poll :

They still represent an excessive complicated model that attempts to
implement /dev/epoll the same way that one would implement poll()/select().

Sometimes the answer isn't emulation, or comparability.

Sometimes the answer is innovation.

mark

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/

