Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262110AbVD2Prj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262110AbVD2Prj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 11:47:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262054AbVD2Pri
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 11:47:38 -0400
Received: from mail.tmr.com ([64.65.253.246]:19461 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S261946AbVD2Pr2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 11:47:28 -0400
Date: Fri, 29 Apr 2005 11:34:17 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-ide@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Multiple functionality breakages in 2.6.12rc3 IDE layer
In-Reply-To: <1114727182.24687.235.camel@localhost.localdomain>
Message-ID: <Pine.LNX.3.96.1050429112342.2645A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Apr 2005, Alan Cox wrote:

> On Iau, 2005-04-28 at 19:13, Bill Davidsen wrote:
> > On Thu, 28 Apr 2005, Alan Cox wrote:
> 
> > But isn't that the stuff we use for swapping drives? Down the drive, down
> > the interface, swap, and restart? Are these the functions called by hdparm
> > (-bRU) which are all of a sudden not going to work? Or am I being
> > alarmist?
> 
> True but the only kernels supporting that are 2.4.x-ac. There are
> reasons I noticed this and looking at getting 2.6 IDE back to 2.4
> standards in this area was one of them.

The amazing part is that I haven't had a drive fail since I went from 2.4
to 2.6 over a year ago. As you say, it works on your 2.4 kernels, I've "oh
shit" tested it. So if I lose a drive now I'm screwed, not my favorite
operating status.

> 
> > I missed the discussion of why it was felt that the users would no longer
> > want to be able to do these things, or the new way to do it.
> 
> I'm assuming it may be accidental rather than detailed planning. Also
> its taken this long to notice so its clearly not that critical to
> everyone. Seems to be reasonably sane to fix too.

I was being a bit sarcastic about the "missed the discussion" bit, but I'm
pretty sure ripping out the capability was deliberate. Hopefully it's now
going to be evaluated, and then fixed. One thing Linux doesn't seem to do
well is recover failed drives at boot time, it always seems to take a
bunch of fiddling or even a boot from live CD and hand recover.
> 
> Alan
> 

Thanks for jumping into this, with ATAPI storage down to about
$1100(US)/TB it's getting really hard to justify SCSI and real hot swap
hardware.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

