Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755523AbWKQHQw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755523AbWKQHQw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 02:16:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755525AbWKQHQw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 02:16:52 -0500
Received: from MTA068A.interbusiness.it ([85.37.17.68]:13891 "EHLO
	MTA068A.interbusiness.it") by vger.kernel.org with ESMTP
	id S1755523AbWKQHQv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 02:16:51 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Aj0KABTwXEVVLxTBUGdsb2JhbACBSYp2AQEp
Date: Fri, 17 Nov 2006 08:16:50 +0100
From: Mattia Dongili <malattia@linux.it>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux1394-devel@lists.sourceforge.net, bcollins@debian.org
Subject: Re: 2.6.19-rc5-mm2
Message-ID: <20061117071650.GA4974@inferi.kami.home>
Mail-Followup-To: Stefan Richter <stefanr@s5r6.in-berlin.de>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	linux1394-devel@lists.sourceforge.net, bcollins@debian.org
References: <20061114014125.dd315fff.akpm@osdl.org> <20061116171715.GA3645@inferi.kami.home> <455CAE0F.1080502@s5r6.in-berlin.de> <20061116203926.GA3314@inferi.kami.home> <455CEB48.5000906@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <455CEB48.5000906@s5r6.in-berlin.de>
X-Message-Flag: Cranky? Try Free Software instead!
X-Operating-System: Linux 2.6.19-rc5-mm2-1 i686
X-Editor: Vim http://www.vim.org/
X-Disclaimer: Buh!
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 16, 2006 at 11:50:48PM +0100, Stefan Richter wrote:
> Mattia Dongili wrote:
> > On Thu, Nov 16, 2006 at 07:29:35PM +0100, Stefan Richter wrote:
> >> Could you also test one or even better both of:
> >>  - 2.6.19-rc5 plus
> >> http://me.in-berlin.de/~s5r6/linux1394/updates/2.6.19-rc5/2.6.19-rc5_ieee1394_v204_experimental.patch.bz2
> >> (these are the same FireWire drivers as in -rc5-mm2)
> > 
> > the oops disappear
> > 
> >> and/ or
> >>  - 2.6.19-rc5-mm2 minus
> >> http://www.it.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.19-rc5/2.6.19-rc5-mm2/broken-out/git-ieee1394.patch
> > 
> > the oops is there again.
> > I suppose git-ieee1394 is the one then...
> 
> On the contrary, it's very likely _not_ git-ieee1394.

yup, sorry. That's exactly what I ordered my fingers to type... (damn
fingers).

> > dmesg:
> > http://oioio.altervista.org/linux/2.6.19-rc5-test1-ok
> > http://oioio.altervista.org/linux/2.6.19-rc5-mm2-1-ko
> 
> I will look at it tomorrow.
> 
> > next step (smells like bisection) if for tomorrow :)
> 
> Unless you are eager to get results faster, let me think about where
> this superfluous node_entry could come from. Perhaps a run-time test of
> -mm by myself is in order; I am currently on 2.6.19-rc4 plus that patch
> at me.in-berlin.de. Could spare you a lot of time if I find out more. :-)

No problems, I can wait :) After all I don't have any ieee1394 device
(that's why I was rmmod-ing modules :))
If needed feel free to ask me for a bisection.

-- 
mattia
:wq!
