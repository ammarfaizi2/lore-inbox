Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261228AbUKWDQj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261228AbUKWDQj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 22:16:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261175AbUKWDOG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 22:14:06 -0500
Received: from out008pub.verizon.net ([206.46.170.108]:20702 "EHLO
	out008.verizon.net") by vger.kernel.org with ESMTP id S261228AbUKWDNY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 22:13:24 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: Dave Jones <davej@redhat.com>, Len Brown <len.brown@intel.com>,
       Adrian Bunk <bunk@stusta.de>, Chris Wright <chrisw@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Bjorn Helgaas <bjorn.helgaas@hp.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: why use ACPI (Re: 2.6.10-rc2 doesn't boot (if no floppy device))
Date: Mon, 22 Nov 2004 22:13:21 -0500
User-Agent: KMail/1.7
References: <20041115152721.U14339@build.pdx.osdl.net> <1101178052.20007.196.camel@d845pe> <20041123025004.GM17249@redhat.com>
In-Reply-To: <20041123025004.GM17249@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411222213.21168.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out008.verizon.net from [151.205.10.220] at Mon, 22 Nov 2004 21:13:21 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 22 November 2004 21:50, Dave Jones wrote:
>On Mon, Nov 22, 2004 at 09:47:32PM -0500, Len Brown wrote:
> > > > Also, CPUFREQ usually often on ACPI, and that can save
> > > > power even when the system is not idle, and this results
> > > > in lower temperatures and hopefully slower fan speeds.
> > >
> > > My computer has a desktop Athlon...
> >
> > maybe Dave can determine if there is a governor that can help
> > you.
> >
> > cheers,
> > -Len
>
>desktop athlons tend not to have powernow. And those that do
>(usually by someone transplanting a mobile part into a desktop
> board), hit the problem where the BIOS has no idea what the
>hell is going on, and sets up no PST tables.
>
>  Dave
>
A link to a neat util was posted earlier today, to 'gcccpuopt', which 
scans things and reports the appropriate options to put in the 
Makefile.  But it doesn't even contain the 'powernow' string.  Does 
this need updated?

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.29% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
