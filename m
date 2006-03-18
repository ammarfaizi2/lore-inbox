Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751642AbWCRO0T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751642AbWCRO0T (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 09:26:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751690AbWCRO0T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 09:26:19 -0500
Received: from waste.org ([64.81.244.121]:43500 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S1751536AbWCRO0S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 09:26:18 -0500
Date: Sat, 18 Mar 2006 08:16:18 -0600
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/14] RTC: Remove RTC UIP synchronization on x86_64
Message-ID: <20060318141618.GT12372@waste.org>
References: <2.132654658@selenic.com> <3.132654658@selenic.com> <20060317215255.509fed49.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060317215255.509fed49.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 17, 2006 at 09:52:55PM -0800, Andrew Morton wrote:
> Matt Mackall <mpm@selenic.com> wrote:
> >
> >  Remove RTC UIP synchronization on x86_64
> 
> Needed rework due to pending changes in get_cmos_time().  Please
> check the result.

I did a test merge against -mm before I sent it off, and saw a minor
conflict with real_year that was easily fixed up. Assume you had no
trouble with it.
 
> There are >1600 patches queued up already.  There's already a large RTC patch
> series from Alessandro Zummo which has been queued for the last several
> -mm's.
> 
> Your patches did merge up okayish but if they cause significant problems
> I'll drop them, sorry.

Understood.

-- 
Mathematics is the supreme nostalgia of our time.
