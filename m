Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261330AbSI3VKk>; Mon, 30 Sep 2002 17:10:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261332AbSI3VKj>; Mon, 30 Sep 2002 17:10:39 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:63733 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S261330AbSI3VKj>;
	Mon, 30 Sep 2002 17:10:39 -0400
Message-ID: <3D98BED5.79A73D7C@mvista.com>
Date: Mon, 30 Sep 2002 14:15:01 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Randy.Dunlap" <rddunlap@osdl.org>
CC: John Levon <movement@marcelothewonderpenguin.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 6/6] High-res-timers part 6 (support-man) take 2
References: <Pine.LNX.4.33L2.0209301054310.4649-100000@dragon.pdx.osdl.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Randy.Dunlap" wrote:
> 
> On Sat, 28 Sep 2002, John Levon wrote:
> 
> | On Sat, Sep 28, 2002 at 10:32:08AM -0700, george anzinger wrote:
> |
> | > The 4th, 5th, and 6th parts are support code and not really
> | > part of the kernel.
> |
> | So ...
> |
> | > This part contains man pages for the new system calls.
> |
> | ... why are they here ?
> |
> | http://freshmeat.net/projects/man-pages/
> 
> I agree, please let's not clutter the kernel tree.

Oh, I agree also.  I don't think any of the high-res-timers
support patches belong in the tree.  For testing and
verifying the system calls, however, it is nice to have
them.  It is easy to do the patch and then move the whole
directory as this is the only thing in it.

I might suggest, however, that we should have a regression
test set for the kernel "somewhere".  Does such a thing
exist?  I haven't seen it, but then I have yet to see a
great number of things ;)
-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml
