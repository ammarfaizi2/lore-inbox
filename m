Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313773AbSDPRRV>; Tue, 16 Apr 2002 13:17:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313774AbSDPRRU>; Tue, 16 Apr 2002 13:17:20 -0400
Received: from mark.mielke.cc ([216.209.85.42]:59658 "EHLO mark.mielke.cc")
	by vger.kernel.org with ESMTP id <S313773AbSDPRRS>;
	Tue, 16 Apr 2002 13:17:18 -0400
Date: Tue, 16 Apr 2002 13:12:09 -0400
From: Mark Mielke <mark@mark.mielke.cc>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Terje Eggestad <terje.eggestad@scali.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Liam Girdwood <l_girdwood@bitwise.co.uk>,
        BALBIR SINGH <balbir.singh@wipro.com>,
        William Olaf Fraczyk <olaf@navi.pl>,
        Lee Irwin III <wli@holomorphy.com>
Subject: Re: Why HZ on i386 is 100 ?
Message-ID: <20020416131209.A5531@mark.mielke.cc>
In-Reply-To: <20020416093824.A4025@mark.mielke.cc> <Pine.LNX.4.44L.0204161231440.16531-100000@duckman.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2002 at 12:32:25PM -0300, Rik van Riel wrote:
> On Tue, 16 Apr 2002, Mark Mielke wrote:
> > Increasing the HZ can only improve responsiveness, however, there is a
> > cost (mentioned by others). The cost is that the scheduler is executed
> > more often per second. If the scheduler does the same amount of work
> > per tick, but there are more ticks per second, the scheduler does more
> > work overall, and the CPU is free for use by the processes less.
> Why are you discussing Linux 1.2 ?
> Linux is not running the scheduler each cpu tick and hasn't
> done this for years.

Hmm... sorry... :-) Too early in the morning...

mark

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/

