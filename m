Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270800AbRICRlG>; Mon, 3 Sep 2001 13:41:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270821AbRICRlC>; Mon, 3 Sep 2001 13:41:02 -0400
Received: from lsmls02.we.mediaone.net ([24.130.1.15]:40098 "EHLO
	lsmls02.we.mediaone.net") by vger.kernel.org with ESMTP
	id <S270800AbRICRko>; Mon, 3 Sep 2001 13:40:44 -0400
Message-ID: <3B93C104.AE8909C4@kegel.com>
Date: Mon, 03 Sep 2001 10:42:28 -0700
From: Dan Kegel <dank@kegel.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.14-5.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
Newsgroups: linux.redhat.misc
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: 1.5 GB ram on system - only 900 MB shows
In-Reply-To: <ffd4cdd8.0108271353.75476210@posting.google.com> <slrn9olo4b.u89.BigLar@leonardo.localdomain> <ffd4cdd8.0108281415.16a63a2d@posting.google.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

natestone@hotmail.com (Nate Stone) wrote:
> > > We were able to address 1024 MB of ram on our previous machine using
> > > the append feature during boot up, but it doesn't seem to work any
> > > more.  Is this a problem related to the new memory management system
> > > in kernel 2.4.xx?  Any solutions?
> >
> > I think you must recompile your kernel with >1GB support.  ...
> 
> Actually, we already built the kernel with 4GB support enabled and the
> ram was still not recognized.  We get the same exact problem.
> 
> ... try running
> 40+million pageviews per month off a crippled server because you can't
> access all the ram and the shared memory utilization sucks in kernel
> 2.4.xx.  Talk about nightmares.
> 
> We probably will switch back to kernel 2.2.16 (which worked with 1GB
> of ram) and seemed way more efficient at memory management unless
> someone offers an alternative.

Going back to 2.2.x is probably a good idea for the moment, but
it's a bit suprising that the RAM isn't showing up in 2.4.
Is it possible you didn't boot with the kernel you thought you did?

I'm cc'ing this to linux-kernel, as this isn't really redhat specific,
and the people there may have suggestions for you.
- Dan

-- 
"I have seen the future, and it licks itself clean." -- Bucky Katt
