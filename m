Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274520AbRJYQiy>; Thu, 25 Oct 2001 12:38:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275278AbRJYQip>; Thu, 25 Oct 2001 12:38:45 -0400
Received: from marine.sonic.net ([208.201.224.37]:36118 "HELO marine.sonic.net")
	by vger.kernel.org with SMTP id <S274520AbRJYQie>;
	Thu, 25 Oct 2001 12:38:34 -0400
X-envelope-info: <dalgoda@ix.netcom.com>
Date: Thu, 25 Oct 2001 09:39:05 -0700
From: Mike Castle <dalgoda@ix.netcom.com>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: modprobe problem with block-major-11
Message-ID: <20011025093904.C24125@thune.mrc-home.com>
Reply-To: Mike Castle <dalgoda@ix.netcom.com>
Mail-Followup-To: Mike Castle <dalgoda@ix.netcom.com>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27036.1004015036@ocs3.intra.ocs.com.au>
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 25, 2001 at 11:03:56PM +1000, Keith Owens wrote:
> The problem is caused by a bash "feature", it was added in bash 2.01.

Gotcha.  I take it you've seen this before then?  :->

I didn't see any mention of this the docs.  Would it be worth while to add
what you just wrote to a PROBLEMS file?

> Workaround: Replace 
>   pre-install foo modprobe bar
> with
>   before foo bar

Will do.

> That does all the work internally without using the system() function
> and falling foul of the bash feature.  It is also faster and it lets
> modprobe maintain the chain of modules for unload.
> 
> BTW, users can never run rmmod, only root can do that.

Right.  But it IS with root that rmmod -a is failing.

Maybe I'll get lucky and it will magically start working when I switch to
the above?

Appreciate your help!
mrc
-- 
     Mike Castle      dalgoda@ix.netcom.com      www.netcom.com/~dalgoda/
    We are all of us living in the shadow of Manhattan.  -- Watchmen
fatal ("You are in a maze of twisty compiler features, all different"); -- gcc
