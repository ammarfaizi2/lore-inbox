Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262201AbTAIIqV>; Thu, 9 Jan 2003 03:46:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262224AbTAIIqV>; Thu, 9 Jan 2003 03:46:21 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:7694 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262201AbTAIIqU>;
	Thu, 9 Jan 2003 03:46:20 -0500
Date: Thu, 9 Jan 2003 00:54:33 -0800
From: Greg KH <greg@kroah.com>
To: "Kristofer T. Karas" <ktk@enterprise.bidmc.harvard.edu>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.21-pre3 fails compile of ehci-hcd.c
Message-ID: <20030109085433.GF8400@kroah.com>
References: <1042096276.8219.126.camel@madmax> <20030109073849.GC8400@kroah.com> <1042100988.3055.11.camel@madmax>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1042100988.3055.11.camel@madmax>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 09, 2003 at 03:29:46AM -0500, Kristofer T. Karas wrote:
> On Thu, 2003-01-09 at 02:38, Greg KH wrote:
> > On Thu, Jan 09, 2003 at 02:11:15AM -0500, Kristofer T. Karas wrote:
> > > Noticed that I could not get patch-2.4.21-pre3 to compile:
> > 
> > Does this patch solve it for you?
> 
> Hi Greg - Yes.  The extra whitespace made gcc do the right thing. 
> Thanks.

Thanks for testing it, I'll go add it to my trees.

> <Bewilderment> Well I learn something new every day </Bewilderment>
> 
> I notice, however, that speed with this version of EHCI seems down.
> 	hdparm -t /dev/discs/disc1/disc
> 		2.4.21-pre2	2.4.21-pre3
> 		-----------	-----------
> 		10.5 MB/s	8.3 MB/s

Hm, that is odd.

> Either way, this is a great improvement over my previous attempts at
> getting USB2.0 running with a Soltek SL75-DRV2 MoBo, which resulted in
> instantaneous reboots.

Yes, a little slower is better than reboots :)

thanks,

greg k-h
