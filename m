Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269942AbSISFHL>; Thu, 19 Sep 2002 01:07:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269943AbSISFHL>; Thu, 19 Sep 2002 01:07:11 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:1801 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S269942AbSISFHK>;
	Thu, 19 Sep 2002 01:07:10 -0400
Message-ID: <3D895C8D.6070504@mandrakesoft.com>
Date: Thu, 19 Sep 2002 01:11:41 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jason Lunz <lunz@falooley.org>
CC: netdev@oss.sgi.com, Richard Gooch <rgooch@ras.ucalgary.ca>,
       becker@scyld.com, "Patrick R. McManus" <mcmanus@ducksong.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.4.20-pre sundance.c update
References: <20020828185612.GA14342@reflexsecurity.com> <20020828231333.GA15183@reflexsecurity.com> <200209190353.g8J3r5q28456@vindaloo.ras.ucalgary.ca> <20020919041403.GA10527@orr.falooley.org> <3D89519C.1020809@mandrakesoft.com> <20020919045621.GA11144@orr.falooley.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jason Lunz wrote:
> On Thu, Sep 19, 2002 at 12:25AM -0400, Jeff Garzik wrote:
> 
>>It still has several flaws that were pointed out, but this is the base 
>>from which I would like testing and patching to proceed.  (also 
>>hopefully the flaws are minor in terms of general operation)
> 
> 
> what's the point of moving rx handling into rx_poll then running it in a
> tasklet? I've tested an older variant of that scheme from D-Link and it
> doesn't perform as well as my patch. It looks to me like an attempt to
> keep this version synced with the NAPI version of the driver, but it
> doesn't actually work very well.

This is a merge and test point.  The whole interrupt handler path is 
getting updated after this.  (but thanks for the feedback, it is noted)


> The functional part of my patch was just taking the tx handling from
> d-link's driver and ditching the rx part.  That and merging in the
> cleanups from Becker's driver; most notably ignoring the broken
> IntrRxDone bit.


Maybe you could show me that in broken-out patches :)

