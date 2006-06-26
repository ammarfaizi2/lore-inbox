Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932447AbWFZPPt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932447AbWFZPPt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 11:15:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932149AbWFZPP3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 11:15:29 -0400
Received: from calculon.skynet.ie ([193.1.99.88]:27008 "EHLO
	calculon.skynet.ie") by vger.kernel.org with ESMTP id S932447AbWFZPP2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 11:15:28 -0400
Date: Mon, 26 Jun 2006 16:15:26 +0100 (IST)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet.skynet.ie
To: Franck <vagabon.xyz@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.17-mm1
In-Reply-To: <449FF7D4.6010004@innova-card.com>
Message-ID: <Pine.LNX.4.64.0606261613370.1206@skynet.skynet.ie>
References: <20060623134634.GA6071@skynet.ie> <449C036D.6060004@innova-card.com>
 <20060623151322.GA13130@skynet.ie> <449C0DF3.601@innova-card.com>
 <Pine.LNX.4.64.0606231728040.13746@skynet.skynet.ie> <449F9B4C.6000404@innova-card.com>
 <Pine.LNX.4.64.0606261011480.24431@skynet.skynet.ie> <449FC592.8050409@innova-card.com>
 <Pine.LNX.4.64.0606261409140.24431@skynet.skynet.ie> <449FE5E0.3050603@innova-card.com>
 <20060626143159.GA700@skynet.ie> <449FF7D4.6010004@innova-card.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Jun 2006, Franck Bui-Huu wrote:

> Mel Gorman wrote:
>>
>> Lets close this out first and then figure out where to go next.  The following
>> patch should fix the problem where mem_map is offset twice when ARCH_PFN_OFFSET
>> != 0 and documents what ARCH_PFN_OFFSET is for.
>>
>
> why not dropping the initial patch, and resubmit the whole thing that
> can be called an optimization rather than a fix ?
>

Also works. I note that the patch has been dropped from -mm so I'll 
revisit it after the next -mm release.

> <snipped>

-- 
Mel Gorman
Part-time Phd Student                          Linux Technology Center
University of Limerick                         IBM Dublin Software Lab
