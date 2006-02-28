Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932417AbWB1T1j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932417AbWB1T1j (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 14:27:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932456AbWB1T1i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 14:27:38 -0500
Received: from dsl093-016-182.msp1.dsl.speakeasy.net ([66.93.16.182]:61111
	"EHLO cinder.waste.org") by vger.kernel.org with ESMTP
	id S932417AbWB1T1i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 14:27:38 -0500
Date: Tue, 28 Feb 2006 13:27:38 -0600
From: Matt Mackall <mpm@selenic.com>
To: Gautam H Thaker <gthaker@atl.lmco.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>
Subject: Re: ~5x greater CPU load for a networked application when using 2.6.15-rt15-smp vs. 2.6.12-1.1390_FC4
Message-ID: <20060228192738.GO4650@waste.org>
References: <43FE134C.6070600@atl.lmco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43FE134C.6070600@atl.lmco.com>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 23, 2006 at 02:55:56PM -0500, Gautam H Thaker wrote:
> The real-time patches at the URL below do a great job of endowing Linux with
> real-time capabilities.
> 
> http://people.redhat.com/mingo/realtime-preempt/
> 
> It has been documented before (and accepted) that this patch turns Linux into
> a RT kernel but considerably slows down the code paths, esp. thru the I/O
> subsystem. I want to provide some additional measurements and seek opinions
> of if it might ever be possible to improve on this situation.

Are you using the SLAB or SLOB allocator in the -rt kernel?

-- 
Mathematics is the supreme nostalgia of our time.
