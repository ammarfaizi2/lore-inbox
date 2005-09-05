Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932323AbVIEQ2m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932323AbVIEQ2m (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 12:28:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932329AbVIEQ2m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 12:28:42 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:27619 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932323AbVIEQ2l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 12:28:41 -0400
Date: Mon, 5 Sep 2005 09:28:08 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: Con Kolivas <kernel@kolivas.org>
Cc: vatsa@in.ibm.com, linux-kernel@vger.kernel.org, akpm@osdl.org,
       ck list <ck@vds.kolivas.org>
Subject: Re: [PATCH 1/3] dynticks - implement no idle hz for x86
Message-ID: <20050905162808.GF25856@us.ibm.com>
References: <20050831165843.GA4974@in.ibm.com> <20050904212616.B11265@flint.arm.linux.org.uk> <20050904203755.GA25856@us.ibm.com> <200509051308.20331.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200509051308.20331.kernel@kolivas.org>
X-Operating-System: Linux 2.6.13 (i686)
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.09.2005 [13:08:20 +1000], Con Kolivas wrote:
> On Mon, 5 Sep 2005 06:37 am, Nishanth Aravamudan wrote:
> > On 04.09.2005 [21:26:16 +0100], Russell King wrote:
> > > On Sun, Sep 04, 2005 at 01:10:54PM -0700, Nishanth Aravamudan wrote:
> > > > I've got a few ideas that I think might help push Con's patch
> > > > coalescing efforts in an arch-independent fashion.
> 
> Thanks very much Nish!
> 
> I've updated the patches here http://ck.kolivas.org/patches/dyn-ticks/ with 
> the latest change to timer_pm.c that Srivatsa sent me and have a new rollup 
> there as well as the split out patches. The ball is in Nish's court now so 
> we'll avoid touching the code till you get back to us (this project needs 
> some form of locking ;) ).

Albeit, don't take that to mean that other people shouldn't keep doing
what they are doing (Srivatsa with his pm_timer work, scalability work,
e.g.) :) Hopefully, any changes I make, will not take too long.

Thanks,
Nish
