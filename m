Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262053AbSIYSy4>; Wed, 25 Sep 2002 14:54:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262054AbSIYSy4>; Wed, 25 Sep 2002 14:54:56 -0400
Received: from netrealtor.ca ([216.209.85.42]:25095 "EHLO mark.mielke.cc")
	by vger.kernel.org with ESMTP id <S262053AbSIYSyz>;
	Wed, 25 Sep 2002 14:54:55 -0400
Date: Wed, 25 Sep 2002 14:57:27 -0400
From: Mark Mielke <mark@mark.mielke.cc>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Mark Veltzer <mark@veltzer.org>, Peter Svensson <petersv@psv.nu>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Offtopic: (was Re: [ANNOUNCE] Native POSIX Thread Library 0.1)
Message-ID: <20020925145727.B14820@mark.mielke.cc>
References: <200209241519.g8OFJcB26734@www.veltzer.org> <Pine.LNX.4.44L.0209241427520.15154-100000@duckman.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44L.0209241427520.15154-100000@duckman.distro.conectiva>; from riel@conectiva.com.br on Tue, Sep 24, 2002 at 02:29:30PM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 24, 2002 at 02:29:30PM -0300, Rik van Riel wrote:
> I just posted a patch for this and will upload the patch to
> my home page:
> Subject: [PATCH] per user scheduling for 2.4.19
> My patch also allows you to switch the per user scheduling
> on/off with /proc/sys/kernel/fairsched and has been tested
> on both UP and SMP.

I missed this one. Does this mean that fork() bombs will have limited
effect on root? :-)

I definately want this, even on my home machine. I've always found it
to be a sort of fatal flaw that per-user resource scheduling did not
exist on the platforms of my choice.

mark

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/

