Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261996AbTAIIVL>; Thu, 9 Jan 2003 03:21:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262040AbTAIIVK>; Thu, 9 Jan 2003 03:21:10 -0500
Received: from enterprise.bidmc.harvard.edu ([134.174.118.50]:34577 "EHLO
	enterprise.bidmc.harvard.edu") by vger.kernel.org with ESMTP
	id <S261996AbTAIIVI>; Thu, 9 Jan 2003 03:21:08 -0500
Subject: Re: 2.4.21-pre3 fails compile of ehci-hcd.c
From: "Kristofer T. Karas" <ktk@enterprise.bidmc.harvard.edu>
To: Greg KH <greg@kroah.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20030109073849.GC8400@kroah.com>
References: <1042096276.8219.126.camel@madmax> 
	<20030109073849.GC8400@kroah.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.7 
Date: 09 Jan 2003 03:29:46 -0500
Message-Id: <1042100988.3055.11.camel@madmax>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-01-09 at 02:38, Greg KH wrote:
> On Thu, Jan 09, 2003 at 02:11:15AM -0500, Kristofer T. Karas wrote:
> > Noticed that I could not get patch-2.4.21-pre3 to compile:
> 
> Does this patch solve it for you?

Hi Greg - Yes.  The extra whitespace made gcc do the right thing. 
Thanks.

<Bewilderment> Well I learn something new every day </Bewilderment>

I notice, however, that speed with this version of EHCI seems down.
	hdparm -t /dev/discs/disc1/disc
		2.4.21-pre2	2.4.21-pre3
		-----------	-----------
		10.5 MB/s	8.3 MB/s

Either way, this is a great improvement over my previous attempts at
getting USB2.0 running with a Soltek SL75-DRV2 MoBo, which resulted in
instantaneous reboots.

Kris

