Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265874AbSKBErw>; Fri, 1 Nov 2002 23:47:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265875AbSKBErw>; Fri, 1 Nov 2002 23:47:52 -0500
Received: from findaloan-online.cc ([216.209.85.42]:45838 "EHLO mark.mielke.cc")
	by vger.kernel.org with ESMTP id <S265874AbSKBErw>;
	Fri, 1 Nov 2002 23:47:52 -0500
Date: Fri, 1 Nov 2002 23:55:35 -0500
From: Mark Mielke <mark@mark.mielke.cc>
To: John Gardiner Myers <jgmyers@netscape.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-aio@kvack.org, lse-tech@lists.sourceforge.net
Subject: Re: Unifying epoll,aio,futexes etc. (What I really want from epoll)
Message-ID: <20021102045535.GA21356@mark.mielke.cc>
References: <20021031230215.GA29671@bjl1.asuk.net> <Pine.LNX.4.44.0210311642300.1562-100000@blue1.dev.mcafeelabs.com> <20021101020119.GC30865@bjl1.asuk.net> <3DC30DED.6040207@netscape.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DC30DED.6040207@netscape.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 01, 2002 at 03:27:41PM -0800, John Gardiner Myers wrote:
> There's also the oddity that I noticed this week: pipes don't report 
> POLLOUT readiness through the classic poll interface until the pipe's 
> buffer is completely empty.  Changing this to report POLLOUT readiness 
> when the pipe's buffer is not full apparently causes NIS to break.

These seems deficient. Does this mean that pipes managed via poll() are
not able to maximum throughput?

mark

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/

