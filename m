Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264334AbTICS4p (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 14:56:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264304AbTICSzb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 14:55:31 -0400
Received: from fw.osdl.org ([65.172.181.6]:22252 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264316AbTICSyF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 14:54:05 -0400
Message-Id: <200309031853.h83Iron04928@mail.osdl.org>
To: William Lee Irwin III <wli@holomorphy.com>
cc: Nick Piggin <piggin@cyberone.com.au>, linux-kernel@vger.kernel.org
Subject: Re: UP Regression (was) Re: Scaling noise 
In-Reply-To: Your message of "Wed, 03 Sep 2003 10:21:04 PDT."
             <20030903172104.GO4306@holomorphy.com> 
Date: Wed, 03 Sep 2003 11:53:50 -0700
From: Cliff White <cliffw@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, Sep 03, 2003 at 08:51:56AM -0700, Cliff White wrote:
> > On the Scalable Test Platform, running osdl-aim-7,  for the
> > UP case, 2.4 is a bit better than 2.6, this is consistent across
> > many runs. For SMP, 2.6 is better, but the delta is rather
> > small, until we get to 8 CPUS. We have a lot of un-parsed data from other
> > tests - might be some trends there also.
> > See http://developer.osdl.org/cliffw/reaim/index.html 
> > 2.4 kernels are at the bottom of the page.
> 
> Do you have profile data for these runs? 

For most of them, yes. The link to the profile data is at
the top of the report. Report sorted by load right now.

Also, that webpage doesn't
> have 2.4.x results.

>> 2.4 kernels are at the bottom of the page.

Scroll all the way down, look for the 'Other Kernels' 
header. There are results for linux-2.4.22, 2.4.23-pre1 + pre2 
for both the new_dbase and compute workloads.

Here's a link to 2.4.23-pre2 on an 8-way, if you don't see it..
http://khack.osdl.org/stp/278651/
cliffw

> 
> 
> -- wli
> 
